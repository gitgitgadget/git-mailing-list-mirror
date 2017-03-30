Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEB220966
	for <e@80x24.org>; Thu, 30 Mar 2017 14:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbdC3ODY (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 10:03:24 -0400
Received: from mout.web.de ([212.227.15.4]:51281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933426AbdC3ODX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 10:03:23 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8L3a-1bz8VD393C-00vyoA; Thu, 30
 Mar 2017 16:03:17 +0200
Subject: Re: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
To:     Ben Peart <Ben.Peart@microsoft.com>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-2-benpeart@microsoft.com>
 <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
 <BL2PR03MB3233616BE57BB7D911B1AAEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
Cc:     "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <a5e259bd-d994-6ddb-9dae-43531ee2e875@web.de>
Date:   Thu, 30 Mar 2017 16:04:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <BL2PR03MB3233616BE57BB7D911B1AAEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qpHunW1Dj1Mf+wJN88t3Uuz/KPe7uZCyno8xMrUQ0PIzLz2p2Ay
 1Xn9pEzhvs8UF4epSb4rl4FacTK5/2S9r4Wn3u7+eNXiTjugTh9Ss3i8+xaxbKVwkdZSje6
 xOJrasNOAoWz57jzYPc6brLokLYMvcbJ7nckEc7apyxUcxfIcCv2lnohHgePZ0kD7XiJXNc
 koATsNFTDv3okeBbUCz7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77nvGcndefM=:bOvNwUM7n98SwGrbOs2BVe
 FVic/XX8z+X4rdIosFKTNmATqzMMZ/AdT9mhLhVv1OfzXLMhKg2h46jsNqZEJReV+AwZTue2V
 lC/4QkPbns9hs7Fl/xvEX73rlYt0SXUvFA3MGBY5fFlhnSk4UsDC/nQad1B4xGYKVBqqeQXY8
 NepLCUDooovgQqOq6wZfxhHl62DObyIVedFUyU3+MZ8hxpYx0Kg9j2xuyYGO33GMQsEP2d9NX
 joLsErp9i1KzVmo57cngX3fCEZUcfrPb9AbCz+xTmEIXUbg+XALKM4Aa78tHNyPQ2wWJOF5qu
 RaoP2O0C8R8ztHF2Qm3fYkuXI5GjrcoUUbkvOznA3GL+E8eFCC/9a9axcfEqH6C41D281mJXN
 ojCPIgt8FtZ8FGp73U2SGVYybI+MJ7QoHpjhRqkgXi6RLUkEIC7b31ku/acvFcurzSMRpXCXE
 YCVFVoB5TXkACZCksLHepPPEo0WqSKpFJv2leblM5V3Qy59NX+Y2wcMcblvJX/AQpGvC+8SZE
 hMl1YdoI326haLsTbdZ29Zr9WFmh9OWb73/wkiw/L+2KvkPyDFO20YBFuF+mDl6P/Sm3HvoHp
 HfIH91PPvJoXVsG+y54rX071ZxuQxOY7mlchPw2Uu5Hg0lFpdKqtrXGDxaRG+QJq1x4ArySh7
 8AuYaUz4eJ5g5ZJZkyleaupeMNKyODdjGU6xcnYFEHXhCSpgK/KRLC9M3iraroGwcQEYy9WJ8
 tJ4BNz9YFT52AMLBXGQamGHHfXywUYJ8YqizQvpg1u63OAwPKfAO5H5nDdIpxpszXLvmrQu9g
 ymue963
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[snip]
>> Would packet_write_lines make more sense ?
>>
>
> Just goes to prove that there are two hard things in computer science: cache invalidation, naming things, and off-by-one errors. :)  The feedback on V1 was:
>
> "I am hesitant to take a function that does not take any "list"
> type argument and yet calls itself "write_list".  IOW, I'd expect something like these
>
> 	write_list(int fd, const char **lines);
> 	write_list(int fd, struct string_list *lines);
>
> given that name, and not "varargs, each of which is a line".  I am tempted to suggest
>
> 	packet_writel(int fd, const char *line, ...);"
>
>>> +{
>>> +	va_list args;
>>> +	int err;
>>> +	va_start(args, line);
>>> +	for (;;) {
>>> +		if (!line)
>>> +			break;
>>> +		if (strlen(line) > LARGE_PACKET_DATA_MAX)
>>> +			return -1;
>>> +		err = packet_write_fmt_gently(fd, "%s\n", line);
>>> +		if (err)
>>> +			return err;
>>> +		line = va_arg(args, const char*);
>>> +	}
>>> +	va_end(args);
>>> +	return packet_flush_gently(fd);
>>> +}
>>> +
>> I don't think that this va_start() is needed, even if it works.
>>
>> int packet_write_line(int fd, const char *lines[])
>> |
>> 	const char *line = *lines;
>> 	int err;
>> 	while (line) {
>> 		if (strlen(line) > LARGE_PACKET_DATA_MAX)
>> 			return -1;
>> 		err = packet_write_fmt_gently(fd, "%s\n", line);
>> 		if (err)
>> 			return err;
>> 		lines++;
>> 		line = *lines;
>> 	}
>> 	return packet_flush_gently(fd);
>> ]
>>
>
> This is a helper function to simply the common pattern of writing out a variable number of lines followed by a flush.  The usage of the function as currently implemented is:
>
> packet_writel(fd, "line one", "line two", "line n");


Does this work ?
I would have expected
packet_writel(fd, "line one", "line two", "line n"), NULL;

>
> which requires the use of variable number of arguments.  With your proposal that convenience is lost as you have to create an array of strings and pass that instead.  The usage just isn't as simple as the current model.
>
What is wrong with

int packet_write_fmt_gently(int fd, const char *fmt, ...)
and we use it like this:
if packet_write_fmt_gently(fd, "%s%s%s", "line one", "line two", "line n")



(Or do we need another one like)
int packet_write_fmt_gently_flush(int fd, const char *fmt, ...)

Sorry if I am lost here
