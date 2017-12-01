Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D7320C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbdLAD5I (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:57:08 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44518 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbdLAD5H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:57:07 -0500
Received: by mail-pf0-f195.google.com with SMTP id m26so4077018pfj.11
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kaawt2uDDPl0dl2t85ZKuJ5IbhxEchIpfQfhEWccopc=;
        b=szRBq+FJz+XXFTCOBpuvBiMUc2JWjehO+izQ36qSzefb5fq/ctfWW8Y4PJa1tJxn16
         hxkVWQ3O/vNV47ItAEE0naMWRYiogF8QJWquTOPWmwPgtSU0GnO4l3TQmkgrcLPD6zhN
         NnRQvcjEBOLH/HJ3SLkCzBmgYDen4+nLiNpQm/4Xsdf0l2BiqvGKQX0r03Q5lLQtbngg
         EUIEOEfFgHEphIRMCCNXL6a4zcDfEoGVl/1/Oei1lDioc/u9vrCURVBMvkz6vm9UOuY3
         Hz5LbQt3xWifj1aPNxiiyJzAmoLw6ux9jcVU1iUmEonaysHhYwmcZUpMA4yTTG3LFSMk
         bIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kaawt2uDDPl0dl2t85ZKuJ5IbhxEchIpfQfhEWccopc=;
        b=q1u2oBDwAA+SFYh9cGHVs/ENA9DYqDUyz6yEzDVmVZfM4Z3Oiks4v3mTrMwsEr7hFV
         ar0xwJa4vxaop/0isYKHRKMbjKP2WGdrKMDdvrvyVmhcaPtvAu8ciL5E7PdiLkydEVnB
         MWRu8kwsOuAF02jT66+Zll90iYMCAtVL81MKnVoNAAUXb6Y65vgj45rp8xVgO4CT/tS0
         uDFqkiR0Jpghf+ZkjkzdLYgpW439Wob/GAtFL4sY1bxEESMrliq91brbtm+YoeDvU5q9
         8uj6Zie1Mit7yF1k9KG9h/OBurcQ+NBbpGiHQPkL2s9YVUAMgSlQe2ofFN8PAXDqZHhr
         vVJw==
X-Gm-Message-State: AJaThX4mRISC8G+D20sJzoxN1LnHgtDhCwm/9zdhuvyZ3Iw7uDocO/QC
        tOHRF77DsXBwsAANj1aBvlw=
X-Google-Smtp-Source: AGs4zMZs9Ci5LH5qXD1qROVM6E6Ny+0U0eyCq+NjQKIv/MTSps3Nvhg0qYHHa8iJ5WcFfnC1uR4TxA==
X-Received: by 10.98.58.208 with SMTP id v77mr4578449pfj.150.1512100626671;
        Thu, 30 Nov 2017 19:57:06 -0800 (PST)
Received: from [192.168.206.100] ([117.249.175.222])
        by smtp.gmail.com with ESMTPSA id m22sm9712047pfg.120.2017.11.30.19.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 19:57:05 -0800 (PST)
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user
 input
To:     Jeff King <peff@peff.net>, lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-3-lars.schneider@autodesk.com>
 <20171130205137.GC3313@sigill.intra.peff.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <2f8d6037-b7cf-64e0-3cb6-6b684faa3144@gmail.com>
Date:   Fri, 1 Dec 2017 09:26:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171130205137.GC3313@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 01 December 2017 02:21 AM, Jeff King wrote:

> These are obviously the result of devils-advocate poking at the feature.
> I doubt any editor would end its output with a CR. But the first case is
> probably going to be common, especially for actual graphical editors. We
> know that emacsclient prints its own line, and I wouldn't be surprised
> if other graphical editors spew some telemetry to stderr (certainly
> anything built against GTK tends to do so).
> 

Yeah, at times 'gedit' does do what you say. And if the user 
(surprisingly!) uses an IDE such as "eclipse" or a hackable text editor 
"atom" (of course with the '-f' option) for entering his commit message 
it is likely to happen all the time for him.


> I don't think there's a good way around it. Portably saying "delete
> _this_ line that I wrote earlier" would probably require libcurses or
> similar. So maybe we just live with it. The deletion magic makes the
> common cases better (a terminal editor that doesn't print random
> lines, or a graphical editor that is quiet), and everyone else can flip
> the advice switch if they need to. I dunno.
> 

---
Kaartic
