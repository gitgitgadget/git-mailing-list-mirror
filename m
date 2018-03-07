Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5901F404
	for <e@80x24.org>; Wed,  7 Mar 2018 23:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934385AbeCGXTs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 18:19:48 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35210 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934362AbeCGXTr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 18:19:47 -0500
Received: by mail-wr0-f175.google.com with SMTP id l43so3869019wrc.2
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 15:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CtiIV3j4pB0qeZTkd0bmZ11eMAW+xbhniIGJWd2G88o=;
        b=i6Bm74YD3dZvw/I8POnpkDVtOhQ33VF0QkAH8gEasJMKAh6lv3doq+KQb4TVJnL2Ch
         V1nxjnTg0i8zwPvZTedmCYOcEkXzTb1Hc4lSQsjhUcMUDcsgsML7QCWgjAvSax7covFd
         mPtUS0ux06JXbF2BmMm83kONStVWPi5POO76YawAMdPWiw7C/GPNN5Oi5SDFcuCIMR6k
         PuP4YSbp23GCvsNuSUnxa6lDQk77z7009E7FNi3TJH8tPQ0MkLFeP7O250WTbFNsq7R/
         dED1bJJNpZHOku/Oro3ZcGXtr5FcFhQG+swZhGNuyW/AUgYWYbgfGd8DBQeM+9vdSh+C
         mJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CtiIV3j4pB0qeZTkd0bmZ11eMAW+xbhniIGJWd2G88o=;
        b=uSY+PfBllZDbhWAF3B6FS3x5NYJi9MZyqVSUXcXeWc1oEr4obuhYBuNnPMkVSeioZT
         RSLLclbPOCRyu/zQf9bi5rlyOpxxdo1n6PyODo0Upq4/q7Ytduat3uNpR/p17c3dXKbo
         fi3vkJL+TT1mQpgLv/28O6bYrt0Zm4d8SVAtFiT4eK6WTeJMRNItYbS9t8X1WXWBi+HO
         7HN73R9haQIeBDVOLAQdGysgArQVDtYd7bI87aGtxigzESPpXGhpkKcdLdUm87REptTy
         kGErRXdNdR6EWowT0WbF0ZDfVSXjIrSGgQcuFQ7GOhctBJDQ0tVKPtv0iOLn68zqa3zf
         IqCA==
X-Gm-Message-State: APf1xPBm8dTxbY03y7Q6F1gmr7ftXs4NSd/2B1LAU34qxCBZttjjr0Z3
        8uJr8NgJBnHEAPZIHDzihZU=
X-Google-Smtp-Source: AG47ELt2auq1RK3/sbfqIxnO/4Pv4W9A7Ealihy222G6NpATaECebTM2F2lax1GRDEVBfOtsu1d8KQ==
X-Received: by 10.223.156.208 with SMTP id h16mr22111799wre.123.1520464786585;
        Wed, 07 Mar 2018 15:19:46 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id b136sm14243997wme.34.2018.03.07.15.19.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 15:19:46 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvae7xznk.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 8 Mar 2018 00:19:44 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <4465AF18-EBE8-4BA3-8F95-B51630A41B86@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-8-lars.schneider@autodesk.com> <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com> <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com> <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com> <766B302C-446B-4730-A5D9-909C6FCF6A84@gmail.com> <xmqqvae7xznk.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 23:57, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> At this point I thought it would make sense to make the advised
>> encoding name uppercase in both situations. OK with you?
> 
> In the endgame, if upcased and properly dashed form is always used,
> that would be good (if we are enforcing the policy, which I am not
> onboard 100% but it's your code and I do not care too strongly about
> it).  I do not see much point in an interim step that only upcases
> without doing the dash insertion.

I would like to advise the dashed form as this seems to be the
canonical form and it avoids cross platform issues. My macOS
iconv does not support the form without dashes.

Would this approach work for you?

			const char *advise_msg = _(
				"The file '%s' contains a byte order "
				"mark (BOM). Please use UTF-%s as "
				"working-tree-encoding.");
			const char *stripped;
			char *upper = xstrdup_toupper(enc);
			upper[strlen(upper)-2] = '\0';
			skip_prefix(upper, "UTF-", &stripped) ||
			skip_prefix(stripped, "UTF", &stripped);
			advise(advise_msg, path, stripped);

Thanks,
Lars
