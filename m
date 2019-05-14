Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923141F461
	for <e@80x24.org>; Tue, 14 May 2019 08:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfENIJ1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 04:09:27 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35887 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENIJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 04:09:26 -0400
Received: by mail-ed1-f45.google.com with SMTP id a8so21561153edx.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 01:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ieV6u/chlkg4OXy2SxyS+P/WbfCnNgBLkjvRUkbG32E=;
        b=pGWTJYO7QbT+CO7WHqCCg2fMsq7J4ayWuEHKzxu1KCLciN6WzGW3f6mSrYb+VfRp4X
         fYreU1hmluPhM3Z9KsKexhT0vo6EfeuQIVPo7NktaSIUsSZFG/zjEr33kORrjpnKazMi
         KHLnF/u/fL/vjHIRq6yRrYPwd0K4aN/NroqLo/3BLlycnu3Ko/NrHjm1kcTqGMObBLTb
         e7LEPuZ9yzM/nCzXWjSgxBxgFNEFcOZGdlF+Ab5c98tSCHCjgXg2/AGJMX1QBG3C8lqr
         TEC3H8GDzPKhSvrYlWfmhfAjMveTg9J7oSKIZ4BqB1BS8C2DCxvVpii05xTAECR7Xd/H
         lBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ieV6u/chlkg4OXy2SxyS+P/WbfCnNgBLkjvRUkbG32E=;
        b=YDEj5vxDCUnWnhrbrAJKSycURR/inRtR1HlIDvkWbWLmCriY5oGa7FsUG2QLR43b/a
         AwyUKERrQbKLqTS5vA0lNPtpWMWl0LpY8HS0YeChJDwktTWsqYFEZctGEK9Ix+L3Y0F+
         cnN4322if7tijlLCIqu5brFVTmRBVYCVQWQIlHo95aDziAFDA3taw6qm5wCJhI/pDWha
         HYBSphlb8GncPnZfiMsB+z+edJhSD4PgOCLZ8IKp6z2wNR/LY9gERlkZ3XYW7zp+3RQv
         Req/SUnaxAX3sT0HjCTYXq1dm2kXki4vrGa2+7T0WoVm5zffKRFWp4Nku4nYStzW+GXP
         z/rg==
X-Gm-Message-State: APjAAAWsKWRkegU8E989iYorRsMQzJpPAoAmeA1MV6OoVQxgHRvVQyY3
        oaUnGjRf8ZIeo4agIpaV4d0=
X-Google-Smtp-Source: APXvYqxq6/spttBaIipbbsL012b+E68QqSHF8ZXf9OkUuX0EI6zFIFcQ5EEDQeEgf9zJX+NbyCqASA==
X-Received: by 2002:a17:906:6a8e:: with SMTP id p14mr25691348ejr.295.1557821364708;
        Tue, 14 May 2019 01:09:24 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id a13sm4404202eda.87.2019.05.14.01.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 01:09:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
References: <20190514020520.GI3654@pobox.com> <20190514023245.GB34155@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190514023245.GB34155@google.com>
Date:   Tue, 14 May 2019 10:09:23 +0200
Message-ID: <87o945wj7w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Jonathan Nieder wrote:

> Todd Zullinger wrote:
>
>> The JGIT prereq uses 'type jgit' to determine whether jgit is present.
>> While this should be sufficient, if the jgit found is broken we'll waste
>> time running tests which fail due to no fault of our own.
>>
>> Use 'jgit --version' instead, to catch some badly broken jgit
>> installations.
>>
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>> I ran into such a broken jgit on Fedora >=3D 30=C2=B9.  This is clearly a
>> problem in the Fedora jgit package which will hopefully be resolved
>> soon.  But it may be good to avoid wasting time debugging tests which
>> fail due to a broken tool outside of our control.
>>
>> =C2=B9 https://bugzilla.redhat.com/1709624
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> It would be nice to describe that bug in the commit message, to save
> readers some head scratching.

FWIW the jgit in Debian testing/unstable is similarly broken right now:

    $ apt policy jgit-cli
    jgit-cli:
      Installed: 3.7.1-6
      Candidate: 3.7.1-6
      Version table:
     *** 3.7.1-6 900
            900 http://ftp.nl.debian.org/debian testing/main amd64 Packages
            800 http://ftp.nl.debian.org/debian unstable/main amd64 Packages
            100 /var/lib/dpkg/status
         3.7.1-4 700
            700 http://ftp.nl.debian.org/debian stable/main amd64 Packages
    $ jgit --version; echo $?
    Error: A JNI error has occurred, please check your installation and try=
 again
    Exception in thread "main" java.lang.NoClassDefFoundError: org/kohsuke/=
args4j/CmdLineException
            at java.lang.Class.getDeclaredMethods0(Native Method)
            at java.lang.Class.privateGetDeclaredMethods(Class.java:2701)
            at java.lang.Class.privateGetMethodRecursive(Class.java:3048)
            at java.lang.Class.getMethod0(Class.java:3018)
            at java.lang.Class.getMethod(Class.java:1784)
            at sun.launcher.LauncherHelper.validateMainClass(LauncherHelper=
.java:544)
            at sun.launcher.LauncherHelper.checkAndLoadMain(LauncherHelper.=
java:526)
    Caused by: java.lang.ClassNotFoundException: org.kohsuke.args4j.CmdLine=
Exception
            at java.net.URLClassLoader.findClass(URLClassLoader.java:382)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:424)
            at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:349)
            at java.lang.ClassLoader.loadClass(ClassLoader.java:357)
            ... 7 more
    1

So rather than describe specific bugs on RedHat/Debian maybe just say:

    This guards against cases where jgit is present on the system, but
    will fail to run, e.g. because of some JRE issue, or missing Java
    dependencies. Seeing if it gets far enough to process the
    "--version" argument isn't perfect, but seems to be good enough in
    practice. It's also consistent with how we detect some other
    dependencies, see e.g. the CURL and UNZIP prerequisites.
