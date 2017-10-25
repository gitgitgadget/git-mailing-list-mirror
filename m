Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D19F202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932101AbdJYQSW (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 12:18:22 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:47013 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdJYQSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 12:18:20 -0400
Received: by mail-qk0-f173.google.com with SMTP id k123so732169qke.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s9T4N+/WwIficDNYCF5/xk6yfJL2IF9il0ujtMNHFXg=;
        b=rj2529QG95J30FVLSs8hND7iiWuUBo131IfvLM38GKCgCvxWIObppq0rWF9qrV19bM
         0aCiVS6E05KG0TnKlCdJLvLcYiXUeslRoLFtu0SZojaKXEd8nrzV+XiwoFJhCGFUCh9g
         w92sjQrLRtkc0dTfwoEdG9GvXrhfFKpQ5ebUl5TVlhuTBYfTW3JW2aihqh5p8aJId9rR
         fVvTctCIYhA34qyWGqOeexQlg0QBV76CSmO6w3tdMTJXlXbl8lT4paPFQrnV8kfm+J39
         qW8pdcRSb3zJo8EFTIcbaQMEbQ8mdbSFHMn0rDVV72PEdWTYSI8Durr4x+B9ljSdueTW
         XiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s9T4N+/WwIficDNYCF5/xk6yfJL2IF9il0ujtMNHFXg=;
        b=N05rZQV+P20df7FhbdKr7aMv7PQatoxAjS+i6D4sqSBTQS+YqaQ/jHNjUDiRhjujOX
         RQC6uXIRnTjapvyRlziVIPuP9R1RAqK9KjeVbQY3jsbdE1akntNuNDLYo8THW6Byoe45
         ClSltKpao3k05PiGe07TAFSkkPqwu+7B6KYlIXoKkve5IICZzMlFfC0qsXseF68N0xiC
         Z1eWRC5GtS6lzll+CPPtgnVf3yinaw6ITECGyVbkQlAsO1ypNtgGIvjHDtVYG7ba5/tZ
         5D+vtbNZNpIpYpjnfNtlrglMXPTHOgPxUnUSOjeCPVRrlhEuvpGtdWyygVmKm1ZtWVfc
         EPoQ==
X-Gm-Message-State: AMCzsaVFBL50agjaJ+IUxLzMppI8psf4Al9/qkyzQtHDYvr25f4zHyYM
        HwATV4TXGOvXZz4Zd+MDrQJGjH+/+3J28vz1+lfYFg==
X-Google-Smtp-Source: ABhQp+RnDKZ/kCKE2kGVAB3ds7zAo9jmtM3okVJFhuU5Wf10KH/c0q1GTo8CB9MK8dYaL8OzC7u+iKmT7T4d1W42t/s=
X-Received: by 10.55.111.3 with SMTP id k3mr3721499qkc.332.1508948299673; Wed,
 25 Oct 2017 09:18:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 25 Oct 2017 09:18:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com> <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com> <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1710251437090.6482@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Oct 2017 09:18:18 -0700
Message-ID: <CAGZ79kYTYg09A7UbhvyiT0QmRQG5ZJV6v1iaQBNCZY8RTj300A@mail.gmail.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and 'simple'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, William Yan <wyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 5:51 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jonathan,
>
> [I only saw that you replied to 3/5 with v2 after writing this reply, but
> it would apply to v2's 3/5, too]
>
> On Mon, 23 Oct 2017, Jonathan Nieder wrote:
>
>> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
>> index 86811a0c35..fd94dd40d2 100755
>> --- a/t/t5601-clone.sh
>> +++ b/t/t5601-clone.sh
>> @@ -384,6 +384,20 @@ test_expect_success 'uplink is treated as simple' '
>>       expect_ssh myhost src
>>  '
>>
>> +test_expect_success 'OpenSSH-like uplink is treated as ssh' '
>> +     write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
>> +     if test "\$1" = "-G"
>> +     then
>> +             exit 0
>> +     fi &&
>> +     exec "\$TRASH_DIRECTORY/ssh$X" "\$@"
>> +     EOF
>> +     GIT_SSH="$TRASH_DIRECTORY/uplink" &&
>> +     export GIT_SSH &&
>> +     git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
>> +     expect_ssh "-p 123" myhost src
>> +'
>> +
>>  test_expect_success 'plink is treated specially (as putty)' '
>>       copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>>       git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
>
> This breaks on Windows. And it is not immediately obvious how so, so let
> me explain:
>
> As you know, on Windows there is no executable flag. There is the .exe
> file extension to indicate an executable (and .com and .bat and .cmd are
> also handled as executable, at least as executable script).
>
> Now, what happens if you call "abc" in the MSYS2 Bash and there is no
> script called "abc" but an executable called "abc.exe" in the PATH? Why,
> of course we execute that executable. It has to, because if "abc.exe"
> would be renamed into "abc", it would not work any longer.
>
> That is also the reason why that "copy_ssh_wrapper" helper function
> automatically appends that .exe file suffix on Windows: it has to.
>
> Every workaround breaks down at some point, and this workaround is no
> exception. What should the MSYS2 Bash do if asked to overwrite "abc" and
> there is only an "abc.exe"? It actually overwrites "abc.exe" and moves on.
>
> And this is where we are here: the previous test case copied the ssh
> wrapper as "uplink". Except on Windows, it is "uplink.exe". And your newly
> introduced test case overwrites it. And then it tells Git specifically to
> look for "uplink", and Git does *not* append that .exe suffix
> automatically as the MSYS2 Bash would do, because git.exe is not intended
> to work MSYS2-like.
>
> As a consequence, the test fails. Could you please squash in this, to fix
> the test on Windows?

This explanation is in detail and would even make a good commit message
for a follow up commit. (Squashing just that line would loose the explanation
as I suspect the original commit will not dedicate so much text to
this single line)

>
> -- snipsnap --
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index ec4b17bca62..1afcbd00617 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -393,6 +393,7 @@ test_expect_success 'simple does not support port' '
>
>  test_expect_success 'uplink is treated as simple' '
>         copy_ssh_wrapper_as "$TRASH_DIRECTORY/uplink" &&
> +       test_when_finished "rm \"$TRASH_DIRECTORY/uplink$X\"" &&
>         test_must_fail git clone "[myhost:123]:src" ssh-bracket-clone-uplink &&
>         git clone "myhost:src" ssh-clone-uplink &&
>         expect_ssh myhost src
>
