Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CCC3207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdEERzC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:55:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33965 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdEERzA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:55:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id u187so1664479pgb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=caqt/+QK8vorBA/oUDcM6NE3aHkK2PcezslkwImpi6U=;
        b=BOmMtCjC7wFdZ39PCR4l2ub2qvZrkDV22N+8+VvqHwh9at/XgdahOjAPOblqKTI1V6
         wF8AR+BeiDMDBCjrf6s+wFSkSyIG2NmyPfi0I8hCsAtnHNOd7PQzbom3waofELrm3cpI
         CcCeO6HQugZXMTdCqcU1Km4zCiTfA00LWhkdHkTZJ/kJbcbyQdowlQ4tbzRXw8KdgVmg
         iMAIZZcYc9Lfu1DC/7tVFlOYXDnd7oRo1TpHM2fHNNemNxwsCAS2muUEOuq3+i9Yzgt9
         VsrPIZnkZYKyIFBXT+fu7VdoGQE6lb5DdQ8YNZ+FaupY2wNAjCMAAyJ8pG0RVb6UziCO
         nbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=caqt/+QK8vorBA/oUDcM6NE3aHkK2PcezslkwImpi6U=;
        b=hXNmhXxVhDoBJOz88ngqDcIhkpuLSGDGxkodGJGEQOEJik5PwCp6E1DIt/9D1gPEjH
         aT0vXUfi23vRs6DUjOC6YfY9fjWh2xzDXHVaKtMER6xwYdRdR9IKAM2iBZWb9KD/xO8D
         EnRBCziLO5p6wcNuyL2sGHJmJ26rZIMaLKHSlwdELzmfFdesE3vtZI3B/fedl81jWmQK
         4OqEy8OoLVWT4SPE7MbgXdRHdtMjlTMRqZoXWGMZaZLzTGIEgzE6stg3BwHza+XUWD3M
         DE2C4g4N5Ne9KWtAc3E6sW+opcqWZLkUfN0/M2huzNmH+afzvgeDD1SgfSmOKEsw4T+v
         Z2Jg==
X-Gm-Message-State: AN3rC/7ju8YQTg9672CkRxTd8X2nvkKd/biR4GWb6Kz/iCMobLIMf+Cc
        JhuLZKIihRT0AA==
X-Received: by 10.84.224.140 with SMTP id s12mr47707256plj.169.1494006899983;
        Fri, 05 May 2017 10:54:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:aca8:b828:d7c5:8258])
        by smtp.gmail.com with ESMTPSA id 12sm4213440pgb.35.2017.05.05.10.54.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 10:54:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 00/10] Add blame to libgit
References: <20170505052729.7576-1-whydoubt@gmail.com>
Date:   Fri, 05 May 2017 10:54:58 -0700
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com> (Jeff Smith's message
        of "Fri, 5 May 2017 00:27:19 -0500")
Message-ID: <xmqqr3036vf1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> Jeff Smith (10):
>   Remove unneeded dependency on blob.h from blame
>   Move textconv_object to be with other textconv methods
>   Add some missing definitions to header files
>   Remove unused parameter from get_origin()
>   Split blame origin into its own file
>   Move fake_working_tree_commit() to lib
>   Break out scoreboard a little better
>   Split blame scoreboard into its own file
>   Break out scoreboard init and setup
>   Move scoreboard init and setup to lib

Make sure these shortlog entries, when eventually appear along with
other people's changes, let readers know what these are about
easily, and formatted similarly to others'.  Write the "<area>: "
prefix in front is a good pratice to help that, e.g.

    blame: remove unneeded dependency on blob.h

In general I am OK with the idea of splitting builtin/blame.c into
the blame Porcelain part (i.e. cmd_blame()) and some form of
reusable "blame library".

However, you'd need to be cafreful about names.  Are contents of
"commit-fake", "origin" and "scoreboard" generally useful outside
the context of running a "blame"?  They are not good filenames if
saying "origin.c" in the context of the entire Git codebase, anybody
would understand that it is about "the origin" concept used by the
blame engine (similarly for other new files).  I would imagine that
having blame.[ch] at the toplevel instead of creating that many
"blame library" files would be a good way to go (mirrors how other
parts of the system is laid out, e.g. diff.[ch] and diff-*.[ch] are
library-ish files, while builtin/diff*.c implements the Porcelain).

Have you renamed the names of structures, functions and variables
that used to be private to builtin/blame.c and now shared between
builtin/blame.c and these new files so that they are specific enough
and are obvious that they are about blame infrastructure?  Names
that were perfectly acceptable and appropriate as private ones
inside a subsystem are often too vague or generic when exposed to
outside world as part of the library-ish code.

