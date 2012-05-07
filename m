From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v4 5/6] completion: calculate argument position properly
Date: Mon, 7 May 2012 03:27:31 +0200
Message-ID: <CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
	<1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCjh-0006Rp-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2EGB1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 21:27:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50538 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab2EGB1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 21:27:32 -0400
Received: by eaaq12 with SMTP id q12so1250536eaa.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=e6zlVAGJYFWU3PEEPVmvceG/jrq7S+hy5BLxwqcuE1Q=;
        b=qmLUyhFcfQQ8b2jPCNYfHuJ9fXeeARvaHb79Lu9D/Knl/I83dGG9B8rRCRmxqL8Ngo
         X8pOBFwwRMk0f9E4/+MGCaG6+M2tDJ4EIh9tUIH4NEex/s1bBh5hooPBwbv2QjXsGJpQ
         DRSeWqRGyzxhHblfl9LLdb5+uyiyFaQghSTPOpLJltrHMKIrQRRgWVI83afaHLuAf4DW
         r8/1VT/FVINOkntHywpBZYov+BxbY69+oLREBwdTGr0G3MnI/PkbhhJOk/1v1/CKdB6u
         aC3FnYvJaHtBhpCruZ+wYvz/117VUxc0gXfE4wgkhjXyHC2Hh+yxDxKhZpAXPvS8S6BH
         QFkA==
Received: by 10.213.20.72 with SMTP id e8mr947129ebb.85.1336354051495; Sun, 06
 May 2012 18:27:31 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 18:27:31 -0700 (PDT)
In-Reply-To: <1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197233>

On Mon, May 7, 2012 at 3:23 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> @@ -2642,6 +2642,8 @@ _git ()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> + =C2=A0 =C2=A0 =C2=A0 (( cmd_pos =3D c + 1 ))

Actually, I would prefer cmd_pos=3D$((c + 1)).

--=20
=46elipe Contreras
