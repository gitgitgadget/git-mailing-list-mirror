Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009071F790
	for <e@80x24.org>; Tue,  2 May 2017 17:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbdEBRWF (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 13:22:05 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36470 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdEBRWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 13:22:01 -0400
Received: by mail-wm0-f47.google.com with SMTP id u65so120161536wmu.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mXn3jHOVqJ6olM4yutsx0JDrO6FHV0sG856ImZVVv2I=;
        b=Q0SOxKG6kftJ5uBP9bHnX19VR1PupEdJOUYX0rq6naChYkh+ojkf12qHISt9i90bhX
         y3LPdoHlQXMrkjpQUqddbPQrIIEdrv91VxRDS3zzp/XxJZARBu6Lzq2IQQI4TWvINm27
         0iSeVE+A8Lv7A7Exb2hnmsKEfXDN7npx4tQSESlVl3HK/ivgmZPAO3OfZ6bsEZFkm7pU
         gjkZi9boCsYdddK224hroYrh1YcFFAyMBXeW0lJFsBTAVQHE1Ccr8ZFglE77N4Lycqcm
         3ieYe2rZe06ciEX5VDHg53rveUoRzW6UK5ImJ+k/TYpZO7Xv2VlArneMiCicgsJ0tWeP
         C54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mXn3jHOVqJ6olM4yutsx0JDrO6FHV0sG856ImZVVv2I=;
        b=AdbdF02WKS9ozfh6dOuUdIutnAV1I630Ph4RAK6pnByp9QMFblR/xjIzWAfSp3GbTV
         ebauxpy2mW0W8xAREjCScluDlh9BMnUquF03r0WttYVXqSMC5xmOf7BVZ018AAqsdSp8
         BrDQuSV8ikJzYZfaTUUYb0LLuBPi36oOZE6njUIFh5L+Qb0IOTc/oHgZUdm4/bnsFdh4
         q/NmlPhMjvtrliEirlvFcHTfLr4cUfLqPrzGqxsWohYeYm52gjnze4+PP2GlsBxZ6baU
         CsKVrhJNMX+x6/jZPTH0fZrtsi5ZE+4otY5uTx7IdygTq6QWNmZmeqIEBcOyCmRbtzsi
         RtGw==
X-Gm-Message-State: AN3rC/7ETLf9sSjttVrRwqFlpraVj0cMddW+6b+ApnMAV1O6t4oY7VIh
        yokQVNAFsbPwpiA3j18Ko9zBFtIiV1BX
X-Received: by 10.28.130.210 with SMTP id e201mr2969938wmd.128.1493745720219;
 Tue, 02 May 2017 10:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.6.210 with HTTP; Tue, 2 May 2017 10:21:59 -0700 (PDT)
In-Reply-To: <xmqq37cof320.fsf@gitster.mtv.corp.google.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com> <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
 <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com> <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
 <xmqq37cof320.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 2 May 2017 10:21:59 -0700
Message-ID: <CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com>
Subject: Re: Proposal for missing blob support in Git repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Kevin David <kevin.david@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> On 05/01/2017 04:29 PM, Junio C Hamano wrote:
>>> Jonathan Tan <jonathantanmy@google.com> writes:
>>>
>>>> Thanks for your comments. If you're referring to the codepath
>>>> involving write_sha1_file() (for example, builtin/hash-object ->
>>>> index_fd or builtin/unpack-objects), that is fine because
>>>> write_sha1_file() invokes freshen_packed_object() and
>>>> freshen_loose_object() directly to check if the object already exists
>>>> (and thus does not invoke the new mechanism in this patch).
>>>
>>> Is that a good thing, though?  It means that you an attacker can
>>> feed one version to the remote object store your "grab blob" hook
>>> gets the blobs from, and have you add a colliding object locally,
>>> and the usual "are we recording the same object as existing one?"
>>> check is bypassed.
>>
>> If I understand this correctly, what you mean is the situation where
>> the hook adds an object to the local repo, overriding another object
>> of the same name?
>
> No.
>
> write_sha1_file() pays attention to objects already in the local
> object store to avoid hash collisions that can be used to replace a
> known-to-be-good object and that is done as a security measure.
> What I am reading in your response was that this new mechanism
> bypasses that, and I was wondering if that is a good thing.

Oh, what I meant was that write_sha1_file() bypasses the new
mechanism, not that the new mechanism bypasses the checks in
write_sha1_file().

To be clear, here's what happens when write_sha1_file() is invoked
(before and after this patch - this patch does not affect
write_sha1_file at all):
1. (some details omitted)
2. call freshen_packed_object
3, call freshen_loose_object if necessary
4. write object (if freshen_packed_object and freshen_loose_object do
not both return 0)

Nothing changes in this patch (whether a hook is defined or not).

And here's what happens when has_sha1_file (or another function listed
in the commit message) is invoked:
1. check for existence of packed object of the requested name
2. check for existence of loose object of the requested name
3. check again for existence of packed object of the requested name
4. if a hook is defined, invoke the hook and repeat 1-3

Here, in step 4, the hook could do whatever it wants to the repository.
