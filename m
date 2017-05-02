Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A16E207D6
	for <e@80x24.org>; Tue,  2 May 2017 00:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdEBAdF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 20:33:05 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35548 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdEBAdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 20:33:04 -0400
Received: by mail-pg0-f47.google.com with SMTP id o3so46711692pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=CH8OumqINXmy1OxiyAOmf75fcGCsTnt6M67gV/dho2E=;
        b=WA1t+20BqXWkT7T4OlqpsKvtMV8dhTt1+UDESUwFw98KzT7a606mVhNiAhAH3QPLkS
         Pvr9y7VGiGNdKKFKCLkl6UwTuZXQ3H1mQEQpbHt/knZJ9u6aB3n1Uhfhlr5uVjk8TTgk
         6WQXQtGk239qlfre8ek1gc365g69jR7fINkhQ23Unf0iLuIfTQBo4xhTVimOjmS132Hl
         Ai+Lf4dfwPO1KRWBuCZxcRsM1RvUEdk2mfiZ3eZtFq9QBYPUr0OQp6qtgb39NtW2hsQO
         t9pCJXY7PobPmomR8J/QLyaJ3ETLk4Q2yUnjLMIhrBks6rz9LOjFthjRHCfY8HEffQX8
         8y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=CH8OumqINXmy1OxiyAOmf75fcGCsTnt6M67gV/dho2E=;
        b=SL++2+V2xNWOtqxCnSoCYTlyW5KhyUgRjuzDKfktqv1nJ4YnU7UOW2JzLEReKsHLiV
         JpOx1SreiFRHOZ3KPueS+u9IPj+28w4Ag5iWbjg7Ss+rtLuP85gfhHaY7mbLBqfSg2M8
         ci+IgSTrrnpOut9mInjLL3lK1Qx3wv7cC6qTRJ6mxlRp0ufuTW4e9SI6/GzqBBqMhD1W
         +3iPf+cwJH0Zcs7hCZg3SyZ5sFpD1lzqW2ABHHrmNenIv32R8BtNfOKUgcDVCuBx6Dza
         hfNxElvVSJye0ALJih6q9FQ6v3YOuNmArTMKvxjdHmFLjzkWqpG4KheelRl29thBJask
         WJfw==
X-Gm-Message-State: AN3rC/7TFIto5y7AtPaaWLxgwLWmCuxDWaPH6+2HtYg8VNeEbtKeW0g9
        eS40Hv82AaNZHz8G
X-Received: by 10.84.130.35 with SMTP id 32mr37357525plc.24.1493685183734;
        Mon, 01 May 2017 17:33:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id 29sm25383150pfo.9.2017.05.01.17.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 17:33:02 -0700 (PDT)
Subject: Re: Proposal for missing blob support in Git repos
To:     Junio C Hamano <gitster@pobox.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
 <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
 <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, markbt@efaref.net, git@jeffhostetler.com,
        kevin.david@microsoft.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c0c8a0c3-582c-cf3b-3833-c918a0630f9f@google.com>
Date:   Mon, 1 May 2017 17:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2017 04:29 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Thanks for your comments. If you're referring to the codepath
>> involving write_sha1_file() (for example, builtin/hash-object ->
>> index_fd or builtin/unpack-objects), that is fine because
>> write_sha1_file() invokes freshen_packed_object() and
>> freshen_loose_object() directly to check if the object already exists
>> (and thus does not invoke the new mechanism in this patch).
>
> Is that a good thing, though?  It means that you an attacker can
> feed one version to the remote object store your "grab blob" hook
> gets the blobs from, and have you add a colliding object locally,
> and the usual "are we recording the same object as existing one?"
> check is bypassed.

If I understand this correctly, what you mean is the situation where the 
hook adds an object to the local repo, overriding another object of the 
same name? If yes, I think that is the nature of executing an arbitrary 
command. If we really want to avoid that, we could drop the hook 
functionality (and instead, for example, provide the URL of a Git repo 
instead from which we can communicate using a new fetch-blob protocol), 
although that would reduce the usefulness of this, especially during the 
transition period in which we don't have any sort of batching of requests.
