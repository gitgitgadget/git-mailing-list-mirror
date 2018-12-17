Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2272B1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 16:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388228AbeLQQYw (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 11:24:52 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:54077 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbeLQQYv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 11:24:51 -0500
Received: by mail-it1-f177.google.com with SMTP id g85so19384370ita.3
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nfIW3as4VO23WpLz12MtGNUcnH2lLu98XqTLC3Worl4=;
        b=kV+90zfkoZi8qJzLDK/MEfHFGbIksp0YicyHk7TgcRBOmCra5qM7ZM/w3gWEyAH2uU
         HywkN2KSnLsc8GPQagOEPbf8NRVrC2BXfRQk/eeArYT/kqRxjfI0epL+rgb+T01uxRYR
         YC+8nRFbsFwuTTUE52LZxWDu8VFgd1CgxNHViPUvRwW6Rig9gB/4iV+SB+9WffTKCe2B
         Y544CcZoB5NgOCvZr9Y7VI8OO5VMAzryMLQSaZCfuqrawItUWotQYkjUARswj7vjkwRE
         6I9VCkeVyDTsEj8AddfAswsIw7LsviUyowsiGVOWIxWmSWykRIX6nXXb8I2iAnL6jtkh
         JCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nfIW3as4VO23WpLz12MtGNUcnH2lLu98XqTLC3Worl4=;
        b=irjixVVcxXJzs+/11IkdEM3OiQUH2rT9ICWHQiUf7PwScrtrEh327E8GqcrHtRT5ZI
         Npc2UwMRzQ+n8ORS8PBOBmsvKnpHz0FMOqTljpiTe6AGQDoX2hhwvwbNcsRGZDyOdP84
         yJDqhB0xxK6eAuzMx0Ny5rKeVKBR1yjdKwFWk4lwNTQUAYdlBRXdsZfSG+lmD+7dZOy8
         GSMKB3xMkra3T5ZD9XKxhyw1HJ4FkXOc+JnUgsSEMNs+8Z5LL73Kr0Ajdq8cKUIEVBCP
         hKLEpVfeyjrM2BjMUG4J7fjwaLJ/C7GR5SDIfyvTq7ZC45VdexfHv+WOgBw3vI3iD1/Q
         XEXg==
X-Gm-Message-State: AA+aEWYyiUzV/Qu4q9YBOychJuk5uH3MlxODBCshtYD3Bm5GZzSI+4fV
        wWU/DDpkYefx+6eY0xNUDFAtbxbHZW9vuGWdGh7FPA==
X-Google-Smtp-Source: AFSGD/VkWaLATUa9sA9pH1I5LimipqhOYWy51T4RwswCXLp36wj/k7uEJwtraKXBF3b02cCzAqN5CK4dpa1h5B+I6O8=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr12626339itk.70.1545063890570;
 Mon, 17 Dec 2018 08:24:50 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
In-Reply-To: <CAG2YSPzmN5u1uAPVbjsqC3LzVVinFR21-_6wfrkBHdPWhOfMfQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Dec 2018 17:24:24 +0100
Message-ID: <CACsJy8ANoiWfmLkmO9ACab5H+m2c2y5uhKBJzGNwwxcs9zV0wA@mail.gmail.com>
Subject: Re: Can git tell me which uncommitted files clash with the incoming changes?
To:     Mark Kharitonov <mark.kharitonov@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 17, 2018 at 2:11 PM Mark Kharitonov
<mark.kharitonov@gmail.com> wrote:
>
> Hi,
> I have asked this question on SO
> (https://stackoverflow.com/questions/53679167/can-git-tell-me-which-uncom=
mitted-files-clash-with-the-incoming-changes)
> and usually there are tons of responses on Git questions, but not on
> this one.
>
> Allow me to quote it now.
>
> Please, observe:
>
>     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]> git pull
>     error: Your local changes to the following files would be
> overwritten by merge:
>             2.txt
>     Please commit your changes or stash them before you merge.
>     Aborting
>     Updating 2dc8bd0..ea343f8
>     C:\Dayforce\test [master =E2=86=932 +0 ~2 -0 !]>
>
> Does git have a command that can tell me which uncommitted files cause
> the this error? I can see them displayed by git pull, but I really do
> not want to parse git pull output.

Assume that you have done "git fetch origin" (or whatever master's
upstream is). Do

git diff --name-only HEAD origin/master

You get the list of files that will need to be updated. Do

git diff --name-only

to get the list of files that have local changes. If this list shares
some paths with the first list, these paths will very likely cause
"git pull" to abort.

For a better check, I think you need to do "git read-tree -m" by
yourself (to a temporary index file with --index-output) then you can
examine that file and determine what file has changed compared to HEAD
(and if the same file has local changes, git-pull will be aborted).
You may need to read more in read-tree man page.

Ideally though, git-read-tree should be able to tell what paths are
updated in "--dry-run -u" mode. But I don't think it's supported yet.
--=20
Duy
