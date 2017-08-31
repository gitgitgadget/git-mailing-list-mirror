Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4162208E4
	for <e@80x24.org>; Thu, 31 Aug 2017 17:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdHaRWL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 13:22:11 -0400
Received: from mout.web.de ([212.227.15.4]:55154 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbdHaRVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 13:21:16 -0400
Received: from [192.168.178.36] ([91.20.59.6]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu57G-1dOp0H0FF8-011P6U; Thu, 31
 Aug 2017 19:21:15 +0200
Subject: Re: [PATCH 17/34] mailinfo: release strbuf on error return in
 handle_boundary()
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175005.20756-18-l.s.r@web.de>
 <CAN0heSopzQdkO373_eTHM8=z9fAWJFhyo6a5tVPWW-j8p0V2xA@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fe9a4b1a-14e0-04af-15aa-d687118f34b5@web.de>
Date:   Thu, 31 Aug 2017 19:21:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSopzQdkO373_eTHM8=z9fAWJFhyo6a5tVPWW-j8p0V2xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:u5V+G0e8NlWEaQNix2VQKhPQTjYj3xvHgd2bGZG8cPFPKXgNdCp
 ET+g2FC5mtnZQa7GdCA7mSLwBj+zyhIWyXwOxa138mZGnDqeJ8q1YxeiwKmnHn4+i/oMM2W
 MZPtjismzfDHweBrdYTj1lp6a2Dnh/FdREzr6gvjI/NT46ATeaNhy9LRVgACw8b8Wbgu7Ij
 QLnex6LCLCV5DOZ7L0olQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xubzAZtwAGg=:/++y2Zz+G0FTRuYOCDpK5S
 ETWWZwdy1X780dnO/+m0JIZ7Pua0iq8kN5zVrZhNGIgg2+PN9cstMyB2jcXlLvO3hWbch3/gk
 9oMpW4++BhF02Y5EKH33j5gIilSvEjYLKXX+aixDkuYTwcah2B1Me+Hbo1Taa6LcAi2Wa7Fct
 v3zIs10JDUR5X02TyGN6zD7RfsI7uiTzBwsDT8hJkosnFUgJ7R2UrVXnH04oAiXAOsq3bJyUh
 NpkEWnzmzoouYVXNcAbcC6JFo2ILVklHnDwvNGh479+uFvlHoo2Kyn/S3H5jbGD1lOAN12Bd1
 K9CVbRumSKMWxp9b9SZNXzouzO1qyToboEQ7EPJ38POfbqySPaNtT6gOQy2RK3CP45T1O62wl
 iiT9KGc71jta3sUmZGCFXddjMSP6alYPv+fizhAZB2R+hgHLk9+IRbIjtMcv+jJXpHb75dacy
 J5JsRErQP13txPCJhGuWo9miUDDv119sPmEl9ilaG97nZtrKveOr8P0qW6MpfklkgPZyk4kXx
 uRGIHeyxHhHr/qto3W5cOaNvd/a+8QcIaRVTFpjXEptO0uHE+qdqsoKaS1ExBjg+KXl9Yh716
 ls71yUtIMDhf2Br833BPPHgJcpOk5ffvPagXPTpmoE+2ocPh4+bn7a8iGqHvNNayGf0NJ8WIi
 swYhEofr9RvihvwK5tA/cz41iQQIU/ytRVeEmgGAn4dIyTi8OUmqIvleLMXYrsbyGRRcTadv2
 ooPX21IYGebZPaYd9tG22Di+yyxp0Hvn5LDeTYRckkGwRIuOcXzTGkoJmNHGNgFHM9AABdNl0
 8maDbYSoLhPCVb/IEGCvaeOC7YQODcW6AvDJRrg7sK17uxP0Qs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.08.2017 um 20:23 schrieb Martin Ågren:
> On 30 August 2017 at 19:49, Rene Scharfe <l.s.r@web.de> wrote:
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   mailinfo.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/mailinfo.c b/mailinfo.c
>> index b1f5159546..f2387a3267 100644
>> --- a/mailinfo.c
>> +++ b/mailinfo.c
>> @@ -911,48 +911,49 @@ static int find_boundary(struct mailinfo *mi, struct strbuf *line)
>>   static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
>>   {
>>          struct strbuf newline = STRBUF_INIT;
>>
>>          strbuf_addch(&newline, '\n');
>>   again:
>>          if (line->len >= (*(mi->content_top))->len + 2 &&
>>              !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
>>                  /* we hit an end boundary */
>>                  /* pop the current boundary off the stack */
>>                  strbuf_release(*(mi->content_top));
>>                  FREE_AND_NULL(*(mi->content_top));
>>
>>                  /* technically won't happen as is_multipart_boundary()
>>                     will fail first.  But just in case..
>>                   */
>>                  if (--mi->content_top < mi->content) {
>>                          error("Detected mismatched boundaries, can't recover");
>>                          mi->input_error = -1;
>>                          mi->content_top = mi->content;
>> +                       strbuf_release(&newline);
>>                          return 0;
>>                  }
> 
> Since this code path can't be taken (or so it says): How did you find
> this and the others? Static analysis? Grepping around?

Code inspection: I looked for functions with STRBUF_INIT that return
without calling strbuf_release() with "git grep -W STRBUF_INIT" and
searching for return in less(1).

René
