Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE111F42D
	for <e@80x24.org>; Fri, 18 May 2018 11:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeERLcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 07:32:03 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:38043 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeERLb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 07:31:58 -0400
Received: by mail-io0-f172.google.com with SMTP id z4-v6so5774689iof.5
        for <git@vger.kernel.org>; Fri, 18 May 2018 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anmol.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yw7B5BdfAGgIrkkH+3s5SR873/1aD7CPguvQFNN3b8=;
        b=OulYg2W6YgfKiNhBUBkYZh7EMlYvn7gqIXzFDN3v3LZiHbDaxzy9/WHfvf2nMF785B
         QY7e7BmqAKlLuJKMiHMaCdslynopB75UyFmUGVB59OVm2Y+rQcBFoRqRFxCV6r0UknKZ
         1D3yHbILx3a8csq13cr5JFhfgXzyELNnTbG8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3yw7B5BdfAGgIrkkH+3s5SR873/1aD7CPguvQFNN3b8=;
        b=M6NLNx8CUZ1ROf8sTFWWvQJJi07Lu+3e34YSsrtXJT0svV+v/lsEXixIAvLWB/b3TC
         1LEtS7cAzGI3ndZrm3s63lupD6oFzUlBeDtMzdUwE3hzslif/3rPFHvNayL1c62jxF/P
         v+WGMpy402B9rsjl7q5Exen+dzZxNnYfxNjqcCZ5KWxB0PMkC6g85Es/c2kWIebn8dBS
         gkJqHeQxBI8OauUZkgA4R+QE1rOOiSheJJ6JHaP9z4kNONOPdO2lGma6r358FxuyvLC2
         XZAqwejHMyJ2nNIZx1U4KchCqWsSJR+Hzc0B0Fxly1zI6D2Yr5Qcqizz4VRZhH9lGjCE
         /fLA==
X-Gm-Message-State: ALKqPwe0jUMu0mDvMvITRv1zpR3oxJ6wReYvBguwkoFFaMlBmD8ezR7J
        8Vi7GX4ZACzxWbpYXLSpt27aMQ==
X-Google-Smtp-Source: AB8JxZrfdlxywNEVW6xMR1rJrQlDzQ7odvb+VDoGltwhdm42bGK4R+dnKszdXHkUMzBKIh1wcoV9ig==
X-Received: by 2002:a6b:6b02:: with SMTP id g2-v6mr10291139ioc.250.1526643117750;
        Fri, 18 May 2018 04:31:57 -0700 (PDT)
Received: from ?IPv6:2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6? ([2607:fea8:4da0:8ef:7088:aff6:8a95:3ce6])
        by smtp.gmail.com with ESMTPSA id q6-v6sm5107592ita.44.2018.05.18.04.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 04:31:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: Add option to git to ignore binary files unless force added
From:   Anmol Sethi <me@anmol.io>
In-Reply-To: <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com>
Date:   Fri, 18 May 2018 07:31:56 -0400
Cc:     Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30BAE567-25B9-4D5E-B86B-45A578DDC57A@anmol.io>
References: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
 <CA+P7+xqQZzTrm274rbbP_O85Y+YGZ4PQ8PMFJnJtKR4wR0AObQ@mail.gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This definitely works but it would be more clean to just have git ignore =
the binary files from the get go.

> On May 16, 2018, at 11:18 PM, Jacob Keller <jacob.keller@gmail.com> =
wrote:
>=20
> On Wed, May 16, 2018 at 5:45 PM, Anmol Sethi <me@anmol.io> wrote:
>> I think it=E2=80=99d be great to have an option to have git ignore =
binary files. My repositories are always source only, committing a =
binary is always a mistake. At the moment, I have to configure the =
.gitignore to ignore every binary file and that gets tedious. Having git =
ignore all binary files would be great.
>>=20
>> This could be achieved via an option in .gitconfig or maybe a special =
line in .gitignore.
>>=20
>> I just want to never accidentally commit a binary again.
>>=20
>> --
>> Best,
>> Anmol
>>=20
>=20
> I believe you can do a couple things. There should be a hook which you
> can modify to validate that there are no binary files on
> pre-commit[1], or pre-push[2] to verify that you never push commits
> with binaries in them.
>=20
> You could also implement the update hook on the server if you control
> it, to allow it to block pushes which contain binary files.
>=20
> Thanks,
> Jake
>=20
> [1]https://git-scm.com/docs/githooks#_pre_commit
> [2]https://git-scm.com/docs/githooks#_pre_push
> [3]https://git-scm.com/docs/githooks#update

--=20
Best,
Anmol

