From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] upload-pack: remove unused "create_full_pack" code in 
	do_rev_list
Date: Wed, 28 Jul 2010 10:47:19 -0600
Message-ID: <AANLkTi=OfoMd4Q8YJPLyYX3jTz+RBQZuV4chvzdG+_fG@mail.gmail.com>
References: <1280309950-5597-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 18:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe9mw-0002x1-Gn
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 18:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab0G1QrV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 12:47:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34835 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab0G1QrU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 12:47:20 -0400
Received: by vws3 with SMTP id 3so4407031vws.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 09:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sB1/QVEVFEkL9+pD0IuKc5v16yqbzUrbQ/S9Or12PY4=;
        b=Y4iJmC/k57LXuLo4ClpsmNyYp5Z4x3v6anlQEd7MP7kKB/VToVNi0YFjkM8YFBKUBJ
         OCl2xDPUikCQlqmjov4RkLX5vrTODuDAt80nVq2Qmf2e3e/O2RmXVSBitSsKpm0xiijW
         0Fv22yg9tiXywFgnXTrdLsfWS2B20agYaAvC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ME+aNc14lKWc0X1sl9PXPR8ubEdq2LfBnsr1INBtxhhqMU/aigvuNGWFqhlkuStKZd
         RWIoXga9BH8ylyAyuiSh95dxbHkhcBmm8FGgPljzlgHSNKhaw5YCJSRCwUUj0ksR6HoJ
         GayGFCeMhdcLw8S40Y4LK0snUL+8+IVeTMSVI=
Received: by 10.220.62.5 with SMTP id v5mr6385925vch.102.1280335639556; Wed, 
	28 Jul 2010 09:47:19 -0700 (PDT)
Received: by 10.220.97.15 with HTTP; Wed, 28 Jul 2010 09:47:19 -0700 (PDT)
In-Reply-To: <1280309950-5597-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152100>

Hi,

2010/7/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> A bit of history in chronological order, the newest at bottom:
>
> - 80ccaa7 (upload-pack: Move the revision walker into a separate func=
tion.)
> =C2=A0 do_rev_list was introduced with create_full_pack argument
>
> - 21edd3f (upload-pack: Run rev-list in an asynchronous function.)
> =C2=A0 do_rev_list was now called by start_async, create_full_pack wa=
s
> =C2=A0 passed by rev_list.data
>
> - f0cea83 (Shift object enumeration out of upload-pack)
> =C2=A0 rev_list.data was now zero permanently. Creating full pack was
> =C2=A0 done by passing --all to pack-objects
>
> - ae6a560 (run-command: support custom fd-set in async)
> =C2=A0 rev_list.data =3D 0 was found out redudant and got rid of.
>
> Get rid of the code as well, for less headache while reading do_rev_l=
ist.

Definitely a more detailed explanation than I gave for this patch
(http://thread.gmane.org/gmane.comp.version-control.git/151667).  :-)
