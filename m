From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v2 1/3] blame: add --abbrev command line option
Date: Tue, 5 Apr 2011 23:46:19 -0300
Message-ID: <BANLkTim8bR1Z5sQCtVeqCJcCh_wuQxCvJQ@mail.gmail.com>
References: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Namhyung Kim <namhyung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 04:46:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7IlF-0006TU-DO
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 04:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab1DFCqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Apr 2011 22:46:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44185 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab1DFCqU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 22:46:20 -0400
Received: by iyb14 with SMTP id 14so996579iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6doNlV1MPE46J0Nx56Ce8aRw3PMA2YUKtYkTswUJJAQ=;
        b=whNj8RsCSYV5tXXP0ESfiD9GQploR7Td8jys7GyxEKaylfTxciJ8JkjjUL0fZjxXNK
         ntT0cEUbIgRYXr9OpRdCHefqH5mS8FtiSubRIcmPCkTyU/qiks9ZhyAapPQq2Fv5q6/t
         qWmArGmsK0/GC8YnZkEu1mIsT+banb1rhyy5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VbyROqSa22kURAHxcJRVSbv36mSZIZA0fj3zFjt9SAY2OQD4tXHHuTFYjkcanbQwHH
         S3pxfGPKA08TbNcbpBaYs90oY44aMuqotbT3t6jVOCx5QRwbrJWPU0xktTQGrdmJcgdQ
         DEPc1QDr3SDIN5fuoYQj9mBQ9n21ydKiViqPM=
Received: by 10.43.69.130 with SMTP id yc2mr687638icb.298.1302057979137; Tue,
 05 Apr 2011 19:46:19 -0700 (PDT)
Received: by 10.42.164.3 with HTTP; Tue, 5 Apr 2011 19:46:19 -0700 (PDT)
In-Reply-To: <1302056452-5387-1-git-send-email-namhyung@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170950>

On Tue, Apr 5, 2011 at 11:20 PM, Namhyung Kim <namhyung@gmail.com> wrot=
e:
> Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> ---
> =C2=A0builtin/blame.c | =C2=A0 =C2=A04 +++-
> =C2=A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index f6b03f7..253b480 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -41,6 +41,7 @@ static int reverse;
> =C2=A0static int blank_boundary;
> =C2=A0static int incremental;
> =C2=A0static int xdl_opts;
> +static int abbrev =3D 8;
>
> =C2=A0static enum date_mode blame_date_mode =3D DATE_ISO8601;
> =C2=A0static size_t blame_date_width;
> @@ -1670,7 +1671,7 @@ static void emit_other(struct scoreboard *sb, s=
truct blame_entry *ent, int opt)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cp =3D nth_line(sb, ent->lno);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (cnt =3D 0; cnt < ent->num_lines; cnt+=
+) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char ch;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int length =3D (op=
t & OUTPUT_LONG_OBJECT_NAME) ? 40 : 8;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int length =3D (op=
t & OUTPUT_LONG_OBJECT_NAME) ? 40 : abbrev;

Should this 40 be a constant?
