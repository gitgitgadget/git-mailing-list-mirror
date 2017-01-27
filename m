Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F081F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933645AbdA0R1c (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:27:32 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35048 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933580AbdA0R0p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:26:45 -0500
Received: by mail-qt0-f181.google.com with SMTP id x49so144301328qtc.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 09:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=twoFLqxng5bWRRG0f4zR0HoljdUtdWlSvOBTxaY709o=;
        b=rnfUJehLwYGYoXKec3Fc1kEtzLdPMTSMZ8DMvkiEfg7CJY7O5/twyYSPAr7pzgvc4Y
         Kovi4zYs9SD0wB+/CI7a9nCykfgzVKCUIkQzPozZpQho2ezILDmuxkoyfVUC4idNc7kk
         0tPCYz7tzME/fLo3yg05cIsHWBvFNYfT0C5MTO7tRLUfJF1XFt5hskVwV1BnIlIg+W8X
         BvVVbAvwEA+ZLcOlC0GvLydldccXR7zgBJpzvXYm0JhMVQrpQY295WtIDG5D21zEpx2t
         OoHkomp+lZWdrRpKe3781Cr2Eu9xb5W1YcovKLMA7TDAMWiIIhGP4arkBRKv891WTNwH
         MSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=twoFLqxng5bWRRG0f4zR0HoljdUtdWlSvOBTxaY709o=;
        b=ROQuzuODm9PohrPgOzGJ1HhtN0NJLS9aMD2lt64h8kao3Z+RJ3+H4knRLGTDfRnBNk
         Lzz/jqILmSxgvjY05rJiLIZviQExA6ojt2wSFocBxNUMmJWslp8A7O+37P1v8hKrnpw0
         aEFrvr2euZbeWy4fBRICnSZXkNc4iRh7PjjiSwYlwFvb7oVprF/uXquRcH+CRLb3P/EI
         7Zo/hAEIolB/1bPTaQOc+i7VKTi4ZJh6wCKNTgKFyrsK5xCzjYjyn0BTKY5kYuU7HG1T
         44oTKp8KqBU49vfCiduhnsMz/YLrrs6kw5oWTSD88apOEjfoCEIC4iAH60f8KY1dibuI
         ENjw==
X-Gm-Message-State: AIkVDXICEqDFlv7TM8/5lwISA0ybVi8IEy6Luh8LCpMqPRplwAdgimQFQAE4gD2JmoSsECGd5yinBZqP0dHc0A==
X-Received: by 10.237.60.122 with SMTP id u55mr8676213qte.41.1485536168981;
 Fri, 27 Jan 2017 08:56:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.129.236 with HTTP; Fri, 27 Jan 2017 08:56:08 -0800 (PST)
From:   Michael Spiegel <michael.m.spiegel@gmail.com>
Date:   Fri, 27 Jan 2017 11:56:08 -0500
Message-ID: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
Subject: show all merge conflicts
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm trying to determine whether a merge required a conflict to resolve
after the merge has occurred. The git book has some advice
(https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging) to use
`git show` on the merge commit or use `git log --cc -p -1`. These
strategies work when the merge conflict was resolved with a change
that is different from either parent. When the conflict is resolved
with a change that is the same as one of the parents, then these
commands are indistinguishable from a merge that did not conflict. Is
it possible to distinguish between a conflict-free merge and a merge
conflict that is resolved by with the changes from one the parents?

Thanks,
--Michael
