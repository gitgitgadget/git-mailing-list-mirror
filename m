From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Documentation/gitignore: "foo/" patterns match
 directories, not files under them
Date: Mon, 07 Nov 2011 08:53:28 -0800
Message-ID: <7vty6f27sn.fsf@alter.siamese.dyndns.org>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net>
 <20111107080711.GA30486@elie.hsd1.il.comcast.net>
 <CACsJy8CZFihbS8MrG=0gWdRPu6F0BqG2FLp48KDxOXWc+4amuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>, Johannes Sixt <j6t@kdbg.org>,
	"Y.G." <yamomo1@hotmail.com>, Eli Barzilay <eli@barzilay.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSRz-0000AX-U1
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265Ab1KGQxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 11:53:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55655 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab1KGQxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 11:53:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C22F45AD;
	Mon,  7 Nov 2011 11:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M0g6/RI7NwZ4
	mJ5BIp48Lq5CN4c=; b=MkD4j9ChF4rElHhNF7Yw6uCr4kkaq+dQn3j2Ooqpz/lf
	7yiXkKuTA0cmrbUKhwXurcIj6VeGwBP8gQPEh504JAvMd+a5RBwJV4Ft9wIK/jaW
	yDwH+W9jk4FZJqdczYJQCLH40YeCbN2rbAyo/p6uQksu7syB33yOJUSmuPvnppM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZSUwbz
	tmvfj7AUlgCqKWycLxbHFycGo4RypdH+6tf46Rg0XN3kHvN86Ij2bt1fLLQHjGVU
	uE/EKXeenLKc1VsTFr0LzE0D8FWW0TlrJIgt8w/g6hgN5mZLXBbJ2ehDBguQY8pW
	gQNyMbe15Fya04dgiL417VHfwyNK/IZICDfSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2086145AC;
	Mon,  7 Nov 2011 11:53:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EA6745AB; Mon,  7 Nov 2011
 11:53:29 -0500 (EST)
In-Reply-To: <CACsJy8CZFihbS8MrG=0gWdRPu6F0BqG2FLp48KDxOXWc+4amuQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 7 Nov 2011 16:57:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04C2EF74-0961-11E1-A19E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184998>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/11/7 Jonathan Nieder <jrnieder@gmail.com>:
>> The gitignore(5) manpage says that "foo/" will match a directory foo
>> and paths underneath it.
>
> If git ignores a directory, then it essentially ignores all paths
> underneath it, doesn't it?
>
>> But that is completely false: as Johannes
>> Sixt likes to remind us, patterns with a trailing '/' match the name=
d
>> directory, not files under that directory. =C2=A0For example, the fo=
llowing
>> .gitignore file
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/build/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0!/build/tests/results
>>
>> does not un-ignore build/tests/results since it was never ignored in
>> the first place; and commands like "git status" will not notice
>> changes to build/tests/results because git doesn't enter the (ignore=
d)
>> build/ directory.
>
> I haven't checked but I think it's because when a directory is
> ignored, git just stops checking further ignore rules. So "build" _is=
_
> ignored, too strongly that it does not care if some files may need to
> be un-ignored later on.
>
> I remember the argument was, because ignore rules are distributed
> across .gitignore files, we would need to go into ignored directories
> for collecting potential un-ignore rules (for example "!results" on
> build/tests/.gitignore) and that just does not make much sense becaus=
e
> we always have to go into ignored directories.
>
> But in your example, where we know we have negated rules, we should
> follow the rules and ignore all but build/tests/results.
>
>> Correct the manual to just say that "foo/" matches the directory
>> "foo", and make the wording a little clearer in other ways while at
>> it.
>
> I haven't not read the next patches, maybe you have mentioned this
> already. We should make clear that git does not look for negated rule=
s
> once a directory is ignored.
>
> Your example however demonstrates a bug that should be fixed in my
> opinion. So maybe one or two lines under BUGS section.
>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> =C2=A0Documentation/gitignore.txt | =C2=A0 14 ++++++++------
>> =C2=A01 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.t=
xt
>> index 2e7328b8..5b070bf0 100644
>> --- a/Documentation/gitignore.txt
>> +++ b/Documentation/gitignore.txt
>> @@ -72,12 +72,14 @@ PATTERN FORMAT
>> =C2=A0 =C2=A0included again. =C2=A0If a negated pattern matches, thi=
s will
>> =C2=A0 =C2=A0override lower precedence patterns sources.
>>
>> - - If the pattern ends with a slash, it is removed for the
>> - =C2=A0 purpose of the following description, but it would only fin=
d
>> - =C2=A0 a match with a directory. =C2=A0In other words, `foo/` will=
 match a
>> - =C2=A0 directory `foo` and paths underneath it, but will not match=
 a
>> - =C2=A0 regular file or a symbolic link `foo` (this is consistent
>> - =C2=A0 with the way how pathspec works in general in git).
>> + - If the pattern ends with a slash, it will only match
>> + =C2=A0 directories. =C2=A0In other words, `foo/` will match a
>> + =C2=A0 directory `foo` but will not match a regular file or a
>> + =C2=A0 symbolic link `foo` (this is consistent with the way
>> + =C2=A0 pathspecs work in general in git).
>
> Looks good.

Or just remove "In other words, ..." that is bogus. Everything before t=
hat
is correct.

>> ++
>> +The trailing slash is removed before applying the remaining
>> +rules.
>
> Why does the trailing slash of a rule affect the remaining rules?

Later rule makes a path with and without a slash in it work differently=
=2E
A single token "foo/" acts as if there is no trailing slash to match
any directory in the hierarchy, e.g. it matches a directory "frotz/foo"=
=2E
