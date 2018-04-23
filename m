Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 115A81F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755549AbeDWQAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:00:52 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34044 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755114AbeDWQAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:00:50 -0400
Received: by mail-qt0-f174.google.com with SMTP id a25-v6so18277834qtm.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8poLOK2BhkhhloqDTKbFyR+IfdxjxkH+yQ4VugP23cY=;
        b=OJDXPX2N/3iLrE9gxFWm7MyxrKj0FC2bq41cMWTnMlHslf7ualDPlK0h8HG70ubOim
         eMIrtxlyWdexikBsSzSmIcNnZPRyi4Oe3JrGk0vwR4dW4KKo3cQJdCTYZPyXEQuyfCgu
         bSaf75h/j15fNDoVwWadnY1L5evJ6MPEKwOzIV1LgTx4D527G+fwr9xX7buXfDhewk2r
         4S0rdp2vNgJX3ruDivDst9xVYN3RZIEhevMzJ9nfrXrRhPXMhudEsnD+XgO5eXyfch+l
         oCA6f8t+Y9rPr04qXlkpchNe8v3UqjENEET+gWzu5d37pnjkCeC9fzzvWpca1/fGLYFy
         0U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8poLOK2BhkhhloqDTKbFyR+IfdxjxkH+yQ4VugP23cY=;
        b=JoO1NmjRl9uliu+9NRWLu5Owg1D6jhbogZsD5JO77FleYk3fv/irG0MWBPozsXqNPC
         Mu0s2XgfnrRt7crHVr3jXuXqlEBXZoMQhObD7GCV59gKUEW+ePtY6Od55gMi1V7JC9Mz
         BZz1Uv4tTuv1HSxLEfxhK124kOZh1qX3c9eLZ45Gq6J19XoCuPjjh9CLg8XiUkHmi+oK
         9hwMSem6DfwDwAPjg2VGLYufyw2UZ99XCgN9U2ZUjmtKRyroA2/umPmoskFsiLlWuy+U
         1K94Y62BF7u/YXKMbd+gH7oBd/m7XFkv51pYMK/4T9f34zXH6dVz47Q2Y5tBEZr2gpzm
         9Fog==
X-Gm-Message-State: ALQs6tBAsaSufZ2zGnzrT/KTuxEykA7c7fv1rH8fjXaNDPHk806CmL6u
        o9lNv0GhYF3Cdk3TX2r4qu8=
X-Google-Smtp-Source: AB8JxZrWpUvkQSwk4oUo1qAipEJtxeh893sei1l1ZkmdFSKUaulaCpD60cXnkMy+IeWmKiH/+O9Jow==
X-Received: by 10.12.189.37 with SMTP id m37mr1961004qvg.209.1524499249866;
        Mon, 23 Apr 2018 09:00:49 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d199sm10826258qka.26.2018.04.23.09.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 09:00:49 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <cd49481c-9665-124a-5f94-791f1a16657d@gmail.com>
 <CABPp-BFqj2TFiHUDsysafq0NHC4MV-QYZVxOZe1TNRrXMOQfng@mail.gmail.com>
 <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <1fb11850-4c20-5327-a63a-6d1f5aa18ea4@gmail.com>
Date:   Mon, 23 Apr 2018 12:00:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqwox19ohw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/21/2018 12:23 AM, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>>>> +merge.renames::
>>>>> +       Whether and how Git detects renames.  If set to "false",
>>>>> +       rename detection is disabled. If set to "true", basic rename
>>>>> +       detection is enabled. This is the default.
>>>>
>>>>
>>>> One can already control o->detect_rename via the -Xno-renames and
>>>> -Xfind-renames options.
>> ...
>> Sorry, I think I wasn't being clear.  The documentation for the config
>> options for e.g. diff.renameLimit, fetch.prune, log.abbrevCommit, and
>> merge.ff all mention the equivalent command line parameters.  Your
>> patch doesn't do that for merge.renames, but I think it would be
>> helpful if it did.
> 
> Yes, and if we are adding a new configuration, we should do so in
> such a way that we do not have to come back and extend it when we
> know what the command line option does and the configuration being
> proposed is less capable already.

Between all the different command line options, config settings, merge 
strategies and the interactions between the diff and merge versions, I
was trying to keep things as simple and consistent as possible.  To that 
end 'merge.renames' was modeled after the existing 'diff.renames.'

I wonder if we can just add a
> single configuration whose value can be "never" to pretend as if
> "--Xno-renames" were given, and some similarity score like "50" to
> pretend as if "--Xfind-renames=50" were given.
> 
> That is, merge.renames does not have to a simple "yes-no to control
> the --Xno-renames option".  And it would of course be better to
> document it.
> 

With the existing differences in how these options are passed on the 
command line, I'm hesitant to add yet another pattern in the config 
settings that combines 'renames' and '--find-renames[=<n>]'.

I _have_ wondered why this all isn't configured via find-renames with 
find-renames=0 meaning renames=false (instead of mapping 0 to 32K).  I 
think that could have eliminated the need for splitting rename across 
two different settings (which is what I think you are proposing above). 
I'd then want the config setting and command line option to be the same 
syntax and behavior.

Moving the existing settings to this model and updating the config and 
command line options to be consistent without breaking backwards 
compatibility is outside the intended scope of this patch.

> I also had to wonder how "merge -s resolve" faired, if the project
> is not interested in renamed paths at all.
> 

To be clear, it isn't that we're not interested in detecting renamed 
files and paths.  We're just opposed to it taking an hour to figure that 
out!

> Thanks.
> 
