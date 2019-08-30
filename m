Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29FF1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 13:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfH3NXZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 09:23:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41978 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfH3NXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 09:23:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id i4so7538196qtj.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UhkOxEevjAOe08wpMo68LqFfP0IhS254LqOAUnDDTJ8=;
        b=gDTAp2G+/LNqa628qGMIn5ENr3rBwVdM033rbNbNSzZ/t6u9GAg+pNLNzbvDS7ExIa
         4+sJGtRafZgja/GLQZAJTYvcCIb6pmIktVWxtiMDBH/y2m4f+ATTjvzDyV+pnFi/77jY
         xTLoXYuM8xrsAG2ISMv5hrq8I8VEZjSEqFUONGC8U8Q/IBBBVCxk1XEZC+Lei90ix84J
         k8CpR7Ahr+DrAJBhkuBxE/RSXp0x3ErRfnyPfXRvDiPHpUivOgSLpYq0QlNPxqA2u/L+
         7BS75yFeSeOosQ0B5lxWjoG1hkcWArpJI9Aswz1TJkwe3Hs5LaUIOUFHWhYVZKBoPCMO
         0IAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UhkOxEevjAOe08wpMo68LqFfP0IhS254LqOAUnDDTJ8=;
        b=g6nS8m4J7AQSQoI/yEldjBJ7YopHBD2hUd4lq6yR19icDg/a5WO3gC4eZ/g6305eJI
         sSVd4dQj4AM7WNByI8A9HsJwp4sqxtJjH+MuN066CYkZg5JUOtpRqiaA+pOwBFqohBTm
         yL+Tuz5OnxzYG9AKKZQ28vm/wYyyAnHL99dwaSx8nGd4L2TmrUIZOKQ7JqdeNFh9GFay
         +ouaagymmYPSAgFWKPK14kH31Tv2jUVvaCM4xEpZjaLIpOu7WE+NbkzP4PQ3jIkn+ypE
         5OV5iD4Ammdp5eLB5Fb2g0v7Xj4yHEDSfirCWAwLn6049djc+C3RqRYWF7RywPZtLtyX
         IVxQ==
X-Gm-Message-State: APjAAAWqpUpTuyTuZrHEB4umajeHPmCAH8c1HNrlwZL06uuh9VZifdhk
        qIJbWcUxyh2gcn1pypfmX6DfwQtp6c/2LqgDTAjP9gTmjEdB/w==
X-Google-Smtp-Source: APXvYqwfUsoBZ5ztsl8eLEiaTNLjcX0Eq6FFsdDS4DXDBAx6nw5iuGrjiMtft9AphqYKfisqDiOjqSYXmr+vb35bwpg=
X-Received: by 2002:ac8:340d:: with SMTP id u13mr11321691qtb.103.1567171404736;
 Fri, 30 Aug 2019 06:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAH53SykX12SN83=gey8KS_x3cGkXH758sfEieskXnnvos8DMcA@mail.gmail.com>
 <xmqqtva0zkvu.fsf@gitster-ct.c.googlers.com> <CAH53SymNwjrh_CzXVVtU5xABuGQWMsXhRDYyRzyHEwuxLWA2NQ@mail.gmail.com>
 <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
In-Reply-To: <9c280a3f-6a1a-61d1-a255-1dcf0671d39c@gmail.com>
From:   Dmitry Nikulin <pastafariant@gmail.com>
Date:   Fri, 30 Aug 2019 16:23:13 +0300
Message-ID: <CAH53SykQWLtjt0gWVrz5KyH-9WyqaQ0GtkhmyLt09QEqcAS_dw@mail.gmail.com>
Subject: Re: git-diff passes <rev>:<path> args to GIT_EXTERNAL_DIFF incorrectly?
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Aug 2019 at 13:16, Phillip Wood <phillip.wood123@gmail.com> wrote:
> I'm not sure why the last argument is being split in
> your example. It is not split in the example below

I have replicated the splitting issue on my small demo repo [1]:

$ env GIT_EXTERNAL_DIFF=./print_argv.py git diff -M origin/branch1
origin/branch1-mv -- file1.txt file1-mv.txt
['./print_argv.py',
 'file1.txt',
 '/tmp/EWaCSc_file1.txt',
 '2bef330804cb3f6962e45a72a12a3071ee9b5888',
 '100644',
 '/tmp/mtEiSc_file1-mv.txt',
 'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
 '100644',
 'file1-mv.txt',
 'similarity index 90%\n'
 'rename from file1.txt\n'
 'rename to file1-mv.txt\n'
 'index 2bef330..f8fd673 100644\n']

This is, however, tangential to the original problem: documenting the
external diff CLI interface for diffing two blobs. Here is what I am
seeing:

$ env GIT_EXTERNAL_DIFF=./print_argv.py git diff
origin/branch1:file1.txt origin/branch1-mv:file1-mv.txt
['./print_argv.py',
 'file1.txt',
 '/tmp/n9USvy_file1.txt',
 '2bef330804cb3f6962e45a72a12a3071ee9b5888',
 '100644',
 '/tmp/Zst0uy_file1-mv.txt',
 'f8fd6737fbe5a45c97ba9c9de495dc46ff11eccd',
 '100644',
 'file1-mv.txt',
 'index 2bef330..f8fd673 100644\n']

The meaning and origin of the last arg remains mysterious, and the
other args do not conform to the published documentation[2], which
states that the args should be:

    path old-file old-hex old-mode new-file new-hex new-mode

Instead the args that are passed are:

    path old-filename old-file old-hex old-mode new-file new-hex
new-mode new-filename something

[1]: https://github.com/dniku/git-external-diff-argv
[2]: https://www.git-scm.com/docs/git#Documentation/git.txt-codeGITEXTERNALDIFFcode
