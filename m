Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9109208B8
	for <e@80x24.org>; Mon, 14 Aug 2017 09:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdHNJ0e (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 05:26:34 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38816 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdHNJ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 05:26:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so6651910wrd.5
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DBEfWeXPpsMXKuTiTFdWI5gQkPTSYn48fjPqLydG5TY=;
        b=KpUwoxeOI15sFZgbfwXFziE4X+zaH3Z/VSqjiLnmBxniCQp98K3Bqmq56cICtsgjJF
         y4vAcq+1QbRSY/Zw9y+Vvl8+u7/0j+DzUiUNQHZI4r92DbRbU+gT78CpQDh7sGNo0wOh
         Tnno3NEcKtWHLD/tqF58bykf6UwXYVFknn21qU4ac+HD2YHlpI5AF0ayFPX+EikACXJb
         1jBE5SNxcTDR207O7ZGmdsu+4KtTCya1LOtq+8LPlpCEaHqohEQE0yip3yYgOYnbh8jE
         RWCNsaRONPMn2HoG2XYL3ieaFyiJoy3hvdVdS20YWeM5n7EFOyD6QEPmvYZKnFcPlI9u
         0+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DBEfWeXPpsMXKuTiTFdWI5gQkPTSYn48fjPqLydG5TY=;
        b=LPgntOdA8gsYUaZMq+9zt5gs3XFCoIF3LqeHyHWb6MrGlbKX2SAexLMs7DHLXDSS2H
         uWbZKhgJjPpFF2CnJpVGD/0+eC4/VhZbJ5GHkqHgukyYd+apvqU80OyJJUKHapRay8ZK
         3gYX9Hd/VTAYFAqM/5VZghNq8DFULvq6eXUZ0+wvhTfm9ZvOdNbAbB11br3OT4D273be
         IJUGfIlEfPWwXY8C1nTHhB2qTtwkicW0F8r0ww2SsO6CiPxTUjzU1RSF7wLYRJuVvVYA
         4PY38FGmH+opQiA6IgP9JrGUFbr89SOY3RBO5U7zqksCuFwYCvkPmu7T+wAgItNu45Jb
         biBw==
X-Gm-Message-State: AHYfb5iBPmXUPatKc9ryJlsWzDc3oZ6b/jD0IrzrQoASCcmdF+snfZdz
        PPe4kyqIpkNzhA==
X-Received: by 10.223.144.131 with SMTP id i3mr15415542wri.40.1502702792242;
        Mon, 14 Aug 2017 02:26:32 -0700 (PDT)
Received: from [192.168.10.165] (94-39-192-75.adsl-ull.clienti.tiscali.it. [94.39.192.75])
        by smtp.googlemail.com with ESMTPSA id h190sm4830687wmd.4.2017.08.14.02.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2017 02:26:30 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] interpret-trailers: add --where, --if-exists,
 --if-missing
From:   Paolo Bonzini <bonzini@gnu.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20170801090333.32642-1-bonzini@gnu.org>
Message-ID: <0ac82014-4da9-9ef2-5da0-07996c8aa8fd@gnu.org>
Date:   Mon, 14 Aug 2017 11:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170801090333.32642-1-bonzini@gnu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2017 11:03, Paolo Bonzini wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> These options are useful to experiment with "git interpret-trailers"
> without having to tinker with .gitconfig (Junio said git should ahve
> done this first and only added configuration afterwards).  It can
> be useful in the case where you want a different placement for the trailer,
> or for scripts/aliases that don't want to rely on specific .gitconfig
> settings.
> 
> Compared to v2, the main change is that option order on the command-line
> is respected.  That is,
> 
> 	--trailer 'acked-by: foo' --where end --trailer 'signed-off-by: me'
> 
> will only apply where=end to the second trailer.  Likewise,
> 
> 	--where end --trailer 'signed-off-by: me' --no-where \
> 	--trailer 'acked-by: foo'
> 
> will only apply it to the first, reverting to trailer.*.where for the
> "acked-by" trailer.

Junio, I see you haven't yet applied this v4 to origin/pu, did you miss it?

Thanks,

Paolo

> Paolo
> 
> v1->v2: support --no-* options, minor code fixes
> 
> v2->v3: largely rewritten to respect option order on the command-line;
> 	keep trailer.h namespace clean (Christian)
> 
> v3->v4: fix compilation warnings (Junio), added documentation fix
> 
> Paolo Bonzini (4):
>   trailers: export action enums and corresponding lookup functions
>   trailers: introduce struct new_trailer_item
>   interpret-trailers: add options for actions
>   interpret-trailers: fix documentation typo
> 
>  Documentation/git-interpret-trailers.txt |  27 ++++++-
>  builtin/interpret-trailers.c             |  73 +++++++++++++++++--
>  t/t7513-interpret-trailers.sh            |  66 +++++++++++++++++
>  trailer.c                                | 118 +++++++++++++++++++------------
>  trailer.h                                |  43 ++++++++++-
>  5 files changed, 274 insertions(+), 53 deletions(-)
> 

