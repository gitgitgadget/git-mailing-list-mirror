Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4FEC1F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbdEATMb (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:12:31 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35423 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdEATMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:12:30 -0400
Received: by mail-pg0-f51.google.com with SMTP id o3so43580335pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=G8i0dGBiuoeTZ5ZnEj8jDlDSHV9NMcx01DoT2kAY7lc=;
        b=c5T64/+m6P1mKP8SpPMovyKzQOLXlof4KSzCeA3pSOkwQEPRb6SvEmOowTXRqq/EYk
         TarLrbkxsXA1L3KkkbGycZyUIUDckAifL/5+FS3WlqulqbybsVJQMy78Dd1Jc0tKEXhq
         YEZeWFekqw9+a/Mns0K7EsbvTVMpNlBeEHHv8eR4X4AC1BZoKNlY1GgreLacjP9fjK45
         DJUG8gdXC1dEvoHywHjua2Wd21q4ruJpsOiRo0Ld+ZK7cvFIOemRpKNQ0tIt+DRp3jzu
         e/f0LtidsztXpl2ZCO+4HibdH4UNrt+okDA6OA6IfONaVj/WcuuddCQ+IrKDwSZnZYTz
         GdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=G8i0dGBiuoeTZ5ZnEj8jDlDSHV9NMcx01DoT2kAY7lc=;
        b=ARAzTJLXW6v4UcCcw7qednnv8Tw+EmL5lsQVWyl0Jj8PXBuqDtgaLdN/OUt+T5mUiO
         N0ZX6J6ci5mR7qIls/C9OARIQoiWAiT6jS9h/20Cgn+AMQJoY5k5rzRffHEF/tjuTULy
         h8dlbkObWYCpcCikReq2tbAFtHHh+xxlhZmIME104BaW3jvrt59eChID7kgSsbG4/7TE
         ya8eULK9bNsqEZ3yZ2EPfVdTjeo1yDUVvWr83wOV9TFaiRm4fAr3hXQXVKp2F5pjoo2w
         okoFDL4NvQhHO3KbKIY7rp9LVXk4VHiGhOzu+CecfWeCuTIf4UTxi/qbqyyi5sLn/Sf8
         S+cg==
X-Gm-Message-State: AN3rC/4DVYupuh22jistTRn7YWJ9/DK1fNj0KjC7xyfsc0omwNui1f4i
        9mEdnKu65TF5ef3MbFZBvQ==
X-Received: by 10.98.142.25 with SMTP id k25mr27980757pfe.238.1493665949697;
        Mon, 01 May 2017 12:12:29 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a910:d570:c34e:20d9])
        by smtp.gmail.com with ESMTPSA id r18sm25845470pfk.109.2017.05.01.12.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 May 2017 12:12:28 -0700 (PDT)
Subject: Re: Proposal for missing blob support in Git repos
To:     Junio C Hamano <gitster@pobox.com>
References: <20170426221346.25337-1-jonathantanmy@google.com>
 <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, markbt@efaref.net, git@jeffhostetler.com,
        kevin.david@microsoft.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
Date:   Mon, 1 May 2017 12:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/30/2017 08:57 PM, Junio C Hamano wrote:
> One thing I wonder is what the performance impact of a change like
> this to the codepath that wants to see if an object does _not_ exist
> in the repository.  When creating a new object by hashing raw data,
> we see if an object with the same name already exists before writing
> the compressed loose object out (or comparing the payload to detect
> hash collision).  With a "missing blob" support, we'd essentially
> spawn an extra process every time we want to create a new blob
> locally, and most of the time that is done only to hear the external
> command to say "no, we've never heard of such an object", with a
> possibly large latency.
>
> If we do not have to worry about that (or if it is no use to worry
> about it, because we cannot avoid it if we wanted to do the lazy
> loading of objects from elsewhere), then the patch presented here
> looked like a sensible first step towards the stated goal.
>
> Thanks.

Thanks for your comments. If you're referring to the codepath involving 
write_sha1_file() (for example, builtin/hash-object -> index_fd or 
builtin/unpack-objects), that is fine because write_sha1_file() invokes 
freshen_packed_object() and freshen_loose_object() directly to check if 
the object already exists (and thus does not invoke the new mechanism in 
this patch).

Having said that, looking at other parts of the fetching mechanism, 
there are a few calls to has_sha1_file() and others that might need to 
be checked. (We have already discussed one - the one in rev-list when 
invoked to check connectivity.) I could take a look at that, but was 
hoping for discussion on what I've sent so far (so that I know that I'm 
on the right track, and because it somewhat works, albeit slowly).
