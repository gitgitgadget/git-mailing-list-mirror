From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 18:22:47 -0700
Message-ID: <CA+55aFzGwPYNn2baFhEr4msBTV7__nkTSUqAZ7=PRVoYrchV5w@mail.gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl> <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
 <7v7gxfwpc8.fsf@alter.siamese.dyndns.org> <CA+55aFwPrjtAttsH75tTGHO=14g_2GbyOtUt4eY9LPHbtcXvcQ@mail.gmail.com>
 <CA+55aFyAsF4jNvNMKC6divzAfyVmgrHvxJtnX0fjkpp_bLHkPQ@mail.gmail.com> <20120416233218.54daa2f6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 03:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJx91-0008GO-6N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 03:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab2DQBXK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 21:23:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48608 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2DQBXJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 21:23:09 -0400
Received: by wgbdr13 with SMTP id dr13so5826790wgb.1
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0CZpRzaSYda+QlHXhmOXD45Q35IOEGsQnNH2H60qHV4=;
        b=JajddeAtvmv8zDK1JvWMYsJQnKn88gvoJWa1sC9sf/HR58wLTkCkAVtm7jz4zdp3rs
         LFETs81fPdeBpYSF5LBri9naZ6GuQu9XA/5paAkEuX/mF6N/Lah/3Z9V69VPncahxa1r
         K47yeuGsFFeQUMpL50OWoKAn1vEh+Pq4z9fgOWsVr+e1CSpsauteBnfhhKy9ezc7Pt/o
         2i/cxV6fftV+xjyP2SxRAV7Bfe5MzOdpvljTI8FUKdZHejr5NDk9CSDsmhXbeDn9f+TX
         utbrkIRohEQHIE/nMHhujZuH5Bac6BCbi5nkzU+sb+mw2Ejdc7EADFDDApqSYZKaM+5J
         DFuA==
Received: by 10.180.92.130 with SMTP id cm2mr12429477wib.4.1334625787691; Mon,
 16 Apr 2012 18:23:07 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Mon, 16 Apr 2012 18:22:47 -0700 (PDT)
In-Reply-To: <20120416233218.54daa2f6@gmail.com>
X-Google-Sender-Auth: 825V9ds6Xc8_seeAXIotRFOz-Fs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195730>

2012/4/16 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
>
> So, the difference is that `git merge --no-ff HEAD^` used to work, no=
w
> it doesn't because we reduce_heads() only if we allow fast-forward (a=
nd
> even though there is just one remote we merge with, parents contains
> two commits). So what about that trivial patch instead (discarding ou=
r
> previous patches)?

Yes, I suspect this might work.

And I like how reducing the remoteheads should also automatically fix
the case of the commit messages containing redundant information when
you give the same branch multiple times (assuming you have the whole
merge log thing enabled).

                     Linus
