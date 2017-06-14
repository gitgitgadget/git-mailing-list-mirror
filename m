Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F13A1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 01:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbdFNBZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 21:25:40 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32788 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdFNBZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 21:25:39 -0400
Received: by mail-pf0-f178.google.com with SMTP id 83so75795498pfr.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0PzBXWy+hoa5qtr7sL4KyEpdZv4xe50Bt9jElehyYGI=;
        b=DfccpBqUJxmDXM5tppsfUbsYvjAJ1eri51iKFKtJ8vntGSpQzKxaEMy/xbemQrFpwT
         ZJe8VaxS5so0uliwZFijEoz1mZ+LXzHPLXaSWEo/MMNTZvx2o3awR3iMEK63ul3KAvfa
         o7qZb/ywqirCUjq/7dTBF0Y3sCcvnLeLmNHCPGlHYfVKwTcbhl86QFWDo8BBqzEuYzWs
         P7ivOEkcoyiL20Dhqa683DK0GWZyaMDiDB2hDPjYVQn529qQGw6JWCz35feEYK11Ug6H
         T5r3mkdUHiMz6xabR29Rgv3slMezKFhX6/U5cToyDSbSbOas4ZdVXuw0efIBYMVlPRmX
         u3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0PzBXWy+hoa5qtr7sL4KyEpdZv4xe50Bt9jElehyYGI=;
        b=higOYITUKrLCZ98KUYXn1x6cjhijsCHPU5PwPbOfDsS+IhCBSJE5CpBlzu9lfX7l+m
         V+rlOCzoOq5ZnFVZb+VYuwudgLKR1Wc2wBLkyMoGmthy0MDakwjPMsmPQ2RcTIM3WJ9E
         YwGx9MwDVLB4iQR7beLbM7Wu8sc9syl+trSgY99u2UCkTEZiDCeL/uHCauTE0+kmG8qO
         pCXcydx02QRGCrArfrU+j/zkHsGqVfEHp/2hGK0P/2DG6l44XWg3YDQpPsKLH9JCC9U8
         Tsisy3r6XcuTPhJwmIToOG3jZFhYITynJoB7T7Vth8kIE9aknYuIJctskCbxJVxdNpUK
         w79Q==
X-Gm-Message-State: AKS2vOyjspC7DFmWlgpT1Y1ARHpiALDzarv4hLbhnapsyoY+M/95xK6D
        f3OvESqThZOgNA==
X-Received: by 10.98.153.6 with SMTP id d6mr1668810pfe.223.1497403538648;
        Tue, 13 Jun 2017 18:25:38 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id v21sm21427713pfk.75.2017.06.13.18.25.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 18:25:37 -0700 (PDT)
Date:   Tue, 13 Jun 2017 18:25:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t1308-config-set.sh fails on current master
Message-ID: <20170614012535.GU133952@aiede.mtv.corp.google.com>
References: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170614011514.sh4euddp44hjbu4u@sunbase.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Øyvind,

Øyvind A. Holm wrote:

> t1308-config-set.sh fails on current master (v2.13.1-449-g02a2850ad58e). 
> The error is introduced by commit e2d90fd1c33a ("config.mak.uname: set 
> FREAD_READS_DIRECTORIES for Linux and FreeBSD"). Reverting the commit 
> results in a conflict, but the test works on the commit before, 
> 02912f477586.
>
> Tested on
>
>   Debian GNU/Linux 8.8 (jessie)
>   Linux Mint 18 Sarah

Interesting.  I'm not able to reproduce it, but of course that doesn't
mean much.

> Test output:
> 
>   $ ./t1308-config-set.sh
>   ok 1 - setup default config
>   ok 2 - get value for a simple key
>   ok 3 - get value for a key with value as an empty string
>   ok 4 - get value for a key with value as NULL
>   ok 5 - upper case key
>   ok 6 - mixed case key
>   ok 7 - key and value with mixed case
>   ok 8 - key with case sensitive subsection
>   ok 9 - key with case insensitive section header
>   ok 10 - key with case insensitive section header & variable
>   ok 11 - find value with misspelled key
>   ok 12 - find value with the highest priority
>   ok 13 - find integer value for a key
>   ok 14 - find string value for a key
>   ok 15 - check line error when NULL string is queried
>   ok 16 - find integer if value is non parse-able
>   ok 17 - find bool value for the entered key
>   ok 18 - find multiple values
>   ok 19 - find value from a configset
>   ok 20 - find value with highest priority from a configset
>   ok 21 - find value_list for a key from a configset
>   ok 22 - proper error on non-existent files
>   not ok 23 - proper error on directory "files"
>   #
>   #               echo "Error (-1) reading configuration file a-directory." >expect &&
>   #               mkdir a-directory &&
>   #               test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
>   #               grep "^warning:" output &&
>   #               grep "^Error" output >actual &&
>   #               test_cmp expect actual
>   #
>   ok 24 - proper error on non-accessible files
>   ok 25 - proper error on error in default config files
>   ok 26 - proper error on error in custom config files
>   ok 27 - check line errors for malformed values
>   ok 28 - error on modifying repo config without repo
>   ok 29 - iteration shows correct origins
>   # failed 1 among 29 test(s)
>   1..29

What is the output of the following command?

	./t1308-config-set.sh --run=1,23 -x -v -i

Other diagnostics:

- what is the output of "env"?
- cat ../GIT-BUILD-OPTIONS
- if you run that under 'strace -f -o /tmp/strace.out', does the
  strace.out say anything interesting?

Thanks,
Jonathan
