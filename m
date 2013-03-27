From: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 00/15] Use =?UTF-8?Q?test=5Fconfig?=
Date: Wed, 27 Mar 2013 17:19:34 +0100
Organization: OPTEYA
Message-ID: <ec6c6b2101cf035b5dea7f7110ddf706@meuh.org>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <1363704914.6289.39.camel@test.quest-ce.net>
 <loom.20130321T212911-611@post.gmane.org>
 <cdc4f45e7520ce1fc48588c260214717@meuh.org>
 <1363946943-30269-1-git-send-email-ydroneaud@opteya.com>
 <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
 <7vmwtoq3xb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKt54-00029e-OX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab3C0QTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Mar 2013 12:19:38 -0400
Received: from mx-out.ocsa-data.net ([194.36.166.37]:59525 "EHLO
	mx-out.ocsa-data.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab3C0QTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:19:37 -0400
Received: from [192.168.111.12] (helo=rc.ouvaton.coop)
	by mx-out.ocsa-data.net with esmtpa (Exim - FreeBSD Rulez)
	id 1UKt4Y-00058S-7M; Wed, 27 Mar 2013 17:19:34 +0100
In-Reply-To: <7vmwtoq3xb.fsf@alter.siamese.dyndns.org>
X-Sender: ydroneaud@opteya.com
User-Agent: Roundcube Webmail/0.8.4
X-abuse-contact: abuse@ocsa-data.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219268>

Hi,

Le 27.03.2013 16:05, Junio C Hamano a =C3=A9crit=C2=A0:
> Yann Droneaud <ydroneaud@opteya.com> writes:
>
>> Tested against master, 7b592fadf1e23b10b913e0771b9f711770597266
>
> Is this because I suggested you to clean things up while you were
> touching in a vicinity of something that could use this clean-up?
>

Yes, grep'ing shows others usage of the test_config pattern. I patched=20
them all.

> If so, please first clean _that_ script in a patch, and then add the
> change you wanted to do in another patch, as a single two-patch
> series, without touching anything else that is not related to that
> change.  The patch to t7600 is the one that needs to become two
> patches, one to clean up and the other to add tests for --no-ff.
>

Actually the initial patch adding test for --no-ff-only is not part of=20
this series.


Patch against t7600 has a special note about a strange behavor found=20
while testing
test_config "anyware", that's why there's somes line added to the test=20
and a note
in the commit message.

I was waiting for your opinion on this change in the test, but more, on=
=20
the difference
of behavior exhibited in the patched test "merge log message":

   git merge --no-log
   git show -s --pretty=3Dformat:%b HEAD

vs

   git merge --no-ff --no-log
   git show -s --pretty=3Dformat:%b HEAD


=46irst produce an empty file, while the second produce an empty line.

This was revealed by changing test "merge c0 with c1 (ff overrides=20
no-ff)
-    git config branch.master.mergeoptions "--no-ff" &&
-    test_config branch.master.mergeoptions "--no-ff" &&


I could split this patch in a first patch that add the behavor test to=20
"merge log message" test,
than I could rebase the patch series against.
And later, submit my proposition for new tests in t7600 regarding=20
--no-ff-only and tags.

> The rest, as a separate "only cleaning up, doing nothing else"
> series, are fine as a follow-up, but please make sure that they do
> not touch anything in-flight (one easy way to check is to see "git
> diff --name-only maint pu -- t/").  I would prefer to see "clean-up
> only" changes that introduce unnecessary conflicts with other real
> features and fixes held off until the dust settles.
>

It's a good advice that fit perfectly in=20
Documentation/SubmittingPatches.

Regards.

--=20
Yann Droneaud
OPTEYA
