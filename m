Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93D64201A7
	for <e@80x24.org>; Sat, 20 May 2017 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756544AbdETTfm (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 15:35:42 -0400
Received: from mout.web.de ([217.72.192.78]:57853 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756535AbdETTfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 15:35:41 -0400
Received: from [192.168.178.36] ([79.213.117.211]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhDgb-1dYUPH3FwX-00MNE8; Sat, 20
 May 2017 21:35:34 +0200
Subject: Re: [PATCH] mingw: simplify PATH handling
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c5b7292f-6367-e4a9-2ee0-96b93b1b587f@web.de>
 <5d4f08c0-07e2-b59c-a132-d165a21323df@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <8fcdecde-2039-c674-3fee-b8e766fbcde7@web.de>
Date:   Sat, 20 May 2017 21:35:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <5d4f08c0-07e2-b59c-a132-d165a21323df@kdbg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:CyDzLGE94bt7zAsvZJpVM1B4xsE5YYOCAgW0edVSZNV3+dqlTDZ
 n1KrIhP7snFtU1pibdEB+FQV0kEy0nFaQBmXUdZ9V2NzpAxGeFwZ1Xt5nKaHmJ7ti73Xz8v
 OSxHZ/a6a//r2t0zUnVzVDCnrmtdNKA5iHbq1wWOF00nx3OnAjn9vS6kAh7VnSxGWdulnAm
 OIPqICtmtn/SuO+q9O0bA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QJnFa6vs8gc=:YnmmmLhyQlJhT1vHrTJq+t
 mrn8jnD4sqR0e1gWrWi99o4QU/38l7FhQshhmllfBeyGiNkJYMfMkGMmoc4590EdAQh3pLlpu
 yP184Y2jdNBSg4yqJhIvtXtzfnp0z5aY/8//BxCv8WOAFjvxt/OrkEuzWy8OZA4+WjiyImrLk
 5WAQJfV7iX3SXiDG5NSRE9aq4OgexlQtgPip0Vkb1a/ThfgUiI0TNZ1CbTLTfHqhHD31mLU6l
 SxFIV8vAk1Xr5uDk9+RAAAfsE2PIHNFO132Qju2zhQ+qxOSF4Ko2tGVGhzlFptf84xZW6iUOS
 TZ4MVV7ehe03YYs6EI8mu/ChvRr/+bXrRywWuZlDP5PmuWd6AMQRQkPFaHq/hcDSra16jkfWg
 mfJ0+bjtpg7cTgI8HBtDAk9EmIHYY4m4LNFdJvaJ6bXuA12ZeP4wwYBMLEW8sy59rd99sgM6P
 xYwayW1CEuhCiAbhHY4xH+II/OdINGu2NJmbVP2PNW+Oq3rWlGGPey0Eqk9sYZJgyDI4MH6xZ
 lU6BZjBrEUBUZcVsqj/uE1XQt5snvxyHgZ6L1NajZ6UUe6fmG/63wNBYs+pPmRQqLmseqIL+7
 y7erWOT1oRFSlWXHa6MQXhxj00QKUEEGn6jWSu3tr3Qyu+XUoYTkdJ/yPtwFsSmEjKNm+ofQF
 mtS3/pXVS3JNb9Ix4eLV33yk5bML5u6X982q9qmeRmClAD142C/tkqKyBnZQoP0GTOfTC9UNp
 4TBqBgOhI9X/526bxRr3kyGDXRVunbunICCtJvUZ/4IksHQC7V+mWmcT7qNskBqcZXpktuGMa
 dMl0Svt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.05.2017 um 19:00 schrieb Johannes Sixt:
> Am 20.05.2017 um 17:29 schrieb René Scharfe:
>> -static char *path_lookup(const char *cmd, char **path, int exe_only)
>> +static char *path_lookup(const char *cmd, int exe_only)
>>   {
>> +    const char *path;
>>       char *prog = NULL;
>>       int len = strlen(cmd);
>>       int isexe = len >= 4 && !strcasecmp(cmd+len-4, ".exe");
>>       if (strchr(cmd, '/') || strchr(cmd, '\\'))
>> -        prog = xstrdup(cmd);
>> +        return xstrdup(cmd);
>> -    while (!prog && *path)
>> -        prog = lookup_prog(*path++, cmd, isexe, exe_only);
>> +    path = mingw_getenv("PATH");
>> +    if (!path)
>> +        return NULL;
>> +
>> +    for (; !prog && *path; path++) {
>> +        const char *sep = strchrnul(path, ';');
>> +        if (sep == path)
>> +            continue;
>> +        prog = lookup_prog(path, sep - path, cmd, isexe, exe_only);
>> +        path = sep;
>> +    }
> 
> The loop termination does not work here. When the final PATH component 
> is investigated, sep points to the NUL. This pointer is assigned to 
> path, which is incremented and now points one past NUL. Then the loop 
> condition (*path) accesses the char behind NUL.

Ugh, yes.  Thanks for catching!

Cause: Last minute/hour edit, had used strspn() before.

>>       return prog;
>>   }
>> @@ -1569,13 +1527,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, 
>> const char **argv, char **deltaen
>>       }
>>       if (getenv("GIT_STRACE_COMMANDS")) {
>> -        char **path = get_path_split();
>> -        char *p = path_lookup("strace.exe", path, 1);
>> +        char *p = path_lookup("strace.exe", 1);
>>           if (!p) {
>> -            free_path_split(path);
>>               return error("strace not found!");
>>           }
>> -        free_path_split(path);
>>           if (xutftowcs_path(wcmd, p) < 0) {
>>               free(p);
>>               return -1;
> 
> Upstream does not have this hunk.


Right, it's in next, but not yet in master.  And there are other
differences, so it's a bad time to do that cleanup. :(

René
