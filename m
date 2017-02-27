Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042DC1F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 01:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbdB1BPN (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 20:15:13 -0500
Received: from mout.web.de ([212.227.17.11]:51238 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbdB1BOw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 20:14:52 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1c7VfJ1vFS-00gZfG; Mon, 27
 Feb 2017 23:45:51 +0100
Subject: Re: [PATCH] strbuf: add strbuf_add_real_path()
To:     Brandon Williams <bmwill@google.com>
References: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
 <20170227182217.GC153455@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3063b6fb-02aa-703c-0b56-300109cf054d@web.de>
Date:   Mon, 27 Feb 2017 23:45:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170227182217.GC153455@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:w0Afcf2Kp+dlU9I74Kl3pO3daGQI/JxRdVFlH/bw/lhMUtiLbPm
 TVQs/t9EnaRvh3rB/cMjbqVn0rMczGpE+OtKGl/EcCA/EP3G/ymFZoX2G3vYVJO1Ugr40AN
 BkHf2Hfd9+o1l+CuQILFJzwWHdduVq3z8VjqSjweR4MNR3YGjTdirMod6S/tm6wSyeAcIdw
 HTqniEc8rcuraJ6UdhDFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsIrDJ5np9M=:m+5Jsio6yYAxWS55pTJZcn
 PVi+uebQC34dH5WhzIH73aHEtYR/64yEjerivaReymki1Udr3uCFimxctf/1NP5dt/QXFLVe7
 RaiAq6Lo/jW5t4MpjacE6y1X9XsaUuybBjOVhpCy7Rl1u8+KPDjvsOlFVx6htbJYIVccmnZwl
 5Wmp0rpOa6U6kl0gVwIcgzy1F/6aSfoLIaotfS6lzzntPEWuW/cGDjC/IKD5kiZpAgLfK4DVu
 a/0o/5iGXF4xgeMJyGUMMll/uwZc4Un6F9SjUiHC7VJ5zEdwy+C6mzHog4UJJXRrAm7QiVzd6
 ICLDopAnT8RL9nyAq1EkemG+DDV1YoEg4UQwbSHyCn09eHnvZ9Y88/nDubcNEzbuQu46kx8hP
 qIrBHFdi1GQrTemGykrxusYEmEsYHCtsujnmrTaLaX8SjIZ6iTd/e7JbXwsKJ+tjM1ZFS8roq
 qEFBDsb1zzDfGobWh29MYw0p0N0cInCuDkJ6H0hcU5fuJf3xzz2UmkWmZJ2TV9QeOy9GKwZ3f
 viQQBEHKNMDEydB24/AxGAUHuVcx5aVZYqRqEpbaA5W9oAhjU0OVYRJKfrQgge2e0BSjnPkcy
 W/WNp6RYptsOdVpWaKI4uDWcrZ82XRbpi2zr46KVTFh4cE9dsdDYdar2uX5sQRpAAy+percRI
 GAgcU5J3xvSrSD5vqGs2oGvERFTen3n9xMo10tN1GNbWpTVuD5HxKePUn/nWqVvD8Ruvl4A9B
 dwNk2Yu7/rEK7KvKeI5ybKqRJPUE1CbI2NTqCLUKZfsyuifjjUJKwHZRaVY/ENmoi4SkxYZFh
 Gt+WKOZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 19:22 schrieb Brandon Williams:
> On 02/25, René Scharfe wrote:
>> +void strbuf_add_real_path(struct strbuf *sb, const char *path)
>> +{
>> +	if (sb->len) {
>> +		struct strbuf resolved = STRBUF_INIT;
>> +		strbuf_realpath(&resolved, path, 1);
>> +		strbuf_addbuf(sb, &resolved);
>> +		strbuf_release(&resolved);
>> +	} else
>> +		strbuf_realpath(sb, path, 1);
>
> I know its not required but I would have braces on the 'else' branch
> since they were needed on the 'if' branch.  But that's up to you and
> your style :)

Personally I'd actually prefer them as well, but the project's style has 
traditionally been to avoid braces on such trailing single-line branches 
to save lines.  The CodingGuidelines for this topic have been clarified 
recently, though, and seem to require them now.  Interesting.

René
