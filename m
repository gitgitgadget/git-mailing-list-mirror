Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127291F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbdL1TFs (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:05:48 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:46305 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753588AbdL1TFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:05:47 -0500
Received: by mail-it0-f67.google.com with SMTP id c16so4906323itc.5
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y9B71isDKM6cgfsHuVPR1LPVmt94UmCRw8EVp+4cGr4=;
        b=V2XKdE5ru+Sdd3SNIWa4f3fHAWs/jnt3UlSbYcpt2036+NsMoVJZY14u4ft+0VdbrC
         7HbvYpjhe9IZPfzvmLjVk3ktL6IigtbuCvn0nK6MZWE5STfZ+pp6UN+NH9EXRYnJMTMm
         +QFSQemacQPY+gxhsShRgu11Sn5QsOZOrV+sg3K/jsxqMldrhhnsxHjKnF6sTDA9rBfv
         Sn6i65BAypLoJQrA0U6LmHGm+/jro1CoQtIlcJI5ML+D7JSnchQIWq1anDMKmfsafrZZ
         eTBOOeY4Z9JgsUDYk2ztnYMvrA9XCzD6/YTnQ71Xqe3DXUxV+18NLRxq6XLH7wPHfxfx
         BLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y9B71isDKM6cgfsHuVPR1LPVmt94UmCRw8EVp+4cGr4=;
        b=EnaaBfVnMBKGQKZPglg+INPMdvbd8tg35q61+N72ilKLj5bJg2FMmhcEVSFKZwAdAD
         K7sthUUkZolam/lIP0EC9BoHSdjy1ZIjk5GY/4UmaRhjaYYv77sOAaOcdWaAGgar7Ahn
         FcqwndcZry/jclHeZonMpiCi69lwc+EE6jlpKIWwJip+sFj5OLTkBZe3jphYVaabBDPD
         FglArmtAOA7VId9UQhg4l5hwqpVwKwjtYVY3FBFbe52DtkXTxyXCj9EIQuEIJpliA45w
         7d1D8WzO/W5V8cPJ0ZVLoOIGkKcOVYNO/KZExG2xLHFdrJsteAok26hU9kZMRIzZPnfM
         uvxA==
X-Gm-Message-State: AKGB3mJOcB+loPw2CyOR2uJ824DMAWhKG6BwEv7pVWEw0Z8LIP8ZzvjP
        9qP+QpRPJhWbQVu/sWXxF/M=
X-Google-Smtp-Source: ACJfBosXJLhz/N9oBg9XP0NI+M5AEurUwBvA1sXROiVAkOJmg71MvqjyZITtFBG/Uegk9kSeBLUJ5A==
X-Received: by 10.36.190.205 with SMTP id i196mr42964838itf.84.1514487946469;
        Thu, 28 Dec 2017 11:05:46 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 125sm18658443ioo.68.2017.12.28.11.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 11:05:46 -0800 (PST)
Date:   Thu, 28 Dec 2017 11:05:44 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Makefile: NO_OPENSSL=1 should no longer imply
 BLK_SHA1=1
Message-ID: <20171228190544.GC92530@aiede.mtv.corp.google.com>
References: <20171227233912.GB181628@aiede.mtv.corp.google.com>
 <20171228140742.26735-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171228140742.26735-2-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Use the collision detecting SHA-1 implementation by default even when
> NO_OPENSSL is set.
>
> Setting NO_OPENSSL=UnfortunatelyYes has implied BLK_SHA1=1 ever since
> the former was introduced in dd53c7ab29 (Support for NO_OPENSSL,
> 2005-07-29).  That implication should have been removed when the
> default SHA-1 implementation changed from OpenSSL to DC_SHA1 in
> e6b07da278 (Makefile: make DC_SHA1 the default, 2017-03-17).  Finish
> what that commit started by removing the BLK_SHA1 fallback setting so
> the default DC_SHA1 implementation will be used.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

This is indeed
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.
