From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Tue, 08 Mar 2016 10:10:35 -0800
Message-ID: <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
	<20160304055117.GB26609@ikke.info>
	<1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
	<20160304115634.GC26609@ikke.info>
	<CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
	<xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
	<xmqqlh5ungct.fsf@gitster.mtv.corp.google.com>
	<xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
	<CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:11:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adM5y-00061u-Q9
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcCHSKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:10:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbcCHSKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:10:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B9D549428;
	Tue,  8 Mar 2016 13:10:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qWxGVT+8YxsPXC4AWhHKoJqL/YQ=; b=ND0szs
	PGXEB0QRSkGHcOCMkhWWkSVRRUjteolCPjH5FjrFMPQoJlhf4HD1gtnfm+BMva+U
	5aBKOmR0Ca26aHqMYv3uvxuNRCrjBH9wQEvseZ92Gd8kt0Nnn9l/34cQulYFcpAH
	hO9P2KGw+5U2DP6cJOLOoTZYIJudjnWHkPlS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C5oNgIaTnqn251VeCV2umgaCPjyIhkKW
	b1fSXCtA+2M/z6/8uNAAEtz82TRB9oFf0IxQwJG3YeeVXEE7SZEb2SVqNcrhvSvc
	uGiJtM/FYJFtBjAIsZYbbnH5ztsmPBQKId1j6ev/C7XYVJcV3wbjEJWm6eQq/2Tp
	bmtC/AXlMDc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FA5F49427;
	Tue,  8 Mar 2016 13:10:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EF5849423;
	Tue,  8 Mar 2016 13:10:37 -0500 (EST)
In-Reply-To: <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Mar 2016 17:19:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0F17E104-E559-11E5-AB0C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288444>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 8, 2016 at 1:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> We need documentation update to settle this one before 2.8 final
>>> ships, as we seem to be seeing more and more end-user confusion on
>>> the list.  I tried to come up with a trimmed-down example, which is
>>> shown below, but I suspect that the code is not exactly working the
>>> way it is described in that (1) dir/file1 is ignored and (3)
>>> !dir/file3 entry makes difference.
>>>
>>> Where did my example go wrong?
>>>
>>> FYI, if I prefix '/' to all the .gitignore entries in the example, i.e.
>>> making it
>>>
>>>     *
>>>     !/dir
>>>     /dir/file2
>>>     !/dir/file3
>>>
>>> instead, then dir/file1 and dir/file3 do get shown as unignored.
>
> Arghhh.. bug!!!
>
> The difference between "dir" and "/dir" is, the former is basename
> matching while the latter is pathname matching. When we check
> dir/file1 after we enter "dir", we do try to check rule "!/dir" (or
> "!dir") before rule "*". In the pathname matching case, it works
> thanks to a60ea8f.

So what do we want to do for the upcoming release?  I am OK to leave
the code as-is for now and describe it as a known bug that is still
being worked on (as long as it indeed is being worked on, that is),
as the desired endgame of making "!dir" act in a way more similar to
how "dir" acts does sound sensible.

If we are going that route, perhaps something like this is the
minimum we would need before 2.8 final.

Thoughts?


 Documentation/gitignore.txt | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 3ded6fd..91d1ce2 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -148,7 +148,43 @@ excluded, the following conditions must be met:
    be in the same .gitignore file.
 
  - The directory part in the re-include rules must be literal (i.e. no
-   wildcards)
+   wildcards and has to start with a `/`).
+
+A re-inclusion of a directory makes all files in the directory
+unignored.  For example, suppose you have files `.gitignore`,
+`dir/file1`, `dir/file2`, and `dir/file3`, and have the following in
+your `.gitignore`:
+
+----------------
+# .gitignore is not mentioned in .gitignore
+*
+!/dir
+# dir/file1 is not mentioned in .gitignore
+dir/file2
+!dir/file3
+----------------
+
+Then:
+
+ - `.gitignore` gets ignored, because it matches the `*` at the top
+   level;
+
+ - `dir/file1` does not get ignored, because `/dir` marks everything
+   underneath `dir/` directory to be 're-included' unless otherwise
+   specified;
+
+ - `dir/file2` gets ignored, because `dir/file2` matches it.
+
+ - `dir/file3` does not get ignored, because `!dir/file3` matches it.
+   Note that the entry `!dir/file3` is redundant because everything
+   underneath `dir/` is marked to be 're-included' already.
+
+Some earlier versions of Git treated `!/dir` above differently in
+that it did not cause the paths under it unignored (but merely told
+Git that patterns that begin with dir/ should not be ignored), but
+this has been corrected to be consistent with `/dir` that says "the
+directory `dir/` and everything below are ignored."
+
 
 EXAMPLES
 --------
