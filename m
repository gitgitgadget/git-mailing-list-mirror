From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in "git log --graph" at the tail end?
Date: Fri, 23 May 2008 18:39:42 -0700
Message-ID: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org>
References: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
 <20080524010555.GA5385@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sat May 24 03:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzil1-0005d7-PQ
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbYEXBjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbYEXBjv
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:39:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbYEXBju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:39:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62D0232FC;
	Fri, 23 May 2008 21:39:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5414832FB; Fri, 23 May 2008 21:39:46 -0400 (EDT)
In-Reply-To: <20080524010555.GA5385@adamsimpkins.net> (Adam Simpkins's
 message of "Fri, 23 May 2008 18:05:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C2A2CF0-2932-11DD-AAD0-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82789>

Adam Simpkins <adam@adamsimpkins.net> writes:

> - Merge commits that have uninteresting parents print branch lines for
>   all of their parents, even the uninteresting ones.
>
>   This is just a cosmetic issue, but I agree it looks bad.  Perhaps the
>   best thing to do is not to display anything for the uninteresting
>   parents.  It might look a little confusing to some users though, since
>   you can have a merge commit that is printed as 'M', but it only has
>   one parent displayed in the graph.

Ah, I was also going to suggest you _not_ to use 'M' at all.  In other
words, I do not see anything wrong if you drew the graph like this:

      *   1af8bca... Merge branch 'maint'
     /|
    | *   008442f... Merge branch 'maint-1.5.4' into maint
    | * e77b0b5... git-am: fix typo in usage message
    | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
