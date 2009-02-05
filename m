From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Wed, 04 Feb 2009 16:04:43 -0800
Message-ID: <7v4oz9lpes.fsf@gitster.siamese.dyndns.org>
References: <200902021948.54700.jnareb@gmail.com>
 <20090202202424.GG14762@mit.edu> <200902040304.05028.jnareb@gmail.com>
 <20090204235436.GA8945@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 05 01:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrl5-0002ZT-Qe
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 01:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbZBEAEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753982AbZBEAEx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 19:04:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbZBEAEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:04:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A549F2A744;
	Wed,  4 Feb 2009 19:04:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AFC6E2A738; Wed, 
 4 Feb 2009 19:04:45 -0500 (EST)
In-Reply-To: <20090204235436.GA8945@mit.edu> (Theodore Tso's message of "Wed,
 4 Feb 2009 18:54:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B9D7872-F318-11DD-8721-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108474>

Theodore Tso <tytso@mit.edu> writes:

> 1) In branch A, the directory src/plugin/innodb-experimental is
>    renamed to src/plugin/innodb, and in branch B, a commit (i)
>    modifies a file src/plugin/innodb-experimental/table.c, and (ii)
>    creates a file src/plugin/innodb-experimental/mod-schema.c.  This
>    commit in branch B is then pulled into branch A, where the
>    directory rename has taken place.  The user may not know that a
>    directory rename had taken place under the covers, so they don't
>    give any magic options when they run the "git cherry-pick" or "git
>    merge" command.  Does the right thing happen such that the right
>    file in src/plugin/innodb is modified, and the new file is created
>    in src/plugin/innodb, even though in the original commit, the
>    changes were made to files in src/plugin/innodb-experimental?

Careful.

Although it is reasonable to expect that existing file's modification will
move to innodb/ directory, it is not as clear-cut as some people seem to
assume that the new file should always be created in the new directory
innodb/.  You seem to imply you understand the issues by having the second
example, though.
