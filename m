Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C328A2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 14:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdBOO0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 09:26:46 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35796 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdBOO0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 09:26:45 -0500
Received: by mail-ua0-f193.google.com with SMTP id 96so13691654uaq.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 06:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P82PqbSsYG8btyGDlBm8m4DmiCWYiioOuqGGz5FHgKU=;
        b=bWKEFNiMG+yX9aCiqndbgqUp2v10L+YA51nYrXip+iIWjEQ2gznfeC1NGJxek2zc2l
         LB1ilI1roYNJR3k4GoRWXg4T3pwn8roxLtORELGH3+gCDjs3K9GQBELlkVLLr862dUCk
         SZDobH9QZzbvsloNxLtGEJjtUwESPJQv5gG9D1TuKxgX88G1ItPu4vp6eGqcPRkf+54w
         VPystfTZn7pMWh7CIH3Fy/3UxCO5ScGk1KOHMKbUeV53CxEOAoKpXWW5tgzsdDZ3TTz/
         YK/aqg2T69WUz8vmzVDy4N4UGqOHWJyW8JLyQPb9FuuCoo7Me0hLO/61iRk/5ZOBidV6
         JCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P82PqbSsYG8btyGDlBm8m4DmiCWYiioOuqGGz5FHgKU=;
        b=do8CDQVlwSDJxAypQiNHlZreKxwn/71aGJAPA9pfbFalt8X6UeNmKf0iuzgRaEg/Re
         +7/YB/DURV2tIf8aQr6ERqintbxetVXX4yXHHERsvSZUf/DRXqib92oQtMi+n1mLeVIc
         dwG49dz3SxI50RV7lCt1bUzI5vkp1XIMi4t0jftNxZtU3QwEzfQ03bcK5a52qDAjEC2G
         QnKqS5lFhL4jN7qO6KN6YDcbTkqIUT6Db5r+vcgxJsXnKv5Erom4zjwaYfvgxbQL6O8R
         fmGNt80e30zMRJUtogzsrzhvbUODGUioFXrlNtexj/d81r/ubEijISBDjXHkAaT7uzbO
         YMfg==
X-Gm-Message-State: AMke39kannOfWo7kyLh2iR8CgpVHg0EQOL4GVbT+K13A3BaZUbdB7JB98i0/8Q4MK8ukaiW1GE4olBnNwjTIeA==
X-Received: by 10.159.48.69 with SMTP id i5mr18010162uab.121.1487168804996;
 Wed, 15 Feb 2017 06:26:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Wed, 15 Feb 2017 06:26:44 -0800 (PST)
In-Reply-To: <20170214212404.31469-2-cornelius.weig@tngtech.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com> <20170214212404.31469-2-cornelius.weig@tngtech.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 15 Feb 2017 15:26:44 +0100
Message-ID: <CAM0VKjkUu2k73+PxZ2UNKrnBg0nW_za+10O7eHEgcko6BaGx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref given
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>,
        j6t@kdbg.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:24 PM,  <cornelius.weig@tngtech.com> wrote:

> +               *)
> +                       __git_complete_tree_file "$ref" "$cur"
> +                       ;;

There is one more caveat here.

Both our __git_complete_index_file() and Bash's builtin filename
completion lists matching paths like this:

  $ git rm contrib/co<TAB>
  coccinelle/                        contacts/
  completion/                        convert-grafts-to-replace-refs.sh

i.e. the leading path components are not redundantly repeated.

Now, with this patch in this code path the list would look like this:

  $ git checkout completion-refs-speedup contrib/co<TAB>
  contrib/coccinelle/
  contrib/completion/
  contrib/contacts/
  contrib/convert-grafts-to-replace-refs.sh

See the difference?

I once made a feeble attempt to make completion of the <ref>:<path>
notation (i.e. what you extracted into __git_complete_tree_file())
look like regular filename completion, but couldn't.

G=C3=A1bor
