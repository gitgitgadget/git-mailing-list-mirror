Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10631F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756269AbcIYOEF (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:04:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34009 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbcIYOEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:04:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so10105339wmf.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OQqq9Ki1kuTkrUZV79O4UZxgLh/meCSvbLS74jb/Jok=;
        b=jrpxrg/v3QCHEHeGDaao1tnd4awrghvKSq2VSrthaSUqz0i3uETa8Pv/qAiURK4eAp
         PsCLpKj6MoBgEanwPLiDwNfFbXatyDDtz0D1aVBaGWl/CUTzrP8RufTx4F469uha1cCB
         S5yjmiwk8PDXlWQchHhFlpUJNrsFHZpLHp+M8RrOuNzGOGNFiGoqlOn0FHV9hMd5GM33
         iYjtv/zNDW7hl7fOMFtSZhEgqesM6P4142zZEZ9HapxBkOZdQrYdP4xGbrPGZWCB1gtK
         /Tt93EIfBD0j9CWz42hTMkFhIOMAkNM9UJohE2LscN2cF78BfLkP79H0/+PGLRXq6RkJ
         fvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OQqq9Ki1kuTkrUZV79O4UZxgLh/meCSvbLS74jb/Jok=;
        b=dOBmV2Tm5LI/fUa69zKCiqQOpwE3meP1+fm1fV66jS9bn9u5cHfDFCSJUIdvC4KVN0
         sIpp604W3fUkDH3GWaE6P8h0fwZ/GVC+EPm2dWE66Q6h5sjtymfT/3jVgT29A/chtJPU
         jlwcKzJIpsJRGFIp/2pmEoWSLogDTYs7bpVxL9Q84+2EcmirLcitW2oAa7G4DuQir8/Q
         nV6Tmdf4PwkV9MyFdhmmcgMepn2pjwkSZicT2QOpQGGojrYab0wGTmdMLJlluG7fjUJq
         ylhipM6FcwdCe6W74Uw/BRMvWBy0PjjNFsORGGkSYBNA8LgDWK8jh3kmvT0I9K/q20oQ
         lwIg==
X-Gm-Message-State: AA6/9Rm9Bb5BYxaMrQELNqBy0zKllPOLuCJiwnieN7R0qTeKo/gOWOJI6nCHDOu7rfCPFw==
X-Received: by 10.28.229.20 with SMTP id c20mr11795591wmh.0.1474812243604;
        Sun, 25 Sep 2016 07:04:03 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id 74sm6123393wmi.7.2016.09.25.07.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 07:04:02 -0700 (PDT)
Subject: Re: [PATCH v8 08/11] convert: quote filter names in error messages
To:     larsxschneider@gmail.com, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-9-larsxschneider@gmail.com>
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        mlbright@gmail.com, tboegi@web.de, ramsay@ramsayjones.plus.com
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <6fc996fd-cdae-43c1-3ea9-2408e9ea47de@gmail.com>
Date:   Sun, 25 Sep 2016 16:03:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-9-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git filter driver commands with spaces (e.g. `filter.sh foo`) are hard
> to read in error messages. Quote them to improve the readability.
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Looks good (those are all sites matching 'error.*%s' in convert.c).

> -		return error("cannot fork to run external filter %s", params->cmd);
> +		return error("cannot fork to run external filter '%s'", params->cmd);

> -		error("cannot feed the input to external filter %s", params->cmd);
> +		error("cannot feed the input to external filter '%s'", params->cmd);

> -		error("external filter %s failed %d", params->cmd, status);
> +		error("external filter '%s' failed %d", params->cmd, status);

> -		error("read from external filter %s failed", cmd);
> +		error("read from external filter '%s' failed", cmd);

> -		error("read from external filter %s failed", cmd);
> +		error("read from external filter '%s' failed", cmd);

> -		error("external filter %s failed", cmd);
> +		error("external filter '%s' failed", cmd);

