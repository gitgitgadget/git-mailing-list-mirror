Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A44A1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 12:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKNWnP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 17:43:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40333 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKNWnP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 17:43:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so7944410wrt.7
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 04:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FLIukTF0DroJbGaa0CErlW17V/SS8ef5rmPWtGVZKtM=;
        b=D5A2zeiJE8jw/d8QmSgrJrtZCoR+EnSon8rBBWjtT/HxiC4SFqe7U6/AGNcjZFqlgw
         0ccpTDyD6LkRs+WwABx9X2CAVxzLFcs1Wx1mMpeGZ5olFFEbNHTDEPGNfWZB8EG+TC8a
         GvS5abwl8nlGcbFLrtdzoMUDTTVGgEHlcsxG3QbnAwQPK3VuzKJIf3FJqiuSIJHLpnON
         6oWewKb7tdNKPot/Gz3ujx7oXdoBvo395D7qd4uiXR8tDTKGiRvNx+XN1IYfphUOavh5
         jITJ+8X9tMo6GFD7hRcO2jah4oZb/Aw4Vvh6RpcwI53Lov1TRLvthNbvEr1AdFFqA+Ik
         bnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FLIukTF0DroJbGaa0CErlW17V/SS8ef5rmPWtGVZKtM=;
        b=n2PsbAdK3ASphj71BKlpPmhXCf37U+2ijl6cOAzxPIVnGgK5KxHcjEngP+kESxeb6l
         H/HXPtCeRTqPkbAI7LqELncnJwIOlNk7mbNLa4fo22FRZ3TzeXM4we9EZ0a38CCBOmWX
         5ukPGcyC4fCigHeL7wb4Mp4LfIMs2lHuqGbLKPeJxOC2mmyJpO3lynz75CTxf/frX25b
         EJJqLeu4r8kbTu2ncW0Y1SIrhgE84j48px7/qlxKkhEnUUl0MLS/ayYFnL4OmwxxAci2
         QkNhyuDH6sY6fSZM+Trza6F4ZVLmZ/f2AY4+HrsJsBiMYPYVLoqTd023HNaz89zxsTsv
         bdBg==
X-Gm-Message-State: AGRZ1gIjHiB2f9RmqOkpC9ivj6vDNLqHy7WHTr5UPD9ReFwJId3YbkFs
        sMNIlBQLtktpQg97I13mo8M=
X-Google-Smtp-Source: AJdET5ejnFg02RjcNkCwFPOppDhvkZg99E2+EOSb0JqSu7g6+S//AGlOnDkEWOLCV4WUOZq/POExeQ==
X-Received: by 2002:adf:f748:: with SMTP id z8-v6mr1767954wrp.237.1542199208248;
        Wed, 14 Nov 2018 04:40:08 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o15-v6sm3802861wmc.18.2018.11.14.04.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 04:40:07 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH v3] index-pack: add ability to disable SHA-1 collision check
References: <20181030184331.27264-1-avarab@gmail.com> <20181113201910.11518-1-avarab@gmail.com> <xmqqftw4nnj6.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqftw4nnj6.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 14 Nov 2018 13:40:06 +0100
Message-ID: <87va4z25p5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 14 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Add a new core.checkCollisions setting. On by default, it can be set
>> to 'false' to disable the check for existing objects in sha1_object().
>> ...
>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>> index 2004e25da2..4a3508aa9f 100644
>> --- a/builtin/index-pack.c
>> +++ b/builtin/index-pack.c
>> @@ -791,23 +791,24 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>>  {
>>  	void *new_data = NULL;
>>  	int collision_test_needed = 0;
>> +	int do_coll_check = git_config_get_collision_check();
>>
>>  	assert(data || obj_entry);
>>
>> -	if (startup_info->have_repository) {
>> +	if (do_coll_check && startup_info->have_repository) {
>>  		read_lock();
>>  		collision_test_needed =
>>  			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
>>  		read_unlock();
>>  	}
>>
>> -	if (collision_test_needed && !data) {
>> +	if (do_coll_check && collision_test_needed && !data) {
>>  		read_lock();
>>  		if (!check_collison(obj_entry))
>>  			collision_test_needed = 0;
>>  		read_unlock();
>>  	}
>> -	if (collision_test_needed) {
>> +	if (do_coll_check && collision_test_needed) {
>
> If I am reading the patch correctly, The latter two changes are
> totally unnecessary.  c-t-needed is true only when dO-coll_check
> allowed the initial "do we even have that object?" check to kick in
> and never set otherwise.

You're right. I was trying to do this in a few different ways and didn't
simplify this part.

> I am not all that enthused to the idea of sending a wrong message to
> our users, i.e. it is sometimes OK to sacrifice the security of
> collision detection.

I think I've made the case in side-threads that given the performance
numbers and the danger of an actual SHA-1 collision this is something
other powerusers would be interested in having.

> A small change like this is easy to adjust to apply to the codebase,
> even after today's codebase undergoes extensive modifications; quite
> honestly, I'd prefer not having to worry about it so close to the
> pre-release feature freeze.

Yeah, let's definitely wait with this under 2.20. I sent this out more
because I re-rolled it for an internal deployment, and wanted to get
some thoughts on what the plan should be for queuing up these two
related (no collision detection && loose cache) features.
