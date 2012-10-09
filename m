From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: [PATCH] configure.ac: Add missing comma to CC_LD_DYNPATH
Date: Tue, 9 Oct 2012 19:23:54 +0200
Message-ID: <CAA787rnXw2fR5DG5bhz9uF4ub8=jZgUvpJLVGJ5sGXGSF8VMEQ@mail.gmail.com>
References: <1349800026-10717-1-git-send-email-sunny@sunbase.org>
	<1349800572-2963-1-git-send-email-sunny@sunbase.org>
	<7v4nm3h8yr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, stefano.lattarini@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 19:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLdXR-00050Y-2C
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab2JIRX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 13:23:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:52095 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430Ab2JIRXz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2012 13:23:55 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so5382911pad.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ys2O2srl3cPuicGzGLSdqXcIIAs3yzFz3Fxy+UBp+s0=;
        b=BtP+bkTd3DlT2ypUM+fQfpfMuEW93zBjITP+qE8LmvILdgXfPGXq/scr8FM+bz+lQ9
         u/HPoiZJxXDGRKtiPCiXwmOhJcYLeHF+027U4J054+77v+KGtpXM49AG808A9MuC/nrH
         gqhSgSPC/fnA1/+PSwYQWgJxzV/iZ0s142PRLBaUL8nceIRlrLTy62JEutgIlCX2BpXi
         fYJfiTFr17gKrjbZ7bL44XiMmKqklGauiQVqmmdmw/ufarXEz87ojAmkBJjslqlxR2sC
         ssaGin8ZOp00NZ6WQL1ijlHFhS6bosAuU0Jmmi5L/TgYdBVa0Lm4jHuo0c1In3tTb4Zf
         azlg==
Received: by 10.66.86.133 with SMTP id p5mr54138313paz.35.1349803434759; Tue,
 09 Oct 2012 10:23:54 -0700 (PDT)
Received: by 10.68.222.7 with HTTP; Tue, 9 Oct 2012 10:23:54 -0700 (PDT)
In-Reply-To: <7v4nm3h8yr.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: d0iW6TNybRllxN7Lsrue2v29cJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207330>

On 9 October 2012 19:05, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=98yvind A. Holm <sunny@sunbase.org> writes:
> > 40bfbde ("build: don't duplicate substitution of make variables",
> > 2012-09-11) breaks make by removing a necessary comma at the end of
> > "CC_LD_DYNPATH=3D-rpath" in line 414 and 423.
>
> The earlier one is a cut-and-paste-error regression.
>
> Isn't the one at line 423 from before 40bfbde, though?  If that is th=
e
> case, I'm a bit hesitant to take that part of this patch without a
> second opinion.

It looks like it is, yes. More accurately, from 798a945 way back in
2008. If it hasn't caused any trouble since then, it probably won't. :)
The line was changed in 40bfbde, though, but AC_SUBST doesn't contain a
comma, so to be on the safe side, the first patch should be used.

But I made a minor copy+paste error in the commit message of that patch=
:

  "CC_LD_DYNPATH=3D-rpath" in line 414.

should be

  "CC_LD_DYNPATH=3D-Wl,-rpath" in line 414.

Just a minor, but slightly annoying detail.

Regards,
=C3=98yvind
