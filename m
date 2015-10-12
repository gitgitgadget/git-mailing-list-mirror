From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v3 3/3] git-p4: Skip t9819 test case on case insensitive
 file systems
Date: Mon, 12 Oct 2015 07:47:05 +0100
Message-ID: <CAE5ih79M9guQsjs34XmyE6sxExa6a6KkgdYEHOyeBCv57-4-QA@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 08:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlWt6-0006sK-EA
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 08:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbbJLGrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 02:47:08 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33415 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbJLGrG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 02:47:06 -0400
Received: by obbbh8 with SMTP id bh8so100850332obb.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WNRWKXo+uxPrvxMC9ebCb6xTHoNOHLMBWPeZ4GYOfbA=;
        b=BQzg7ZtaCUTDHptbK5dfaR1UAW7RsYwdv9NW1iOjBhpT5albRv9hPndRGsiqnzZxop
         86CovFhzJjNrCxoZaBVrnrUu2l71mFQlyWlk/IViQgz01j4CLyzOmIKBqUdmf6WK32Rz
         LWhzEtSFrvYan+E+yiJo5zso1JQ3WeoTWTXDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WNRWKXo+uxPrvxMC9ebCb6xTHoNOHLMBWPeZ4GYOfbA=;
        b=LFTorPdR2zXT3eFx3kNcl3TBm2LRZpqxemBu8KYAZURd651lf2Y2c81wD4obKD6VDj
         /2DaKYUDsC6SeLp8WPs4wruj05d5M6tlJU9oyxY56sTKcUEAgQdTyrzdHqtvQH7Hy7HC
         WziCE8xErneZXsgQFezSLOveMnM0BitLGuRDQ+ltXqnJNiVWR+kKFtlim45MM7OMtfOJ
         xR/pkyF8CVkowC/8azuhIL/GJKRdhz4TRx2UMbS7ETJ2driX2tPn9oDMRWDGx6VLZrSz
         aIe8wVwywVLmJ0/fqG2JZtwABQ3tQqX5r0UPoXplP9GbGB9SRyty5Itg0ZezWCWYT6Md
         S9rA==
X-Gm-Message-State: ALoCoQmUKh+B8+QZJ81qUP+tnKkjhHYESMQrasyr/iXTcgu/Lp5xE44ygp9C8LDUTYwF6mc9bwSf
X-Received: by 10.182.19.167 with SMTP id g7mr14703401obe.13.1444632425513;
 Sun, 11 Oct 2015 23:47:05 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Sun, 11 Oct 2015 23:47:05 -0700 (PDT)
In-Reply-To: <1444586102-82557-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279362>

Looks good to me, Ack.

On 11 October 2015 at 18:55,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Windows and OS X file systems are case insensitive by default.
> Consequently the "git-p4-case-folding" test case does not apply to
> them.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t9819-git-p4-case-folding.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t9819-git-p4-case-folding.sh b/t/t9819-git-p4-case-folding.sh
> index 78f1d0f..d808c00 100755
> --- a/t/t9819-git-p4-case-folding.sh
> +++ b/t/t9819-git-p4-case-folding.sh
> @@ -4,6 +4,12 @@ test_description='interaction with P4 case-folding'
>
>  . ./lib-git-p4.sh
>
> +if test_have_prereq CASE_INSENSITIVE_FS
> +then
> +       skip_all='skipping P4 case-folding tests; case insensitive file system detected'
> +       test_done
> +fi
> +
>  test_expect_success 'start p4d with case folding enabled' '
>         start_p4d -C1
>  '
> --
> 2.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
