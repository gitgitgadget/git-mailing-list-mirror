From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 17/25] setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
Date: Thu, 27 Feb 2014 09:43:56 +0700
Message-ID: <CACsJy8CQTV65KnzhQ8PrgrEUAJA+LPD=-5=g9J_gtNoLOPApAg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-18-git-send-email-pclouds@gmail.com> <xmqqios11k0v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 03:44:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIqxc-0007OC-5u
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 03:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbaB0Co2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 21:44:28 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:56519 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbaB0Co1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 21:44:27 -0500
Received: by mail-qc0-f175.google.com with SMTP id m20so1913334qcx.6
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 18:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7gWj0bMUuBlVhC/TVhfhDdBbs8RC2P0NaJr+ox0qtjU=;
        b=zBq8VDkjoXnsh+A2NiPSixwGg9fEwpB4/DinGQJKG5HW8HxcFLGs2s0ieKKMwViNBd
         8l6eHuNcabDCBG33rNqeVWjCWco9FRNCrtMxw8hLIUIxxYt8Xg4eGs4UJ/DnRK32sDWz
         TuNaIaevtAeRaxeg2TsiMbSIPLH14JEU+JgMsY+Bnrvr/K7Qh+CJEUfSZV95NIUZzde4
         W5SPS1+JDxtnbXbNOO+FOi9Twjkj+qBkUveS3pdlm0WFBdHVrDOZf/awB/lg3YCexOnd
         OzOlkyGx30LW4ndU53d5Dv2cm1RQqbeBZ+ADqxKxgAktViKXf3T9p0l2S3zuEBfhWbSm
         2Fjg==
X-Received: by 10.140.40.5 with SMTP id w5mr3762891qgw.65.1393469066976; Wed,
 26 Feb 2014 18:44:26 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 18:43:56 -0800 (PST)
In-Reply-To: <xmqqios11k0v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242782>

On Thu, Feb 27, 2014 at 7:22 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> It is a good thing to do to read config from the real repository we
> are borrowing from when we have .git/commondir, but it makes me
> wonder if we should signal some kind of error if we find .git/config
> in such a borrowing repository---which will be silently ignored.
>
> My gut feeling is that such a check may be necessary, but may not
> belong to this function.

Just checking. Once we do this, what about .git/refs/.. that is also
ignored in such a repo? I can see the point that config could be
manually edited so the user may edit the file at the wrong place, so
it's good the we catch this exception.
--=20
Duy
