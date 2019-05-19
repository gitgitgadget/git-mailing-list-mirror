Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BB51F461
	for <e@80x24.org>; Sun, 19 May 2019 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfESTn0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 15:43:26 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:37814 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfESTn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 15:43:26 -0400
Received: by mail-it1-f173.google.com with SMTP id m140so19862356itg.2
        for <git@vger.kernel.org>; Sun, 19 May 2019 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KtS17MJHLZfMDbm4Jm2FKME6gn5z0tZ42isK59RCi4=;
        b=Ljtlyf9F2nhgJvuzOAXAtjW1DhMSDRH4rtL7ylONjz1LrQ03S7eS2LUy0RUgyv3q/+
         rhhJcwzHHxh0LVxTIYv73THd2uAgS2UfEWgT6Ycz0sTEGRr+eL2c/4ZYV7+NrBfzLCe4
         RBrxTUF9Hjuuyrc0jg+bOL1f9daIyAlCXoZ7dK9ghnhR215CjpY0S+aYP+AEyRksmC7A
         0a5WNDtnzmQxF5erYLePM193KruO7Wp4k3gJXMBREZDTIlCmFwSYH4bcH/4JirRoL9lC
         A8XnHidX/JflE6cnUVz5tCfvOYZs2dZ5/oZekFay/JJon/qfs1UMKa+5gh8jOMFix3EP
         3aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KtS17MJHLZfMDbm4Jm2FKME6gn5z0tZ42isK59RCi4=;
        b=pctiChNcRQp91eFfGJeuQxafIeS/3pMX7tVMJU1x+n9ZG9wzwJVwQuKkhfc7lQJ1kf
         bMcSSjc5hT4tWI4Q0q+jyh1hT9EmgEg4Kv3ek+vmeJ4MDH23e7jm44R83qy+yIkIZo1E
         7eQDvos40UGeUiQMcxD56qfYa54Wmix0BAh/AteXs/ETZy7vMIqNXH9QzrgM15clTcvx
         SK/AuuHRldqpFoNA99alFg3m5c/6TqzQd+dsTe7N6CGyRuc6Vde31DvO/LMGsajg0lmx
         mAvkqN7SghhGPqhnK6Ef3ZvoUcHF2nmR/WA8r2T0IssSDdxfWnbnsXQebftJ09giW144
         SYlg==
X-Gm-Message-State: APjAAAXzqIxmP5efkpd4AoZnQC30aJA5QgTWcOnUGYGrboqVCg53gxe5
        wY+kbFH8QI9GhSicHQcO63iDe6/ZzbbjYHZ/9EJt0Q==
X-Google-Smtp-Source: APXvYqzw9udOB/HcaXAp6qi97JMghgF9B5kh2DDcmwXVh4nB0ltMYb4UQNhc5GPw/HAKuiB2aePX0RycE2k4yaV9vYY=
X-Received: by 2002:a02:3002:: with SMTP id q2mr4344372jaq.30.1558235269930;
 Sat, 18 May 2019 20:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org> <87lfz3vcbt.fsf@evledraar.gmail.com>
 <720a0b5f-cc20-5b75-8222-68eed77beeea@iee.org>
In-Reply-To: <720a0b5f-cc20-5b75-8222-68eed77beeea@iee.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 May 2019 10:07:23 +0700
Message-ID: <CACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S+hiXBoUGQ@mail.gmail.com>
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e.
 select from rtb's)
To:     Philip Oakley <philipoakley@iee.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 2:55 AM Philip Oakley <philipoakley@iee.org> wrote:
> I'll add the answer to one on the stackoverflow Q&A's I'd looked at. I
> hadn't put the branch -a and -l options together.

Maybe update/add some examples in our man pages too.
-- 
Duy
