Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E956B207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 18:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942854AbdDTShx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 14:37:53 -0400
Received: from mout.web.de ([212.227.15.14]:60122 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939298AbdDTShu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 14:37:50 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYviN-1cXAwk4BpD-00VfZV; Thu, 20
 Apr 2017 20:37:30 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
 <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
 <7d075a07-edc9-83eb-25cf-7f8b13700584@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <a718ca38-4c07-9f3d-e7f5-9efd7ef59007@web.de>
Date:   Thu, 20 Apr 2017 20:37:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7d075a07-edc9-83eb-25cf-7f8b13700584@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:DQFQvY1Th9y7EyelUHSqB+qphmcDAY3deushUt9bTbCdEi74e6R
 kSieCLvXdPYP23xGMy6bmT1HxohdpxPvsmlMZ5tdcDVLdnifoKS06FY+emk3gIxMpkRyVrq
 3ABbqbu3sQsM+DHKE3pEO/8YFpttAgWd4wgHih3LVR86Xuzh1oBUC5MA4d91o8M+P72kAKX
 kog3K8CYkXqArr98gSgdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l0L8pSR6IbI=:BI2eccr1f2OB7ELRNRFQXl
 nbK86QA/paGdfKIGPSwmwBOYsezB79lEMmT4N0LuI7wdtXeQTrpepvWk0OqmbeFo6kITPh7T1
 SJIJzOW5ARv3CsOSVNxxyJHoSvxHCVa3BKCLKKBJnkW5M9YzA61TPjmhXPWWqgoN32ZYn9yHR
 bENGkXxoTvkitQ8btjVoU3gHE27Sm1ElQAgGqNWyIQ5J43XRGT2CRNvOhMzVbLIZCpEK/vudO
 vEao2NITL70Mli8vgrdDW4/ciFLTivY0SHcpsuzCG8u2ct9aPsEC+5N7HLlPxaaHQRn0eqKLR
 EcuuqbT0coIKXVmrQp+7TVt1zZKufq/jY7dhqBYUf9unEC3W8Llj5Zk5anjCr3ufUl0HCK8S+
 VhKwgwpPN5szmU5ojR92DfuUcOz3GUBdwe+KxrhbNkSMThv5C7vHqWqfJALY43fRNXmtCNJU4
 5/EYJRZQqWLLLesZL6KsqtdfjyuxtfEfku7EMfe64PWPE8aJNZ2oRKQ6G3EaQj7Tk4NnmWdv5
 Bp48rrlLYLGpljBnb5uhRFIUBvYU4S21ME3xOKuBzmezFNJXaII0a1NcG+pvY1JF15JGLBL0e
 tgqjBbX57XpxSumyISU2XL7M20cWBQhFBLHw9D0wuqFguuvSDz3REKj0nTIvjy2jSkLihri8B
 knhFvtlgeslyFNsg65TcC/IwcuI7w6bKfuEiQeb2ubRmzJIu23+pmlasRQHdMBR6ejo7BIKzS
 Y7Oxd85E/EqA4DW4qWOJ2pVLUGoI82TkzVUGrxLtn2ka7TpFF1Co2dnZSQOrXqdD849Y+HEOj
 7AcKUCR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-19 22:02, René Scharfe wrote:
> Am 19.04.2017 um 21:09 schrieb Torsten Bögershausen:
>> On 2017-04-19 19:28, René Scharfe wrote:
>> []
>> One or two minor comments inline
>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>> index 2daede7820..4c1c01e87d 100644
>>> --- a/builtin/gc.c
>>> +++ b/builtin/gc.c
>>> @@ -228,21 +228,99 @@ static int need_to_gc(void)
>>>       return 1;
>>>   }
>>>   +struct pidfile {
>>> +    struct strbuf buf;
>>> +    char *hostname;
>>> +};
>>> +
>>> +#define PIDFILE_INIT { STRBUF_INIT }
>>> +
>>> +static void pidfile_release(struct pidfile *pf)
>>> +{
>>> +    pf->hostname = NULL;
>>> +    strbuf_release(&pf->buf);
>>> +}
>>> +
>>> +static int pidfile_read(struct pidfile *pf, const char *path,
>>> +            unsigned int max_age_seconds)
>>> +{
>>> +    int fd;
>>> +    struct stat st;
>>> +    ssize_t len;
>>> +    char *space;
>>> +    int rc = -1;
>>> +
>>> +    fd = open(path, O_RDONLY);
>>> +    if (fd < 0)
>>> +        return rc;
>>> +
>>> +    if (fstat(fd, &st))
>>> +        goto out;
>>> +    if (time(NULL) - st.st_mtime > max_age_seconds)
>>> +        goto out;
>>> +    if (st.st_size > (size_t)st.st_size)
>>
>> Minor: we need xsize_t here ?
>> if (st.st_size > xsize_t(st.st_size))
> 
> No, xsize_t() would do the same check and die on overflow, and pidfile_read() is
> supposed to handle big pids gracefully.
This about the file size, isn't it ?
And here xsize_t should be save to use and good practise.




