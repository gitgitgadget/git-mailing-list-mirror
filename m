From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] builtin/pack-objects.c: Fix a printf format compiler warning
Date: Thu, 20 Oct 2011 13:54:23 -0500
Message-ID: <CAEik5nNPrxuRfkbniLV96Mfsg_pPDQc_oOsS29Y2+ofoLW+5-A@mail.gmail.com>
References: <4E9F20AD.4020209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 20 20:54:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGxl7-0004kP-NG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab1JTSyZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 14:54:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49608 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1JTSyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 14:54:24 -0400
Received: by bkbzt19 with SMTP id zt19so3886622bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=76OOTKQ+fwESpl+sEZiRNteKAze5SCzLOKTvqQn2wdY=;
        b=ixUwA4BNpOkmtsZGP16Cp2J2oKzYz52ELtZRJlDoGDgJjBnT8uBzaI1PamU6lN8Jhq
         8EMhqO+GTsumQKhjeRladzNFxPmEBQ04Lpa/jk+XtowuefWJUhmsRfmrsILVZHhaoDzQ
         49NI8r7LvtjD9WOCBYiaOwqqvxVsXSaoYvqaY=
Received: by 10.204.153.217 with SMTP id l25mr8913619bkw.0.1319136863304; Thu,
 20 Oct 2011 11:54:23 -0700 (PDT)
Received: by 10.204.40.140 with HTTP; Thu, 20 Oct 2011 11:54:23 -0700 (PDT)
In-Reply-To: <4E9F20AD.4020209@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184034>

On Wed, Oct 19, 2011 at 2:10 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> In particular, on systems that define uint32_t as an unsigned long,
> gcc complains as follows:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CC builtin/pack-objects.o
> =C2=A0 =C2=A0pack-objects.c: In function `compute_write_order':
> =C2=A0 =C2=A0pack-objects.c:600: warning: unsigned int format, uint32=
_t arg (arg 3)
>
> In order to suppress the warning, we use the C99 format specifier
> macro PRIu32.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Dan,
>
> If you need to re-roll your pack-objects series (dm/pack-objects-upda=
te
> branch in pu), could you please squash this change into your final co=
mmit
> 0a8145bd (pack-objects: don't traverse objects unnecessarily, 18-10-2=
011).
>
> If you don't need to re-roll, then I'm hoping Junio will notice and s=
quash
> this in before it hits next. ;-)
Sorry about that- fixed locally, and if I do need to resend them then
it will be fixed.

-Dan
