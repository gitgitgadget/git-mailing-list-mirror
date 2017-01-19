Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18C920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 12:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbdASMNg (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 07:13:36 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:37361 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbdASMNf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 07:13:35 -0500
Received: by mail-it0-f46.google.com with SMTP id r185so32236664ita.0
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 04:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZPBXB4ZjCYoYWyY6L9R0mxYuLk8n3MovIzX4sh9J5zk=;
        b=RfUkoJT07+7SEcc48/s69If3GLOByKkthEwGiU8IrYb99pW8Eu7hU1epL1Wz7r048D
         GFFs0WyhRCNb6rxmiEZQY/S5L/WJGGhqUDkrX6hBaXDJaW1bwHgTnzTcD3aDzSNzgvwy
         j7lR5eEl+XBxdo/Io+y/CyFjpltkf9R6aBH7/pGu8YHK5bXdi6fdjKBbZeuputTyxpNT
         HB+HunmEcCNXE7Vq1AJKhmd7cHn0Qf1UmXUeIglStVWAJoBnSHi4Qvzu8KAOqBj78W4m
         kc9x6xo0CdKiS/lEvIiJH8X6mK3UUPANG7HpZm88BR0+yjR7qNrIndIykW5hUVMdideZ
         Pgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZPBXB4ZjCYoYWyY6L9R0mxYuLk8n3MovIzX4sh9J5zk=;
        b=VqbLv4ZlzJ83C1G+tBiU+RSTiG9n3WRjYixuQ/pWr/MyOR4cQFz/45F+6NTVrYDIVl
         vZns2Bv1l3klkz86baw7GRwKiQGosnk5H2tdbq8ZnaDkpbPDz5/Ft0G5dNzsyu50uhjG
         rgEA9EhnRvTHh+AryRO7C7tad3gUinweDbpvy9l93J6syZ/Sku5qDMalVFNajia/Z/L3
         I30FJVsv2pSJLMvNVrMFft+bisaK1r5NjvVyIvDpoawI74zXyACwGPSnQaKG8vLrBYBt
         0fsG27O5cJ/sLuBu/ctHYTxE6ARUrEFGr2kOLFSdx1BJK+mVsElqIZu+84nz2qFhdiAu
         D9qg==
X-Gm-Message-State: AIkVDXLVUC7MsFuWD6/DEh02sLFohzVYDP+AVC8ScKMY8H7FBTkPDkobABiuLwGpADlN2W1Sa15U2+PidXymKA==
X-Received: by 10.36.122.208 with SMTP id a199mr7926135itc.74.1484828014796;
 Thu, 19 Jan 2017 04:13:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 19 Jan 2017 04:13:04 -0800 (PST)
In-Reply-To: <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
 <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com> <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
 <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 19 Jan 2017 19:13:04 +0700
Message-ID: <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> So what should we do if freshen_file() returns 0 which means that the
>>>> freshening failed?
>>>
>>> You tell me ;-)  as you are the one who is proposing this feature.
>>
>> My answer is, we are not worse than freshening loose objects case
>> (especially since I took the idea from there).
>
> I do not think so, unfortunately.  Loose object files with stale
> timestamps are not removed as long as objects are still reachable.

But there are plenty of unreachable loose objects, added in index,
then got replaced with new versions. cache-tree can create loose trees
too and it's been run more often, behind user's back, to take
advantage of the shortcut in unpack-trees.

> For the base/shared index file, the timestamp is the only thing that
> protects them from pruning, unless it is serving as the base file
> for the currently active $GIT_DIR/index that is split.
-- 
Duy
