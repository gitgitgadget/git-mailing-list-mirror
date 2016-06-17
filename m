Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB75B1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 22:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbcFQWYV (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 18:24:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:55037 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbcFQWYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 18:24:20 -0400
Received: from [192.168.178.27] ([88.70.210.132]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MZwYd-1ayI5W10M3-00Loa8; Sat, 18 Jun 2016 00:24:17
 +0200
Subject: Re: [PATCH] hooks--pre-commit.sample: check for chars, that are not
 allowed for a windows file name
To:	Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org
References: <0102015553154cde-5c798c87-87c1-4acf-919a-c824dce01fae-000000@eu-west-1.amazonses.com>
 <5c02cc24-f68d-6eb3-9759-ffff328a0c2f@virtuell-zuhause.de>
From:	dex teritas <dexteritas1@gmx.de>
Date:	Sat, 18 Jun 2016 00:24:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5c02cc24-f68d-6eb3-9759-ffff328a0c2f@virtuell-zuhause.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <0Lyj4F-1bQz0I1R2N-016Asy@mail.gmx.com>
X-Provags-ID: V03:K0:DYae4kQaUsDfKS0aT+pQnYf2fqp58LoKKDxpOAv+B37iqSVPUhl
 00g4EhvZdQ3sK6YP5fQfQqId+EcnypI2gDfKNCfpOkz9hmEYgazJeGVL0oxccTNQjpPGDWn
 /3tAz+wcR/fbw1DqG2fBofBY+yM2L1xpOqQLEQsop4DTNIVGdY2U6hwKsk+w9lo1cKjXNYF
 n/ciCK/FT8s06Z4PvaHPQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:29mmsDJFNQ0=:GFQdkXwL7Kv6CUVvMyqBq7
 uEhy844yPrq9cSuqC0TgnYYL4btGCBzCIbyvVshVyuyonvvEy9V/oCDKdyU2wBB4kl0xwyidt
 X+SAGB6XO6mbt1MuHL8T9CdxdMjzU+Kx3Z6ZiIP6CDvCN3lJuKzY2WUMqgwIDdeC6XuOtKiLV
 c1x3jNtjW4/FBBh1/Bx506QV5+x/yLEUL+xn/waJ4pYbKcORo7i698+KaLSa7/f5zuBruWIXf
 753ff8NvzI4xrsPm7QjIU0yg8JGZnNL2PZVH4hAL0edTsYdG9CY+GNgD5PE+iLh+bOYXPv0iG
 HvE5GKVqitPmy51IDCitCaLVnnhMe8c0vsOooC+NqfE5oI/mpXUfxxhBhaHApAL6/T2EMyg2d
 8YAez5VSABlmiURjJZCfZOiMgT64AmZFSb9YioIRUASnL4crDz5wddDC3rKTLwjf787oHtjq/
 Qj97D8aLNIQauDTKUsaLaXpXiTrTqsQmiEPRhzobazUNW6c/8TbJL5A0+K8bfOmG9Kw2hY/CJ
 GuttQXOy9VxSFTGLwHeW0l+9uTsel68qk985BhieB1tZAdDQuSygVnJdqE8M8wbcEuf2pn1XA
 2uKJcs+/CK0rswMOQByXqp7SvGg52EeeUf2OP/wGsjLTsGz/sCl6sizsu3078gC9pkHXnOaDT
 10zb0m4P1912t517sD8d9YMrdL7277ceBaQjXgpExMou1lZ3oKyhLz4+OkznZ+ab3UqfCsu19
 X1RAM44KACHNRLbfxeRvljZSUJykoFRQDxCMXsMGOieSSL2ptrcdaFhOWmGhv/KCfEu9Lksy0
 nyEa+Hr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 15.06.2016 um 13:15 schrieb Thomas Braun:
> Am 15.06.2016 um 10:02 schrieb dexteritas:
>> After the ASCII-check, test the windows compatibility of file names.
>> Can be disabled by:
>> git config hooks.allownonwindowschars true
>> ---
>>  templates/hooks--pre-commit.sample | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
>> index 68d62d5..120daf1 100755
>> --- a/templates/hooks--pre-commit.sample
>> +++ b/templates/hooks--pre-commit.sample
>> @@ -17,6 +17,7 @@ fi
>>  
>>  # If you want to allow non-ASCII filenames set this variable to true.
>>  allownonascii=$(git config --bool hooks.allownonascii)
>> +allownonwindowschars=$(git config --bool hooks.allownonwindowschars)
>>  
>>  # Redirect output to stderr.
>>  exec 1>&2
>> @@ -43,6 +44,27 @@ If you know what you are doing you can disable this check using:
>>    git config hooks.allownonascii true
>>  EOF
>>  	exit 1
>> +elif [ "$allownonwindowschars" != "true" ] &&
>> +	# If you work with linux and windows, there is a problem, if you use
>> +	# chars like \ / : * ? " < > |
>> +	# Check if there are used only windows compatible chars
>> +	test $(git diff --cached --name-only --diff-filter=A -z $against |
>> +	  LC_ALL=C tr -d '[0-9A-Za-z\[\]\{\}_ -)+-.]\0' | wc -c) != 0
>> +then
>> +	cat <<\EOF
>> +Error: Attempt to add a chars that are not allowed for a windows file name.
>> +
>> +This can cause problems if you want to work with people on other platforms.
>> +
>> +To be portable it is advisable to rename the file.
>> +
>> +Check your filenames for: \ / : * ? " < > |
>> +
>> +If you know what you are doing you can disable this check using:
>> +
>> +  git config hooks.allownonwindowschars true
>> +EOF
>> +	exit 2
>>  fi
>>  
>>  # If there are whitespace errors, print the offending file names and fail.
> There are some cases of illegal file names missing. E.g. reserved names,
> trailing period and space. My trial with a precommit hook for avoiding
> illegal filenames on windows can be found at [1]. Feel free to loot my
> version for a reroll.
>
> [1]:
> https://github.com/t-b/git-pre-commit-hook-windows-filenames/blob/master/pre-commit
>
You're right. Thanks for the example.
