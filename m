From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Test 17 of `t9119-git-svn-info.sh' fails with svn 1.6.9
Date: Thu, 01 Jul 2010 12:26:44 +0200
Message-ID: <4C2C6D64.4060802@drmicha.warpmail.net>
References: <8739w3fupp.fsf@ft.bewatermyfriend.org>	<4C2C5D2F.90000@drmicha.warpmail.net>	<87y6dveekn.fsf@ft.bewatermyfriend.org>	<4C2C647F.7090909@drmicha.warpmail.net> <87pqz7ec79.fsf@ft.bewatermyfriend.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Eric Wong <normalperson@yhbt.net>
To: Frank Terbeck <ft@bewatermyfriend.org>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:27:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGzc-0006GA-CM
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab0GAK1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 06:27:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33540 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754849Ab0GAK1e (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 06:27:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8EF5910ADAB;
	Thu,  1 Jul 2010 06:27:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 01 Jul 2010 06:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3eCO7Rlr90tGDBHAOSvI69OJMPw=; b=Y47Px/QkU0yWxnNJdc6BPCiLsyov9UOVaAYuQ3JuPJp10NsRYGiTVOzHvsCla+g+JdP8c6DNac0Srpwzx7VDFCok0W8O/lA4FChpYXgiygRTVzG9Omq5RKqSawsYCdwcn+LYv5+I8k1FdfvynUmAXfw3E+320BUn59h0uOscIe8=
X-Sasl-enc: B6BBSYcx8T6wdvnASRfMOlrO4maq5O7BuvGb3OexUq0K 1277980053
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B53A15D4F4;
	Thu,  1 Jul 2010 06:27:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <87pqz7ec79.fsf@ft.bewatermyfriend.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150027>

=46rank Terbeck venit, vidit, dixit 01.07.2010 12:19:
> Michael J Gruber wrote:
> [...]
>>> And a unified diff of the two:
>>> [snip]
>>> --- trash directory.t9119-git-svn-info/actual.info-added-directory =
2010-07-01 11:22:16.000000000 +0200
>>> +++ trash directory.t9119-git-svn-info/expected.info-added-director=
y 2010-07-01 11:22:16.000000000 +0200
>>> @@ -1,6 +1,7 @@
>>>  Path: added-directory
>>>  URL: file:///usr/src/sys/git/t/trash%20directory.t9119-git-svn-inf=
o/svnrepo/added-directory
>>>  Repository Root: file:///usr/src/sys/git/t/trash%20directory.t9119=
-git-svn-info/svnrepo
>>> +Repository UUID: 638d0b70-c7df-46bd-9c56-aff8052b4ab8
>>
>> "Nachtigall, ick h=C3=B6r Dir trapsen." [I really don't know how to =
translate
>> this...]
>=20
> No need. :)
>=20
>> Anyway, this is something I had fixed previously before realizing it
>> doesn't need a fix and something else is wrong:
>>
>> It indicates that Git's svn-bindings (git-svn) use a different svn
>> version than the actual "svn". (There used to be a bug where Git was
>> wrong about the version of the bindings but that is fixed.)
>>
>> Do the following agree for you:
>>
>> git svn --version
>> svn --version
>>
>> Do you have any private copies of svn/svn bindings in your path or p=
erl
>> path?
>=20
> Okay, it wasn't really a private copy, but you're otherwise
> spot-on. Here's what was wrong:

Turns out you cc'ed the right persons :)

>=20
> I didn't realise, `git-svn' was using Perl's subversion bindings. Thi=
s
> happens on my laptop which runs debian stable (lenny). I was upgradin=
g
> my subversion package to the one provided by backports.org (a service
> that provides backports of newer versions of certain software package=
s
> to debian stable). While that worked nicely, the subversion bindings =
for
> Perl are provided by a package called `libsvn-perl' which was kept at
> the version in stable, which is 1.5.1. Backports.org also provides an
> upgrade for that package. Now both "svn --version" and "git svn
> --version" report the same subversion version and the test passes aga=
in.
>=20
>=20
> Maybe it would be good if git-svn or maybe just the test suite checke=
d
> whether subversion's and the Perl binding's version matched?

Then you would not be able to use git-svn with your setup!

Having svn and its bindings at different versions is perfectly fine for
git-svn: it uses and cares about the bindings only (and adjusts
according to the binding's version).

It's only the test suite which cares, because it tries to make sure tha=
t
"svn" and "git-svn" behave as similar as possible.

We should probably check in the test suite before triggering false
alarms, I'll look into that.

Cheers,
Michael
