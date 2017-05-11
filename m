Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97A58201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbdEKTSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:18:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32922 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934419AbdEKTR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:17:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so4650001pgc.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XPEGqSizkcmF5RqoAlBvHj69SHLNN0SZMT+DTV7osow=;
        b=G1gH6JB/TzsBPYNHK/huFQ9/vm/Gv/i6+mVzq6X82uClzuwDyEcgXyHY6UElDVz0dw
         BcUPMGYH5TNiTOmThROw2oHD68xGPOtdH7vxdaU1ozAv0Z/3zGOcPWtDhJvpoK8pmV1s
         VEiBq1Vv5lpKiQ4LOrC5eOfRskaZ53NWsWggzwLcrKbYqywWUO0Er2cq2aqLBne0peOO
         BwLddcRUZol710SRAVB3AwhKsHbFxBTQeE30jPGjucDZYrZqtBp4Nsw5Tau4lgblpI2g
         fHE3GETB+U1zpSa14Q3mNxBtqMYjOjN6bBj0yhJixX5iME/jLivJkpTvJPPL/oUk1xTn
         f66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XPEGqSizkcmF5RqoAlBvHj69SHLNN0SZMT+DTV7osow=;
        b=JoV43nOYQMR84bgwyO0A06AjplShxj6qc4IzEoKSZcKXDFeWF0jJZbfK3lLjRN7WaL
         3eNpNm3TO0Sc7Qi2bPRtBLPvwfvAJwWMtPVKezhcIOxIea97F3+khNTY5XJQA7UUNDep
         PIjcY8Ku2i42q+OIiMInq5cQSyrAHRUOv9VCcU7rpgKS4XgVvY9FnJbLDfaglReWmu0Y
         sems6vSZMkRhiIPQiJ+mejgfMTMW2DBJiYYmi37Tj68/9qzSsJyUGvJ2Ld7G+AID8+i9
         rMkUya+cesQlxq1wlJadYlFuNOFLOAETCBfBqIOr/4mht7QhQtp4gDh70apwfPucn87Z
         YH+g==
X-Gm-Message-State: AODbwcC5pOVq3+tA7AIrYJoJdj1HrZmU6IDEF39foELmZ/gRAUKgo1Et
        mzZZIPpE2Z+CSg==
X-Received: by 10.84.179.99 with SMTP id a90mr174312plc.26.1494530242565;
        Thu, 11 May 2017 12:17:22 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:ac23:a158:2bd3:569b])
        by smtp.gmail.com with ESMTPSA id 134sm1244199pgh.43.2017.05.11.12.17.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 12:17:21 -0700 (PDT)
Date:   Thu, 11 May 2017 12:17:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 0/2] perf: show that wildmatch() regressed for
 pathological cases in v2.0
Message-ID: <20170511191719.GC12516@aiede.svl.corp.google.com>
References: <20170511074354.11336-1-avarab@gmail.com>
 <20170511094108.8756-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170511094108.8756-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Ævar Arnfjörð Bjarmason (2):
>   perf: add function to setup a fresh test repo
>   perf: add test showing exponential growth in path globbing
> 
>  t/perf/README            |  1 +
>  t/perf/p0100-globbing.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  t/perf/perf-lib.sh       | 19 +++++++++++++++----
>  3 files changed, 59 insertions(+), 4 deletions(-)
>  create mode 100755 t/perf/p0100-globbing.sh

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
