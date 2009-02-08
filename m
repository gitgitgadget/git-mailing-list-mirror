From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checking sha1's of files
Date: Sun, 08 Feb 2009 01:58:35 -0800
Message-ID: <7veiy9z1v8.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:00:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6SN-0000JI-Ob
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZBHJ6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbZBHJ6n
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:58:43 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZBHJ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:58:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2407397401;
	Sun,  8 Feb 2009 04:58:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC04C97400; Sun,
  8 Feb 2009 04:58:37 -0500 (EST)
In-Reply-To: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com>
 (Caleb Cushing's message of "Sun, 8 Feb 2009 04:39:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1033FA0C-F5C7-11DD-989C-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108942>

Caleb Cushing <xenoterracide@gmail.com> writes:

> I need to check the hashes of specific files in the repo in an
> automated fashion, in another tool.

What "hash" are you talking about?  sha1?  md5?  crc?

I *think* you are trying to say that gentoo has a tool to compute some
sort of hash for regular files in their source tree by:

	"gentoo's portage tree has manifests for each file"

but without knowing what kind of hash they use, I cannot tell you if you
can reuse some part of git to compute their hash without using their tools
(it also is unclear why you are not using their tool to compute their hash
and instead are expecting git to know about the specific hash function
used by them).

For exammple,

	"sha1sum Makefile"

would give you the SHA-1 checksum of the contents of the Makefile.  Is
that what gentoo's tools expect?  If that is the case, that is different
from the blob object name git will give to the contents of that Makefile,
so you cannot reuse much of git.
