Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F201F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfHXIDc (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:03:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46015 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfHXIDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:03:32 -0400
Received: by mail-io1-f66.google.com with SMTP id t3so25465902ioj.12
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aldemFVdAIcXnBpr88QsZWvktMDt+ySM6cuaIsQeD3E=;
        b=NEooi2UtpTTylYbAv+AVapOqy8a/k4VzVU/ZfO2mAktHIjXSoG4ZPcNFzti+Sv2QHb
         fzxw/F2rFxQNAmfQfDaF5a0zYGQnnUKn1CkKbcY9ZnpwpWSvr5yozvwBevxC7GDAL9Yq
         R2SBmVmfPEVQJx8+6zH4Bd63cVS54k9bh0cyK/IG3Br6VokuCzEz5RDNAMb2zYluwPjR
         VSLdUGW/7NTIo0wgAxN3GdYaM1q5PHaq1+C4tbgLrv3GtbLfAGSC4OiS+J6Hq31cbBks
         tKdpQy92l00CKS7tHtcZoT7xQHask0hC1Gf8uc/sWbwjxqHD1/AsY/Jfc92q8uf1zF/I
         W1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aldemFVdAIcXnBpr88QsZWvktMDt+ySM6cuaIsQeD3E=;
        b=Yn9dA+TKvlOPM2tBjU+jP6j4f7CyplOheZQS0KpwP5OgLUyDuoYXv2M/YKMEPjfh7B
         4onYtad+uSnBg1HTZNTfiGdaGnBodOUCjiXbW9Q8uoaJawTiJGvwWH3qss0JDC8IHOcU
         Ds8SY4ZSQdwcgNlGKlFpRGeAF73tnlCUutNK9iYoFlZDGeo0WjXC+9E85IoDApRNKHGC
         /v0X6o0KO4CXkB9V9Yy/ZrLgNHSkB9EZCMGtYJmYV5bIyeV/ZFcaMuNlsv1sT40TWTqo
         0tyxRbVrVIO7SnVz66Bk/QfQ3pYuu+Wt5WQDRiQcvyVDGYOncWJrxTRVC8Ysz0jrYLLk
         pjVg==
X-Gm-Message-State: APjAAAXV8cUheXqUZOwhWDQlnZPi5KIunYTJj0N6nOXUOXLdrzuJzq9s
        zaUEXyc/VZ5h8wMMc+3qd7ZjsQB0
X-Google-Smtp-Source: APXvYqz/Euq8EH4iMpbtCxfeD73R/U/08zTbf1/HKwNpUpNUYGnnJCCmmDFaaIATsAoLZZaNt2CPbA==
X-Received: by 2002:a5d:9746:: with SMTP id c6mr6410939ioo.235.1566633811100;
        Sat, 24 Aug 2019 01:03:31 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id l8sm5251702ioh.85.2019.08.24.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:03:30 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:03:28 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
Message-ID: <20190824080328.GA9726@archbookpro.localdomain>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
 <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
 <20190823181545.GA14048@archbookpro.localdomain>
 <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
 <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 01:18:44PM -0700, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
> 
> > Perhaps the `--infer-cover-subject` the config option needs to be
> > multi-valued to include:
> >      "subject" (always expect short first lines) or
> >      "message" (always the long paragraph description, still use
> > ***Subject Here***),
> >      with the "true" being used when expecting both as previously
> > described.

Good idea, I like this a lot!

> 
> The idea to have three choices feels that this is getting better,
> but I notice that the choice is no longer about "subject".
> 
> I've always felt that the name of this option is way suboptimal.
> One reason is because the option only says it is about the subject
> of the cover (letter), and the verb "infer" conveys almost no
> information---especially it does not say anything about what affects
> the inference (hint: the branch description value gets used, in a
> single hardcoded ways right now, but now with the patch we have a
> choice to control how it gets used).

Perhaps something like
--cover-subject-from-description={true,auto,false}?
