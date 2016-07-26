Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E49F203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758028AbcGZUy5 (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:54:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56791 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757840AbcGZUyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:54:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E3EC2FB14;
	Tue, 26 Jul 2016 16:54:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kb4iCv5eW3kKlUy/DgURF24jDEk=; b=j4pKfL
	NjJFH+BdR/Cju0gbGia8HWuQQ49u14Wqjna5XJ3GDzA5NyyGrFGmu0/WeMCMFZKX
	Rb3rp6T6zSdskmW4SOpY6yDXyHONEn2fhfPTrjbPWXUmI0BF0nPlgg7YI/W6xG67
	kgnoc+KeQgZcghVD2l7dqo1bpDdOYPF4OebL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hVr1jVZLEJrC7miFkxx/v2Pt2Wo5pu06
	bYwm9UumTU3UtuBivusXm0aH9kDARuzGG7donem6gZYBGG9UiMwlF9C3kTrKldr0
	9KOQWFE96txcxhq5d5csOzqaJJUkjbCJiyWoVi8zNJt2i9gNQu7kHSZzV5w8/4h+
	REQzkcegx1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 668FC2FB13;
	Tue, 26 Jul 2016 16:54:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD5942FB12;
	Tue, 26 Jul 2016 16:54:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brett Cundal <brett.cundal@iugome.com>,
	"David A . Greene" <greened@obbligato.org>,
	Charles Bailey <cbailey32@bloomberg.net>,
	Techlive Zheng <techlivezheng@gmail.com>
Subject: Re: [PATCH 3/3] subtree: adjust style to match CodingGuidelines
References: <20160726041416.9438-1-davvid@gmail.com>
	<20160726041416.9438-3-davvid@gmail.com>
	<a12604f4-7dc9-7c35-0853-c3bffd734281@kdbg.org>
Date:	Tue, 26 Jul 2016 13:54:51 -0700
In-Reply-To: <a12604f4-7dc9-7c35-0853-c3bffd734281@kdbg.org> (Johannes Sixt's
	message of "Tue, 26 Jul 2016 08:12:39 +0200")
Message-ID: <xmqqfuqwyvac.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33FAE2FE-5373-11E6-8C4D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> These caught my eye browsing through my inbox. I'm not a subtree user.

All good comments.

Let's queue 1/3 and 2/3 and fast-track them down to 'master'.  Style
fixes can come independently later.

Thanks.

> Am 26.07.2016 um 06:14 schrieb David Aguilar:
>> @@ -50,87 +51,145 @@ prefix=
>>
>>  debug()
>>  {
>> -	if [ -n "$debug" ]; then
>> -		printf "%s\n" "$*" >&2
>> +	if test -n "$debug"
>> +	then
>> +		printf "%s\n" "$@" >&2
>
> Are you sure you want this? It prints each argument of the 'debug'
> invocation on its own line.
>
>>  	fi
>>  }
>>
>>  say()
>>  {
>> -	if [ -z "$quiet" ]; then
>> -		printf "%s\n" "$*" >&2
>> +	if test -z "$quiet"
>> +	then
>> +		printf "%s\n" "$@" >&2
>
> Same here.
>
>>  	fi
>>  }
>>
>>  progress()
>>  {
>> -	if [ -z "$quiet" ]; then
>> -		printf "%s\r" "$*" >&2
>> +	if test -z "$quiet"
>> +	then
>> +		printf "%s\r" "$@" >&2
>
> But here I'm pretty sure that this is not wanted; the original is
> clearly correct.
>
>>  	fi
>>  }
> ...
>> @@ -139,22 +198,27 @@ debug "command: {$command}"
>>  debug "quiet: {$quiet}"
>>  debug "revs: {$revs}"
>>  debug "dir: {$dir}"
>> -debug "opts: {$*}"
>> +debug "opts: {$@}"
>
> When the arguments of a script or function are to be printed for the
> user's entertainment/education, then it is safer (and, therefore,
> idiomatic) to use "$*".
>
>>  debug
> ...
>>  cache_get()
>>  {
>> -	for oldrev in $*; do
>> -		if [ -r "$cachedir/$oldrev" ]; then
>> +	for oldrev in "$@"
>> +	do
>
> It is idiomatic to write this as
>
> 	for oldrev
> 	do
>
> (But your move from bare $* to quoted "$@" fits better under the "fix
> quoting" topic of this patch.)
>
>> +		if test -r "$cachedir/$oldrev"
>> +		then
>>  			read newrev <"$cachedir/$oldrev"
>>  			echo $newrev
>>  		fi
> ...
>> @@ -631,17 +749,19 @@ cmd_split()
>>  		debug "  parents: $parents"
>>  		newparents=$(cache_get $parents)
>>  		debug "  newparents: $newparents"
>> -		
>> +
>>  		tree=$(subtree_for_commit $rev "$dir")
>>  		debug "  tree is: $tree"
>>
>>  		check_parents $parents
>> -		
>> +
>>  		# ugly.  is there no better way to tell if this is a subtree
>>  		# vs. a mainline commit?  Does it matter?
>> -		if [ -z $tree ]; then
>> +		if test -z $tree
>
> This works by accident. When $tree is empty, this reduces to 'test
> -z', which happens to evaluate to true, just what we want. But it be
> appropriate to put $tree in double-quotes nevertheless.
>
>> +		then
>>  			set_notree $rev
>> -			if [ -n "$newparents" ]; then
>> +			if test -n "$newparents"
>> +			then
>>  				cache_set $rev $rev
>>  			fi
>>  			continue
>
> -- Hannes
