From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 6 Oct 2011 22:24:16 +0000
Message-ID: <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
Reply-To: Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 00:24:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBwMZ-00064S-Px
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab1JFWYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 18:24:18 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:39706 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1JFWYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 18:24:17 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 904D31B4043
	for <git@vger.kernel.org>; Thu,  6 Oct 2011 22:24:16 +0000 (UTC)
Received: (qmail 23692 invoked by uid 10000); 6 Oct 2011 22:24:16 -0000
Content-Disposition: inline
In-Reply-To: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183046>

On Wed, Oct 05, 2011 at 05:56:55PM -0700,  Junio C Hamano wrote:
> And this uses the gpg-interface.[ch] to allow signing the commit, i.e.
> 
>     $ git commit --gpg-sign -m foo
>     You need a passphrase to unlock the secret key for
>     user: "Junio C Hamano <gitster@pobox.com>"
>     4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)
> 
>     [master 8457d13] foo
>      1 files changed, 1 insertions(+), 0 deletions(-)
I like it, but I have a couple of questions: 
1. Are the sig lines used in computed SHA1/commitid of a given commit (I
   see examples w/ --amend and that would usually change the SHA1)?
2. Can we allow more than one person sign a commit?
3. If I have prepared a series on a local branch, and I want to sign all
   of them, is this a variant of rebase or?

I think this isn't a replacement for push certificates, but has value in
itself. It's certainly provides better integration than the
signature-in-note variants.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
