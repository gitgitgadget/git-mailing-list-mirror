Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C721F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 01:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNBKx (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 20:10:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45215 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfKNBKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 20:10:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so4500489wrs.12
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 17:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JRW3eJzsPp8CR6dE2sFec2f7j91Q1vd7vUv2TYkVwds=;
        b=anXlJW/PEsxmjNE9mRlPf1e+UjlSkee6s6BX+VTMHBwBwdJS2ZYe47v59uVdcQvmou
         flHIssVIH19sA8GSUCMIgdAqtiaomM60ue6YGUIQYe3BUI82IcRIra5UK+PLRVs8bNvY
         znfDQx0FDhGLMSHB5ZQGxzXM3/ApiCiZdMpFnHHFCQTcLJwFjGpmmuf4jNzF4FE3pBZw
         9V92nZPUJYKf3KymC5hthmFch0A7Z7zfCKoHlXPCdLJlaP4d+mrB+0f5FNizQbUfizOc
         zXRym5pz2nSsDzrC2b5O+TzuvUPXcePkU/FzFCgezRretdB7DMdmVhBS8wbrqp4sKHGJ
         DUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JRW3eJzsPp8CR6dE2sFec2f7j91Q1vd7vUv2TYkVwds=;
        b=Jd6nH6gdjXFQQwdZS8MqBjvt9L/LDv4dtHBn2o9OcVPmRhireRUV/gYmWbhuDA0LUn
         xIQy5vCdZ/Zy65WSF+0t/FE42gge9zQqZlSiaXLd+u/buIDUgeCMHzFv9DJrbG4h8hqz
         OR6MhKK2yxP3DyRS3S/Vd06SEXkhzuuxE4be826l5fm9AnJ32IuWP2Fl6khbhyQMvGr/
         FV/MPoIWPSxf7NymxLvZz6tIVhX45EEAq3V0QXDRJUVIqd8VZXfHtQJB58JWKC+SiGA4
         lPfMjHollzI4ScKEbR9uq3FtVk+3f9QiGuutyUVgaUclIH6uEmE3oPH1w1sv0w36tdbD
         0Q7A==
X-Gm-Message-State: APjAAAW2f11VedpnuR+96k2TGoEUvJCCsuBdi9bGBh+9JELl1hRV2eRs
        QbTE4/leE/FfRtDQtlsGweY=
X-Google-Smtp-Source: APXvYqzsI0PP9nAKXtCPPujUltQqDJvK3tDLMi5zYq1+iPNolFGl10PDSxdvkO3cNmh76tnuAOST+g==
X-Received: by 2002:adf:ab41:: with SMTP id r1mr5904305wrc.281.1573693851120;
        Wed, 13 Nov 2019 17:10:51 -0800 (PST)
Received: from szeder.dev (x4db60f58.dyn.telefonica.de. [77.182.15.88])
        by smtp.gmail.com with ESMTPSA id u2sm5791990wrg.52.2019.11.13.17.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 17:10:50 -0800 (PST)
Date:   Thu, 14 Nov 2019 02:10:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
Message-ID: <20191114011048.GS4348@szeder.dev>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
 <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 08, 2019 at 12:08:34PM -0800, Denton Liu wrote:
> The standard format for referencing other commits within some projects
> (such as git.git) is the summary format. This is described in
> Documentation/SubmittingPatches as
> 
> 	If you want to reference a previous commit in the history of a stable
> 	branch, use the format "abbreviated hash (subject, date)",
> 	with the subject enclosed in a pair of double-quotes, like this:
> 
> 	....
> 		Commit f86a374 ("pack-bitmap.c: fix a memleak", 2015-03-30)
> 		noticed that ...
> 	....
> 
> Since this format is so commonly used, standardize it as a pretty
> format.

SubmittingPatches is simply wrong: our de-facto standard format for
referencing other commits does not enclose the subject in a pair of
double-quotes:

  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \("' |wc -l
  785
  $ git log v2.24.0 |grep -E '[0-9a-f]{7} \([^"]' |wc -l
  2276

Those double-quotes don't add any value to the references, but they
result in weird looking references for 1083 of our commits whose
subject lines happen to end with double-quotes, e.g.:

  f23a465132 ("hashmap_get{,_from_hash} return "struct hashmap_entry *"", 2019-10-06)

and without those unnecessary pair of double-quotes we would have
~3000 more commits whose summary would fit on a single line.

