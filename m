Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BE71F424
	for <e@80x24.org>; Sat,  7 Apr 2018 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeDGI4g (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 04:56:36 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40111 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeDGI4f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 04:56:35 -0400
Received: by mail-qk0-f194.google.com with SMTP id o64so3805921qkl.7
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0Q1iRF4P6DCSEW9GMnQOb4lPIDQtdTSRKdsR3kaRdrs=;
        b=Cyvj+Ctv/wDjojxtid4XBZLCVqabvxOmi7ESpYobFR0r3yLXxSFzWBsZfdt7yD6roM
         aY5yd+/z7gjh0X4v40PqMOPf81zr2PSVNH619cQkjxVtDXWzCCsZ/VRveMhU0cAS5Z51
         jWVFb1w8bE6w7JlhfnYoiFnJ3jwCUnqra8ZWa0tB2mtmCXx2/ZCLGY3UB3mPC00MnY8s
         OIiX5c/w+sSMQZ6KD41f9cTXMwymfwl66JtIb/gPBEq08rNjhDBluMOMgu2fsb6vAomu
         5UX4drkhmZTghadcrMxI5Zrcu3eD22gjGNMHTjAJvxFNoSGhTCGq58SmeCm6jtNNvH1L
         8c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0Q1iRF4P6DCSEW9GMnQOb4lPIDQtdTSRKdsR3kaRdrs=;
        b=WNlvj1UdASm9Bhh8oicmf1la57FgFrK4gMfybRtK4B8+yTv0R/IZ6MxQ+HGLNPn3AO
         5gXIQlOAWn1Ht9GUInv9FYo9dhEAi2X3+FwvcfM6X4BBTec3BTbCrVbo19Lj548Djlsy
         mdy1HI4Y+dlbh/YRxHLIBJhqebaTnrhus58b5tSwUSwtNUKgazaal7gvFfCWsix9khI/
         XDCFPf54Mp1/xRrjAoaryEu1+WGXayqmw3n2c4/VLGAqrsOE5pdFvOQeU9SMpoWXBgvf
         QQ9RQXYDBx6sWG/tmy8h/c26Kr8UJWa4zgK0L/o59oasTa5flUNWVe2SpN0N1A6ejx/W
         MtgQ==
X-Gm-Message-State: ALQs6tD1DNbS71oKso41lCz/XvcmR0GPHcks0WLA2ca6YIXVBTRTV2oS
        C03kx770ZNKA4+V+6Qoij1ykKl6pJvcdEleJHZs=
X-Google-Smtp-Source: AIpwx4/x55zOV2n6B3jtUcSzI0ePCaZxEdocReoPqoiz6BAzGfENFa09dtmg4T6UtUILONWt0+CQvesElqjJW67yxzw=
X-Received: by 10.55.198.217 with SMTP id s86mr39474926qkl.153.1523091395199;
 Sat, 07 Apr 2018 01:56:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 7 Apr 2018 01:56:34 -0700 (PDT)
In-Reply-To: <63772b7d-7b1e-2a3a-b12c-2dae9e254b68@gmail.com>
References: <20180324182313.13705-1-ungureanupaulsebastian@gmail.com>
 <CAPig+cS9QwCOG7BA7O5Nu_zsh-xTbDFy2vTWpAXxBuKTY-uzUw@mail.gmail.com> <63772b7d-7b1e-2a3a-b12c-2dae9e254b68@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 7 Apr 2018 04:56:34 -0400
X-Google-Sender-Auth: _nWbnkx74Cq0YwlTpVFylsyQETI
Message-ID: <CAPig+cSMv0p6m1kjNN4bGN8prX-9Ri_XbVzHah=MugHmZh46+w@mail.gmail.com>
Subject: Re: [RFC][PATCH] git-stash: convert git stash list to C builtin
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 5:38 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> On 25.03.2018 10:08, Eric Sunshine wrote:
>> On Sat, Mar 24, 2018 at 2:23 PM, Paul-Sebastian Ungureanu
>> <ungureanupaulsebastian@gmail.com> wrote:
>>> diff --git a/git.c b/git.c
>>> @@ -466,6 +466,7 @@ static struct cmd_struct commands[] = {
>>>          { "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>>> +       { "stash--helper", cmd_stash__helper, RUN_SETUP },
>>
>> You don't require a working tree? Seems odd for git-stash.
>
> For now, I do not think that it is necessary (for stash list), but I am
> pretty sure that it will be required in the future when porting other
> commands.

The existing git-stash requires a working directory:

% git stash list
fatal: not a git repository (or any of the parent directories): .git
%

so it would make sense for the C port to follow suit.

More generally, a stash is a temporary storage area for changes to the
_work tree_ (and index). Without a work tree, you wouldn't be able to
create any stashes in the first place, so "git stash list" without a
work tree would be meaningless.
