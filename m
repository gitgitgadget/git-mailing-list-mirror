Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F19BB1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeD2NI4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 09:08:56 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:45403 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbeD2NI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 09:08:56 -0400
Received: by mail-vk0-f44.google.com with SMTP id 203-v6so3673567vka.12
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+9xdTTcozSGZNH5Y1MZ7lipJ/qcZdT84P95KwGppdN4=;
        b=r4NTnI9EF6KTEUlqyTL2lAi+efcy0YgGbewX4am10e7gZalAoS7f7UG1gaIjexX2bC
         To1C27fFYGLTxiGidnZvnHvVoxtR+VWlSuBGxDjlsUB8eoYEbtTNGie27aBUhL2UQ4IY
         vGDDCQzVQ5BSWhRJ28mG1S2ahnPFP+hZKjj0KXDtIn6yHkrvN8fjAK54m5QUGv2kjxpe
         smFOqXXsLD00LnoPCtX8+u6nDWmGy6DBl9nhf+DmFKKyF2k/CFDa+PnAkaEC47vIL/Lw
         ApyhNcZEtbNdlPabjNkHMwwRZ0u0c92xPnK0CuOOCV0k1qAwfByrasQmrI02QM5GujoZ
         BPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=+9xdTTcozSGZNH5Y1MZ7lipJ/qcZdT84P95KwGppdN4=;
        b=in3CZ8JcYUpbpQVQOcPby5+HVsAjTATP2oQm2X567ZFqP+156ffzOwGDTPf+BpnCWd
         3WNXQvQ3PdW/uLLN8uqoSorVUGVxAqo/a+oJu7goPzKedi+jQmOr7bsWY+dK9MBVHB7t
         ilaLJEdb60bS1TkBZRmh9iZ+HfvadbEBcuPPhIYWdSmqtzZk2JxO52zCR8ywXsnbv0QA
         SZ3+T6NYQhIfb1AmTNjnmSg2NkRwbC9p6vvF/lzgQhYAqUj0KFoT6AVXEFvKYxDkIMDO
         sTzx08nv5sVwYLTalYSwFzmfRK00KqgkNoZ0LQyAPrGCSm0OQx7T/1zhbVeYENHJ1IJY
         +MOQ==
X-Gm-Message-State: ALQs6tDKkq+74DWNchEkfTH1BCbL9WrN3FMKH51+LSg+RTyMkUBWgeqx
        1R6FfRPM88TWA5PeQdp/mbAFpYgt+riw2DLZz/0=
X-Google-Smtp-Source: AB8JxZp8Qj6kGUxjcMnaFW5lukVmxV1ojKy24DPop/HQsQiQ6MoybgrgLRMbF+1nvoVeFgCycM5NyVTk10zmn9S2W7g=
X-Received: by 2002:a1f:8d09:: with SMTP id p9-v6mr5964461vkd.58.1525007335129;
 Sun, 29 Apr 2018 06:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Sun, 29 Apr 2018 06:08:54 -0700 (PDT)
In-Reply-To: <20180429111533.GA31974@furore>
References: <CAM0VKj=MVY15SbRanfhXP3pPjNEuhZ=dbQmhXox6n5AOFyz2oQ@mail.gmail.com>
 <20180429111533.GA31974@furore>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sun, 29 Apr 2018 15:08:54 +0200
Message-ID: <CAM0VKjkmQObwiUBnf+xydKS1rO5B20HdWsdBjsQLDhcndoM7ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] completion: load completion file for external subcommand
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 29, 2018 at 1:15 PM, Florian Gamb=C3=B6ck <mail@floga.de> wrote=
:
> On 2018-04-25 16:40, SZEDER G=C3=A1bor wrote:
>>
>> In my previous emails I overlooked the _completion_loader() helper
>> function.
>>
>> It seems that this function does almost exactly what we want.  It was
>> introduced along with dynamic completion loading back in 20c05b43, so it=
's
>> available for us even in older LTS/Enterprise releases.  Since cad3abfc =
it's
>> a wrapper around __load_completion() and thus benefits from all the
>> improvements, notably searching for completion scripts in a user-specifi=
ed
>> directory ($BASH_COMPLETION_USER_DIR) or in the user's home directory
>> ($XDG_DATA_HOME or ~/.local/...) as well.  It loads the matching complet=
ion
>> script, but does not call the completion function unconditionally.
>
>
> Sounds good so far.
>
>> The "almost" refers to he case when _completion_loader() can't find a
>> completion script with a matching name to load, and then registers the
>> _minimal() completion function for the given command to do basic path
>> completion as fallback.  I don't think this matters in practice, because=
 in
>> this case the given command is a git command in its dashed form, e.g.
>> 'git-diff-index', and those have been deprecated for a long time.
>
>
> I sense a problem here. If I have a directory with a file xyzfoobar in it=
,
> and I type `git xyz`, with no defined subcommand that starts with these
> letters, then minimal bashcomp would give me `git xyzfoobar`, which can o=
f
> course not execute. This can be unintuitive for users, as in: "If it can'=
t
> be executed correctly, then why does it even suggest such a completion?"

I'm not sure I understand the problem.  After 'git xyz<TAB>' (note
there is no space between 'xyz' and <TAB>) we try to complete the name
of a git command, not options of a git command.  This means:

  - At this point we don't look for a _git_xyz() function, so we'll
    return from __git_main() before even reaching the piece of code
    your patch modifies.

  - There are (presumably) no commands starting with 'xyz', so we
    don't list any commands.  Bash will then fall back to its own
    filename completion, and that's where that 'xyzfoobar' will come
    from.  It has been behaving like this basically since forever.

And after 'git xyz <TAB>' (this time with space) we already complete
the next word, not 'xyz'.

>> I think all you need to do is run a
>> s/__load_completion/_completion_loader/ on your patch and update the com=
mit
>> message with relevant bits from the above discussion.
>
>
> I can do that, no problem. But prior to that I want to be sure that you a=
re
> okay with the above mentioned drawback. Will the behavior be acceptable i=
n
> this case? Or should we try to somehow "undo" the minimal completion
> afterwards?

As explained above, I don't think there is any drawback here.  Or at
least not any new drawback that your patch is introducing.  Or I'm
completely missing your point; certainly a possibility, it's early
Sunday afternoon, after all :)
