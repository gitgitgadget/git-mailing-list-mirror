From: Thomas Schneider <thosch97@gmail.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 22:18:25 +0100
Message-ID: <CAJUTLVUK4+OiS_LDaFsRo_pwxF4nO2vR0zyumHBxBc9+8C3FUw@mail.gmail.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
 <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com> <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 22:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4K1-0001Qq-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbbCTVTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2015 17:19:09 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:36205 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbCTVTH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 17:19:07 -0400
Received: by labe2 with SMTP id e2so21224560lab.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uh+U5JSkbBJjdnGnOJaDS5V4+oaPO0Iw6oJv70mO7DU=;
        b=eGtQwpypbLyaa3d2KgYyB/uWKdXwuP4ECjl6c2y83tF0OELcc2T03NB2n+xLpNV8MO
         CxGqtbMEcuJmCeUtGqqs1ky3HCKV9HglFPl4wGnSAqH1dn25jIVBVfRUiL6ATnihBCvc
         FESldD9UJ0SmL0Yso+fL3Uo1S4V0Ae4qrqTwAMyssVZ6GgVeoTms91f/yLA9GUss0kmR
         brbtHo/E1gY+4/5szf/f6QiMDFsGUEo76oy25VGQQARiEP+EqQFmB/zt1KuQX2n0ke+4
         iN7QrC1MCdWTGL3GhyoTE40rwnifRgbEOyU79fGlHNdEpHWB3hFzzgEk4dY2a3x6jRiJ
         QO1g==
X-Received: by 10.152.22.229 with SMTP id h5mr74813544laf.21.1426886346254;
 Fri, 20 Mar 2015 14:19:06 -0700 (PDT)
Received: by 10.112.63.199 with HTTP; Fri, 20 Mar 2015 14:18:25 -0700 (PDT)
In-Reply-To: <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265965>

2015-03-20 21:21 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Stefan Beller <sbeller@google.com> writes:
>
>> ... though how would I read man pages in pdf
>> format? I tried searching the web and all I can find is how
>> to convert the a man page to pdf. So is there a conveniant
>> way to tell `man` to prefer opening pdfs when available?
Make man(1) open your PDF viewer?  As far as I know, you=E2=80=99d have=
 to
either patch man or write a wrapper around it.

> Personally, I honestly am not quite sure why anybody wants to
> generate manpages in the PDF format like this patch does, unless
> they are planning to print them on paper, in which case the existing
> manpages (git.1 and friends) or html pages (git.html and friends)
> should be an already available source format.
Somebody in the #git IRC channel, called =E2=80=9CIIT=E2=80=9D, asked h=
ow to get PDF
manpages, so I found out respectively mostly already knew how to and
wrote this patch.
Their usecase was =E2=80=9Cread manpages offline on an iPad and make
annotations and highlights.=E2=80=9D  I do not know iOS and the availab=
le
apps, so making annotations to documents might indeed be cumbersome
with HTML documents, not to mention troff.  I could also imagine
making an EPUB or mobipocket file from the AsciiDoc (which is quite
easy, both formats are more or less HTML), there are of course
dedicated eBook readers, which mostly support some sort of
annotations, and I=E2=80=99m sure there are decent apps for iOS as well=
=2E

So, maybe most people are fine with the other formats, but those who
need PDF can directly generate them.  And those who don=E2=80=99t will
probably not even notice.  Fedora does not seem to include any PDFs
(find /usr/share/doc/git* -iname "*pdf") and the Gentoo ebuild doesn=E2=
=80=99t
have any hints on PDF either, I suppose most other distros are
similar.
