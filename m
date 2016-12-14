Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7778320451
	for <e@80x24.org>; Wed, 14 Dec 2016 00:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbcLNAgh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 19:36:37 -0500
Received: from mail-wj0-f182.google.com ([209.85.210.182]:33970 "EHLO
        mail-wj0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbcLNAgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 19:36:35 -0500
Received: by mail-wj0-f182.google.com with SMTP id tg4so5989423wjb.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=vq1bmC/IHuTeZ/Q21BM/TA6cav/WWvCm6QLWF80mch8=;
        b=ROhHF1NS8U6rcmUrUdaMJYW+gT8TT1L02j6YG3i/9puzvr3vJopgCzObiYkOqwo9w/
         OxT7GoImXRvLawrLaNUkYcesUmtBAPSNi3KJAnmHfZpHieB9K/6Zd08u81j2A8ZNpYUL
         jwb+MbvP3VABEeNb1igCfeenRIA+SGFal4oi6JpAml2N6gMtvGOLT3GyhXS240n4Yfxs
         pHeA+WISdsNYwDNrxHoCidW3cjzfp4MC/nzHzccylwy6c1xnEF9h2C5ColAueQ9+whG8
         s7QT5jC5rwGfo+QrK/kM1xeheyNy1bdyPZu184NSQhJ/u3kbU9Vc361LY1sYnMt4cmxA
         C/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=vq1bmC/IHuTeZ/Q21BM/TA6cav/WWvCm6QLWF80mch8=;
        b=OCBeM9TY0pulprIVHzLd85XyxLKdzpnnCqubtegpkp8UQdUitvSVVKNWlB3VwxyRnA
         NF7MBPQCzLo59c4O7FzutdTHObNW0Rck0CNpUK3+TbqrLnsrhjerdRPaYZYozHq0lKKu
         QVtNp71rvwTlDaEQ034Gt/lJAQSQSZLPO0Hv4pH/qreRHCnjDK7ze+fMocH4hMXNet5u
         L6oOgSRtYgTbCdKsZk+d5YgYaBFvd9CBpNJ3gjobX9xwyR0GgarU11srwO2h4coUXI9D
         cLP1+J+NqROMcret08zU9BVUzctXOVQnur1LTapNX8hNVTdFRlWJ1qkqhW5JBFYKa/u3
         Roww==
X-Gm-Message-State: AKaTC01YGB4b/eSLTGv2XXSGugJhkOSV6nwhw6yyAkGYO6DVxK7gvaknwKkhO0VdW61A9A==
X-Received: by 10.28.126.18 with SMTP id z18mr5056739wmc.87.1481675763775;
        Tue, 13 Dec 2016 16:36:03 -0800 (PST)
Received: from [192.168.1.36] (233.red-88-8-30.dynamicip.rima-tde.net. [88.8.30.233])
        by smtp.gmail.com with ESMTPSA id di9sm64535329wjc.37.2016.12.13.16.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 16:36:03 -0800 (PST)
From:   =?utf-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: Proposal for an increased `gitk` cohesion with `git stash`.
Date:   Wed, 14 Dec 2016 01:36:01 +0100
References: <CANidDKZRisodpQgqyYaG_tCi0+EyxYv+t8+Entp0joMSetd3oA@mail.gmail.com>
 <20161212093613.GD20934@fergus.ozlabs.ibm.com>
To:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
In-Reply-To: <20161212093613.GD20934@fergus.ozlabs.ibm.com>
Message-Id: <B9F8449A-291C-4D7E-A5D2-165173E6E8DA@madiva.com>
X-Mailer: Apple Mail (2.3251)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dearest all,

am sorry my previous message did not enter the list (cross my fingers =
this will). I won't be pasting it verbatim because shame on me it leaked =
zombie processes (but that part got silently dropped out by kind Paul).

In case anyone could be interested in the topic, and because a thorough =
reply will take me some time, my most recent edit of this is hosted at =
https://gist.githubusercontent.com/uprego/d8c3c059c56ebb911974bb905157a81e=
/raw/6a08d9e0ce9c2b1decd4ed92acc924961c7f7769/gitk%2520multi%2520stash%252=
0patch. All problems shown I still think is a nice start (of course =
p.o.c / pre alpha) if anyone ever wanted to get this working or even fix =
the current problems it has.

As Paul recommend I'll be reworking and giving a patch against a rev of =
his upstream.

I'm going to try his code tips to improve non obvious design choices, =
and (even he doesn=E2=80=99t commented it and seems to me most =
important) really put an extra effort in not changing the behaviour of =
`gitk` (i.e. started without '--all').

Then some testing against large repos, github.com/cartodb/cartodb then =
github.com/odoo/oodo finally Linux; will be done.

The performance issue Paul points to, I don't think is impacting me, but =
now I reckon (just as one example) there are people who develop using =
IDEs that leave garbaged unuseful stashes, and that has to be taken into =
account as scenario. And the large repos. But this file event handlers =
thing is something that will make me lag to fix it, even surprised me =
because the remaining of the subroutines that I patched are just doing =
the same I typed, I just replicated near source (general revs =
processing) because I have no idea Tcl, even do not give a shit, but =
have to say Tcl is fun C: and an interesting discovery though. I hope =
that was not a trick to get me into improving the performance of the =
near loop that process ALL involved revs (and the similar for refs)! I'm =
old and tired to get into performance hacking.=20

I guess you know, the underworked grep must be an easy solve, probably =
excluding ' refs/stash' because a branch named 'refs/stash' is allowed =
but not a branch named ' refs/stash' (IDK which version I was trying but =
I will try both 1.x.y and 2.x.y in time).

Finally... if you don't leverage stashing too much, what is the =
practice? committing ephemeral to later reset and recommit? I hope I =
don't just needed a lesson on git-reset instead of all this.

Please pardon my potentially mangler mail client. Yours sincerely, =
regards and thanks for your time,

> On 12 Dec 2016, at 10:36, Paul Mackerras <paulus@ozlabs.org> wrote:
>=20
> Hi Uxio,
>=20
> On Thu, Sep 08, 2016 at 03:41:29PM +0200, Ux=C3=ADo Prego wrote:
>> Hello, please forgive me for not introducing me.
>>=20
>> +-----------+
>> |Description|
>> +-----------+
>>=20
>> Patch for showing all stashes in `gitk`.
>>=20
>> +-----------+
>> |The problem|
>> +-----------+
>>=20
>> Being `gitk` one of the best tools for navigating and understanding =
graphs
>> of git repo revs, I got used to have it for home use, some years ago, =
soon
>> for office use too.
>>=20
>> At some point I got used to invoke always `gitk --all` in order to =
keep
>> tracking of tags when using the program for building, when possible, =
stable
>> versions of any GNU/Linux software I would want to use.
>>=20
>> It seems `gitk --all` uses `git show-ref` for showing remotes =
information.
>> A side effect of this is that the most recent stash gets shown in =
`gitk
>> --all`. After learning what the stash was, I got used to it.
>>=20
>> Later, when at jobs, I got used to have a stash on all working branch =
tips.
>> So I often would have several stashes in `git stash list` but only =
the last
>> one in `gitk --all`. That annoyed me for about a year, finally I got
>> working in `gitk` to show a stash status more similar to what `git =
stash
>> list` shows.
>>=20
>> +-----------+
>> |The feature|
>> +-----------+
>>=20
>> Show all stashes in `gitk` instead of only the last one.
>=20
> This seems like a good feature, although I don't use stashes myself.
>=20
>> +------------------+
>> |Why it's desirable|
>> +------------------+
>>=20
>> In order to have better visual control when working on repos that =
have
>> several active branches and there are needed quick context changes =
between
>> them with the features that `git stash [apply [STASHNAME]| list | pop
>> [STASHNAME]| push | save | show [[-p] STASHNAME]]`.
>>=20
>> In order to have a better cohesion between the mentioned features and =
`gitk
>> --all`.
>>=20
>> +------------------------+
>> |Caveats and side effects|
>> +------------------------+
>>=20
>> With this patch several side effects happen:
>>=20
>> * Stashes are shown even invoking `gitk`, not only when running `gitk
>> --all`. If this is a problem, I can keep working in the patch to =
avoid this.
>>=20
>> * The most recent stash, which was previously shown as 'stash' =
because its
>> corresponding `git show-ref` output line reads 'refs/stash', gets =
shown as
>> 'stash@{0}'. Not removing lines with 'stash' when calling `git =
show-ref`
>> gets it shown both as 'stash' as usual and as 'stash@{0}'.
>>=20
>> +--------------------------+
>> |Non-obvious design choices|
>> +--------------------------+
>>=20
>> There are many improvable things consequence of never having edited
>> anything Tcl before this. Besides, its working for me as a proof of
>> concept, both in Debian 7 Wheezy and 8 Jessie.
>>=20
>> The origin document of the following diff is `gitk` as it ships in =
Debian 8
>> Jessie. I have not tried yet but if required I would be willing to =
rework
>> it for the repo master.
>=20
> A patch against the latest version in my git repo at
> git://ozlabs.org/~paulus/gitk would be better.
>=20
>> `gitk-stash-list-ids.sh` is a shell script that performs `git stash =
list
>> --pretty=3Dformat:"%H"`, i.e. show rev hashes for all stashes in the =
fashion
>> that `git rev-list --all` does its default output. I did this because =
I
>> could not work out a better pure Tcl solution.
>=20
> Hmmm, I don't want gitk to have to depend on an external script.
> It should be possible to make Tcl execute the git command directly,
> though (see below).
>=20
>> +--------------------+
>> |Unified diff follows|
>> +--------------------+
>>=20
>> 0:10:1473338052:uprego@uxio:~$ diff -u /usr/bin/gitk-deb8-vanilla
>> /usr/bin/gitk-deb8-multistash
>> --- /usr/bin/gitk-deb8-vanilla  2016-08-29 10:07:06.507344629 +0200
>> +++ /usr/bin/gitk-deb8-multistash       2016-09-08 14:36:35.382476634 =
+0200
>> @@ -401,6 +401,10 @@
>>=20
>>     if {$vcanopt($view)} {
>>        set revs [parseviewrevs $view $vrevs($view)]
>> +    set stashesfd [open [concat | gitk-stash-list-ids.sh] r]
>=20
> set stashesfd [open [list | git stash list {--pretty=3Dformat:%H}] r]
>=20
>> +    while {[gets $stashesfd stashline] >=3D 0} {
>> +        set revs [lappend revs $stashline]
>> +    }
>=20
> Could this ever take a long time?  The UI is unresponsive while we're
> in this loop.  If this is always quick (even on large repos), OK.  If
> it could take a long time then we'll need a file event handler.
>=20
>>        if {$revs eq {}} {
>>            return 0
>>        }
>> @@ -1778,7 +1782,7 @@
>>     foreach v {tagids idtags headids idheads otherrefids idotherrefs} =
{
>>        catch {unset $v}
>>     }
>> -    set refd [open [list | git show-ref -d] r]
>> +    set refd [open [list | git show-ref -d | grep -v stash] r]
>=20
> If I had a branch called "dont-use-a-stash-for-this", would it get
> filtered out by this grep?  It seems like it would, and we don't want
> it to.  So the filtering needs to be more exact here.
>=20
>>     while {[gets $refd line] >=3D 0} {
>>        if {[string index $line 40] ne " "} continue
>>        set id [string range $line 0 39]
>> @@ -1811,6 +1815,16 @@
>>        }
>>     }
>>     catch {close $refd}
>> +    set stashesidsrefsd [open [list | gitk-stash-list-ids-refs.sh] =
r]
>=20
> set stashesidsrefsd [open [list | \
> 	git stash list {--pretty=3Dformat:%H %gD}] r]
>=20
> Paul.

