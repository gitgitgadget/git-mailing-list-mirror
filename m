From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Tue, 26 Apr 2016 21:19:23 +0200
Message-ID: <CACBZZX5EtUU5UPXX=nuL29aV-m2nX1x9vtL07WD2yHkLku576g@mail.gmail.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
 <1461532702-4045-1-git-send-email-avarab@gmail.com> <xmqqlh41junh.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5X_7guR2b+uQFcxzzC6xCv55z=KiMUO6kEmJdQ-U1Gcw@mail.gmail.com> <xmqqvb34faed.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:19:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8WT-0001Sp-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbcDZTTp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 15:19:45 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36230 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbcDZTTo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 15:19:44 -0400
Received: by mail-qg0-f68.google.com with SMTP id f74so1603215qge.3
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F0VeGbKomxn/ynaZ60sml6U+mpJab9bKskBYe3zfmn4=;
        b=rZOZ8SIhZ1VL3HBVyitcXmG9KkinGA2FQ6Z0Gf0z3px2IfMJiuT7B8k4s1Ait0wTP/
         UokC6o67qgpVJspQ3w886g9de37Io1J7WH5tRtkCYjEYQBX84hgWH2ZtSAxMUs8aP9hy
         P2mafPclp9hmWtiar47dq1/HXeAnhbeiZfzR+aZhMqRfF+nsel6ZovOpnI4AqtX+ldQE
         hWH3F5FvnrTJRupGUJvzGJQUVQUDCKp8MfGZq6NRvMvxxDZu3b90qHosmv3Xoh8pb2KB
         rMeWf7tB/3TNuPfO8D7W/K8dnWy0OrUKX8Epy+t435nhSN+0jPZWJBr5j0GFNY9Qs6bq
         UTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F0VeGbKomxn/ynaZ60sml6U+mpJab9bKskBYe3zfmn4=;
        b=WY8DOVAiurMKk0TQ/tGL8vx2ScVgqoBSZZ2ZGxTwRuQfLBmTaK5ATyUJ9Q+XqpSCzc
         FdoAF6RxKW83NbyAc258Cf/a/b0wVRDNxb/z5ApkYg6E5eIDCrFEwrYR+ifoueyb3tTV
         O1S/ioLDSYzF+p5/XPOY3to6s9wCrLpkfNqjpqO+47Yl/rDwkMTSzJdi6rKlx/Vxz8hg
         fbW1rS+NaeSvm2osGuRgQOxIq+cryq7u2vSjDbTuD+Y4fA7BE0xrKTRYIr6hY7DSUnkq
         +hIFGdbJa2zlYKVnbFJGEzZs3ICaWeR6I6Qul1eDK7+PzigTNQ4Bip9W55BJbvz7TrkN
         1Y4g==
X-Gm-Message-State: AOPr4FU9fvK57qSQVk4sbDYyJW80g5tibk+3/pfgcPW9mkwTO9kwC7TjZUje/eXD5i+jcJJB2Z7tEleglWHqaQ==
X-Received: by 10.140.89.19 with SMTP id u19mr4063022qgd.90.1461698383274;
 Tue, 26 Apr 2016 12:19:43 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 12:19:23 -0700 (PDT)
In-Reply-To: <xmqqvb34faed.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292652>

On Tue, Apr 26, 2016 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> +The path can either be absolute or relative. In the latter case s=
ee
>>>> +the discussion in the "DESCRIPTION" section of linkgit:githooks[5=
]
>>>> +about what the relative path will be relative to.
>>>
>>> ... which does not seem to appear there, it seems?
>>
>> I think it does. Read on...
>
> I actually read the result of applying the patch before sending the
> review above.
>
>>>>  DESCRIPTION
>>>>  -----------
>>>>
>>>> -Hooks are programs you can place in the `$GIT_DIR/hooks` director=
y to
>>>> -trigger action at certain points. Hooks that don't have the execu=
table
>>>> -bit set are ignored.
>>>> +Hooks are programs you can place in a hooks directory to trigger =
action
>>>> +at certain points. Hooks that don't have the executable bit set a=
re
>>>> +ignored.
>>>> +
>>>> +By default the hooks directory is `$GIT_DIR/hooks`, but that can =
be
>>>> +changed via the `core.hooksPath` configuration variable (see
>>>> +linkgit:git-config[1]).
>>>
>>> The section talks about what the cwd of the process that runs the
>>> hook is, but it is not clear at all from these three lines in
>>> core.hooksPath description above how the cwd of the process is
>>> related with the directory the relative path will be relative to.
>>
>> I think the documentation mostly makes sense, but that the context o=
f
>> this patch is confusing.
>>
>> I.e. when I say:
>>
>>> The path can either be absolute or relative. In the latter case see
>>> the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
>>> about what the relative path will be relative to.
>>
>> In config.txt, I'm not talking about the patch to githooks.txt I'm
>> adding in this commit, but the first patch in the githooks.txt serie=
s,
>> i.e. this section:
>>
>>> When a hook is called in a non-bare repository the working director=
y
>>> is guaranteed to be the root of the working tree, in a bare reposit=
ory
>>> the working directory will be the path to the repository. I.e. hook=
s
>>> don't need to worry about the user's current working directory.
>>
>> I.e. I'm not talking about the "by default the hooks directory [blah
>> blah]" part I'm adding here.
>
> I know.  What it boils down to I think is this.
>
> If somebody said:
>
>     The path to the hooks directory can be specified relative, and
>     it is relative to something described elsewhere.
>
>     Hooks are run either at the root of the working tree or in
>     GIT_DIR, and they are not affected where the user's current
>     directory is (they cannot even know where it is).
>
> you interpret, with the knowledge that "we first determine in which
> directory to run a hook with a given name, go there, and then look
> for the named hook", the directory hooks are run in is NATURALLY the
> directory relative paths the hooks are found are relative to.
>
> My problem was that it is only natural if you have that knowledge.
>
> A reader who starts with a mindset "Git first finds the hook to run,
> and then goes to the directory to run it in", it is not naturally
> clear.  The latter is specified by two rules, one for a bare and the
> other for a non-bare repository, and it is very clear.  The former
> is specified nowhere, unless you give a hint to fix the mindset of
> such a reader.

Right. I changed the wording for all of this to hopefully be more
clear in my v4.
