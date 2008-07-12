From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/2] Do simple in-index merge with diff+apply instead of read-tree
Date: Sat, 12 Jul 2008 11:22:00 +0100
Message-ID: <b0943d9e0807120322l350784b5sfceeb967f0956cdb@mail.gmail.com>
References: <20080702060113.11361.39006.stgit@yoghurt>
	 <20080702061243.11361.75544.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 12:23:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHcFp-0003pd-Pb
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 12:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbYGLKWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 06:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYGLKWB
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 06:22:01 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:1531 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbYGLKWB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jul 2008 06:22:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4754823rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3rk4tzBeoa+Ouzyzu0LrSlQBY3lZrnIwrgV6Vq2Nzj0=;
        b=Ss77W3YoOrE3jK9aoy8IQVcj7d1zF38APP3cW2Da0BXFkpkQdQWonVZIugSEklirUP
         xDyx5NDTPvC9Pjsd0Urhch7TELsBBRJMrjPeYh38hvtEbuGcIzVhWo2mHZqZ+pr3FRo3
         SIDuXlf7b7NkAIuorF9vK+ulLsvfU4ME+U3aY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZEsIS27AjVpumM/VaSL7knw2IQ5013F3hBr9vwUOaZxZcsJPQrbeD0gSswMYZS7/1I
         AksZ/OKareqpnbvCGq2789HWOKvGhdGwKdohtaJDs9dul2f+eTjgsRhKGkYLWkNYrFHw
         FyGfFpRl5aWSzn/vdstB2GBTu8eEERHjp3ZAI=
Received: by 10.114.194.1 with SMTP id r1mr15356881waf.205.1215858120487;
        Sat, 12 Jul 2008 03:22:00 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Sat, 12 Jul 2008 03:22:00 -0700 (PDT)
In-Reply-To: <20080702061243.11361.75544.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88231>

2008/7/2 Karl Hasselstr=F6m <kha@treskal.com>:
> The advantage is that patch application will resolve some file conten=
t
> conflicts for us, so that we'll fall back to merge-recursive less
> often. This is a significant speedup, especially since merge-recursiv=
e
> needs to touch the worktree, which means we have to check out the
> index first.

Thanks.

--=20
Catalin
