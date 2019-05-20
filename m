Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEA51F461
	for <e@80x24.org>; Mon, 20 May 2019 01:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfETBdN (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 21:33:13 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:44002 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfETBdN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 21:33:13 -0400
Received: by mail-qk1-f180.google.com with SMTP id z6so7854213qkl.10
        for <git@vger.kernel.org>; Sun, 19 May 2019 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vdpHX7+BrUsTA7xgAOUiS9/XeTe3KOG8hBrHz9sdVyI=;
        b=cAv3MkeZXtC5/ClmRZ0WMOHxZTyGRdsytpc95nFpQ4qlGu1jLVMHI5qQ2ltJNpUg7I
         uR0w8aW1Qwkjh6cNkBKcdrbhbAgszQAhS8IebzEdXNxQB/K6QKhdYeOqYsp+biOiCB+5
         /2Nt9TiM6b7sxAm9XBF3/cnVWydhz6gj+gnMFsRqll5edrTNHc+YAAh4YQAvoRHV0BRb
         0b6+Sgk+u9vbgVnLJCFAzQkq0wP6SZZ3kECTvwB2MBReUs/6qJF3lLUoIINOIYt/dvn2
         a1a91BKwAmMwBFvlAdN48RpB5qFxn+THJgmD84JMhmJzb/aW1XlF1Yz1T8cZCYFqY2rn
         KXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdpHX7+BrUsTA7xgAOUiS9/XeTe3KOG8hBrHz9sdVyI=;
        b=p3FNBYcd284jnBcxFSRCqtHRK3cLu3miA3pUx2EDIJBwJ8EgGU8aU6iPhcNIwjEGF7
         ed3XSZ8N5BoSdOZeB8S6XxrlWWqQR/9qfFQa5Ef+H4HGOCyB2vv9FtnxnphDyy7hy/tH
         gqk0DtDA0lsq2o848ta9W41Je66S+FTQT4/ABslhC4ugU1ve+yGMAULD8Hp06RcBjcQ3
         asQrp/DF+NtVYThvhx1Uc3cSdls37E5c/Ixh1QbxmaHvHtfnMP9NMYBIown1hB5Hb++R
         KbTvmisMO+JInmuZqxWPv3BKNNh/A8bF/ulYJydZp23euEBXM+Lwkfz2NRA4Hb8/1stj
         TzcQ==
X-Gm-Message-State: APjAAAWBmWCAuhxj0oL0hcIAUPg4t8d5egIzKimCaJh7j4G4bWd69DeO
        WBrlaN1T342j4zrv7E49zo7GHYbTzLQ=
X-Google-Smtp-Source: APXvYqwMgSuhdPnfhmrRdLrgkWZsKsKsND7FLOWDpyzZegzy+jCGwhNp99mfWevxmbeAtl8UvlCfig==
X-Received: by 2002:a05:620a:403:: with SMTP id 3mr55527353qkp.221.1558315991976;
        Sun, 19 May 2019 18:33:11 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id k8sm3789603qke.16.2019.05.19.18.33.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 18:33:11 -0700 (PDT)
Subject: Re: Revision walking, commit dates, slop
To:     Mike Hommey <mh@glandium.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
Date:   Sun, 19 May 2019 21:33:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190518041706.ct6ie5trvxgdhjar@glandium.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2019 12:17 AM, Mike Hommey wrote:
> On Sat, May 18, 2019 at 12:58:28PM +0900, Mike Hommey wrote:
>> On Sat, May 18, 2019 at 03:50:05AM +0200, SZEDER Gábor wrote:
>>>
>>> All the above is without commit-graph, I presume?  If so, then you
>>> should give it a try, as it might bring immediate help in your
>>> pathological repo.  With 5k commit in the same second (enforced via
>>> 'export GIT_COMMITTER_DATE=$(date); for i in {1..5000} ...') I get:
>>>
>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>   0.069
>>>   $ git commit-graph write --reachableComputing commit graph generation
>>>   numbers: 100% (5000/5000), done.
>>>   $ best-of-five -q git rev-list HEAD~..HEAD
>>>   0.004
>>
>> I'm not observing any difference from using commit-graph, whether in
>> time or in the number of commits that are looked at in limit_list().
> 
> -c core.commitGraph=true does make a difference in time, but not in the
> number of commits looked at in limit_list(). So it's only faster because
> each iteration of the loop is faster. It means it's still dependent on
> the depth of the dag, and the larger the repo will grow, the slower it
> will get.

The plan is to use the commit-graph's generation numbers for these A..B
queries, but due to some cases when commit date is a _better_ heuristic
than generation numbers, we have not enabled them for A..B. You'll see
that 'git rev-list --topo-order -n 1 HEAD` will be much faster with the
commit-graph, but adding '--topo-order' to your 'HEAD~1..HEAD' query
should not change the time at all.

See [1] for the discussion about "generation number v2" which will allow
us to use a better heuristic in these cases.

Thanks,
-Stolee

[1] https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/
