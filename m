Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840F72095D
	for <e@80x24.org>; Mon, 20 Mar 2017 08:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752874AbdCTIKy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 04:10:54 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:28431 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbdCTIKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 04:10:51 -0400
Received: from [192.168.1.112] (unknown [164.177.97.114])
        (Authenticated sender: jn.avila)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id D0C56780389;
        Mon, 20 Mar 2017 09:10:46 +0100 (CET)
Subject: Re: [PATCH v2 1/2] l10n: Introduce framework for localizing man pages
To:     Junio C Hamano <gitster@pobox.com>
References: <20170312200248.3610-1-jn.avila@free.fr>
 <20170312200248.3610-1-jn.avila@free.fr>
 <20170318175353.24578-1-jn.avila@free.fr>
 <xmqqfuia1ifx.fsf@gitster.mtv.corp.google.com>
 <xmqq37ea192h.fsf@gitster.mtv.corp.google.com>
 <xmqqr31sy9xe.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Message-ID: <46714f87-bf42-81a5-4af0-9b3a3282ad56@free.fr>
Date:   Mon, 20 Mar 2017 09:10:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqr31sy9xe.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 20/03/2017 à 03:11, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Travis seems to have failed.  Perhaps something like this is needed,
>> at least?
>>
>>  .travis.yml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 591cc57b80..719e5cdb00 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -20,6 +20,7 @@ addons:
>>      - language-pack-is
>>      - git-svn
>>      - apache2
>> +    - po4a
>>  
>>  env:
>>    global:
> Here is what I have for now on top of yours in an attempt to make it
> work with the public Travis, which is still not working X-<.
>
>   https://travis-ci.org/git/git/jobs/212839039
>
> shows how it breaks, which is somehow different from how it does not
> fail on a copy of Ubuntu I seem to be running, even though I seem to
> have the same 0.41-1ubuntu1 installed).  

Asciidoc support was added in 0.45, and was included Ubuntu 14.04 but is
not present in ubuntu 12.04. The latest version is 0.48.

So I guess you made your trials on 14.04. So, switching to 14.04 on
Travis would help, at least for this patch series, but that would help
much for the (close) future.

I'm trying to push for a release of a new version, because I stumbled
upon a bug on the support of include macros while extending the
translations to git-commit manpage. This bug is already fixed in master,
but no version has been published yet.


The bottom line is that using po4a brings mixed results, for now.

