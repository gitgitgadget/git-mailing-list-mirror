Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFCA71F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162897AbeBNT03 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:26:29 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36241 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162787AbeBNT02 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:26:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id f3so23927494wmc.1
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=M9WiayMgG7Zp+lY6WoWK1TahjhNBAj7hdHm6I+0Uga0=;
        b=gmCfTkV/EJP9iZsilByBCDx18Held2eo+vdeinfCO6OkPdAO1g1ECechF/Rfy8pAUz
         eyJ0a8CyAS29xoWomDN0FxUQk8LeOozkY32rj09WH7XiMefEWqjjS1BsQ4neBRtIMzFX
         8Hg7hyoQuOjMkzkiNhVZoDOeOuRJDnqu3S/M4fZiXGX4qGlsbe4cKr/gHP/vAo42EM2e
         Bui1pkYdrzFcOouh5TqbxagGqpYaAMRMlaGXdDXB2Ld5hwkraOdjkKMh4iRE3seXWSJ0
         VYn7SNH3tFPrs5ycOBBieyNO5juW+cloVuSmiS2aMwLOPYfR3zA2P7/ldCo0APMaHOgC
         77Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=M9WiayMgG7Zp+lY6WoWK1TahjhNBAj7hdHm6I+0Uga0=;
        b=irCrYREnckNqYdKxRjwccJYAuoOLdQBnZMHis8GK3AVScThEJwBkqWYonafY6Ff6zG
         hrrrqOi7tM2odwhaO+fJSLWC0E34/C4tonzDezrT2OVQVIHlrXU60kSfCD4p8btx2U3d
         hDP6Zmd2MMW9M1V6RgHzbaHqVyTdzovVWI2FrEBRt86yZh78JiLsxaYPbAjb7oL8uWki
         LDqfKiQ3toPsudkJsH3ACbzlNBXqBlzWyWg1g+AsTERDTxlXqB8vQcrzrGhs96p8Bcd+
         r7ZxdKj4RegX0GC5ZKQn9z+f+UXYQ4FNSAeVvBmyBL5hzyfCxIcRUBBC41dz3Bq/4c8h
         gT/w==
X-Gm-Message-State: APf1xPCLTRxaujKgzuFaN0mrKXj5DTuzyyeRQbi0sbFoogCshgPoygYT
        0gP4VvMTsbtMozbi29LK0A7trNburNw=
X-Google-Smtp-Source: AH8x226vZnnbsQ/be2puD4fEMeO8wdnGNFm7yYRKkeNAHKcaoDeAyW4wNoH1PQ3/GOhdmdLNmtsj4A==
X-Received: by 10.28.220.66 with SMTP id t63mr128585wmg.100.1518636386707;
        Wed, 14 Feb 2018 11:26:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x26sm2018310wmc.28.2018.02.14.11.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 11:26:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] am: support --quit
References: <20180214111606.4257-1-pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 11:26:24 -0800
In-Reply-To: <20180214111606.4257-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 14 Feb 2018 18:16:06 +0700")
Message-ID: <xmqqy3jvmkyn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Among the "in progress" commands, only git-am and git-merge do not
> support --quit. Support --quit in git-am too.

That's a strange way to phrase it, when the number of commands that
know and do not know it are about the same.

>  --abort::
>  	Restore the original branch and abort the patching operation.
>  
> +--quit::
> +	Abort the patching operation but keep HEAD and the index
> +	untouched.

OK, I see from the documentation of rebase that the above pair is
consistent with how --abort/--quit are done over there.

> @@ -2359,6 +2363,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>  	case RESUME_ABORT:
>  		am_abort(&state);
>  		break;
> +	case RESUME_QUIT:
> +		am_rerere_clear();
> +		am_destroy(&state);
> +		break;

The internal implementation detail of am_abort() is leaking out
here, by saying "rerere-clear" is the only special thing other than
recovering the HEAD and working tree state when abort happens.  It
makes readers wonder if am_rerere_clear() should become part of
am_destroy().  I dunno.
