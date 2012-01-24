From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finding all commits which modify a file
Date: Mon, 23 Jan 2012 17:15:51 -0800
Message-ID: <CA+55aFynLN7kBYh7i-kh+Xd1Qn-wKBePcokmJRNfe8RYA0cCZA@mail.gmail.com>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com> <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Groothuis <ngroot@lo-cal.org>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jan 24 02:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpUzi-0003AO-OC
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 02:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab2AXBQO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 20:16:14 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44574 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab2AXBQM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 20:16:12 -0500
Received: by wics10 with SMTP id s10so2601500wic.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QsCD1vSxRKOFLgKjlbZxtD44Vqtv2Q1IE57oDMMm1cI=;
        b=APRhrFTyQ1+QWyIDKAx6VWsc7FF+NAuV8OA13SeUrm9zpPPFB2wa+lgk4hIqhOvFHd
         AIL0nQkUeak+kDcHyrjIEBBB7PHl3l6BPtLZCViftiq8Qht28lCi2Il6Z7eVC3/zRXVN
         4brgHZlOrDHAae9YwTtMucep9jwWXQbFPPL8Y=
Received: by 10.180.104.4 with SMTP id ga4mr75628wib.17.1327367771211; Mon, 23
 Jan 2012 17:16:11 -0800 (PST)
Received: by 10.216.35.131 with HTTP; Mon, 23 Jan 2012 17:15:51 -0800 (PST)
In-Reply-To: <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
X-Google-Sender-Auth: Qu1wtkTbvBXZSI5VkirB5UEm4Jo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189032>

On Mon, Jan 23, 2012 at 4:58 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
>
> If you add parent rewriting (--parent, --graph or see it in gitk, wit=
h
> --full-history) you'll get your B2 commit as it adds commits to have =
a
> meaningful history. But I don't think this is what you are asking for=
=2E
>
> =A0You could try the following patch (sorry for the whitespace damage=
,
> also attatched):
>
> Subject: [PATCH/RFC] revision: merging branches with different conten=
t
> is interesting in --full-history

The concept seems sane.

But please check the interaction with "--simplify-merges" too, just in
case. The merge simplification looks at TREESAME too, so I suspect
your change may break merge simplification.

                      Linus
