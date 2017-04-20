Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951331FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 19:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947025AbdDTT2w (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 15:28:52 -0400
Received: from mout.web.de ([212.227.15.4]:50502 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946994AbdDTT2u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 15:28:50 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M57ni-1c5ktS3eYQ-00zBb6; Thu, 20
 Apr 2017 21:28:33 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
 <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
 <1b3e983f-4a70-652b-53f3-0c571c6efa1e@web.de>
 <7d075a07-edc9-83eb-25cf-7f8b13700584@web.de>
 <a718ca38-4c07-9f3d-e7f5-9efd7ef59007@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0882e8f6-f9e2-20c2-4e94-3fa8a50097c9@web.de>
Date:   Thu, 20 Apr 2017 21:28:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <a718ca38-4c07-9f3d-e7f5-9efd7ef59007@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SEG3CoFOFEFBbJVjxJgsBXdg+xcuwpP+aULBXZYrpb/0HDfmMLp
 IDAoaFwKoXxvImvqRi5g5nBkLkddcO6lMQdnx4B1dZ3LFdp7BWG/6ZC61tS0wrzQ2OjWGP2
 I319D3Th6qom2AW9Vx5mNQ/+hWlYYYBh9SYo4J/Xrxdbc/Zrzb+lGWz/2sVwk+i/Xn7Ivgh
 WFdYWn3wi2rUGCtPmxS+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qdjNEVL6QPg=:a/sl7TMVRT1feNdPxSeGSL
 6N+Jc2XKo8Vf8up/70wjs6jzUx62aUA+l5puhif0qvNpWEswTbS9as/TNqsO496QzZ5Du9Oep
 JdHQAQJhVMmX2kG/DfHelwLXoQhslF8vYCJSzR73XKmjtx4PRucz2bfdOHp9vbUIhxtLfrXyS
 xC7wWXaPIGkZV5eOoyfuAiLRdaU80yAWoP5IoqZfEbW2LzxHfN3/Va63dPnbl56GVMgxbSiW1
 IHwth+AaLMv0DnBmMSqn9JHhdAyY9N3uBR/Cn23u+w9wamOGtqy5EPnvDb5KCnc97icGd+tcx
 MJmUm1mbjYVEE/rMhs8+DkKeIJsxPT15R1lOe6HMoD7QlEARIvkA3htYfaNeIh+8Y59S05S37
 2F1b7lqDtwlXoQBJiIEyY5VDPxU/IN/xWvg6TjKAQSelldjj7ZV8QPjBdZZ5OSrG4nvsGEon1
 za3hSJwn3Q7BeIdiHvLtrazQ6qOeQb1plGq/pZjhN/G8Bqa0KWGd02vUXZOUqtKZuj4RX+uVA
 me0yZNDLE9eG5iAxWXuVvmoXABvMMY3ECRErRGYlizhTMCu9X1R/MBqkrCJofpxVUWxO9qyU2
 E2OinY5MDvM2i08JjKfQQok4iAH4JrRZ6VIAPOrkZLDIVxkxMqdNEU+Y6xUOQ9tzaGwsd8Dax
 Dq0tqFV/UC/5jpu3UjjFto/7ZK/p7B1HXztkzuToOCK6TuR4rVgKwfoh1yIUKiE6VWFvndBpi
 i/d6BrtqaIrfIo+UOUGkP7e2vpMig1rldP3xiBgz9TFRRZn4plQ8qRAW/RtXLsy0/Dh1JU70p
 Tj8le06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.04.2017 um 20:37 schrieb Torsten Bögershausen:
> On 2017-04-19 22:02, René Scharfe wrote:
>> Am 19.04.2017 um 21:09 schrieb Torsten Bögershausen:
>>> On 2017-04-19 19:28, René Scharfe wrote:
>>> []
>>> One or two minor comments inline
>>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>>> index 2daede7820..4c1c01e87d 100644
>>>> --- a/builtin/gc.c
>>>> +++ b/builtin/gc.c
>>>> @@ -228,21 +228,99 @@ static int need_to_gc(void)
>>>>        return 1;
>>>>    }
>>>>    +struct pidfile {
>>>> +    struct strbuf buf;
>>>> +    char *hostname;
>>>> +};
>>>> +
>>>> +#define PIDFILE_INIT { STRBUF_INIT }
>>>> +
>>>> +static void pidfile_release(struct pidfile *pf)
>>>> +{
>>>> +    pf->hostname = NULL;
>>>> +    strbuf_release(&pf->buf);
>>>> +}
>>>> +
>>>> +static int pidfile_read(struct pidfile *pf, const char *path,
>>>> +            unsigned int max_age_seconds)
>>>> +{
>>>> +    int fd;
>>>> +    struct stat st;
>>>> +    ssize_t len;
>>>> +    char *space;
>>>> +    int rc = -1;
>>>> +
>>>> +    fd = open(path, O_RDONLY);
>>>> +    if (fd < 0)
>>>> +        return rc;
>>>> +
>>>> +    if (fstat(fd, &st))
>>>> +        goto out;
>>>> +    if (time(NULL) - st.st_mtime > max_age_seconds)
>>>> +        goto out;
>>>> +    if (st.st_size > (size_t)st.st_size)
>>>
>>> Minor: we need xsize_t here ?
>>> if (st.st_size > xsize_t(st.st_size))
>>
>> No, xsize_t() would do the same check and die on overflow, and pidfile_read() is
>> supposed to handle big pids gracefully.
> This about the file size, isn't it ?
> And here xsize_t should be save to use and good practise.

I think I meant to write "big pidfiles" there.

With xsize_t() gc would die when seeing a pidfile whose size doesn't fit 
into size_t.  The version I sent just ignores such files.  However, it 
would choke on slightly smaller files that happen to not fit into 
memory.  And no reasonable pidfile can be big enough to trigger any of 
that, so dying on conversion error wouldn't really be a problem.  Is 
that what you meant?  It makes sense, in any case.

Thanks,
René
