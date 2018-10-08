Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5CD1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 18:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJIBmt (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 21:42:49 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37758 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeJIBmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 21:42:49 -0400
Received: by mail-qt1-f176.google.com with SMTP id d14-v6so13383739qto.4
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 11:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PlfXqYxVGoA236G5jSXdrcfYOZ4XBYg3yHtEDYVRXbw=;
        b=AcGgh/H2IQ8t7876U2jrCiinm11YREpnaeeIG/I9UmU/L99xpcMgHm6QFZST3mc1nA
         TOSg4Ke+HX8piOywioBLDyiU9xN5nC6B0LX2go44AgP//8HvrFRCBMVPEwsU96g6XtqW
         VKkOIEvFPz5h8m7+7K5fF5x9iL9YDC6EcS8kbAQ5QobO9CkSjff/1NPD36BjvE1VJRcD
         DUmZMI1HzC21z1qO5l4InQY7Gv0sUMuVagCEHEFFcI+lDY+WrfzBJeuKtTjtvmx2wj03
         RrKiy/hB7+dRMWOqHyCwHNBB8RvUdvT8ktdDyJMIeFP6lWCmreTzxhaHMLlpiCTUQcKw
         /DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PlfXqYxVGoA236G5jSXdrcfYOZ4XBYg3yHtEDYVRXbw=;
        b=Ac7wosR3+6F/HgN3FAz8+8hK09T3wHORl4+gtSxAZAFunnC8ILh0amobOCpUO4Nldl
         sAJFrKqYy3UHN3WDal9trxOehSY27aqZCSsNlS9dhIVfEK4LbW7/iMadaIPzgYmD9zkz
         sXrcnTixc4tOpjbvZohULX462dktpPCO1XxSJFAVbS1bAeYpy+mSFVTrwFjdYL1SaZZH
         SMm2ec/IFLzYOGy4XWYWSiQs01ThBnh1rfMdaaS6gDpOu6k4FdyjKhivIkYuGbvbzI1A
         q2y4FRDBtMxTqNfOeogSPxxnaaghOUJNx2BJIjxnjJkbjrpJ86F8n9xwKzqWraARkHVy
         1qpQ==
X-Gm-Message-State: ABuFfoiKx0bIybz62999ZfGIq/ybol3JUvuJUeM8Z0rpYG6Fn6UKZ1+j
        G2IFkq2LkxwlUHFPI8KAcBILGHpI
X-Google-Smtp-Source: ACcGV62EjDvnCytk3FcdHPStg/4mumCgPK53zipI6vNEzQQ3pycM58xSEnBj0NluO3UY09efHO8YrA==
X-Received: by 2002:a0c:d267:: with SMTP id o36mr6319006qvh.235.1539023387225;
        Mon, 08 Oct 2018 11:29:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1c56:381e:537f:a878? ([2001:4898:8010:0:58c:381e:537f:a878])
        by smtp.gmail.com with ESMTPSA id 135-v6sm8551194qkm.65.2018.10.08.11.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:29:46 -0700 (PDT)
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
References: <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost> <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
Date:   Mon, 8 Oct 2018 14:29:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008181015.GA23446@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2018 2:10 PM, SZEDER Gábor wrote:
> On Mon, Oct 08, 2018 at 12:57:34PM -0400, Derrick Stolee wrote:
>> Nice! These numbers make sense to me, in terms of how many TREESAME queries
>> we actually need to perform for such a query.
> Yeah...  because you didn't notice that I deliberately cheated :)
>
> As it turned out, it's not just about the number of diff queries that
> we can spare, but, for the speedup _ratio_, it's more about how
> expensive those diff queries are.
>
> git.git has a rather flat hierarchy, and 't/' is the 372th entry in
> the current root tree object, while 'valgrind/' is the 923th entry,
> and the diff machinery spends considerable time wading through the
> previous entries.  Notice the "carefully chosen path" remark in my
> previous email; I think this particular path has the highest number of
> preceeding tree entries, and, in addition, 't/' changes rather
> frequently, so the diff machinery often has to scan two relatively big
> tree objects.  Had I chosen 'Documentation/RelNotes/1.5.0.1.txt'
> instead, i.e. another path two directories deep, but whose leading
> path components are both near the beginning of the tree objects, the
> speedup would be much less impressive: 0.282s vs. 0.049s, i.e. "only"
> ~5.7x instead of ~24.8x.

This is expected. The performance ratio is better when the path is any 
of the following:

1. A very deep path (need to walk multiple trees to answer TREESAME)

2. An entry is late in a very wide tree (need to spend extra time 
parsing tree object)

3. The path doesn't change very often (need to inspect many TREESAME 
pairs before finding enough interesting commits)

4. Some sub-path changes often (so the TREESAME comparison needs to 
parse beyond that sub-path often)

Our standard examples (Git and Linux repos) don't have many paths that 
have these properties. But: they do exist. In other projects, this is 
actually typical. Think about Java projects that frequently have ~5 
levels of folders before actually touching a code file.

When I was implementing the Bloom filter feature for Azure Repos, I ran 
performance tests on the Linux repo using a random sampling of paths. 
The typical speedup was 5x while some outliers were in the 25x range.

>
>>> But I'm afraid it will take a while until I get around to turn it into
>>> something presentable...
>> Do you have the code pushed somewhere public where one could take a look? I
>> Do you have the code pushed somewhere public where one could take a
>> look? I could provide some early feedback.
> Nah, definitely not...  I know full well how embarassingly broken this
> implementation is, I don't need others to tell me that ;)
There are two questions that I was hoping to answer by looking at your code:

1. How do you store your Bloom filter? Is it connected to the 
commit-graph and split on a commit-by-commit basis (storing "$path" as a 
key), or is it one huge Bloom filter (storing "$commitid:$path" as key)?

2. Where does your Bloom filter check plug into the TREESAME logic? I 
haven't investigated this part, but hopefully it isn't too complicated.

Thanks,
-Stolee
