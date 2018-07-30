Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A51D1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeG3QeT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:34:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37553 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeG3QeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:34:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so10777256ljk.4
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jhnEOFzlXwy9tHXhXckkusFwm+gKxPsKqQ5w/gAYhxo=;
        b=fmjsSnDwUmTBREBzTWEMw+4rODhTlnnwTMkRscnVHWZVj3eE4/4RZBtQ2aI5NRsEjt
         rfKbBT5t5rjdtMDXIY+IOMoZm9qAJC/gJfrDc+j3hSZPQhG3eo/jYEFBXHUfNblXX3tr
         8XWPGZp/+trRq5afK3QT9Biju2d1Hiq4MOrUEnx0lgvLbC5ciMOsKzFq313OZ25OfVPL
         qFZcP0fsXQDbpay0Gf7zebgCCiCMR3S1L0+9EE1+p7l8wpYxv7Fshw1/gjcyyphAEpv0
         ktza1hteY+pwCYZD3t/xMeQntopfGzfOr3+hl8NIehsxmcFIEUntUCDSJBTII9KTa2WS
         pCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jhnEOFzlXwy9tHXhXckkusFwm+gKxPsKqQ5w/gAYhxo=;
        b=aGdyV11dDvo+oDT9ZMQYvcCan04dE3XxYqNjIBbCKt90nN29K1+19E2+yIYgiesdou
         fDjupOK8dB7ljNz/RUS0tc6N2/bHgWYo+S7gLssJZZ3a+piMYXPgA7ve+q5Kkv3AHm0q
         YZBBsHP5wotqi6aiAjeu5pa8hlchgq6icczIX3k6sQhxbC2fbV+DhG8vq+mj4B9J2wdw
         BCdy62cX+W6WuBykY0V2Q2N42NynIal3Wfta9nviwBdbEEMfM+BzPQsQc/ZciIShTbCY
         i3WZRBsi5O2unRSHZ5taPtQ0gO6kYJAvtLRKDc3wbExKPiXqIeu041ow7NXzj5kkJubq
         u3mw==
X-Gm-Message-State: AOUpUlHheWODBI9dw36wAF7EMyJTXODJ28b9+wpgLHUbzmNdCQHGwr06
        qhOpj6Og9f0bO/UC+OIg6IpVbwDJ
X-Google-Smtp-Source: AAOMgpdY8Y080tzGUv0K3BJDHhAlSU8NtGn0n0ZYDP1z001Eeo0HjzFdLHsKeYvlWWo4xSe6svgNjw==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr12716553ljc.71.1532962735389;
        Mon, 30 Jul 2018 07:58:55 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z15-v6sm1808646lji.58.2018.07.30.07.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:58:54 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:58:51 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] fetch: implement fetch.fsck.*
Message-ID: <20180730145851.GA8074@duynguyen.home>
References: <20180525192811.25680-1-avarab@gmail.com>
 <20180727143720.14948-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727143720.14948-8-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 02:37:17PM +0000, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7ff453c53b..8dace49daa 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1467,6 +1467,16 @@ fetch.fsckObjects::
>  	checked. Defaults to false. If not set, the value of
>  	`transfer.fsckObjects` is used instead.
>  
> +fetch.fsck.<msg-id>::
> +	Acts like `fsck.<msg-id>`, but is used by
> +	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
> +	the `fsck.<msg-id>` documentation for details.

Could you squash this patch in? It would let us auto-complete "git
config fetch.fsck" in bash/tcsh

-- 8< --
diff --git a/help.c b/help.c
index 9c0b5a8de9..32fe466dbf 100644
--- a/help.c
+++ b/help.c
@@ -427,6 +427,7 @@ void list_config_help(int for_human)
 		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
 		{ "color.status", "<slot>", list_config_color_status_slots },
 		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ "fetch.fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
 		{ NULL, NULL, NULL }
 	};
-- 8< --
--
Duy
