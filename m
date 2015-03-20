From: Thomas Schneider <thosch97@gmail.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 22:54:56 +0100
Message-ID: <CAJUTLVXwR+-PBRHZSENryGxkAB--w+oskUDyHhj1Oz37aNcOMg@mail.gmail.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
 <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
 <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com> <CAJUTLVUK4+OiS_LDaFsRo_pwxF4nO2vR0zyumHBxBc9+8C3FUw@mail.gmail.com>
 <xmqqzj77cq9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 22:55:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4tL-0001oW-Jc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:55:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbbCTVzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2015 17:55:39 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34388 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbbCTVzi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 17:55:38 -0400
Received: by lagg8 with SMTP id g8so97155659lag.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EauvwdUwVsFLzn0cGeh6HMxCJGAoQRXIf5yIU2FBHP4=;
        b=edHytKICt88mGstRz9SFuLMH3CU9NIs3wblsFjl5EHGmkKhZWFZc3rPOwji8fF+5AN
         nZ28BEkITR8b8l46q1S8WrUIZjl4o6Ix97oDsDYbZ0UUoEKWYpWzE9FQFRHP0LGH1F32
         CIvO7vxYSL0a9WX6gOCw5Pd8YFWYPQa9A4NgquHa3gaeBIpG67Po5oi/mSeLf/nxodr0
         dXf5vUoOafiYm/Qe+wsEMEmrU/L9Cn4PJKyF1CtJEJOMcBMtrHF30nIOdBYQ2QSSF66F
         SN5TJ34XPeV2ddcB3TRbaD3qKIKc2+ky6i8Nq+weg6dJhHml3elZfoSyZNMziA5elr3z
         fXbw==
X-Received: by 10.152.22.229 with SMTP id h5mr74902623laf.21.1426888536940;
 Fri, 20 Mar 2015 14:55:36 -0700 (PDT)
Received: by 10.112.63.199 with HTTP; Fri, 20 Mar 2015 14:54:56 -0700 (PDT)
In-Reply-To: <xmqqzj77cq9p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265971>

2015-03-20 22:28 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> I think you misunderstood me.  I am not dismissing the need for PDF;
> I am just saying that there is no need to directly generate them
> from asciidoc sources, especially when there are already manpages
> and html pages available as source to "print" to PDF.

Oh, I might indeed have misunderstood you there.
Yes, you can indeed also generate nice-looking PDFs from HTML or
troff.  But if you need all of git=E2=80=99s manpages as PDF, a make ta=
rget to
generate them surely comes in handy, so you don=E2=80=99t have to do it=
 on
your own.  Also, if you are bulk-compiling all of the manpages, it
makes more sense to build them from the DocBook XML AsciiDoc generates
rather than from HTML or troff, simply because of one step less in the
toolchain and hence a way faster build.  It does not make a big
difference if you just compile one document, but for 169, it=E2=80=99s =
a
considerable difference.
