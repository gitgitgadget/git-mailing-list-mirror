Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A8C01F516
	for <e@80x24.org>; Fri, 22 Jun 2018 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeFVRKC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 13:10:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33736 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbeFVRKB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 13:10:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so3516872pfi.0
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OocjW+2RdzE2p7+k6exNonzOYJCb9YNUyT/9rUXaqCY=;
        b=ne5u7GcXnPMKS/i10RxI/th1qhfynqyWnP22zer1IqeVafnjsmw239xEQhs664o1xj
         ag5u4yTWQFTZbXhc3ppsui/usbkQth4vUu9729AFmAGwCMFNAhS9lcCzNFjFG5NgT9Ez
         pqUmXmisqr3TlHvdUcCvkFDqYpdYkX7ixDXIvlzQBl3f6IEmGn7Mc6xY9DUvN1A9ptSZ
         7DnTAvgv8ursYYPrd4vyNY3udEBdN+A+s8pPsPtD5n5wrkXbw2RNAPCZAmzrllzvbpR3
         sv9OjnjMpk9HnIPayZjC0TpbCdEyKPCHihISzZ4Cy5socqvgzufQPsxIOTT+U0dTBb0Y
         P9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OocjW+2RdzE2p7+k6exNonzOYJCb9YNUyT/9rUXaqCY=;
        b=Kg1okpvdzkTAHB/MncXApJBuWXuRqQGkJ3J1ACf0jzBcrbLoG0hwZJ0U+J4UsFb3nM
         JWl+qMZK3bkemtdcDi+IDVq7wyJhnJX0+MO4i3Q7hPESbAfFwsnY7foiwVZJQjIYqsML
         4jeALSLXSnwAWSsaEIdyMoPUIwYBu8VJQVf6mlJt1oNPIBbcvW/FyTmbhrfeaem3dI+z
         Oq6daTQ9G+Bha+f9ZBERQq/0KvQ56KsuLZTxQPAJVjKqXPppaW+EqlKJ2py0cMiBSVqb
         d6kOOAYAOYYuvk5g/TpowtjsTYeAK/mD5n+4u9y6P+/yVK0iRsxUiVZjExWeg//eLuig
         +oaA==
X-Gm-Message-State: APt69E2jLBI2aHS5blJKh/mDgfHFrqIV9UYAGiWyUPpeTJn3kRUUKh+b
        eIvIh81H65TgQ/jrvn5AY00PeFjX0/k=
X-Google-Smtp-Source: ADUXVKJSLAmmwocAqJLe+4B4IB0kG0FfrSblojSScoIONpP4cXPR43Ldze6fHkkTayxRPz4M93UMHQ==
X-Received: by 2002:a65:5648:: with SMTP id m8-v6mr2155348pgs.19.1529687400970;
        Fri, 22 Jun 2018 10:10:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l11-v6sm11881195pff.50.2018.06.22.10.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:09:59 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:09:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] submodule-config: cleanup backward compatibility
 helpers
Message-ID: <20180622170958.GD244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
 <20180622162656.19338-8-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622162656.19338-8-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> Use one callback per configuration setting to handle the generic options
> which have to be supported for backward compatibility.
> 
> This removes some duplication and some support code at the cost of
> parsing the .gitmodules file twice when calling the fetch command.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>

I'm not sure how I feel about this patch, I'm leaning towards not
needing it but I like the idea of eliminating the duplicate code.  One
way you could get rid of having to read the .gitmodules file twice would
be something like the following but I don't really think its needed:


diff --git a/submodule-config.c b/submodule-config.c
index ce204fb53..7cc1864b5 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -681,19 +681,24 @@ void submodule_free(struct repository *r)
 		submodule_cache_clear(r->submodule_cache);
 }
 
-struct fetch_config {
-	int *max_children;
+struct fetch_clone_config {
+	int *fetchjobs;
 	int *recurse_submodules;
 };
 
-static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
+static int gitmodules_fetch_clone_config(const char *var, const char *value,
+					 void *cb)
 {
-	struct fetch_config *config = cb;
+	struct fetch_clone_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
-		*(config->max_children) = parse_submodule_fetchjobs(var, value);
+		if (config->fetchjobs)
+			*(config->fetchjobs) =
+				parse_submodule_fetchjobs(var, value);
 		return 0;
 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
-		*(config ->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
+		if (config->recurse_submodules)
+			*(config->recurse_submodules) =
+				parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
 
@@ -702,23 +707,20 @@ static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 
 void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
 {
-	struct fetch_config config = {
-		.max_children = max_children,
-		.recurse_submodules = recurse_submodules
+	struct fetch_clone_config config = {
+		.fetchjobs = max_children,
+		.recurse_submodules = recurse_submodules,
 	};
-	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
-}
-
-static int gitmodules_update_clone_config(const char *var, const char *value,
-					  void *cb)
-{
-	int *max_jobs = cb;
-	if (!strcmp(var, "submodule.fetchjobs"))
-		*max_jobs = parse_submodule_fetchjobs(var, value);
-	return 0;
+	config_from_gitmodules(gitmodules_fetch_clone_config, the_repository,
+			       &config);
 }
 
 void update_clone_config_from_gitmodules(int *max_jobs)
 {
-	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
+	struct fetch_clone_config config = {
+		.fetchjobs = max_jobs,
+		.recurse_submodules = NULL,
+	};
+	config_from_gitmodules(gitmodules_fetch_clone_config, the_repository,
+			       &config);
 }

-- 
Brandon Williams
