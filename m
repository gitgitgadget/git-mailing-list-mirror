Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 778581F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 19:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdAZThI (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 14:37:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60127 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752658AbdAZThG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 14:37:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73729636A0;
        Thu, 26 Jan 2017 14:34:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LAcLL3gGBLEe
        ccEUz6W8pcIafH8=; b=UoLuo+OW5bC4LiQAVrovPFlgWjNf0SvXZ4fmqSlrD24s
        DE6ZN5oc5KCdw+1IHLi+KmkWSPV8D3rivigEPKwlInGjLinxQvMj5hwBonTLzek9
        MSv8FvjzaDObBFrrXLlmXHIRCNLQIf9JedLJv4Y0aV+aAM94ycL+Im4zxdKBip4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NFaZGG
        NwIwOcESg/QaGEJ+tv0lW7JuO9N3Ru2AFzXcj3xeJKJxdZTTISmN9YfDc18tMKlm
        okqmnSaRIOBQRxh31vgY2TJ9WfHhmm0UI3xNCOK3UBqw7oSvKywTDoE+ddiV8kZ6
        5cI+J1TqnVLRdaJ4rZMud9N4w1m5j6XORX8Hk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BB376369F;
        Thu, 26 Jan 2017 14:34:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB406369E;
        Thu, 26 Jan 2017 14:34:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     marcandre.lureau@redhat.com, Duy Nguyen <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-bisect: allow running in a working tree subdirectory
References: <20170126183030.28632-1-marcandre.lureau@redhat.com>
        <CAGZ79kZkxnoKCyk9teQnEPjsnS7iEorZALY4dXE8Fy78ifur7g@mail.gmail.com>
Date:   Thu, 26 Jan 2017 11:34:07 -0800
In-Reply-To: <CAGZ79kZkxnoKCyk9teQnEPjsnS7iEorZALY4dXE8Fy78ifur7g@mail.gmail.com>
        (Stefan Beller's message of "Thu, 26 Jan 2017 10:46:04 -0800")
Message-ID: <xmqqk29h4nv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67F1EFE6-E3FE-11E6-94B7-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> + Duy, main author of the worktree feature.
>
> On Thu, Jan 26, 2017 at 10:30 AM,  <marcandre.lureau@redhat.com> wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> It looks like it can do it.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---

I do not think the OP meant by "a working tree subdirectory" using
the command in a secondary worktree.  SUBDIRECTORY_OK is about "can
the command be started in a subdirectory (as opposed to requiring to
be run only at the toplevel)?"

I am slightly negative on this change, though.  The subdirectory you
are sitting in when you start your bisection may disappear and reappear
as you dig the history, and I do not think the code makes anything
special to prevent the disappearing current directory from getting
in the way of bisection process.

>>  git-bisect.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index ae3cb013e..b0bd604d4 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -1,5 +1,6 @@
>>  #!/bin/sh
>>
>> +SUBDIRECTORY_OK=3DYes
>>  USAGE=3D'[help|start|bad|good|new|old|terms|skip|next|reset|visualize=
|replay|log|run]'
>>  LONG_USAGE=3D'git bisect help
>>         print this long help message.
>> --
>> 2.11.0.295.gd7dffce1c.dirty
>>
