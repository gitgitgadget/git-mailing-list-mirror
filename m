From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] rebase -i --autosquash: auto-squash commits
Date: Sat, 20 Jun 2009 10:46:40 +0900
Message-ID: <20090620104640.6117@nanako3.lavabit.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<7vvdmu15j0.fsf@alter.siamese.dyndns.org>
	<20090619065534.6117@nanako3.lavabit.com>
	<18DDBEE4-8107-4E0D-B503-0F3BB0A81DC9@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	John Tapsell <johnflux@gmail.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 03:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHpgi-0001h0-SN
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 03:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZFTBsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 21:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZFTBsA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 21:48:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36816 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbZFTBr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 21:47:59 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 954E211B7CB;
	Fri, 19 Jun 2009 20:48:01 -0500 (CDT)
Received: from 9630.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 3HPIVZS4IDPA; Fri, 19 Jun 2009 20:48:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=IeIOwXdQCA0xcgfoJqSROrq75FKPU90SX/Qx3+EMJIpLmV5rfLqrv3EW6DI8uQOHJ7UuYJoWsPuU1XnKvRPjpKuguu3hkR2vxQFUe7iIXXk9U7LLk4W/jHxdKn2Jbf3tAdJ8gZk0esiCS3okzrSw3xi/knhwVZkru3vCYzEtNiw=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <18DDBEE4-8107-4E0D-B503-0F3BB0A81DC9@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121921>

Quoting Wincent Colaiuta <win@wincent.com>:

> El 18/6/2009, a las 23:55, Nanako Shiraishi escribi=C3=B3:
> ...
>> This will help the use case outlined in
>>
>>    From: Junio C Hamano <gitster@pobox.com>
>>    Date: Wed, 17 Jun 2009 09:33:19 -0700
>>    Subject: Re: git rebase --interactive squash/squish/fold/rollup
>>    Message-ID: <7vvdmurfao.fsf@alter.siamese.dyndns.org>
>
> Definitely a fairly common workflow for me. Faced with a sequence lik=
e
> this:
>
> 	[1/3] Cleanup
> 	[2/3] Lay groundwork
> 	[3/3] Implement feature
> 	[4/4] Doh! more cleanup that should have gone in [1/3]
>
> I usually just let 4/4 stand as a separate commit with a message like=
:
>
> 	More cleanup of XYZ
>
> 	Ideally this should have been included in commit abcd1234,
> 	but wasn't noticed until too late.
>
> Seeing as I'm not perfect, I don't necessarily spend time manipulatin=
g
> the history to make it appear that I really am perfect.

I don't think it is about pretending to be perfect.
If you are preparing a patch series to be reviewed, it is a minimum req=
uired courtesy to the reviewers to remove such earlier mistakes before =
submitting.
It is called "making your series presentable."

> Even so, if asked to imagine an ideal workflow for this scenario, I
> don't really want a new switch for "git rebase -i", but rather the
> ability to do "git commit --amend" on a non-head commit. (I know this
> has come up on the list back in February under the subject "FEATURE
> suggestion git commit --amend <ref>".)

I think you didn't read the explanation by Junio (the second message I =
quoted) why that is only one of the options, and isn't a satisfying sol=
ution for him. He explicitly said that he doesn't want his momentum dis=
rupted by having to go back before he finishes the series, while admitt=
ing that the way you suggest may fit other people's workflow better.

As to the extra option, I don't like it, either (my original patch didn=
't have it). I added it only because Johannes Schindelin objected to th=
e patch that the feature can trigger unexpectedly.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
