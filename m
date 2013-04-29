From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Mon, 29 Apr 2013 09:32:51 -0700
Message-ID: <7vhaipl2ks.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<7vvc7baahc.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
	<CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
	<7vppxj6thv.fsf@alter.siamese.dyndns.org>
	<CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 18:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWr0t-00059i-M7
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab3D2Qcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 12:32:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab3D2Qcy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 12:32:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 994BA19C1B;
	Mon, 29 Apr 2013 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=A95Q1Z6qjSx3MD9fMMhWf8MwB4Y=; b=q88B238cO2YRl07VTPdj
	xe3NhCNCyofyz6i67+BmMfTB6ATVBnTsrTo5tzGdi8tmthKIz87aDe5FrlEF4IdC
	VRvy3SmMj4WSBnpolDFdmnGZaC3E2yVKDv9NkrsD4GkvJHoxoNi+IAk/j76cquMw
	IUjHuzaxhtos8Pl5lnx4J8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=kFAjliukEnuyhG9we5eYufWZXXe20Rpt/E8TTttW2gbXaE
	a48R+1t3gjacNPkqhfXMgGTFWJ4DajYhAmqLYqqUrvdO+gz4n2G2pxzMFhZvkaVP
	1BKp7vZFPVDmqeLu4gMsQoKUM6s06bFioGX3HS6c5rG28Nl4zydl/Dp3Q2ZwM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90E1F19C19;
	Mon, 29 Apr 2013 16:32:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB3BE19C17;
	Mon, 29 Apr 2013 16:32:52 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 705B8796-B0EA-11E2-BC8A-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222808>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Okay, so the point I was trying to make is:
>
> The range version of $(git merge-base A B) B is B ^$(git merge-base A
> B), and not B --not $(git merge-base --all A B) [which is equivalent
> to B ^A or A..B].
>
> Junio C Hamano wrote:
>> I dunno.  The description you gave was insufficient for me to answer
>> that question.
>
> Sorry about that.  I'll rewrite it as a set of commands:

[now that a few days have passed...]

Please don't.  All of these clayoven, LICENSE, foom, loom are mere
distraction.

	... goes and draws the diagram himself ...

   > $ git clone gh:artagnon/clayoven
   > $ cd clayoven
A  > $ git checkout -b pu master~10
   > $ echo "foom" >>LICENSE
B  > $ git commit -a -m "Change in pu"
C  > $ git checkout -b rebase.autostash master~5
   > $ echo "loom" >> clayoven.gemspec
D  > $ git commit -a -m "Change in rebase.autostash"
E  > $ git checkout master
F  > $ git merge pu
   > $ git checkout rebase.autostash
G  > $ git merge pu
   > $ echo "quux" >>Gemfile
H  > $ git commit -a -m  "Change 2 in rebase.autostash"

So you have this:

                        (pu)        (master-updated)
        .-----------------B--------------F
       /                   \            /
      /                 D---G---H      /
     /                 /              / 
 ---A-----------------C--------------E
  (master~10)     (master~5)      (master-old) 

In the beginning, master was at E, but at the end, it is moved to
F. The tip of your topic is at H.

> $ git log rebase.autostash ^master

That is range "F..H", which lists "H G D".

> $ git log rebase.autostash --not $(git merge-base --all rebase.autostash master)

The merge bases between F and H are B and C, so that is
range "^B ^C H", which again lists "H G D".

> $ git log rebase.autostash ^$(git merge-base rebase.autostash master)

Depending on which one of B or C is chosen it is either one of these:

 - range "^B H" which lists "H G D C"
 - range "^C H" which lists "H G D B"

neither of which is more useful than "H G D", as it shows irrelevant
"other merge base" you did not pick.

> $ git diff rebase.autostash ^$(git merge-base rebase.autostash master)

This will show either "diff B H", which is work done by G and H, or
"diff C H", which is work done by D thru H.  In the former, "the
work done by G" includes what was done by A..D, which are mostly
irrelevant to explain what you did on your topic, but you asked for
it.  In the latter, "the work done by G" is what was done by A..B,
which again are not what D and H did.

The example explains why you should not merge other's work to your
topic branch [*1*], but does not say anything about usefulness of
A...B vs A~B.

> To summarize: B ^(git merge-base A B) [the current ... syntax of git
> diff] has no exact equivalent in the log world.  

Nor does "log" need one.  See how picking either B or C and omitting
the other would produce worse result than excluding all merge bases,
which log F..H would naturally does.

> Therefore, no matter
> which existing rev spec we overload, we can never get the current ...
> for diff in a consistent manner.

As "log" does not need any such thing, that is irrelevant, no?

> We certainly know that 'git diff A~B' is going to be useful,...

We certainly know it is an unnecessary "there is another way to
spell the same thing we have been using for a long time".

You did not give anything new that hints that it might be worth
spending time listening to you in this message. Should I do a "kill
file for a few days" thing again?


[Footnote]

*1* Instead, you have a separate integration branch for testing that
merges other's work and your topic.
