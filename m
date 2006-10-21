From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 12:09:04 +0200
Message-ID: <vpq64eeyo8v.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<ehao3e$2qv$1@sea.gmane.org> <vpqk62uhzkk.fsf@ecrins.imag.fr>
	<200610211036.44679.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 12:10:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbDnl-0006da-PZ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 12:10:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWJUKJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 06:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWJUKJy
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 06:09:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:39361 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1030325AbWJUKJx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 06:09:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9LA95nO011405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 21 Oct 2006 12:09:05 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GbDmq-0006wk-UE; Sat, 21 Oct 2006 12:09:04 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1GbDmq-0006Bg-Qe; Sat, 21 Oct 2006 12:09:04 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610211036.44679.jnareb@gmail.com> (Jakub Narebski's message of "Sat\, 21 Oct 2006 10\:36\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Sat, 21 Oct 2006 12:09:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29600>

Jakub Narebski <jnareb@gmail.com> writes:

> Ah, that explains this. So why people use bundles instead of patches
> (with some metainfo like commit message)?

You need more metainfo than the commit message. Since revision-id is
not based on the content, you need at least to specify the
revision-id.

And bzr's bundle give indeed _all_ the information that is in the
repository about this revision (i.e. commit message, ancestors, ...).

Another relevant difference between a patch and a bundle is that the
bundles knows its ancestor, so, when you apply the bundle, it builds
the new revision with exact patching. If you need a merge, then it
will happen exactly in the same way as a merge between two branches
(ie. three-way merge for example).

> And do bzr have command to apply in correct ordering series of
> bundles send either chain replied to (each patch in the series is
> reply to previous patch) or being replies to patchseries
> introductory message?

Not directly AFAIK, but since the bundle knows which revision it
applies to, it will refuse to apply the second if the first one is not
in your repository already for example.

It would probably be interesting to have more features to help sending
series of bundles and apply them, but no one have been really asking
for it up to now.

-- 
Matthieu
