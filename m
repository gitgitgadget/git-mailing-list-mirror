Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D9A1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeKNESN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 23:18:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeKNESN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 23:18:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id w24-v6so6419480plq.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRBMT3Rmczm5fG+RiJDRRV/bkvkup1zjlCVeu/nB4MM=;
        b=WOqlAn/EmF1f5bfF39Z+NV+4LYvQ4HBDoS8FGTpuEXV7pFv3cxT/STI/CF62HWgTg1
         5U69TZIi2cmkhDuahw7U9os5UvEEugdiPoU/Ffyy0KZKFnj67FRFWoZLk95ql1AhS2g8
         Hard94sn+1NCfc2AR2NIA0TQNe0+iFMDJlpPblpdVxGIcSlkaUKrpFJOThUXJ+jV/5eT
         jlT9VNWfK5hxDtvaUcBtCqFjZxxaNkwivZB50HXnWohdBozvo41OFFLwbeDAkr9zfJ8w
         tDx0gMaJqD9zKhGW/jmbVnQpa3WiMjO81wYUPqFt97JZxihs0G4NGcDkv4SyvOukCnNk
         J42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRBMT3Rmczm5fG+RiJDRRV/bkvkup1zjlCVeu/nB4MM=;
        b=CK0hLA9mSKSa5LqyFy+2+5l7Dl/ibhTkdnTqGsEDlEXh8qupOUfFlsV2X27XnGyoYU
         pwZj0daFHmhQ7BRF40j7dgU2Ifoiu1TtPSI+6TF32hvQ0yM8hvO0NpbEyyzspfNKGncy
         PRS7YpA277Kx439qqZCQYKmzc8stCfluOzj+BD8o/pHVaIkLXkAFfQTpvpn5ZmFuRc/e
         PDGkKQm0Is5rne0EUL7cQv2qunSTzxID5+yfkTYa+6Tz86WqSTVOkyVrqCbQs3wEgcbV
         by3udup/tvctOSjmn6l3e7/hz3KPetKf9eD6rcAbhZVd15FEDIxstdNHwSA3BXT4Mxbt
         h9fA==
X-Gm-Message-State: AGRZ1gI4vhjMBuRKhnWoVNtMFc7ZOevgauFxwfH5F0NThhQk+pNSJIN+
        jzVE3BZJT5vLAh48ZT8pcie1dqEm
X-Google-Smtp-Source: AJdET5e7zQW5dgocC87h5oHCbQUPvxvlmukU4vyxIAbhsR6+hIIDwVOoRJrWNJEm1Sx5zLramhmHnw==
X-Received: by 2002:a17:902:6b46:: with SMTP id g6-v6mr6060401plt.33.1542133137797;
        Tue, 13 Nov 2018 10:18:57 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id p87-v6sm24605458pfk.186.2018.11.13.10.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 10:18:57 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:18:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 2/3] ieot: default to not writing IEOT section
Message-ID: <20181113181855.GB68106@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:
> On 11/12/2018 7:39 PM, Jonathan Nieder wrote:

>> As with EOIE, popular versions of Git do not support the new IEOT
>> extension yet.  When accessing a Git repository written by a more
>> modern version of Git, they correctly ignore the unrecognized section,
>> but in the process they loudly warn
>>
>> 	ignoring IEOT extension
>>
>> resulting in confusion for users.  Introduce the index extension more
>> gently by not writing it yet in this first version with support for
>> it.
[...]
>> Introduce a '[index] recordOffsetTable' configuration variable to
>> control whether the new index extension is written.
>
> Why introduce a new setting to disable writing the IEOT extension instead of
> just using the existing index.threads setting?  If index.threads=1 then the
> IEOT extension isn't written which (I believe) will accomplish the same
> goal.

Do you mean defaulting to index.threads=1?  I don't think that would
be a good default, but if you have a different change in mind then I'd
be happy to hear it.

Or do you mean that if the user has explicitly specified index.threads=true,
then that should imply index.recordOffsetTable=true so users only have
to set one setting to turn it on?  I can imagine that working well.

Thanks,
Jonathan
