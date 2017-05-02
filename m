Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61A01F790
	for <e@80x24.org>; Tue,  2 May 2017 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbdEBSc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:32:28 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33907 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdEBSc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:32:27 -0400
Received: by mail-io0-f180.google.com with SMTP id a103so166017390ioj.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bVn9uIg7q7QkUBQ0c7iSa7rXPn+pkb9/V1EMrLiYWT4=;
        b=Oi4JIVe/S0slFthuLEeeLYSgcMdbmYH6Gc4m85t/7OXyqvYaBu3SNsRbmKtLrEO8GI
         ky+bWM/k37zGk+MMkhR0dLDf3SZgSr/6rzlJlJPDIquytOXyIBAJX1torddhebNr7Pt2
         MvHRG6AHAjm+Kfp/XmYGRJG9wYox1h+92DVd+RYl9D+PZe519W9bMINIdT0s0oJCCv4C
         j3aQ5a57pnqLR1wsbD+Gijjmz+9J4Kg9d5Kpug+1GXS1zVFTs44X2T1/2Sv3hlpTbIA9
         uw4oLuMTpQM5/f7xOluszxGhJFvSPrZJsAnslj+xt17EShhdccU+e4ZfBEz6xVakmfba
         fyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bVn9uIg7q7QkUBQ0c7iSa7rXPn+pkb9/V1EMrLiYWT4=;
        b=A2VkMBecU8b1wnHBc2MUOtzP1vfOELc9InvNT+oFToQUWvYKjHxFkhNUEUXS7tSci2
         W1uOLZ6apdY2wnOgzTEsRll8M6g+/Ts713PJO0i5q40EIntNktU4p6uUUvwc3qVw8thg
         c8Rv0Eu5bKCRlGCVEGytu0H2wtmQpi2Qc+LE59KD0A0w4dM676HpXJKGs7pjmpB+X180
         Qje3S4/gtBBMbsgn0ykfzDoYqUK4pRzEE7krHDPfVsSUX0s/rqN3BEdedr1XPpXkiZrE
         AHPG8z6v7uRfgcgN2OUlqKFGie62xu6OiOUD78o5lw1a9TUcgAkKOpc1DzpQR2lwPFG+
         CYJA==
X-Gm-Message-State: AN3rC/6Bpgd8sINgWvJCuLz5bFEDfcovnYcgdqaGMGyxguxlxf8Vp4J5
        khlQuEZSUCZ1A1ODReDUSoKUV+psRA==
X-Received: by 10.107.146.139 with SMTP id u133mr27784837iod.160.1493749946647;
 Tue, 02 May 2017 11:32:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 2 May 2017 11:32:05 -0700 (PDT)
In-Reply-To: <CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com> <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
 <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com> <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
 <xmqq37cof320.fsf@gitster.mtv.corp.google.com> <CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 2 May 2017 20:32:05 +0200
Message-ID: <CACBZZX6jQtO_3zYjnvq0dhtWvUxb7vYLtQUWpFHLw1v-SteHcQ@mail.gmail.com>
Subject: Re: Proposal for missing blob support in Git repos
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Mark Thomas <markbt@efaref.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Kevin David <kevin.david@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2017 at 7:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon, May 1, 2017 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> On 05/01/2017 04:29 PM, Junio C Hamano wrote:
>>>> Jonathan Tan <jonathantanmy@google.com> writes:
>>>>
>>>>> Thanks for your comments. If you're referring to the codepath
>>>>> involving write_sha1_file() (for example, builtin/hash-object ->
>>>>> index_fd or builtin/unpack-objects), that is fine because
>>>>> write_sha1_file() invokes freshen_packed_object() and
>>>>> freshen_loose_object() directly to check if the object already exists
>>>>> (and thus does not invoke the new mechanism in this patch).
>>>>
>>>> Is that a good thing, though?  It means that you an attacker can
>>>> feed one version to the remote object store your "grab blob" hook
>>>> gets the blobs from, and have you add a colliding object locally,
>>>> and the usual "are we recording the same object as existing one?"
>>>> check is bypassed.
>>>
>>> If I understand this correctly, what you mean is the situation where
>>> the hook adds an object to the local repo, overriding another object
>>> of the same name?
>>
>> No.
>>
>> write_sha1_file() pays attention to objects already in the local
>> object store to avoid hash collisions that can be used to replace a
>> known-to-be-good object and that is done as a security measure.
>> What I am reading in your response was that this new mechanism
>> bypasses that, and I was wondering if that is a good thing.
>
> Oh, what I meant was that write_sha1_file() bypasses the new
> mechanism, not that the new mechanism bypasses the checks in
> write_sha1_file().
>
> To be clear, here's what happens when write_sha1_file() is invoked
> (before and after this patch - this patch does not affect
> write_sha1_file at all):
> 1. (some details omitted)
> 2. call freshen_packed_object
> 3, call freshen_loose_object if necessary
> 4. write object (if freshen_packed_object and freshen_loose_object do
> not both return 0)
>
> Nothing changes in this patch (whether a hook is defined or not).

But don't the semantics change in the sense that before
core.missingBlobCommand you couldn't write a new blob SHA1 that was
already part of your history, whereas with this change
write_sha1_file() might write what it considers to be a new blob, but
it's actually colliding with an existing blob, but write_sha1_file()
doesn't know that because knowing would involve asking the hook to
fetch the blob?

> And here's what happens when has_sha1_file (or another function listed
> in the commit message) is invoked:
> 1. check for existence of packed object of the requested name
> 2. check for existence of loose object of the requested name
> 3. check again for existence of packed object of the requested name
> 4. if a hook is defined, invoke the hook and repeat 1-3
>
> Here, in step 4, the hook could do whatever it wants to the repository.

This might be a bit of early bikeshedding, but then again the lack of
early bikeshedding tends to turn into standards.

Wouldn't it be better to name this core.missingObjectCommand & have
the hook take a list on stdin like:

    <id> <TAB> <object_type> <TAB> <object_id> <TAB> <request_type> <TAB> [....]

And have the hook respond:

    <id> <TAB> <status> <TAB> [....]

I.e. what you'd do now is send this to the hook:

    1 <TAB> blob <TAB> <sha1> <TAB> missing

And the hook would respond:

    1 <TAB> ok

But this leaves open the door addressing this potential edge case with
writing new blobs in the future, i.e. write_sha1_file() could call it
as:

    1 <TAB> blob <TAB> <sha1> <TAB> new

And the hook could either respond immediately as:

    1 <TAB> ok

If it's in some #YOLO mode where it's not going to check for colliding
blobs over the network, or alternatively & ask the parent repo if it
has those blobs, and if so print:

    1 <TAB> collision

Or something like that.

This also enables future lazy loading of trees/commits from the same
API, and for the hook to respond out-of-order to the input it gets as
it can, since each request is prefixed with an incrementing request
id.
