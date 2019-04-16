Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0776520248
	for <e@80x24.org>; Tue, 16 Apr 2019 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfDPOwU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 10:52:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42691 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPOwT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 10:52:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so23567881qtc.9
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pMvWJxS7gbzaD5tNEAxOakuHfkPqer5B59S4+dZ8h3A=;
        b=pR/WTk6zokn9f51LYxH97KHsK5k84phcsn0MLwgUHsLUk6QwiaD17Sybo1O4JDY+O/
         /gCvFGo0fTnrUVEoE/Y3hMyIz46ABvJXBP2mMIhKoydHHuKwRnei3AJ/rk2Dv34wWDj5
         eymxI2tfGgikkui/LQUt7hAR3lt61qdOqpGX50mjIReOtEhVUirKWBsycoRydM4xFsAJ
         VmqzONu4/udp4UfcTwN7HgMhjnSh2RvaE++vCnyc93YJC0U74buHa2rAAmIXP4UQS5rp
         VUd8NVF1WpW64EGf0/B/NbvoStNbvdhVa9UWgtm0K0JoDtLTRj76iJHmhp/dNRA885Ap
         n2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pMvWJxS7gbzaD5tNEAxOakuHfkPqer5B59S4+dZ8h3A=;
        b=ZkBmjzYXTmVw3iPHjrSbHWWJ+0AwQCfYovTag2r2Wfu4ekQlr7VxEtXyh/4+L0VWg9
         XTtJ3f8z9bTlEnDH5IMMrA8MvkmJvYJA6lSZpylunexdp4XGYkAuyIySW3AoWSoyTGiq
         2Z4Na8revmRFOeDEwljmMUwcyyeZMkhCr1/BG7pxjA2Ops8Kt4D1He/I7jhizngZiiiS
         wqKdSCZEhha36YF6uGtj0V49lDrR/3lCYb1HeTJVCceqxxxX3BdgOcCObZ0KXEdk0p88
         sTda5CLK/QdmWH8JlhytuhImdBAfAwg2AYLmC0Zmp/KPPX2rmVMdteOzVvpAIhHKi+iB
         ysBg==
X-Gm-Message-State: APjAAAU9z9+S9BD2vVNVJ4mvf1rG69xy9Xbo/yziWL5sn3+wzlyQ8h+y
        4yeHKSTpVt42k1zQxvxGG4OBUHREiKid8A==
X-Google-Smtp-Source: APXvYqyrAyD7gjpyjDNE1CiFi9oUZ/r5i1EZRsRNjUVQEAjaaPQ/J8M3bRs3OPBN853f9ml+XMbsIQ==
X-Received: by 2002:a0c:9945:: with SMTP id i5mr65085018qvd.159.1555426338039;
        Tue, 16 Apr 2019 07:52:18 -0700 (PDT)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id d34sm37133029qta.18.2019.04.16.07.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:52:16 -0700 (PDT)
Subject: Re: feature request: .blameignore
To:     =?UTF-8?Q?Christian_Gonz=c3=a1lez?= <christian.gonzalez@nerdocs.at>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
References: <130b0ffd-ed84-59ea-751b-cc59241cab1f@nerdocs.at>
 <20190415211519.GG1704@hank.intra.tgummerer.com>
 <5df051ce-007c-cc12-6f02-345b33480c0a@nerdocs.at>
From:   Barret Rhoden <brho@google.com>
Message-ID: <7cb3e28d-2f4a-9fa8-d3c5-3b9184e53149@google.com>
Date:   Tue, 16 Apr 2019 10:52:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5df051ce-007c-cc12-6f02-345b33480c0a@nerdocs.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 4/15/19 5:56 PM, Christian González wrote:
> Am 15.04.19 um 23:15 schrieb Thomas Gummerer:
>> This sounds roughly like what Barret Rhoden (added to Cc) has been
>> working on.  I haven't followed that patch series in detail, but you
>> can have a look at it atthe latest iteration at
>> https://public-inbox.org/git/20190410162409.117264-1-brho@google.com/.
> 
> As far as I can see this is an "automagic" way of creating those "blame
> skips" - which can be easier in some way, but until it works "perfect"
> It is prone to produce problems IMHO.
> 
> The git history is a "document" that _has_ not to be changed by design.
> So if this "heuristic" produces a wrong result, it's kind of
> unpredictable what was wrong.
> 
> I think it would be MUCH easier to mark chunks or whole commits as  "not
> important" explicitly - by using a file.

I think there's a slight misunderstanding.  In the patchset that Michael 
and I are working on, the user specifies whole commits explicitly.  This 
is usually done with a file, but can also be done from the command line 
for "one-off" ignored commits.  That sounds like what you want.

The heuristics come in when we try to pass blame for specific *lines* 
that an ignored commit touched.  We pass the blame to the parent commit, 
but we also want to match the lines to a specific line in the parent 
commit.  That way we can find the 'right' ancestor commmit.  We're not 
able to always identify the 'right' commit, hence the heuristics.

Barret

