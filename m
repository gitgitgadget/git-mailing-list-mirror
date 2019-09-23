Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB8651F463
	for <e@80x24.org>; Mon, 23 Sep 2019 17:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502093AbfIWRTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 13:19:00 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:39256 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395453AbfIWRS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 13:18:59 -0400
Received: by mail-io1-f45.google.com with SMTP id a1so35364192ioc.6
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=88Fi+u3Oz6YSMP0svDas1kbROQpOsZuzyZWvZlhiIhs=;
        b=C2wIRbvx6tp+s/paoDIsFJdLMgLR8O/1WwNXwcRrMr6HyIg4rqVnLfeBoyYid2o4qf
         W6BhAadt785i3jxzeLARRyRA/KNhu93EgNv5U78GUPrQqPQhFN2naYMlViZwbLZDoDLA
         px3Vv68pC+/FbeBEpqhWiECwPbfCJEz3AcsHFXoXCz5aNk8JHTV1eMzN3wBDnq2mrqlh
         sWLA3II1mNXXmAF8uASoUfZEdParZkeXvIQY41J/3X1nBB5RN9DlfeMUQu1gk3rf+/tJ
         bOjJrZaoqfQRBBLn7kjj3m9vF3XhKvsh91DEEmx8VAbggbOYLatGfGZtIVg8dKGCOCHK
         CgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=88Fi+u3Oz6YSMP0svDas1kbROQpOsZuzyZWvZlhiIhs=;
        b=e//TvM/aogkPDftGE44kgtBlAtPbeuXZY0xZJudVDY3F4omphk4HQwColrRsy2YdZV
         d6IxnlAIuKrKIgLPEgZLIdnIvSdjgZZfB8vSZCKAw1jNGZUAoxtN4LzYtTw8QFf4bti6
         W0sWLKiUmm44KxkCJJ78qCs96KztoYDcF8n8er8uCcIY+znTqctJCnhGNwk9Gfs/rVk+
         pMCA01FDySudPV7JfWG92jpLyzISXwdo78NRpSTC1falOfywdE9UEagJEzVErcdbnfFW
         3VW+m8+axXaPZrBIUyB6f2WB6hCiqVy6UNBlRvdzs23KJMY/QMUEZUYv0kX8OY2YCSKP
         4Elw==
X-Gm-Message-State: APjAAAUKw0FyU4i1vzDJytsCr1IJPa/UbHn+782ocAhOyuBD2i45rlU8
        bmO5WirxTZzRk2o3fwZk5sOqHjNnLI1qL/zcVgJG0V0CpzY=
X-Google-Smtp-Source: APXvYqz3JXggcjtjFh2UsgskbXobDVuZQz+3VkVo2D+SQzRbKq8xHqrTAovdzxUtzUbD4Ng1ILsJQ9/xeGjNt8UERlg=
X-Received: by 2002:a6b:8e57:: with SMTP id q84mr364084iod.41.1569259137281;
 Mon, 23 Sep 2019 10:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
 <20190923092417.GF10866@szeder.dev>
In-Reply-To: <20190923092417.GF10866@szeder.dev>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 23 Sep 2019 13:18:39 -0400
Message-ID: <CAH8yC8mT+rArXBKPb1w2c74ZMRWZsc75x=52fmcpGuE6NBOhCQ@mail.gmail.com>
Subject: Re: How to see command line arguments passed to program in core.sshcommand?
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 5:24 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sun, Sep 22, 2019 at 11:17:59PM -0400, Jeffrey Walton wrote:
> > I need to spy the command line arguments being passed around, but I
> > have not been able to do so. 'git clone -verbose' is ineffective, and
> > -vvv is rejected as an unknown option.
> >
> > How do I see command line arguments passed to the program in core.sshco=
mmand?
>
> Try
>
>   GIT_TRACE=3D1 git <rest of the command>

Thanks.

I set GIT_TRACE=3D1 and enabled tracing on the tunnel.exe program. I
then set <path-to-public-key> to a non-existent file. No warnings, no
errors. Just a failed authentication. It looks like the tunnel.exe
program is the problem.

I did notice Git is not handling paths correctly on Windows. First, a
test program:

#include <iostream>
#include <sstream>

int main(int argc, char* argv[])
{
    std::cout << "Test tunnel program v1.0" << std::endl;

    for (int i=3D0; i<argc; ++i)
    {
        std::ostringstream oss;
        oss << "Arg " << i+1 << ": " << "'" << argv[i] << "'" << std::endl;
        std::cerr << oss.str();
    }

    return 5;
}

Compile:

    >cl.exe /nologo /W4 /EHsc test_tunnel.cxx
    test_tunnel.cxx

=3D=3D=3D=3D=3D

(A) core.sshCommand:

    sshcommand =3D "C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe"

Result:

$ GIT_TRACE=3D1 git clone ssh://jeffrey.walton@example.com:22480/main
...
Cloning into 'main'...
11:44:32.192382 run-command.c:663       trace: run_command: unset
GIT_DIR; 'C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe' -p 22480
jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe: C:UsersJeffrey:
command not found
fatal: Could not read from remote repository.

=3D=3D=3D=3D=3D

(B) core.sshCommand:

    sshcommand =3D "C:\\\\Users\\\\Jeffrey Walton\\\\Desktop\\\\test_tunnel=
.exe"

Result:

$ GIT_TRACE=3D1 git clone ssh://jeffrey.walton@example.com:22480/main
...
Cloning into 'main'...
11:45:59.161132 run-command.c:663       trace: run_command: unset
GIT_DIR; 'C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe' -p
22480 jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe: C:\Users\Jeffrey:
No such file or directory
fatal: Could not read from remote repository.

=3D=3D=3D=3D=3D

(C) core.sshCommand:

    sshcommand =3D "C:\\\\Users\\\\JEFFRE~1\\\\Desktop\\\\TEST_T~1.EXE"

Result:

$ GIT_TRACE=3D1 git clone ssh://jeffrey.walton@example.com:22480/main
...
Cloning into 'main'...
11:47:49.973632 run-command.c:663       trace: run_command: unset
GIT_DIR; 'C:\\Users\\JEFFRE~1\\Desktop\\TEST_T~1.EXE' -p 22480
jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
Arg 1: 'C:\Users\JEFFRE~1\Desktop\TEST_T~1.EXE'
Arg 2: '-p'
fArg 3: '22480'
atal: pArg 4: 'jeffrey.walton@example.com'
rotocol error:Arg 5: 'git-upload-pack '/main''
 bad line length character: Test

=3D=3D=3D=3D=3D

(A) is stripping quotes but they are needed for Windows long file
names. (A) also seems to be double-escaping slashes.

(B) is also stripping quotes. (B) works around the double-escaping slashes.

(C) works around stripping quotes by using short filenames. (C) also
works around the double-escaping slashes.

I did not find a git-path or git-filename man page. Most of this
appear undocumented (to me).

From a usability point of view, Windows long filenames have been
around since at least 1995. This is how Windows users expect things to
work for the last couple of decades:

    shcommand =3D "C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe"

or

    shcommand =3D "C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe"

In contrast, this would not need quotes:

    shcommand =3D C:\Users\Jeff\Desktop\test_tunnel.exe

If there is extra work to be done, then I think the program should do
it, not the user. I believe Git should preserve the quotes in a long
filename.

A fallback is to call GetShortPathName, but it is an incomplete
remediation because short name aliases can be turned off. If short
filenames were disabled on my system then the workaround would not
work.

Jeff
