Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D4ED2035F
	for <e@80x24.org>; Thu, 10 Nov 2016 11:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbcKJLXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 06:23:04 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:36846 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754747AbcKJLXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 06:23:03 -0500
Received: by mail-it0-f48.google.com with SMTP id q124so227694668itd.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 03:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QV0JgFiogL7bBU3qCLltb3QlKUB42L6VrLYG2jdxNWs=;
        b=vGFkesBuhfaQPZcE8g26mbsSZHmjj7jpG7KF3eYBYhGX5geQLLdDnFfFmF8N5rFZGV
         sJygNJVYEE3a36QnFax4WR9K2JMztWbRw46q3U4U9zGYoGaPGP8z19QmrrtY/3qcQJup
         LXvINmcJqM67xlrNiGfG+wwe33umdVFUu9+Jhfh+Di/1A1eAG22cCjaMQhgY3g9n+PZm
         5l973mb10Jk5BSBQnoWcVu0ZzyAMls6E1yFL5RjgTJeeyE614R9Dbf0cFBWN3ri7fBL/
         1LwYEgUfVGnuEaZa59wVaLjfsT6NqZ7ry1FA2Hhk0wVz4pXRrzxDAon+Vub0rhbLwD54
         D1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QV0JgFiogL7bBU3qCLltb3QlKUB42L6VrLYG2jdxNWs=;
        b=c+Kee+oWq7I8Ft4zwnA979cRl/QCUuPKfIv+Y4pBeMzPqZRysLTPbRDO9Q9jnNk8QM
         gvIXiVG0mkIRD5ZQiMJ55B3US3MUOn6Oj3UPEey6BKspcJdhrQEHO10LtyItXrsKHW3V
         Wp7yiR8AwyB7i7LyOHaOqd4/7fV6OqU1L/I/wm8nL21ftd6iRF7Dj5bDaoEVVIjUhPnk
         l8HmbxYfVDEFB8FgiYY0nWVoZ2vPzB016tMt06Io5fm4+nrO2bXES4cxyHf7vhzSJNlS
         I7zaMoS9yqRUiDZeFXViUY3ceJUNg8A9hNcWwJALM5Kn1prlttnlxNuPNDZh55Yi+Yd/
         FL0g==
X-Gm-Message-State: ABUngvd152BmaI9yVtbBHKGrhR6OxWlUR0uUyLGaUmypKXA8x98wR3hg6EvSoevZQz5rrRjd0DCA/EYkqWlFSQ==
X-Received: by 10.36.67.8 with SMTP id s8mr17447600itb.50.1478776982331; Thu,
 10 Nov 2016 03:23:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 10 Nov 2016 03:22:31 -0800 (PST)
In-Reply-To: <CACsJy8D9SHjwb2Ug_DYKmSO+dDxkkqwBFViQrW4eDqbJFjHESw@mail.gmail.com>
References: <20161026094658.20704-1-pclouds@gmail.com> <20161109091131.17933-1-pclouds@gmail.com>
 <xmqqh97g9zut.fsf@gitster.mtv.corp.google.com> <CACsJy8D9SHjwb2Ug_DYKmSO+dDxkkqwBFViQrW4eDqbJFjHESw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 10 Nov 2016 18:22:31 +0700
Message-ID: <CACsJy8CHWZyFgZu1=VKCQc+hbHUmZiAQ9ToL=NDF=YBEkLfbog@mail.gmail.com>
Subject: Re: [PATCH v2] rebase: add --forget to cleanup rebase, leave
 everything else untouched
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 6:09 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Nov 10, 2016 at 3:12 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>>> ---
>>>  v2 changes just the subject line
>>
>> That's not sufficient, is it?  What you did in the documentation
>> would raise the same "Hmph, is this only about HEAD?" and unlike the
>> commit subject, it will carve it in stone for end-users.
>
> Oops. I forgot about git-rebase.txt. How about this?
>
> --forget::
>         Abort the rebase operation but leave HEAD, the index and
> working tree untouched.

Or, since --abort describes it as "reset HEAD to the original branch",
we could write "Abort the rebase operation. Unlike --abort, HEAD is
not restored back to the original branch". Index and worktree are
implied by "not restored". Not sure if it's too subtle.
--=20
Duy
