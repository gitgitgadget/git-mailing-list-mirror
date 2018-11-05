Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF2E1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 20:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeKFFsb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 00:48:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42144 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeKFFsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 00:48:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id z20-v6so130901qti.9
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 12:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c0fcG8eG95Q9MCINsMp/YNOfHnFl3ebXTSugpmrRJqY=;
        b=l6lywQlkQgIGxnC1Z7gQloeh3q7O8puO217XUBhatgeH61iiIbNo9G7NIlIO4LFUTX
         s3uPknXzOaqyX2i9QqtX/9xvSCvbgREYXh/aZfRH48s7VV8w2KhNhLyfwcy/67q/Gnvh
         RM63yUWYdAIowVugjtaSaKR0u959cMcKgxaT1hihZy2SbvQO9wkQ7lruiCSudZFmbBoR
         fJEOjytS8dub8QB5cf2Bw9R/lBcnFZ5QQPnvqBUpbGXl6Y+p+/J4Q0+n/t+2O5NRdG7+
         2v0lUxd/NWcw/RgiESqrr3Ejlv9hfaPx2iIxvR/LXsG3Bck/t4U8p6ErgwZp8iIIGKLF
         nVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c0fcG8eG95Q9MCINsMp/YNOfHnFl3ebXTSugpmrRJqY=;
        b=hl4spJAxLUM+0GjJDG+BdQu5I86BFM9EE6LY/ncDuo+SEjN3RV4xnlbC9/Miymwcke
         UXPzoc/Ue3Xx7c1XKdov4B5qoEHirzyw9FS0N7yIRPgzC6JsrtlWyTSaBxGdWgtambT+
         d6K+m6WZrUuB1Z+xEkgxjCE3hob8a/PqiWAg74G0y6+i883cYfr63VmlZFwkUsvmenQT
         SnnLXcunChBEaQk2pbrBZqe4D4MzKjy0Vmj+ibij4BAuQ6Olg4/v4/KDRbVmvKCYKAoY
         0z87LwPi98VtqCqwoBW0P4Z+un9YdiZdrrBxgdfIROfnofkp5Nsp87mkjkdinJ6nA1x4
         +m8w==
X-Gm-Message-State: AGRZ1gIM+Iohx5zCNg0XARuuB5W+QVk5025GGTH48N5Sybz50oAEnJdO
        cDieHS9dsWyEc6wy/Pg9pFkvHDO6
X-Google-Smtp-Source: AJdET5dxIjFkkv7Xg5M+UuQvuLjqzqlO3q+/EzbRZjE3QYNaaDlVaPKNQj2ngukRtZgElZ6bwZrqdA==
X-Received: by 2002:ac8:3e91:: with SMTP id y17-v6mr22160819qtf.314.1541449625833;
        Mon, 05 Nov 2018 12:27:05 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id u199-v6sm13133432qka.47.2018.11.05.12.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:27:05 -0800 (PST)
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181030191608.18716-1-peartben@gmail.com>
 <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
 <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
 <20181104210105.GK731755@genre.crustytoothpaste.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <5f025224-ca28-4a93-495c-f866544ffc06@gmail.com>
Date:   Mon, 5 Nov 2018 15:27:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181104210105.GK731755@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/4/2018 4:01 PM, brian m. carlson wrote:
> On Sun, Nov 04, 2018 at 07:34:01AM +0100, Duy Nguyen wrote:
>> On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
>>> It's more than a dynamic sparse-checkout because the same list is also
>>> used to exclude any file/folder not listed.  That means any file not
>>> listed won't ever be updated by git (like in 'checkout' for example) so
>>> 'stale' files could be left in the working directory.  It also means git
>>> won't find new/untracked files unless they are specifically added to the
>>> list.
>>
>> OK. I'm not at all interested in carrying maintenance burden for some
>> software behind closed doors. I could see values in having a more
>> flexible sparse checkout but this now seems like very tightly designed
>> for GVFS. So unless there's another use case (preferably open source)
>> for this, I don't think this should be added in git.git.
> 
> I should point out that VFS for Git is an open-source project and will
> likely have larger use than just at Microsoft.  There are both Windows
> and Mac clients and there are plans for a Linux client as well.
> Ideally, it would work with an unmodified upstream Git, which is (I
> assume) why Ben is sending this series.
> 
> Personally, I don't love the current name used in this series.  I don't
> see this patch as introducing a virtual file system in the Unix sense of
> that word, and I think calling it that in Git core will be confusing to
> Unix users.  I would prefer to see it as a hook (maybe called
> "sparse-checkout" or "sparse-exclude"; better names are okay), and
> simply turn it on based on whether or not there's an appropriate hook
> file there and whether core.sparseCheckout is on (or possibly with
> hook.sparseExclude or something).  With a design more like that, I don't
> see a problem with it in principle.
> 

I'm really bad at naming so am happy to choose something else that will 
be more descriptive to the community at large.  The name came from the 
fact that we started with the (equally awful) 'VFS for Git' and this was 
the big enabling feature in git so for better or worse it got saddled 
with the same 'VFS' name.

In other feedback it was suggested to not add a core.vfs setting that 
was the path to the hook and I like that.  I can change it to 
core.sparseExclude (unless someone has something better) and hard code 
the hook name for now.  I do like the idea of having config based hooks 
so when I get some time I will put together a patch series to implement 
that.
