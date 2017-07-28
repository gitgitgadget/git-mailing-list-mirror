Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C92F1F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 13:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbdG1N3f (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 09:29:35 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37938 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdG1N3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 09:29:34 -0400
Received: by mail-qt0-f195.google.com with SMTP id p3so12726430qtg.5
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6DlNsHzxclAqjhhI50Am/FooKX5pLyVtQRwX0ZexBcc=;
        b=JyBCSnGvtd7YXNKHe0NWUXsbzuoeeVjF3BGYX5LagBp2/onHs3YDWKiQ3UB+1U4L+T
         71Fj2IuJ/+OYCiVarE8Dn7/2VrZAWkGGdqLRlk3HTWbB2XNQQiscYRDhHaYZKsxj/92+
         jZl0Hzbl77c11DYLL3yZUw9DMFs8xf6Xl+Se0/1kAumtQBh5rt6JyiETcOeq7Hj5Z9+H
         caYTNuvOu1lH9qENp+cu3YdnYaqIbLyHyH9xpCZOcH8jacwZFc8QGCzAoEAbluV6d2Z0
         xm63AGS53T1w1UpLap9eR2PEDjTYr0rL5eC9RDWkYbMHX14QPhj3luwrFBU7f2m+CnV1
         8q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6DlNsHzxclAqjhhI50Am/FooKX5pLyVtQRwX0ZexBcc=;
        b=HFv43arh8tkT/GaXwgt2mH3sGi+5JSVG0i8/NuqVLUpVWS3cvqsytPtsom5eZjWozT
         XtwsF5gwLAtRFTWxTq/OEUZTWf6Pw/zJdr8GCYzFV1kbQ+lTclQSeyGjDFvwSKUQGzSW
         us+tcDmgQf3d3l7E+N7XOl42S4/AjSlVPLKeSWj4P4uPTqbWVDO3CypviSwbPyEcRMuX
         y56pN4R4cKAc1BAHUCIf5yG3SdX0ws9SEG4Ridu3YLjmy/Td84XjBtsffxPf52GGOKCH
         QHauQ8UoYw970BTNJ4qjaNKErLUt9r32PWTqKatt+lBD/x/sr4jd69UYn7DVmBV/KstC
         aJZQ==
X-Gm-Message-State: AIVw111AdBHW3j5vtWAHPZl76DTDL11EffDE/rwjwMGUSTQGYACC1Qim
        Ol75/5qI2BB8lw==
X-Received: by 10.237.45.69 with SMTP id h63mr4432406qtd.230.1501248573630;
        Fri, 28 Jul 2017 06:29:33 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t57sm15911366qtt.18.2017.07.28.06.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 06:29:32 -0700 (PDT)
Subject: Re: [RFC PATCH 2/4] fsck: support refs pointing to lazy objects
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501111615.git.jonathantanmy@google.com>
 <4c8bc7ab543d8d0d60719f65bd8a150c66123056.1501111615.git.jonathantanmy@google.com>
 <xmqqvamdn1ss.fsf@gitster.mtv.corp.google.com>
 <20170727165058.4eda505e@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dc3c12fb-38e1-7c62-0d51-cca2f9883927@gmail.com>
Date:   Fri, 28 Jul 2017 09:29:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170727165058.4eda505e@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/27/2017 7:50 PM, Jonathan Tan wrote:
> On Thu, 27 Jul 2017 11:59:47 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> @@ -438,6 +438,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
>>>   
>>>   	obj = parse_object(oid);
>>>   	if (!obj) {
>>> +		if (repository_format_lazy_object) {
>>> +			/*
>>> +			 * Increment default_refs anyway, because this is a
>>> +			 * valid ref.
>>> +			 */
>>> +			default_refs++;
>>> +			return 0;
>>> +		}
>>>   		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
>>>   		errors_found |= ERROR_REACHABLE;
>>
>> At this point, do we know (or can we tell) if this is a missing
>> object or a file exists as a loose object but is corrupt?  If we
>> could, it would be nice to do this only for the former to avoid
>> sweeping a real corruption that is unrelated to the lazy fetch under
>> the rug.
> 
> Before all this is run, there is a check over all loose and packed
> objects and I've verified that this check reports failure in
> corrupt-object situations (see test below).
> 
> It is true that parse_object() cannot report the difference, but since
> fsck has already verified non-corruptness, I don't think it needs to
> know the difference at this point.
> 
>>> +test_expect_success 'fsck fails on lazy object pointed to by ref' '
>>> +	rm -rf repo &&
>>> +	test_create_repo repo &&
>>> +	test_commit -C repo 1 &&
>>> +
>>> +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
>>> +
>>> +	# Reference $A only from ref, and delete it
>>> +	git -C repo branch mybranch "$A" &&
>>> +	delete_object repo "$A" &&
>>> +
>>> +	test_must_fail git -C repo fsck
>>> +'
>>
>> And a new test that uses a helper different from delete_object
>> (perhaps call it corrupt_object?) can be used to make sure that we
>> complain in that case here.
> 
> I agree that object corruption can cause this specific part of the
> production code to falsely work. But I think that this specific part of
> the code can and should rely on object corruption being checked
> elsewhere. (I usually don't like to assume that other components work
> and will continue to work, but in this case, I think that fsck checking
> for object corruption is very foundational and should be relied upon.)
> 
> But if we think that defense "in depth" is a good idea, I have no
> problem adding such tests (like the one below).
> 

It's good to know that object corruption is already being checked 
elsewhere in fsck.  I agree that you should be able to rely that as long 
as it is guaranteed to run.  I'd rather see a single location in the 
code that has the logic to detect corrupted objects rather than two 
copies (or worse, two different versions).

Are there also tests for validating the object corruption detection 
code?  If not, adding some (like below) would be great.


> ---
> delete_object () {
> 	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
> }
> 
> corrupt_object () {
> 	chmod a+w $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40) &&
> 	echo CORRUPT >$1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
> }
> 
> setup_object_in_reflog () {
> 	rm -rf repo &&
> 	test_create_repo repo &&
> 	test_commit -C repo 1 &&
> 
> 	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> 	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&
> 
> 	# Reference $A only from reflog
> 	git -C repo branch mybranch "$A" &&
> 	git -C repo branch -f mybranch "$B"
> }
> 
> test_expect_success 'lazy object in reflog' '
> 	setup_object_in_reflog &&
> 	delete_object repo "$A" &&
> 	test_must_fail git -C repo fsck &&
> 	git -C repo config core.repositoryformatversion 1 &&
> 	git -C repo config extensions.lazyobject "arbitrary string" &&
> 	git -C repo fsck
> '
> 
> test_expect_success 'corrupt loose object in reflog' '
> 	setup_object_in_reflog &&
> 	corrupt_object repo "$A" &&
> 	test_must_fail git -C repo fsck &&
> 	git -C repo config core.repositoryformatversion 1 &&
> 	git -C repo config extensions.lazyobject "arbitrary string" &&
> 	test_must_fail git -C repo fsck
> '
> 
> test_expect_success 'missing packed object in reflog' '
> 	setup_object_in_reflog &&
> 	git -C repo repack -a &&
> 	delete_object repo "$A" &&
> 	chmod a+w repo/.git/objects/pack/*.pack &&
> 	echo CORRUPT >"$(echo repo/.git/objects/pack/*.pack)" &&
> 	test_must_fail git -C repo fsck &&
> 	git -C repo config core.repositoryformatversion 1 &&
> 	git -C repo config extensions.lazyobject "arbitrary string" &&
> 	test_must_fail git -C repo fsck
> '
> 
