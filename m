Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876DD1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 22:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIODnV (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 23:43:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeIODnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 23:43:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so11984375wrt.3
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D5Li1SwlQPyheODxd+RA4NKsVJJ3srAOW/F5Cx8dZlg=;
        b=VFbf0ElqYWB0/QpTCQtqkrYx9usWtpZnMS6scN3PHNGtAyJOefdW/ic4v3cH2PPzvi
         swScRmcSLFi1O1gpahc2SPpx4lNJk4TtKZfFECR64whLKbykpD9qjodSnt+wrGilCgEu
         Qo18e2YGTM+DXSSClfVgSTJheb/SY//7GPBKiyPJHS4oxKnzyHv6Wr1WnnADIZePbx6N
         wlbXFeZFsWuwMRS8nwgHlU091jaZxjrukDQandKNaVjO36AJFcIyKrQNjWniSk3MSRFt
         vK8GpYpLkkuqDaGl1OgJ4n/mkzJU0JNlhuGuc9UYmpwcR4gLq7OvQRO/SnxubUnydC0d
         bVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=D5Li1SwlQPyheODxd+RA4NKsVJJ3srAOW/F5Cx8dZlg=;
        b=BxrHsxzR0ERpPnhqF40PnP/gv6ynFLSa6rWQo36btMqnYPEDf1EipGWWvZqP+WNkV4
         VuL5+tFz9WtuNKWxfsIdKG75LntiSAy1AdIm92wy+pvYG0kpWX3E3KWegsE3+6dayQJZ
         UFb1SFlRdYD2XlgzW0KFCUwkm8OndxqJhXLDNtvVB4LpSQ9qF86Q059jnUtqbYiKKU29
         7NvsLt0BYVYIMwH6BkLDWoJh7uMeKEkkFMDv/bAKtmsLOznr0RDflprxf+LpwLZNa/fh
         NcwgwEJ2QYxz5ZiLmqVp6ahrqeWeCMtub6rprTR/HugVpY5x20Dh5Y8pJAUDuoBWVzJZ
         FiQA==
X-Gm-Message-State: APzg51DHvTdqAaKXAuu6dj07mu9ZfskZysj7bEDPN2OpLrXO/7KHu4l/
        1NHsxp/+A31wTGXr32sFeNQ=
X-Google-Smtp-Source: ANB0VdZFQKJqzZxANP2ZhckjKJ7iAg3mvZrlC63JWjB1U/Yv2rxwWeCR3wYZvXQnBu2eabV+9fteoQ==
X-Received: by 2002:adf:f7c4:: with SMTP id a4-v6mr11715781wrq.86.1536964012666;
        Fri, 14 Sep 2018 15:26:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s131-v6sm195764wmf.2.2018.09.14.15.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 15:26:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "peartben\@gmail.com" <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 4/5] read-cache: update TEST_GIT_INDEX_VERSION support
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
        <20180914201340.37400-1-benpeart@microsoft.com>
        <20180914201340.37400-5-benpeart@microsoft.com>
        <xmqqtvmrafs5.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 14 Sep 2018 15:26:51 -0700
In-Reply-To: <xmqqtvmrafs5.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Sep 2018 15:13:46 -0700")
Message-ID: <xmqqpnxfaf6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ben Peart <benpeart@microsoft.com> writes:
>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 653688c067..397eb71578 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -134,9 +134,9 @@ export EDITOR
>>  GIT_TRACE_BARE=1
>>  export GIT_TRACE_BARE
>>  
>> -if test -n "${TEST_GIT_INDEX_VERSION:+isset}"
>> +if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
>>  then
>> -	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
>> +	GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
>>  	export GIT_INDEX_VERSION
>>  fi
>
> Is this done a bit before ...
>
>> @@ -159,6 +159,7 @@ check_var_migration () {
>>  }
>>  
>>  check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
>> +check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
>
> ... this has a chance to kick in to say things like "Whoa you have
> TEST_GIT_INDEX_VERSION that is an old spelling of
> GIT_TEST_INDEX_VERSION", isn't it?

So, the obvious fix would look like the patch below.

One problem with warning is that

	$ TEST_GIT_INDEX_VERSION=4 sh ./t0000-basic.sh

(or any other depreated variable set without its modern counterpart
set) would fail due to extra output produced to the standard error
stream.

 t/test-lib.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 17a56f44ad..8ef86e05a3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,12 +134,6 @@ export EDITOR
 GIT_TRACE_BARE=1
 export GIT_TRACE_BARE
 
-if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
-then
-	GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
-	export GIT_INDEX_VERSION
-fi
-
 check_var_migration () {
 	old_name=$1 new_name=$2
 	eval "old_isset=\${${old_name}:+isset}"
@@ -162,6 +156,13 @@ check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
 check_var_migration TEST_GIT_INDEX_VERSION GIT_TEST_INDEX_VERSION
 check_var_migration GIT_FORCE_PRELOAD_TEST GIT_TEST_PRELOAD_INDEX
 
+# Use specific version of the index file format
+if test -n "${GIT_TEST_INDEX_VERSION:+isset}"
+then
+	GIT_INDEX_VERSION="$GIT_TEST_INDEX_VERSION"
+	export GIT_INDEX_VERSION
+fi
+
 # Add libc MALLOC and MALLOC_PERTURB test
 # only if we are not executing the test with valgrind
 if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
