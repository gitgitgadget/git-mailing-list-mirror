From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] hooks: Add ability to specify where the hook directory is
Date: Tue, 26 Apr 2016 12:16:42 -0700
Message-ID: <xmqqvb34faed.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX7jTHqSq0ADJxO0cP+1MZMWAowLMMj4J0NHkFTYOYsJiw@mail.gmail.com>
	<1461532702-4045-1-git-send-email-avarab@gmail.com>
	<xmqqlh41junh.fsf@gitster.mtv.corp.google.com>
	<CACBZZX5X_7guR2b+uQFcxzzC6xCv55z=KiMUO6kEmJdQ-U1Gcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 21:16:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8Ta-0000GA-BB
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbcDZTQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 15:16:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752226AbcDZTQp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 15:16:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 35A1C15760;
	Tue, 26 Apr 2016 15:16:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=02jkAT8drjko
	O0V7ADQ5oar730E=; b=BepCKfJfJ2ixIWNrwrovYnHrX38CIXEDKAzSGEw5Syfr
	ORfx+2ZZ0s7G7Wr9QXGvkntsQMP/x5lShS22YOHb1YQDxgfWaWz4p5wdmElHSJf9
	eoRCt/LQC78PiO1yOOStVk+DuJdXins1lvp42OzUdYbMOSyQSFWmIIBxMIVG7gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ijc114
	64iktABiV33vuIVxwNoFv83lhe5MnKN5nc3t3JNKwhrrmKphmlWYYEkiwz1MX/v6
	lDrXa0sYhXgsw/mOewUlXXiFLZcBuL7fBV/8NBV8ErxhKK+pjnC84XsFXgsj7sRO
	fsSjk0csnwKZeQcx36+xZLe6tiulyhL4sEtFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C9EC1575F;
	Tue, 26 Apr 2016 15:16:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D8CD1575E;
	Tue, 26 Apr 2016 15:16:43 -0400 (EDT)
In-Reply-To: <CACBZZX5X_7guR2b+uQFcxzzC6xCv55z=KiMUO6kEmJdQ-U1Gcw@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 26 Apr
 2016 18:31:55
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6971F814-0BE3-11E6-895D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292650>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> +The path can either be absolute or relative. In the latter case se=
e
>>> +the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
>>> +about what the relative path will be relative to.
>>
>> ... which does not seem to appear there, it seems?
>
> I think it does. Read on...

I actually read the result of applying the patch before sending the
review above.

>>>  DESCRIPTION
>>>  -----------
>>>
>>> -Hooks are programs you can place in the `$GIT_DIR/hooks` directory=
 to
>>> -trigger action at certain points. Hooks that don't have the execut=
able
>>> -bit set are ignored.
>>> +Hooks are programs you can place in a hooks directory to trigger a=
ction
>>> +at certain points. Hooks that don't have the executable bit set ar=
e
>>> +ignored.
>>> +
>>> +By default the hooks directory is `$GIT_DIR/hooks`, but that can b=
e
>>> +changed via the `core.hooksPath` configuration variable (see
>>> +linkgit:git-config[1]).
>>
>> The section talks about what the cwd of the process that runs the
>> hook is, but it is not clear at all from these three lines in
>> core.hooksPath description above how the cwd of the process is
>> related with the directory the relative path will be relative to.
>
> I think the documentation mostly makes sense, but that the context of
> this patch is confusing.
>
> I.e. when I say:
>
>> The path can either be absolute or relative. In the latter case see
>> the discussion in the "DESCRIPTION" section of linkgit:githooks[5]
>> about what the relative path will be relative to.
>
> In config.txt, I'm not talking about the patch to githooks.txt I'm
> adding in this commit, but the first patch in the githooks.txt series=
,
> i.e. this section:
>
>> When a hook is called in a non-bare repository the working directory
>> is guaranteed to be the root of the working tree, in a bare reposito=
ry
>> the working directory will be the path to the repository. I.e. hooks
>> don't need to worry about the user's current working directory.
>
> I.e. I'm not talking about the "by default the hooks directory [blah
> blah]" part I'm adding here.

I know.  What it boils down to I think is this.

If somebody said:

    The path to the hooks directory can be specified relative, and
    it is relative to something described elsewhere.

    Hooks are run either at the root of the working tree or in
    GIT_DIR, and they are not affected where the user's current
    directory is (they cannot even know where it is).

you interpret, with the knowledge that "we first determine in which
directory to run a hook with a given name, go there, and then look
for the named hook", the directory hooks are run in is NATURALLY the
directory relative paths the hooks are found are relative to.

My problem was that it is only natural if you have that knowledge.

A reader who starts with a mindset "Git first finds the hook to run,
and then goes to the directory to run it in", it is not naturally
clear.  The latter is specified by two rules, one for a bare and the
other for a non-bare repository, and it is very clear.  The former
is specified nowhere, unless you give a hint to fix the mindset of
such a reader.
