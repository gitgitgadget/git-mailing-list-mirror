Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90411F406
	for <e@80x24.org>; Tue, 15 May 2018 01:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEOBRM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:17:12 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33961 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOBRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:17:11 -0400
Received: by mail-vk0-f51.google.com with SMTP id t63-v6so8732310vkb.1
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CSNG/5gy8zXXbrtJDOszekNkgcEQHjXZeedfVxRgGsY=;
        b=KWnAj1KPWgCPsMcMb/+yNNBbNMzkZWn++1z15jlBsIrIHlTivPkzYgEHUq9Et1vYaX
         9w35XnkmWAp3RF+x5h4GZcTUL1U2hzysIgw8z/NSpf/0KR5LkC2tVYvfpaqxpYv+QDXI
         lhzEZLrUIMuxc7TNRFCDRIc5Yzt929h7lZaU08mnFpzeNWjRTvJwXavADLWyGDPCI/fo
         3WowWqdSr4I6jVXOV4jRW5mNlqvgb1ytGim4bELIEZDacpd8pgxrilMBb9WxuMDSQPgb
         yN9XqVka7lB1O0ZFouH3iXk5hK5Wr+LQU4AcB1MXcghZTy5tMxsH2hW5r+nlh9aD32mk
         0bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CSNG/5gy8zXXbrtJDOszekNkgcEQHjXZeedfVxRgGsY=;
        b=YjXFPfMoe1yLBvChxpcUaoA5P8n6aEfaPPTRftwuR77yYL+0/hlcgN/vF4tQiWOfKb
         wjSD3TvVr3TAu3qGk0oqC5+iqo3IIARLrHNEEFE9gCB7K4X9SxTz0NkV+1cvQETU/L6l
         8wpwlGwtHX1469K/s2bWACutIQPvGuioMG0X2oeZPwhiuAHUfSxNPbEEuZzGkEn07s+G
         JSSXQG8YkYdXcyyco92F4o7mJsaRy+PARLn+4d4zRT+dlz+vn33jqI+r5GcPx9Ij2QI9
         FDMs/Hepx0dS0+KhSPTE20USnRLhUFDfQ+88jI6lHl0iHXwR9NBZgjELoyGUaSZQ6cIh
         nHoQ==
X-Gm-Message-State: ALKqPwdQLHQYVipR7D59PQM1jRdZchmu9eCOC4y77wM9VCuqkmzKCVu1
        kSBEWrdovHOZTB0el/6FJE9ODTCwtKn69g1K7Ek=
X-Google-Smtp-Source: AB8JxZr4CwpElAgJHSdHQ0y1PlIcKWKxkdFPa+cRmKV0cTI4vRF6GiUcFbW6zXw0KiuGr9UGujTUh6Mbbt7iO9W8HJ0=
X-Received: by 2002:a1f:2cc6:: with SMTP id s189-v6mr12761431vks.106.1526347030194;
 Mon, 14 May 2018 18:17:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 14 May 2018 18:17:09 -0700 (PDT)
In-Reply-To: <20180514205737.21313-2-leif.middelschulte@gmail.com>
References: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
 <20180514205737.21313-1-leif.middelschulte@gmail.com> <20180514205737.21313-2-leif.middelschulte@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 May 2018 18:17:09 -0700
Message-ID: <CABPp-BGp_zP8Z2S8FskiNvhNeQH3f=HdnQ39vX6xQz=oSyVfMQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Inform about fast-forwarding of submodules during merge
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Leif,

On Mon, May 14, 2018 at 1:57 PM, Leif Middelschulte
<leif.middelschulte@gmail.com> wrote:

Thanks for updating the patch on top of Stefan's series.  :-)

>         /* Case #1: a is contained in b or vice versa */
>         if (in_merge_bases(commit_a, commit_b)) {
>                 oidcpy(result, b);
> +               output(o, 1, _("Note: Fast-forwarding submodule %s to the following commit"), path);
> +               output_commit_title(o, commit_b);

Level 1 is for conflicts; I don't think this message should have
higher priority than "Auto-merging $PATH" for normal files, so it
needs to be 2 (or maybe 3, see below) rather than 1.  (The default
output level is 2, so it'd still be shown, but we do allow people to
remove informational message and just get conflicts by setting
GIT_MERGE_VERBOSITY to 1, or request extra information by setting it
higher)

Also, this two-line message seems somewhat verbose compared to the
other messages in merge_submdoule(), and when compared to the simple
"Auto-merging $PATH" we do for normal files.  The multi-line nature of
it particularly strikes me; the merge-recursive code has generally
avoided multi-line messages even for conflicts.

In comparison, your original patch just had ("Fast-forwarding
submodule %s", path).

Maybe you could "if (show(o, 3)) { output your current message } else
{ output the simpler message }" ?  Or is this verbosity warranted for
submodules at the default print level?

I'm not a heavy user of submodules, so I may need to get others to
weigh in on the verbosity and multi-line aspects, but I wanted to at
least flag this as somewhat surprising to me.


Elijah
