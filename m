Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C750C761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjCaSq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjCaSq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 14:46:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DDF1DF91
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:46:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l7so21392104pjg.5
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680288413;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6a5hh6YmYF3BQgwxAV0uiYsUm+bKogsCAJWEHEo1UwU=;
        b=U63IbCDOCJv5fLfylN3YBUBpIJKSJaLz2RA+yj5fte4o4IVo9cxLSB8Iky2+b+/i6U
         ZLrl5qe/jfwavVrnL96BWqay0U91b+VHt4rvB1tikg1ri47jNNSmUY099sgJmy5rzjT3
         6V7djRHNRJ3wOvBLbNSrxVow1pQ++iWriJViNCp41HJZepIBJyUpLOhzkSVHv9r3IXJJ
         wl3ijSYRjwVHq8phWjUcpwdgpEZc6iyq1sVHhziW0YwbZ2m5w0kce4YmpvaG6f19BZcP
         5MIyyeuBxpm642jRUAjpRoy04HmiDDPlisETMl+4E70eWJ/743zN+SJLMwPqSOZBQ58E
         N7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288413;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6a5hh6YmYF3BQgwxAV0uiYsUm+bKogsCAJWEHEo1UwU=;
        b=p2LRoR2OZnHRSflupJEFa3CqUVkcrCJvFdtjCv0BCToyecQckDxZbpEtSGFqlcKYzt
         sYOepM14n0KI8a3UyLeuZqJfXYTz5UMYEPJ/cadqtyvD28ztgtGmGJ6ze++ChGwnY2Dj
         TdAkI/nSLCWoakx6n9BRNL/L26Or7oosa3AADIUg1lMhtd9aNopZNGh/NGOFazEdb4SW
         yrTScBf3zyAyKOYO8olwmktUQEeWQQeXyLfXr483Pf/5luRooPYmcNrYOYS/vPhpDjm6
         gHNML5B2/I34h4UZjHfTMRZQqV3ooY3LFmi4WYvPsW5uoR8x7wWbCw7+UWVipBOcqTbx
         eIHw==
X-Gm-Message-State: AO0yUKXJhxVSxGvB9C5Ru08mqZ6A6iIWZALl49lvEeFwIEY++9ahWLq4
        F75wFqZda5LcEFRH3iLTfrY=
X-Google-Smtp-Source: AK7set8M+mF+LMJnOEeEpLyb/FIWcr22rZZ83UGfkDghQq6/V0m+MlIGcKWHqGwWOXo/+n0btpkK+w==
X-Received: by 2002:a05:6a20:1321:b0:d4:fd7e:c8b0 with SMTP id g33-20020a056a20132100b000d4fd7ec8b0mr22549420pzh.7.1680288413190;
        Fri, 31 Mar 2023 11:46:53 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k9-20020aa78209000000b0062505afff9fsm1707738pfi.126.2023.03.31.11.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:46:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] doc: interpret-trailers: remove trailing spaces
References: <20230331180817.14466-1-code@khaugsbakk.name>
        <20230331181229.15255-1-code@khaugsbakk.name>
Date:   Fri, 31 Mar 2023 11:46:52 -0700
In-Reply-To: <20230331181229.15255-1-code@khaugsbakk.name> (Kristoffer
        Haugsbakk's message of "Fri, 31 Mar 2023 20:12:29 +0200")
Message-ID: <xmqqsfdkep2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

>  $ git interpret-trailers <<EOF
>  > subject
> -> 
> +>
>  > message
> -> 
> +>
>  > see: HEAD~2
>  > EOF
>  subject

This example pretends as if the above was an interactive session the
writer of the documentation did with a shell in a terminal, and
these lines are trying to show that each line is prefixed with $PS2
(the secondary prompt string given by the shell for continued
lines).

Taking that fact into account, it is arguably more correct to keep
these spaces rather than removing them like this patch does, but of
course it does not make a practical difference, because these spaces
are invisible unless the reader reads the source documentation pages
without passing them through AsciiDoc machinery.

The only folks that would be helped by this patch are those of us
who edit one of these four lines of the source file (perhaps by
replacing '>' with '|', such a patch tries to show use of a
different $PS2) and are annoyed to see trailing whitespaces their
patch inherited from the original trigger "git diff --check"; I
wonder if that is a good enough justification.

I, however, do wonder if we should make our example more friendly to
cutting and pasting.  And I would not mind it if we got rid of these
4 trailing whitespaces as a side effect of such an effort.

One way to do so, while still pretending to show an actual session
with an interactive shell, may be to give the example with an empty
string set to $PS2, i.e.

    $ git interpret-trailers <<\EOF
    subject

    message

    see: HEAD~2
    EOF
    subject
    ...

but then it makes it a bit harder to see what is input and what is
output.  Showing with a separate intermediate file, i.e.

    $ cat sample-message.txt
    subject

    message

    see: HEAD~2
    $ git interpret-trailers <sample-message.txt
    subject
    ...

might make the result slightly easier to follow.  I dunno.

The same comment applies to the other hunk.

Thanks.
