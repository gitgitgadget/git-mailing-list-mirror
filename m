Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEB520756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750894AbdAMSUJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:20:09 -0500
Received: from mout.web.de ([212.227.17.11]:54814 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdAMSUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:20:09 -0500
Received: from [192.168.178.36] ([79.213.118.247]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGicf-1cEeCX1FfF-00DWSV; Fri, 13
 Jan 2017 19:19:52 +0100
Subject: Re: [PATCH 2/3] xdiff: -W: include immediately preceding non-empty
 lines in context
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <1484324112-17773-1-git-send-email-vegard.nossum@oracle.com>
 <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e55dc4dd-768b-8c9b-e3b2-e850d5d521f5@web.de>
Date:   Fri, 13 Jan 2017 19:19:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1484324112-17773-2-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:KYxMvG3bdT2Ep70+LfR+tPjtIfoY/3b20le6mchMQXhloS5HJye
 L7+Zv3lKN6JVh2cdkASBsqNhgsGkkV4ym8dxumiNaWGCPOKFG58x1GSwX287oTdcg6W4qic
 ii8OUJG8RFf0IxxZqoy4I5q1B/Fm8mPamMvsUvww/O+VYRhUUrUe+7U2dNWmWLV0XVyrtjB
 YGRpz4tRNsRnaqb+aWspg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SrdcGv0YzYI=:ezY0efRynP2IqeL42bEm9K
 vlywnFtpZWiERj0HDYKxyCyT2azO2CB0ID8Pja+6K1FEKBmhgkT2gVFw+y03cm02Js2kBElYY
 XIl7b7gH0pPXbBdC7Kgjaz7heDVAIfcWYdYnAwDQgdXapt/5d5CVB0Yg9KkAKDjf6+otai36i
 MTMNRuNuDc7Gb21DVHgJ1oMqFa7BtHsXWJ7LvlW0vuwHJ3m8n38jwRTnWFf/zAAm+uqXtPSYU
 ox5WAD0DHFufbgHZiNvYY+oLVXWkLwum9LqQcSV2oYI7G+bXYtt4Esgh22+pQ1hKG/XFRIgd0
 eb79kOiwsyNHQwBtxxn8+KSOkcRGh7A6Hn9s1cQJqOo0YE25H/IEJairFWvekrjk7WE0ihFD6
 pIeW6x34HZNHDDOYQBAGe/KkRkxt5AThhTFQSFKHz0UW165K2mmxozfWiWm5L+8flpXgvKZdo
 aBRjiUKq07YUSzw3X3WbSLtk+bpaJExWvVjWmv7slIvTyy6uF2g4S1TY8LLyLos7VqfOwcdD1
 Eym8N7+IngPP1UT5ym/mCPt7WxEgOSLl1S33gzJCfxh2gaaX1VfFkGrX0a46RkvMgPMp0mvXU
 oBPD4zm0od71VDhxAtdbmwm9UoDIxoOpq0ZZOJzcg21czqbijrcx3a5/KBPR4jYHEHhniSKnu
 v9xbo0NMiuPRQVqIwMEmoHXQRfbd06xBlENS1xgxEl1KG1ZMwId4RlqWLFBCmkVGSj++dUvLY
 lPwiU7Y3y5V3bdBkxaJvuiePP0TcGQHsN0rqymUoYJ2GiI2+lCXSfM3S5G+bI0Ml2NxSprkaZ
 U1VuEWI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.2017 um 17:15 schrieb Vegard Nossum:
> When using -W to include the whole function in the diff context, you
> are typically doing this to be able to review the change in its entirety
> within the context of the function. It is therefore almost always
> desirable to include any comments that immediately precede the function.
>
> This also the fixes the case for C where the declaration is split across
> multiple lines (where the first line of the declaration would not be
> included in the output), e.g.:
>
> 	void
> 	dummy(void)
> 	{
> 		...
> 	}
>

That's true, but I'm not sure "non-empty line before function line" is 
good enough a definition for desirable lines.  It wouldn't work for 
people who don't believe in empty lines.  Or for those that put a blank 
line between comment and function.  (I have an opinion on such habits, 
but git diff should probably stay neutral.)  And that's just for C code; 
I have no idea how this heuristic would hold up for other file types 
like HTML.

We can identify function lines with arbitrary precision (with a 
xfuncname regex, if needed), but there is no accurate way to classify 
lines as comments, or as the end of functions.  Adding optional regexes 
for single- and multi-line comments would help, at least for C.

René
