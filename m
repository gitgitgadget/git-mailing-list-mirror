Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE4C1F42D
	for <e@80x24.org>; Tue, 20 Mar 2018 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeCTHcF (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 03:32:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35126 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTHcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 03:32:04 -0400
Received: by mail-qt0-f193.google.com with SMTP id s2so602924qti.2
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TseB6A92vD7Glr+jlc+8auHfxsVCE+OZYqXqhqYFfNg=;
        b=dBD4ZcGPpn56P1AzjZLN51sUWcR3YlbMQ0ZMWeirLABARWEpypxQJxDUuHzadjal/j
         Oe3CQiA4qdk4Lo+nOtPq1CKKT2ZQMsH2MfZas70+nfCN026xw1Wy9n4CKpv7mWP07PJ6
         LDsfRfes3OZmiubCnbnnM4Nvdusi8wwmOXrdGS+r+FHEzFFvebe4TGQs5XcUueP5MfsX
         DmZVCVOluKuwEEOF81IfY85KjENI2E0aABHZhOJD/iC4Q6YEsYciWhJFrRJE//AB+JMI
         UPebGiva0aK59pIHkI+856ufvQqNsePG5v5thrLBNVOx0shZuWcd4YU3teQWVjlVfN+v
         3Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TseB6A92vD7Glr+jlc+8auHfxsVCE+OZYqXqhqYFfNg=;
        b=i4pDPcBWByZ6zW7IQvd8u43y/+cYZ4KBTEPDeMMuwV1g7ou6A5e7q/9YPNiFeOuUEl
         i/3Iulf5MMObDU+KvJ3lF4Cd1fgE46vAqPubrxjyXo/3MCYWYb1JLhehWnu3fkxs6Mnm
         KkGqkuMX+qiRg4NhHVnt+CUzHKMqZyTST2znJ99OvqOoWhrMLVMIFKLPkf3AiVVJkOGX
         4htP2Ukd2QmHtIqn+JDV8AOGDjpGE2H3wkQPlbvFe8OchQEEWzG4nFG/oIUDlz62M1hQ
         5puB2BgpjMCCyCAW5ptBacrFoGo14Qx1XSzLEnlffPa1ufRQ5lb57cxf6mdNmqYcZtSC
         TTDg==
X-Gm-Message-State: AElRT7FReeHy8MeX8yxF/Zk+zyU466mzi/lEpHr+WPD/ngK3JEkQxZcU
        qpac1+dFIkfXLkU4xFoQQOSZBhcRWfw0g13jNVU=
X-Google-Smtp-Source: AG47ELs1Qc7c0H61o3PPjKoFgohnro4D5OByOTHjjjLx0hlGrLxqSk+akneb+5i9/iJoq0RGuo+8JpJes3qYBpcEmvc=
X-Received: by 10.237.56.136 with SMTP id k8mr23578594qte.154.1521531123473;
 Tue, 20 Mar 2018 00:32:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 00:32:02 -0700 (PDT)
In-Reply-To: <CAPig+cSsqqn+Wg6DEJRSge9mYqb1_jPXy5ORryrdA6+Omxne1A@mail.gmail.com>
References: <20180317220830.30963-1-t.gummerer@gmail.com> <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180317222219.4940-3-t.gummerer@gmail.com> <CAPig+cSsqqn+Wg6DEJRSge9mYqb1_jPXy5ORryrdA6+Omxne1A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 03:32:02 -0400
X-Google-Sender-Auth: zDvRCK-7qN6EG403t2g4ojyOUsg
Message-ID: <CAPig+cQPhXxVswMbD5HsUJpa9AHfet4zFb+MV3FT_-CuZP8+gw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] worktree: be clearer when "add" dwim-ery kicks in
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 3:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 17, 2018 at 6:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Currently there is no indication in the "git worktree add" output that
>> a new branch was created.  This would be especially useful information
>> in the case where the dwim of "git worktree add <path>" kicks in, as the
>> user didn't explicitly ask for a new branch, but we create one from
>> them.
>>
>> Print some additional output showing that a branch was created and the
>> branch name to help the user.
>> [...]
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
>> +       if (opts->new_branch)
>> +               fprintf(stderr, _("creating new branch '%s'"), opts->new_branch);
>> +
>>         fprintf(stderr, _("worktree HEAD is now at %s"),
>>                 find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
>
> The "creating" message is missing a newline, which results in rather
> ugly output:
>
>     creating new branch 'foo'worktree HEAD is now at ...

Also, I believe that the agreement[1] was that this message should say
merely "creating branch", not "creating _new_ branch". And, indeed,
patch 4/4 stealthily drops "new" from the message, but it really ought
to be introduced with correct text in this patch, not fixed by 4/4.

[1]: https://public-inbox.org/git/xmqqh8qv9ojb.fsf@gitster-ct.c.googlers.com/
