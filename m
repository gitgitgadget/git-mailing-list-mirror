Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0D751F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfIWSiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:38:14 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35613 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIWSiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:38:14 -0400
Received: by mail-wr1-f44.google.com with SMTP id v8so15154836wrt.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=znS9QyrOOrBM1N1+PlXYLCAP3WtaFdeiJcLDcKjNdzM=;
        b=DxH0yfHEISRaWdwdrMkR6v/5uAldbIUu478QannAIF/VsXpVO7xE7LEjpCNO43FXrq
         cbC98zFumnHIDatjcQfWjNY+1Nqao3kQaDcOI3HzTpShWALcgc5aRUk0RNJUIx8lvXbX
         dtJfW8654VwAvhbFv4bYK4NfBfUulRFsCK8wPf30pErCEh4CyRf/7Lyu0uQU3gAMH4L1
         LtTuyETttpcKL5lMvG60iIt/Z9v5q1cqUKB+zn/d5Seii2VvExKW+g5BzWPGahHF8Aih
         OEcYTgwkQURzeFNZSzp8fsxytlAXV5nMEApNiocuy2bITxVAAwT1gD7D3EaZO3U13g5s
         xNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=znS9QyrOOrBM1N1+PlXYLCAP3WtaFdeiJcLDcKjNdzM=;
        b=tM9sqDsmPR3WWnCKKmf6r6KpQqO+N3SzTc7mhA1bf3X+j8W9KpQhb84wMDJHiI/pYh
         JCDa8/brp9Wc2qBrRebbIyQ7fTRwIYGOkmp8zunu4r3nATNQJ1CnDA2w4RhGMkaH4wc5
         XLc92WyQJ389TcohjXanh4ZuUmBtso7C/qai7/4k7cc+yqQ3/njfPqYCdhj2VZDkvd5x
         rctdc09sPCftyl6yKh2x+3WlQYh1rpEgIOC8xeISfSAxIu53CWUJUMcjA6IvaUNHkrt7
         M7O0MCAAtJva4uHAiW33mQ5k4nY7z/b4YjzGsWBD42Sr0GOpAViKwIlhLefz6NVfF1s1
         MTUg==
X-Gm-Message-State: APjAAAW161nTthl6d9StB3sw15ub7thrVr60R6b1ouAdL/ymc8ye3m22
        OGl35Sq2NmegGqWfPwPVmJI=
X-Google-Smtp-Source: APXvYqzSE/S7umPIhSFjMP0fskQcdqrPATpBJcLq7w2Pza8hl95600lR6a7rXrr2BiVWNSB7FRzRiw==
X-Received: by 2002:adf:ea47:: with SMTP id j7mr608079wrn.394.1569263892159;
        Mon, 23 Sep 2019 11:38:12 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id g11sm12838835wmh.45.2019.09.23.11.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:38:11 -0700 (PDT)
Date:   Mon, 23 Sep 2019 20:38:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to see command line arguments passed to program in
 core.sshcommand?
Message-ID: <20190923183806.GA2637@szeder.dev>
References: <CAH8yC8nVBcBntJVZ6eV+YxoBpZRx+ecC2JxGuunhxNbY2cGyFQ@mail.gmail.com>
 <20190923092417.GF10866@szeder.dev>
 <CAH8yC8mT+rArXBKPb1w2c74ZMRWZsc75x=52fmcpGuE6NBOhCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8mT+rArXBKPb1w2c74ZMRWZsc75x=52fmcpGuE6NBOhCQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 01:18:39PM -0400, Jeffrey Walton wrote:
> (A) core.sshCommand:
> 
>     sshcommand = "C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe"
> 
> Result:
> 
> $ GIT_TRACE=1 git clone ssh://jeffrey.walton@example.com:22480/main
> ...
> Cloning into 'main'...
> 11:44:32.192382 run-command.c:663       trace: run_command: unset
> GIT_DIR; 'C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe' -p 22480
> jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
> C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe: C:UsersJeffrey:
> command not found
> fatal: Could not read from remote repository.
> 
> =====
> 
> (B) core.sshCommand:
> 
>     sshcommand = "C:\\\\Users\\\\Jeffrey Walton\\\\Desktop\\\\test_tunnel.exe"
> 
> Result:
> 
> $ GIT_TRACE=1 git clone ssh://jeffrey.walton@example.com:22480/main
> ...
> Cloning into 'main'...
> 11:45:59.161132 run-command.c:663       trace: run_command: unset
> GIT_DIR; 'C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe' -p
> 22480 jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
> C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe: C:\Users\Jeffrey:
> No such file or directory
> fatal: Could not read from remote repository.
> 
> =====
> 
> (C) core.sshCommand:
> 
>     sshcommand = "C:\\\\Users\\\\JEFFRE~1\\\\Desktop\\\\TEST_T~1.EXE"
> 
> Result:
> 
> $ GIT_TRACE=1 git clone ssh://jeffrey.walton@example.com:22480/main
> ...
> Cloning into 'main'...
> 11:47:49.973632 run-command.c:663       trace: run_command: unset
> GIT_DIR; 'C:\\Users\\JEFFRE~1\\Desktop\\TEST_T~1.EXE' -p 22480
> jeffrey.walton@example.com 'git-upload-pack '\''/main'\'''
> Arg 1: 'C:\Users\JEFFRE~1\Desktop\TEST_T~1.EXE'
> Arg 2: '-p'
> fArg 3: '22480'
> atal: pArg 4: 'jeffrey.walton@example.com'
> rotocol error:Arg 5: 'git-upload-pack '/main''
>  bad line length character: Test
> 
> =====
> 
> (A) is stripping quotes but they are needed for Windows long file
> names. (A) also seems to be double-escaping slashes.
> 
> (B) is also stripping quotes. (B) works around the double-escaping slashes.
> 
> (C) works around stripping quotes by using short filenames. (C) also
> works around the double-escaping slashes.
> 
> I did not find a git-path or git-filename man page. Most of this
> appear undocumented (to me).
> 
> From a usability point of view, Windows long filenames have been
> around since at least 1995. This is how Windows users expect things to
> work for the last couple of decades:
> 
>     shcommand = "C:\Users\Jeffrey Walton\Desktop\test_tunnel.exe"
> 
> or
> 
>     shcommand = "C:\\Users\\Jeffrey Walton\\Desktop\\test_tunnel.exe"
> 
> In contrast, this would not need quotes:
> 
>     shcommand = C:\Users\Jeff\Desktop\test_tunnel.exe

Git's configuration file format allows optional double quotes around
the values of configuration variables.  Consequently all double quotes
in your examples above are treated as part of the file format and are
removed; you have to escape them if you want to keep them:

  [foo]
        one = "inside double quotes"
        two = \"need those double quotes\"
        three = "\"need these double quotes, too\""

  $ git config --get foo.one
  inside double quotes
  $ git config --get foo.two
  "need those double quotes"
  $ git config --get foo.three
  "need these double quotes, too"


> If there is extra work to be done, then I think the program should do
> it, not the user. I believe Git should preserve the quotes in a long
> filename.
> 
> A fallback is to call GetShortPathName, but it is an incomplete
> remediation because short name aliases can be turned off. If short
> filenames were disabled on my system then the workaround would not
> work.
> 
> Jeff
