Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD11208B4
	for <e@80x24.org>; Tue,  1 Aug 2017 20:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbdHAU7N (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:59:13 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37641 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdHAU6e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:58:34 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so12537084pgy.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TA8fprzmmSMcHcAh+KG2tNx2eER99xnhA7ULURzD3+E=;
        b=e9Cek5i9lzBkFwFJHGCumDw2baIVJv9iZZXUDz42XmBG/U2unK5q+CFI3Q24L3IzU1
         Op0DHPtOSunaOsy6w81h4pdyeCEIW2WUnizRw4IEJB7nL5lVGhMCR65bdJuFKHXDyxmz
         z7NrwMwNGKKPJWYtkjaNFbTqeIqQfft91pFUcEfWcfRyzWTvUcR3RKmiXL1u/HVmJG7D
         znTp2xAKjlIcuQZQ+OHVinieXsilGvqjPkuHA5msji4PznxgAmfmauWSQPKIYvrp8hnW
         n2Z0Jq+4JFBYOUNqwiHbU3CFXeh9yvVimHf/NT2L8vjQlGFsppgIWtCmwHM+5h92YLyy
         Dj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TA8fprzmmSMcHcAh+KG2tNx2eER99xnhA7ULURzD3+E=;
        b=bZNDAuN4JQ+n+dK5kN35AA2TQ73eZd3t46n9l7yX89oef9C0uvgYTfAn0AWz9n9SCJ
         qo0++3JiNWYh4jbyAAH4WRjvkkmjhLfPiEkH79fyCkWh3WwTy6Tpvy7PtDYKhDluqkWs
         /o4rsxpQD7JJRYlnt5FdYP+Rj+8yAltc02XkMOm79C1bCkwDjvnVwQ5EazF8kbtO0ZCg
         2ZNHa40DeReLIDp68IXaqbx4aHDWIzKZci5zW3zxPl5icPptUO58vbRUpEIlPDhsTt2j
         HOEvdzsFW1KEDFPT1aB//e2opyHcPBIZnZ8oVTybQgTzmDEjE3lGbqsPtSxD0zmBeGPS
         F3vg==
X-Gm-Message-State: AIVw112iql3hjjIho2vKoDC1kDOTMEbbq0/RFQw2OHnIr71PKEx4yGOc
        wjJK9hFyiK5eM4wmj6pSO3wKsmXSOvUS
X-Received: by 10.84.146.140 with SMTP id g12mr12608740pla.80.1501621112789;
 Tue, 01 Aug 2017 13:58:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Tue, 1 Aug 2017 13:58:32 -0700 (PDT)
In-Reply-To: <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
References: <CA+dzEBmsgUjmf5fUmeiwS=Q81OgpL6K5p=8dBuTjuZ4XE1V5SA@mail.gmail.com>
 <287407ac-b0d0-ef24-4950-0982a2db9bed@web.de>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 1 Aug 2017 13:58:32 -0700
Message-ID: <CA+dzEB=3OMw_YM4K_a8dyDG_FwGavU382stXrEOkbYoyM4DSZQ@mail.gmail.com>
Subject: Re: core.autocrlf=true causes `git apply` to fail on patch generated
 with `git diff-index HEAD --patch`
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's where I'm hitting the problem described:
https://github.com/pre-commit/pre-commit/issues/570

Note that `git -c core.autocrlf=3Dfalse` apply patch fixes this
situation, but breaks others.

Here's a testcase where `git -c core.autocrlf=3Dfalse apply patch`
causes a *different* patch failure:

```
#!/bin/bash
set -ex

rm -rf foo
git init foo
cd foo

git config --local core.autocrlf true

# Commit lf into repository
python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
git add foo
python3 -c 'open("foo", "wb").write(b"3\n4\n")'

# Generate a patch, check it out, restore it
git diff --ignore-submodules --binary --no-color --no-ext-diff > patch
python3 -c 'print(open("patch", "rb").read())'
git checkout -- .
git -c core.autocrlf=3Dfalse apply patch
```

output:

```
+ rm -rf foo
+ git init foo
Initialized empty Git repository in /tmp/foo/.git/
+ cd foo
+ git config --local core.autocrlf true
+ python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
+ git add foo
+ python3 -c 'open("foo", "wb").write(b"3\n4\n")'
+ git diff --ignore-submodules --binary --no-color --no-ext-diff
warning: LF will be replaced by CRLF in foo.
The file will have its original line endings in your working directory.
+ python3 -c 'print(open("patch", "rb").read())'
b'diff --git a/foo b/foo\nindex 1191247..b944734 100644\n---
a/foo\n+++ b/foo\n@@ -1,2 +1,2 @@\n-1\n-2\n+3\n+4\n'
+ git checkout -- .
+ git -c core.autocrlf=3Dfalse apply patch
error: patch failed: foo:1
```

My current workaround is:
- try `git apply patch`
- try `git -c core.autocrlf=3Dfalse apply patch`

which seems to work pretty well.

Anthony


On Tue, Aug 1, 2017 at 1:47 PM, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
>
> On 08/01/2017 08:24 PM, Anthony Sottile wrote:
>>
>> Here's my minimal reproduction -- it's slightly far-fetched in that it
>> involves*committing crlf*  and
>>
>> then using `autocrlf=3Dtrue` (commit lf, check out crlf).
>>
>> ```
>> #!/bin/bash
>> set -ex
>>
>> rm -rf foo
>> git init foo
>> cd foo
>>
>> # Commit crlf into repository
>> git config --local core.autocrlf false
>> python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
>> git add foo
>> git commit -m "Initial commit with crlf"
>>
>> # Change whitespace mode to autocrlf, "commit lf, checkout crlf"
>> git config --local core.autocrlf true
>> python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'
>>
>> # Generate a patch, check it out, restore it
>> git diff --ignore-submodules --binary --no-color --no-ext-diff > patch
>> python3 -c 'print(open("patch", "rb").read())'
>> git checkout -- .
>> # I expect this to succeed, it fails
>> git apply patch
>> ```
>>
>> And here's the output:
>>
>> ```
>> + rm -rf foo
>> + git init foo
>> Initialized empty Git repository in/tmp/foo/.git/
>> + cd foo
>> + git config --local core.autocrlf false
>> + python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n")'
>> + git add foo
>> + git commit -m 'Initial commit with crlf'
>> [master (root-commit) 02d3246] Initial commit with crlf
>>   1 file changed, 2 insertions(+)
>>   create mode 100644 foo
>> + git config --local core.autocrlf true
>> + python3 -c 'open("foo", "wb").write(b"1\r\n2\r\n\r\n\r\n\r\n")'
>> + git diff --ignore-submodules --binary --no-color --no-ext-diff
>> + python3 -c 'print(open("patch", "rb").read())'
>> b'diff --git a/foo b/foo\nindex bd956ea..fbf7936 100644\n---
>> a/foo\n+++ b/foo\n@@ -1,2 +1,5 @@\n 1\r\n 2\r\n+\r\n+\r\n+\r\n'
>> + git checkout -- .
>> + git apply patch
>> patch:8: trailing whitespace.
>>
>> patch:9: trailing whitespace.
>>
>> patch:10: trailing whitespace.
>>
>> error: patch failed: foo:1
>> error: foo: patch does not apply
>> ```
>>
>> I also tried with `git apply --ignore-whitespace`, but this causes the
>> line endings of the existing contents to be changed to*lf*  (there may
>> be two bugs here?)
>>
>> Thanks,
>>
>> Anthony
>
>
>
> I can reproduce you test case here.
>
> The line
>
> git apply patch
>
> would succeed, if you temporally (for the runtime of the apply command) s=
et
> core.autocrlf to false:
>
> git -c core.autocrlf=3Dfalse apply patch
>
> So this seems to be a bug (in a corner case ?):
>
> Typically repos which had been commited with CRLF should be normalized,
> which means that the CRLF in the repo are replaced by LF.
> So you test script is a corner case, for which Git has not been designed,
> It seems as if "git apply" gets things wrong here.
> Especially, as the '\r' is not a whitespace as a white space. but part
> of the line ending.
> So in my understanding the "--ignore-whitespace" option shouldn't affect
> the line endings at all.
>
> Fixes are possible, does anyone have a clue, why the '\r' is handled
> like this in apply ?
>
> And out of interest: is this a real life problem ?
>
>
>
>
>
