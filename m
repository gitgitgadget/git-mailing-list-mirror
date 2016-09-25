Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E144207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 08:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940711AbcIYI6j (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 04:58:39 -0400
Received: from mout.web.de ([212.227.17.11]:62205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbcIYI6h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 04:58:37 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LtnzN-1an56t1vnh-011Co5; Sun, 25 Sep 2016 10:58:26
 +0200
Subject: Re: [PATCH 1/2] add COPY_ARRAY
To:     Jeff King <peff@peff.net>
References: <6f402d35-b483-7552-2fb2-a5350112b8a6@web.de>
 <20160925074144.44onzv5pub5dxuix@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <19dabb44-dba1-d1e0-7935-8e1aec0bf7b9@web.de>
Date:   Sun, 25 Sep 2016 10:58:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160925074144.44onzv5pub5dxuix@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YDCgXRmSUF/WnY5RtEoaRq4CYc5SIaxudT352ZWJw22guHJ6yu+
 y0xN6HO89eKg1OihkUFSy0R8E+glbrshjrklqJojYpBhhBJ2Btx76x01tRdvsx6D5cMVwOF
 RiRzw6JC33Kv4EMvuBsumtU6MXUE47oDo3YvIIS2cav72UMDSRaU0Rn5kQcHKQLEliBb2Ux
 U7zX6T47oqlmbaLcbpvWA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4MuoRODymio=:rUTS+opMSjkglDWrgsvKNw
 HpoflJm2k3JHarYNesmxjizI+heNlvG8LH7puCh5ULsaKlQKQiz1KNLKtmAFEOcpp5gemrG+m
 6rOkrvAg/EXNdsC3Q16I7k+bZheXBdy6THlJ3YTnPRyTtSmlMGYM6lKp10q5stiQJYLYgvjRq
 /mAq84QHHhyfEAHEoArhnpPISJ4R2iksjro89wn93TWsRHfaq+Mi9/4AYrHdnSN1i7+IqZwhP
 BUekrKIcU/Mg2ZRbQLnZkpGwlyNNgLqawAbmCRJzFDCvJtVhejNnt4vhVF5DAQTVCzl9yYmsr
 zIIjZWPTo24p4K+NQrnNoKdS/jQvUWQrB978H3H7O4YR/PN2brhp+4+VLVR0n6mvl1XVWOQjs
 pFAL65krtN6HaFQgpRdYNv4tcbreWJXHpHQFmsB/ziXC6qyaHF/k+D8i6pNonlL3k7JfpYGYQ
 yLH10/GtdwwcuvDcc6jczjMR6N2ZiesFmA0OomSKxieD4pFpQe+R0p7G6BlHnxu59Q3cyDLZg
 JOCybBwJI1Ag75NM49y4I8LHLsnYJryWm1DURut9uBF0hRNT8MBg6MBQVCwLXbu4ugS69rS2/
 A8o+NmEgGUKigoapfiOCzW5j3IxbOSc6a+cFzkxAblaT/jwgVwnC10QQelCrDnUwvLDOnrm51
 rBC18IwXGNp2G+v32i6Kqy0PgLBmteAQzSPIiCWe3zaf6qBTEwHSqWebjIekmjbjDUzB9jant
 uRg3Q3ZTNkM8+T0z5rY+dkC+KR9owAwlSRIL/CJoJH7HtEAeJh3riKuLk7rEnlXodi29GpHGu
 dm86K03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.09.2016 um 09:41 schrieb Jeff King:
> On Sun, Sep 25, 2016 at 09:15:42AM +0200, René Scharfe wrote:
>> It checks if the multiplication of size and element count overflows.
>> The inferred size is passed first to st_mult, which allows the division
>> there to be done at compilation time.
>
> I wonder if this actually stops any real overflows. My goal with
> ALLOC_ARRAY, etc, was to catch these at the malloc stage (which is the
> really dangerous part, because we don't want to under-allocate). So the
> first hunk of your patch is:
>
>         ALLOC_ARRAY(result, count + 1);
> -       memcpy(result, pathspec, count * sizeof(const char *));
> +       COPY_ARRAY(result, pathspec, count);
>
> which clearly cannot trigger the st_mult() check, because we would have
> done so in the ALLOC_ARRAY call[1].
>
> Other calls are not so obvious, but in general I would expect the
> allocation step to be doing this check. If we missed one, then it's
> possible that this macro could detect it and prevent a problem. But it
> seems like the wrong time to check. The allocation is buggy, and we'd
> have to just get lucky to be using COPY_ARRAY(). And I don't even mean
> "lucky that we switched to COPY_ARRAY from memcpy for this callsite".
> There are lots of sites that allocate and then fill the array one by
> one, without ever computing the full size again. So allocation is the
> only sensible place to enforce integer overflow.
>
> So I'm not sold on this providing any real integer overflow safety. But
> I do otherwise like it, as it drops the extra "sizeof" which has to
> repeat either the variable name or the type).

Well, yes, checking if the destination object is big enough requires 
calculating the size of the source object and thus should include a 
check for multiplication overflow already.  Note the word "should". :) 
If that's the case then a smart compiler could elide the duplicate 
check.  Keeping the check in COPY_ARRAY reduces the assumptions we have 
make about its use as well as any previous checks and doesn't cost much.

René
