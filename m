Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284B41F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBTGI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:06:08 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:39851 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBTGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:06:08 -0400
Received: by mail-io1-f46.google.com with SMTP id r185so39647362iod.6
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekC7XBNdH736nypa6iFeYFYTz1+PVvmicdMYPhq/jVM=;
        b=h13aGyg0ZQUjPnBTF+We4dL4U+sKxYHFAAoV+elbflVmLWm3lAhX2Uh6gdIhGqON9p
         59eHP1tR1+mQFerFAJbusAqXkRtqqICRbqyRJHRAdWt7dkCrObKRk1a8umzqaNpNMdGY
         cJD4+GvOc1lyOCeOotWw5oKfjLnAnN3TQCACXYdkIv70oGtgKo+GRy2joOU+NIvdrf3I
         3EkucPXcI5CuGbv7+9T8JJonstVG5v6A8gYNtrekvlRaqHlFUuknFXHFp9G3okQ33Y8k
         0HSpFxmWnqr4lE3/l/e8prYP7xqUeReMlNyVyhhTEidkiGU7JSRuPfAn9CVChI55UVYK
         p0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekC7XBNdH736nypa6iFeYFYTz1+PVvmicdMYPhq/jVM=;
        b=cpk/eQS6P2NJkP0sZ71miMf3dEchUg+hHRNxzPwVreYIpV8gQpmmPTA+ib6xvrXQGg
         YoItEMEZRtFUPw7D0qeZuS7g0o+8YYHwgNdmNAmEfXzDXrI07sGvbQcblwYEObyMDqcW
         hhgE5KufONAbw7D3moN1llD7hb8UPH+l7tH6pbZEcgLnjZUDpkTj6sbfvKD82SRIkv76
         TelL3aVexK2msIeQPZSS5QEqGhKEmoNKrju1QYR2z+V62nugzD4iugiuuMaluQ4OXWeQ
         YQcVsv9WW0P2BnzCqKKMCtANLFgmKoszH8QMh6O3RJTipwPaycgKWqoKoAD/e9wcPils
         AoHg==
X-Gm-Message-State: APjAAAWnKqGr5v3xI99+nnrCWAe2I/U9yt2akX4KMfwwGc+0KWxvUWyG
        p1uuavInSHuoJWKPHJExyxdvbSrXInsN1LjA/ULtgw==
X-Google-Smtp-Source: APXvYqzrVsgfewjv7Tf7m9yY7Asv0sdIh/sUA5UaN0Q74b2WGhml5X7IEthoOAxs2U4RpwHz1sg70ClYnrz/ygeVZEQ=
X-Received: by 2002:a5d:9c4d:: with SMTP id 13mr22335503iof.47.1562094366966;
 Tue, 02 Jul 2019 12:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAOt2X9sqbpK2qaKk9uf7fL=WCdzJr4+bx-0CsgjssTKkEhd++Q@mail.gmail.com>
In-Reply-To: <CAOt2X9sqbpK2qaKk9uf7fL=WCdzJr4+bx-0CsgjssTKkEhd++Q@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 Jul 2019 12:05:56 -0700
Message-ID: <CAGyf7-Ewm3A7h0vcbahMM+Jf=TcygVrkUob5YaAdH9HByh3asw@mail.gmail.com>
Subject: Re: [Bug] Unexpected behavior on case insensitive filesystems
To:     Alex Brachet-Mialot <alexbrachetmialot@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 2, 2019 at 10:23 AM Alex Brachet-Mialot
<alexbrachetmialot@gmail.com> wrote:
>
> Branches behave weirdly for case insensitive filesystems, and I'm
> guessing other things as well. For example say I am on a branch other
> than master, checking out 'Master' will _work_, I will of course be on
> the right branch but git status will say I am on 'Master' (expected
> just 'master') and git branch will highlight no branch.

This comes up on the list fairly often. A couple of recent threads are:
https://public-inbox.org/git/d4d8d8208b6a41c380ecf20807763bcf@XCH15-05-02.nw.nos.boeing.com/t/#u
https://public-inbox.org/git/CAGyf7-E3-0SiqweoX-uLotwcCcy5MSxG6Zh+DRo6zQPKqTQQpA@mail.gmail.com/t/#u

This also comes up for files within a repository:
https://public-inbox.org/git/trinity-4a160867-2036-4f8a-8363-7bf2e021d840-1558184320864@3c-app-gmx-bs48/t/#u
https://public-inbox.org/git/AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com/t/#u

The replies to the first thread explain the behavior, why it does what
it does, and why it hasn't been changed yet. It happens on
case-insensitive macOS filesystems and on NTFS on Windows.

Hope this helps!

Bryan
