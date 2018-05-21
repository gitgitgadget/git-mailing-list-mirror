Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CD21F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeEUSN0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:13:26 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44323 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752928AbeEUSN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:13:26 -0400
Received: by mail-vk0-f65.google.com with SMTP id x66-v6so9298400vka.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ScGAYVRkRDzNrcGSRWI0wxKj5EQHlXeVtio6o+thOSc=;
        b=D5krooykN3zeo7P1sASKJLV2DT5eNF2aKEE6DJt0lLDLKKNBYWRf6D10xEzHCLW5A/
         c9h6+T82cpiCyFFCUNIF+csBoBR/nJPHhiN+w7VBtGBhtL6HYhVh9WNCbgvzQfbpYfSK
         kzMv8LCjzzEeqmpnTJW+Xum1Z1H9T5OksAV6zvGG9VCvbNl82IVaygVQe1Zkf3he+zKJ
         DNa/kyo1E5K0J+WDnSjdCdxW55GZTOgzfgolABbKS5BwKEq+/a90rBE0U1J832bir1DL
         hVSOe7YKWZnjsPa5ww5hQ1bRwNeGXADa8QEkBloELa90RqWdiroknqRUDVMYPPw4z4IT
         XrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ScGAYVRkRDzNrcGSRWI0wxKj5EQHlXeVtio6o+thOSc=;
        b=oEXJbEs6YEsaMahp7Ge4S8lEv/Zh/NngU90kWQY9Dx3fuHYoPj/RJUn1nHD0ZzRXO7
         Reg2w/xKJ8TJpgRs15Sj8T1LLd1zQauvwvOSoS1nLm8BJ5/gZ89qfme3D8qtxM1lj2gW
         YszVTW26hIKC0kA2fQ/O+oZ34SmLsy4KhRoTScRz2UmDK25V1t5AryzVYFvaCkyEC2t1
         Qm3WehsXK+oC4dnsrcTakwGCRIeQxGBs8C9Z4yWbUYrKDH2SF6aSycBA3173AbVHyuh+
         FKG6/bFHnG/QgXJ+QpDucONTIQDi5nU9NVuhV4KUlO9us/xqUrYvtU/QATSB06h9wXCa
         vhzQ==
X-Gm-Message-State: ALKqPweeRwBE1JPXwWi3QC8rBU+majWHh5fbxKLB19SbTQ4brkyI6qg6
        vnECZi11VdjNGeQm9FIkZj+C2MgpGgdtwT3cteA=
X-Google-Smtp-Source: AB8JxZqivFuckurtrprccVtNSAPwTtkneX4+vDTk/oN+cyrpph2IiqccCt8BsGLWnC+l0JzidZ3oiGkMvU9B5TGYkBI=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr13936293vkf.76.1526926405272;
 Mon, 21 May 2018 11:13:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 21 May 2018 11:13:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
 <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com> <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 May 2018 11:13:24 -0700
Message-ID: <CABPp-BGsa+e_4XuK0xaKbcNxg5CS8UuAjYNP9XWpAhXOPs7iaQ@mail.gmail.com>
Subject: Re: which files are "known to git"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 10:40 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> On Mon, 21 May 2018, Elijah Newren wrote:
>
>> I had always assumed prior to your email that 'known to Git' meant
>> 'tracked' or 'recorded in the index'...
>
>   i *know* i've been in this discussion before, but i don't remember
> where, i *assume* it was on this list, and i recall someone (again,
> don't remember who) who opined that there are two categories of files
> that are "known to git":
>
>   1) files known in a *positive* sense, those being explicitly tracked
>   files, and
>
>   2) files known in a *negative* sense, as in explicitly ignored files
>
> can anyone refresh my memory if that happened here, and whether that
> was the consensus after the discussion was over?

Perhaps this: https://public-inbox.org/git/EEC5BA1D5F274F02AE20FC269868FDEF@PhilipOakley/
?

> If that's the
> definition that's being used, then this passage makes sense:
>
>   "Normally, only files unknown to Git are removed, but if the -x
>   option is specified, ignored files are also removed."
>
> that pretty clearly implies that ignored files are considered "known"
> to git.

Yes, _if_ that's the definition used, then that passage makes sense.
But if that's the definition used, then the other two passages I
pointed out in Documentation/git-commit.txt and
Documentation/git-rm.txt do NOT make sense and need to be rewritten.

Junio has already chimed in elsewhere on this thread and stated pretty
clearly that the intended meaning for 'known to Git' was just (1), not
(2), and even provided a suggested wording fix for
Documentation/git-clean.txt.  Putting that into a patch format and
submitting along with an update to Documentation/glossary-content.txt
as Duy suggested look like the two todos to me, though perhaps others
want to discuss ways to just avoid the phrase 'known to Git' (as
suggested by Jonathan).
