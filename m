From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] checkout: add --ignore-other-wortrees
Date: Sun, 04 Jan 2015 22:50:20 -0500
Message-ID: <54AA09FC.7080707@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <1420278087-14613-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 04:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7ygd-0004jJ-9D
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbbAEDu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2015 22:50:26 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37526 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbAEDu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:50:26 -0500
Received: by mail-qg0-f42.google.com with SMTP id q108so14981682qgd.15
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TgVpMlBr7giVNyvjFIgkhJEUKSbKgtS2hVPEwxWPcaA=;
        b=yinNXuuV76JFSaOCQ8CE32kUeZlZXPtjB5lyQngwjHpkJ9sPJKfiIXFi7QckWkhWgs
         HKOsHXH2XxpY67wwVmxQcfvRFiFai4w7e1I2eVPowKLzum5k19H7MqrBCx/wTzY6v4fZ
         V2hmMpvUrAP5/7v7dRweNhEWi4OlDGzh+r3AItEb7Lkw9GZiUOXleOv4SL1z5usw6JJK
         eCDlwUDKZPcMhuvoes8/90UD3C0BDF6jzDfwRlu1o4BH0kc9XklxpNq0q7OUUTjTfvvm
         sI/2Wsvzqq5Pqt3hpQlWUvx79hUOSfIJbyHAF1iNWBieg2R3U6QR1YDsr1fPRl8oxk6D
         Wb3g==
X-Received: by 10.224.136.7 with SMTP id p7mr141729311qat.65.1420429825449;
        Sun, 04 Jan 2015 19:50:25 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-124-96.washdc.fios.verizon.net. [173.79.124.96])
        by mx.google.com with ESMTPSA id l8sm31198348qad.43.2015.01.04.19.50.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2015 19:50:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1420278087-14613-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262015>

On 01/03/2015 04:41 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> Noticed-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>   Documentation/git-checkout.txt | 6 ++++++
>   builtin/checkout.c             | 6 +++++-
>   t/t2025-checkout-to.sh         | 7 +++++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index 0c13825..52eaa48 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -232,6 +232,12 @@ section of linkgit:git-add[1] to learn how to op=
erate the `--patch` mode.
>   	specific files such as HEAD, index... See "MULTIPLE WORKING
>   	TREES" section for more information.
>  =20
> +--ignore-other-worktrees::
> +	`git checkout` refuses when the wanted ref is already checked
> +	out by another worktree. This option makes it check the ref
> +	out anyway. In other words, the ref can be held by more than one
> +	worktree.
> +
>
Thanks for adding this, I haven't had a chance to test but by reading=20
this solves the problem I raised.

Mark
