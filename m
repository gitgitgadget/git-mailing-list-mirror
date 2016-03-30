From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG] `git submodule update --init --recursive` stores gitdir in
 full path into `.git` of nested submodules
Date: Wed, 30 Mar 2016 10:24:25 -0700
Message-ID: <CAGZ79kZwSFjADYYC=FBFr8cWv08mv+H7E=Bx3N=J2Q_o8sK9qw@mail.gmail.com>
References: <F89ED33B-E33D-4693-8559-4255727B78B8@gmail.com>
	<CAGZ79kaa2uBmRZ_OPG9hVkrc29uj8Lx9b-6fgbcDNE0OGvJ+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Norio Nomura <norio.nomura@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:24:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJrH-000113-2y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbcC3RY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 13:24:27 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33473 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbcC3RY0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 13:24:26 -0400
Received: by mail-ig0-f178.google.com with SMTP id ma7so71192149igc.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=A1eylELd9hxOO0XXudz5NqVhJk+bhgxkW88cQgUbVnM=;
        b=GKJ16c9T7kTpiKLO1bxAidupzS5cCT3yZmNR3LEBLHlV1nO97hQaJ5RSJmYmOSx610
         bFoOzDOyw0xIZe9Ip5Fnoaxc8ZLWkeYRmCb+TJsKZhdm5wOH6NlY+rN95Lkrhy6tDIdN
         0DXszBYddM2VvPgRBtZ5+b5hCMs/5KOmmp53McRXPw8hWkVdv0N3xWiTgyXJzIpUdl31
         dC1lP8u1pQuaNHwdL2sHGdpkh0bA2zIDM4ybgT88VyMBsj9B5oAdV7Ks0P9fZy15BM7F
         asBHaiBeB2QeP/yk259V3heg59LNU49ssqEYWTO2T/RHgd96OtdKmp3G+tmgT7U1EPjH
         y0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=A1eylELd9hxOO0XXudz5NqVhJk+bhgxkW88cQgUbVnM=;
        b=JsFA1vf4RIeZP065xa8g4XT2lU9tXYGetIBPN9GdqN0OHWgQww6tLfzfngknatZoQc
         1ssvEOzfzUzrKq+AsVa5fmmPTq41FXnFOW2TymFo4dB5uD//JNxm3mxk1I1Ox3O3BIZi
         TyRqbvCAp9RZ73BaZKvDHRhFGE6eQg7wwnNi3T1z2SiPuvt1mhbZzSUQZrGs6zpqk8YZ
         LUSBRZSD9YmtjwQ+mgV+hnv15wWIZFaCzkeLRu5RN/nwuOumO6tCFfNZnUl0KEZcRzdK
         jM1qNZJIca27c4+Z3JbWyC9OQes/P9NnkxWr8Y4GijY6CuaIhBMJeyOJDsLnND5LzBzT
         PCJg==
X-Gm-Message-State: AD7BkJKfNWUDHPDAoMmwlWcvxjivexo05mU+YFY1RLR14y+5+e5av2FS7hdLrOpYJhReF/kW8OHSUKNmsToFdKiy
X-Received: by 10.50.13.36 with SMTP id e4mr24225479igc.85.1459358665215; Wed,
 30 Mar 2016 10:24:25 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 10:24:25 -0700 (PDT)
In-Reply-To: <CAGZ79kaa2uBmRZ_OPG9hVkrc29uj8Lx9b-6fgbcDNE0OGvJ+cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290325>

On Wed, Mar 30, 2016 at 9:05 AM, Stefan Beller <sbeller@google.com> wro=
te:
> On Wed, Mar 30, 2016 at 2:03 AM, Norio Nomura <norio.nomura@gmail.com=
> wrote:
>> Hi,
>>
>> `git submodule update --init --recursive` stores `gitdir` in full pa=
th into `.git` of nested submodules.
>> So, working directory is not portable to another directory.
>
> Are you reporting a regression bug? (Is that a new thing or has it
> always been that way and you just discover that it is unfortunate?)
> Which versions did you test with?

=E2=9E=9C  15:34:32 git:(master) git --version
git version 2.8.0

at the end of your gist.
The same happens when using 2.7.4, it doesn't happen when using 2.6.6 t=
hough.

It turns out ee8838d (2015-09-08, submodule: rewrite `module_clone`
shell function in C)
broke it.

I'll look into fixing it.

Thanks,
Stefan


>
>>
>> On following example, `Carthage/Checkouts/Quick/Externals/Nimble/` i=
s nested submodule and `Carthage/Checkouts/Quick/Externals/Nimble/.git`=
 contains full path.
>> https://gist.github.com/norio-nomura/17ce4bdf0151185e77d9b1fcfb5a469=
d
>>
>> Thanks,
>> --
>> Norio Nomura @norio_nomura
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
