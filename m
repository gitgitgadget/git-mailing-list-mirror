Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280C11F70F
	for <e@80x24.org>; Fri, 27 Jan 2017 00:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbdA0Avn (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 19:51:43 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34488 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbdA0Avn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 19:51:43 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so76564476pgg.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 16:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OnASsLJH7djF4OVt9WIAmQ+ruYo+0m3kqyEoewC6/6c=;
        b=MZK+I6WG1KgnGbFOpN9ErQlM0V79smWjZiS5PaHKOSXyIQYbmBIAnUmuu9HHBRR8ch
         +0mKLfTzjiegoORkmQwinBp5b06CrLsEC6CKMJR+oZ2DJoqLp0gXI4xJRYVD4CY4+PeX
         joF6kVtkQ21q4d4h2huAn0qN3zQcf+qtzDXuj6AVyK/g5u1nGr8/d1cMKVNkkBBsONMo
         ZaNSYksyGoa3ZXLp/sjZuWwEUXjWqm5AFJ+eQDCatLfDY7kbSA99+aDuoWTWpU3e40pX
         OSSGgkqqH8lzs4Bs2AwnfwLb8GjHfSjOOiqec9XnPDqVZT4C5JiYT15LPjGIlEYl4CJ6
         Bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OnASsLJH7djF4OVt9WIAmQ+ruYo+0m3kqyEoewC6/6c=;
        b=LjWv7J3nAlQSfjZofSC3KwBm0AaA7wQCk5+HJ3ua7XINffSJI5x+kcAvId4rqbbsdw
         QoDrFrORT7iarIgMt+AEjE1twB7yYGg7pGjjF+Ighewrm8Op+1Ra/CA96gNXdzsnHEkN
         uyS9upz6yfT4bSYjjuQXdrVbBbpw0npZ6MQ9idnOvCVIzhmU4kfF7eauB07i+uwpsR45
         0mOPdVDbwcCQwucwr0bkxxoI/d9LRz++RCHTg9rtOFZaWW9EsGD/cNFbCj9CT7yv7uGX
         /yWWVRxkYWuRHBakEHjQCAvaAPF1VLZlRC7/nwmldc0TMFLTHk815lDLyMMW/yO/uz5X
         /RgA==
X-Gm-Message-State: AIkVDXKPf+CDjzug5/SlXbleMwcIaUdL9e47aVRzl8If2xvzBoe8VVHFpokdV0fxn59IYz/0
X-Received: by 10.99.67.6 with SMTP id q6mr6368447pga.156.1485477855432;
        Thu, 26 Jan 2017 16:44:15 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f0de:f19e:2597:5e36])
        by smtp.gmail.com with ESMTPSA id p15sm6038497pfk.58.2017.01.26.16.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2017 16:44:14 -0800 (PST)
Subject: Re: [RFC 03/14] upload-pack: test negotiation with changing repo
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
 <cover.1485381677.git.jonathantanmy@google.com>
 <afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
 <xmqq8tpx30zq.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <0c727063-0583-f713-68fb-bd284be696b2@google.com>
Date:   Thu, 26 Jan 2017 16:44:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8tpx30zq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/26/2017 02:33 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
>> new file mode 100644
>> index 000000000..060ec0300
>> --- /dev/null
>> +++ b/t/lib-httpd/one-time-sed.sh
>> @@ -0,0 +1,8 @@
>> +#!/bin/sh
>> +
>> +if [ -e one-time-sed ]; then
>> +	"$GIT_EXEC_PATH/git-http-backend" | sed "$(cat one-time-sed)"
>> +	rm one-time-sed
>> +else
>> +	"$GIT_EXEC_PATH/git-http-backend"
>> +fi
>
> CodingGuidelines?

Thanks - done locally and will send out in the next reroll.

>> +inconsistency() {
>> +	# Simulate that the server initially reports $2 as the ref
>> +	# corresponding to $1, and after that, $1 as the ref corresponding to
>> +	# $1. This corresponds to the real-life situation where the server's
>> +	# repository appears to change during negotiation, for example, when
>> +	# different servers in a load-balancing arrangement serve (stateless)
>> +	# RPCs during a single negotiation.
>> +	printf "s/%s/%s/" \
>> +	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
>> +	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
>> +	       >"$HTTPD_ROOT_PATH/one-time-sed"
>
> I'd prefer for the printf'd result to have a final LF (i.e. not
> leaving the resulting one-time-sed with a final incomplete line).
> Also, do you really need the pipe to tr-d?  Doesn't the result of
> $(command substitution) omit the final LF anyway?
>
>     $ printf '1 %s 2 %s 3\n' "$(echo foo)" "$(echo bar)"; echo OK
>     1 foo 2 bar 3
>     OK

Done.

>> diff --git a/upload-pack.c b/upload-pack.c
>> index b88ed8e26..0678c53d6 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -862,9 +862,13 @@ static void receive_needs(struct string_list *wanted_ns_refs)
>>  		} else if (skip_prefix(line, "want ", &arg) &&
>>  			   !get_sha1_hex(arg, sha1_buf)) {
>>  			o = parse_object(sha1_buf);
>> -			if (!o)
>> +			if (!o) {
>> +				packet_write_fmt(1,
>> +						 "ERR upload-pack: not our ref %s",
>> +						 sha1_to_hex(sha1_buf));
>>  				die("git upload-pack: not our ref %s",
>>  				    sha1_to_hex(sha1_buf));
>> +			}
>
> This somehow looks like a good thing to do even in production.  Am I
> mistaken?

Yes, that's true. If this patch set stalls (for whatever reason), I'll 
spin this off into an independent patch.
