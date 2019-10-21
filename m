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
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C881F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfJUUsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:48:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39477 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbfJUUsM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:48:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so5758357qtc.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uxwEOG0dQkC56nLa2ngEBVGr6Lg31YhctjkwyEphWvw=;
        b=gGqq8MMvnPt3teVEPzglbe1UoooLq8X1d2Gng62Dsew827Air5JQ4EKZzQ0NfInBLm
         U0PmOW91OcsbTQjtSJYfuFakoO7OzINbfbV1tEstZNlBDZo7uLdHVrNXSIi+1V8MJwpa
         FdfX4KoHHf03lRxgXhHfOPAXGG8YFswhvBORstGfwC+SdLYc4mlwF/pebsY+38mb7Tob
         6BdVE+k74rzgPkcd4/WRnh7YUecvoV0jo4Y1Z7kpK58okT1/Mh+0a2RTG0wpHnerTZao
         GyvLNyC8JXuI2vW3P0N4GeQHALfWdvCD2ukyqtFgDsp2kcVorRrNeS2Nhwq4WBkifGhg
         g9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uxwEOG0dQkC56nLa2ngEBVGr6Lg31YhctjkwyEphWvw=;
        b=BlwIdpQNZVjx7uJw0WQLmgN9dCGbJNd/oSSp5ljDKNlznyFwVd0tk8DZFsyG/dsVZi
         6twVJp0fMxbte2WABAMiRBAFmvufPUEhRIQ3ostPzad843/KK6TEytKxNbaxrwGMlZIw
         R4svdV3CrAqwq+6AW52iP2gyYEmPBVTUpoHcNtqBq4jyDAfE4HPlkSh5zcFW2N4Aa6XM
         Ypi2tw1y0XSBrBXzZ+ZUvhdmqxBlJrOSPK1OqJF7uYDQNov/bH4lhRDo+v2O/HP7+Uc4
         HOhJdZ20XN8Z0E9qsX2nCnaMqtr3YT1N9JohnzvFZEpzJD9lFy+YRgNYZdvk5hGzCh92
         EXQQ==
X-Gm-Message-State: APjAAAWCbjP6CQB9gs5FvWTTbEZc7uEujCINfH0zbu46HTHO3wI1r8sR
        yyDULqGPx3yLEfr4kmdnWgpwiyCrKlc=
X-Google-Smtp-Source: APXvYqzAiFp2ajZF5QUUAtl39LIIa2c/Nixp7BKSIX+uin1Y4z1uRSjvam0selMcpT/wWEMVS7XxmA==
X-Received: by 2002:ac8:529a:: with SMTP id s26mr26338209qtn.238.1571690890481;
        Mon, 21 Oct 2019 13:48:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4018:ebea:d287:d7b3? ([2001:4898:a800:1012:f14b:ebea:d287:d7b3])
        by smtp.gmail.com with ESMTPSA id g14sm6997454qkm.33.2019.10.21.13.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:48:09 -0700 (PDT)
Subject: Re: [ANNOUNCE] Git v2.24.0-rc0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c554383b-b569-79f8-88f6-7017be76da9d@gmail.com>
Date:   Mon, 21 Oct 2019 16:48:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <xmqq4l065zx5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(dropping some of the other aliases from this reply)

I ran a few of the performance tests against the Linux repository
using v2.22.0, v2.23.0, and the new v2.24.0-rc0. I thought it worth
pointing out that the drastic performance improvements are due to
turning on the commit-graph by default. I had computed a commit-graph
for my Linux repo, but used my global config to enable core.commitGraph.
The global config is ignored by perf tests, so v2.22.0 and v2.23.0 were
operating without looking at the commit-graph.

(These were run on my old dev machine, which is now running Ubuntu on
bare metal. No VM this time!)

Test                                                          v2.22.0               v2.23.0                     v2.24.0-rc0             
----------------------------------------------------------------------------------------------------------------------------------------
0001.1: rev-list --all                                        6.01(5.73+0.28)       5.99(5.73+0.25) -0.3%       0.97(0.80+0.16) -83.9%  
0001.2: rev-list --all --objects                              40.40(39.86+0.54)     40.22(39.59+0.62) -0.4%     35.28(34.75+0.52) -12.7%
0001.3: rev-list --parents                                    6.11(5.83+0.27)       6.07(5.82+0.25) -0.7%       1.03(0.86+0.16) -83.1%  
0001.5: rev-list -- dummy                                     0.64(0.58+0.06)       0.66(0.59+0.07) +3.1%       0.34(0.29+0.05) -46.9%  
0001.6: rev-list --parents -- dummy                           0.66(0.60+0.05)       0.67(0.62+0.05) +1.5%       0.36(0.32+0.03) -45.5%  
0001.8: rev-list $commit --not --all                          0.03(0.02+0.01)       0.03(0.02+0.01) +0.0%       0.03(0.02+0.01) +0.0%   
0001.9: rev-list --objects $commit --not --all                0.08(0.05+0.03)       0.08(0.05+0.03) +0.0%       0.09(0.07+0.02) +12.5%  
0002.1: read_cache/discard_cache 1000 times                   3.33(3.07+0.25)       3.32(3.05+0.27) -0.3%       3.31(3.10+0.21) -0.6%   
0005.2: read-tree status br_ballast (65695)                   0.48(0.42+0.23)       0.46(0.43+0.19) -4.2%       0.49(0.48+0.18) +2.1%   
0006.2: read-tree br_base br_ballast (65695)                  0.17(0.14+0.03)       0.17(0.15+0.01) +0.0%       0.18(0.16+0.02) +5.9%   
0006.3: switch between br_base br_ballast (65695)             7.17(5.35+2.10)       6.84(5.14+2.04) -4.6%       6.67(5.07+1.88) -7.0%   
0006.4: switch between br_ballast br_ballast_plus_1 (65695)   0.35(0.37+0.29)       0.34(0.32+0.33) -2.9%       0.35(0.33+0.34) +0.0%   
0006.5: switch between aliases (65695)                        0.33(0.34+0.31)       0.32(0.34+0.30) -3.0%       0.34(0.34+0.32) +3.0%   
0007.2: write_locked_index 3 times (65695 files)              0.17(0.16+0.01)       0.17(0.15+0.02) +0.0%       0.18(0.16+0.01) +5.9%   
0071.2: sort(1)                                               6.01(17.44+1.78)      6.05(17.44+1.69) +0.7%      5.85(17.07+1.69) -2.7%  
0071.3: string_list_sort()                                    15.81(14.94+0.87)     15.80(14.83+0.97) -0.1%     15.86(15.03+0.83) +0.3% 
4205.1: log with %H                                           6.46(6.14+0.31)       6.42(6.15+0.26) -0.6%       5.95(5.71+0.24) -7.9%   
4205.2: log with %h                                           7.06(6.74+0.32)       7.02(6.75+0.27) -0.6%       6.47(6.26+0.21) -8.4%   
4205.3: log with %T                                           6.43(6.13+0.29)       6.41(6.10+0.30) -0.3%       6.24(5.95+0.29) -3.0%   
4205.4: log with %t                                           7.29(7.04+0.24)       7.28(6.96+0.32) -0.1%       7.05(6.78+0.27) -3.3%   
4205.5: log with %P                                           6.44(6.19+0.24)       6.51(6.19+0.31) +1.1%       5.95(5.69+0.25) -7.6%   
4205.6: log with %p                                           7.03(6.70+0.33)       7.01(6.74+0.27) -0.3%       6.52(6.26+0.26) -7.3%   
4205.7: log with %h-%h-%h                                     7.79(7.57+0.22)       7.79(7.55+0.24) +0.0%       7.10(6.84+0.26) -8.9%   
4211.2: git rev-list --topo-order (baseline)                  6.32(6.04+0.28)       6.30(6.09+0.21) -0.3%       1.15(0.96+0.19) -81.8%  
4211.3: git log --follow (baseline for -M)                    8.58(8.43+0.14)       8.56(8.41+0.15) -0.2%       3.67(3.53+0.13) -57.2%  
4211.4: git log -L (renames off)                              32.79(30.68+2.10)     32.80(30.69+2.11) +0.0%     27.17(25.24+1.93) -17.1%
4211.5: git log -L (renames on)                               212.64(210.39+2.24)   213.48(211.26+2.20) +0.4%   27.38(25.53+1.84) -87.1%
4211.6: git log --oneline --raw --parents                     46.41(45.97+0.43)     46.34(45.81+0.52) -0.2%     46.03(45.46+0.57) -0.8% 
4211.7: git log --oneline --raw --parents -1000               0.09(0.07+0.01)       0.09(0.09+0.00) +0.0%       0.09(0.08+0.00) +0.0%   

The tests below are some that I don't run very often, but seemed
interesting. Interesting that rebase got a lot faster!

Test                                                            v2.22.0               v2.23.0                     v2.24.0-rc0              
-------------------------------------------------------------------------------------------------------------------------------------------
0100.2: refglob((a*)^nb) against tag (a^100).t; n = 1           0.01(0.01+0.00)       0.00(0.01+0.00) -100.0%     0.01(0.01+0.00) +0.0%    
0100.3: refglob((a*)^nb) against tag (a^100).t; n = 2           0.01(0.01+0.00)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
0100.4: refglob((a*)^nb) against tag (a^100).t; n = 3           0.01(0.01+0.00)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
0100.5: refglob((a*)^nb) against tag (a^100).t; n = 4           0.02(0.02+0.00)       0.02(0.02+0.00) +0.0%       0.02(0.02+0.00) +0.0%    
0100.6: refglob((a*)^nb) against tag (a^100).t; n = 5           0.14(0.14+0.00)       0.14(0.13+0.00) +0.0%       0.14(0.14+0.00) +0.0%    
0100.7: refglob((a*)^nb) against tag (a^100).t; n = 6           2.11(2.11+0.00)       2.11(2.10+0.00) +0.0%       2.14(2.14+0.00) +1.4%    
0100.8: fileglob((a*)^nb) against file (a^100).t; n = 1         0.01(0.01+0.00)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
0100.9: fileglob((a*)^nb) against file (a^100).t; n = 2         0.01(0.01+0.00)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
0100.10: fileglob((a*)^nb) against file (a^100).t; n = 3        0.01(0.00+0.01)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
0100.11: fileglob((a*)^nb) against file (a^100).t; n = 4        0.02(0.02+0.00)       0.02(0.02+0.00) +0.0%       0.02(0.02+0.00) +0.0%    
0100.12: fileglob((a*)^nb) against file (a^100).t; n = 5        0.14(0.14+0.00)       0.14(0.14+0.00) +0.0%       0.15(0.15+0.00) +7.1%    
0100.13: fileglob((a*)^nb) against file (a^100).t; n = 6        2.10(2.09+0.00)       2.11(2.11+0.00) +0.5%       2.10(2.10+0.00) +0.0%    
1450.1: fsck                                                    535.66(535.16+0.48)   531.12(530.65+0.46) -0.8%   533.41(532.91+0.48) -0.4%
1451.3: fsck with 0 skipped bad commits                         7.47(7.02+0.45)       7.42(7.03+0.39) -0.7%       7.24(6.83+0.41) -3.1%    
1451.5: fsck with 1 skipped bad commits                         7.49(7.12+0.37)       7.42(7.02+0.39) -0.9%       7.26(6.92+0.34) -3.1%    
1451.7: fsck with 10 skipped bad commits                        7.45(7.02+0.42)       7.47(7.07+0.39) +0.3%       7.26(6.84+0.41) -2.6%    
1451.9: fsck with 100 skipped bad commits                       7.55(7.10+0.44)       7.49(7.07+0.41) -0.8%       7.29(6.87+0.42) -3.4%    
1451.11: fsck with 1000 skipped bad commits                     7.56(7.14+0.42)       7.46(7.06+0.40) -1.3%       7.28(6.94+0.33) -3.7%    
1451.13: fsck with 10000 skipped bad commits                    7.48(7.13+0.34)       7.49(7.11+0.37) +0.1%       7.57(7.19+0.38) +1.2%    
1451.15: fsck with 100000 skipped bad commits                   7.40(7.04+0.35)       7.38(7.02+0.36) -0.3%       7.21(6.80+0.41) -2.6%    
1451.17: fsck with 1000000 skipped bad commits                  6.19(6.10+0.09)       6.16(6.05+0.11) -0.5%       5.98(5.87+0.10) -3.4%    
3400.2: rebase on top of a lot of unrelated changes             18.86(17.80+1.71)     18.80(17.80+1.66) -0.3%     2.63(2.49+0.79) -86.1%   
3400.4: rebase a lot of unrelated changes without split-index   68.00(62.32+5.04)     68.50(62.34+5.30) +0.7%     45.25(41.37+4.18) -33.5% 
3400.6: rebase a lot of unrelated changes with split-index      46.39(44.89+2.19)     46.24(44.66+2.30) -0.3%     25.00(24.49+1.23) -46.1% 
4000.1: log -3000 (baseline)                                    0.07(0.06+0.00)       0.07(0.06+0.01) +0.0%       0.07(0.05+0.01) +0.0%    
4000.2: log --raw -3000 (tree-only)                             0.21(0.18+0.02)       0.20(0.19+0.01) -4.8%       0.21(0.18+0.02) +0.0%    
4000.3: log -p -3000 (Myers)                                    2.01(1.89+0.12)       2.03(1.92+0.10) +1.0%       2.03(1.91+0.11) +1.0%    
4000.4: log -p -3000 --histogram                                2.02(1.94+0.08)       2.04(1.95+0.08) +1.0%       2.02(1.96+0.07) +0.0%    
4000.5: log -p -3000 --patience                                 2.57(2.50+0.07)       2.57(2.46+0.10) +0.0%       2.54(2.45+0.09) -1.2%    
4001.2: diff --no-index                                         0.01(0.01+0.00)       0.01(0.01+0.00) +0.0%       0.01(0.01+0.00) +0.0%    
5304.4: prune with no objects                                   0.00(0.01+0.00)       0.01(0.00+0.00) +inf        0.01(0.00+0.00) +inf     
5304.6: prune with bitmaps                                      2.76(2.47+0.29)       2.69(2.45+0.23) -2.5%       2.67(2.36+0.31) -3.3%    
7300.2: clean many untracked sub dirs, check for nested git     1.36(0.54+0.81)       1.35(0.51+0.82) -0.7%       1.53(0.62+0.90) +12.5%   
7300.3: clean many untracked sub dirs, ignore nested git        1.19(0.47+0.71)       1.22(0.51+0.69) +2.5%       1.19(0.53+0.64) +0.0%    
7300.4: ls-files -o                                             0.75(0.33+0.41)       0.76(0.34+0.41) +1.3%       0.74(0.25+0.48) -1.3%   

Any thoughts on 7300.2? Seems to not just be noise, or maybe it is?

Thanks,
-Stolee
