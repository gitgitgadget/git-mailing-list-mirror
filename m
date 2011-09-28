From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 13:40:58 +0000
Message-ID: <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net> <7vpqiltsky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 28 15:41:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8uOF-0005qs-P2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 15:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab1I1Nla convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 09:41:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44056 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab1I1Nla convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 09:41:30 -0400
Received: by qyk30 with SMTP id 30so2302383qyk.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3rXI6VeVsgwg9MSzayT6BSAGRHwOVUdnEZD4jWVP5e8=;
        b=D+nbC9lrfm+7J7LnZWWmtWTheLVEPw1U0oIHgs+5FwspaO9n3r8HlHOZeBrrf+YXTv
         HLsLAFI28hp8SN17v7hLPNYemZ31s1FQgjk/X6Spzfrmucjsh9U9MFJx3FJeO48wN2GR
         sSeY5OIq3h1cINuVTq85WhoJJGL+H35jBPh+E=
Received: by 10.224.201.2 with SMTP id ey2mr5910892qab.3.1317217289133; Wed,
 28 Sep 2011 06:41:29 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 28 Sep 2011 06:40:58 -0700 (PDT)
In-Reply-To: <7vpqiltsky.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182311>

On Wed, Sep 28, 2011 at 00:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Sep 27, 2011 at 11:28:14PM +0000, Michael Witten wrote:
>>
>>> =C2=A0 With "git commit --no-parent", you would be altering the cur=
rent
>>> =C2=A0 branch head, which means you are potentially leaving as a da=
ngling
>>> =C2=A0 commit the commit to which that branch head originally point=
ed.
>>> =C2=A0 I.e., it is about as dangerous as "git reset --hard <new_roo=
t_commit>",
>>> =C2=A0 something for which we do NOT provide any protection.
>>
>> Didn't I already mention that example? And then say that I think the
>> lack of protection there has been the source of a lot of confusion a=
nd
>> hardship?
>>
>> Repeating the problems of "git reset" does not seem like a good idea=
 to
>> me. Especially not with a command like "commit", which is usually ve=
ry
>> safe.
>>
>> That being said, I did say in my last email that one option would be=
 for
>> the documentation to be very clear about leaving the old history
>> dangling. That at least keeps clueless people from stumbling into us=
ing
>> the option accidentally.
>
> Both of you are right and I agree "commit --root" is a bad idea (I ca=
n
> change my mind ;-). Especially it is rare (and I would even say it sh=
ould
> be discouraged) to create a new root commit in a repository that alre=
ady
> has history, we should try to make it _very_ hard to lose history by
> mistake, even though that means creating a new root commit has to be =
done
> as a multi-step process (e.g. "checkout --orphan" to dissociate the n=
ew
> state from the current history and then "commit").
>
> Thanks for a bit of sanity.

Well, I think Jeff already proferred a solution. We could have:

  git commit --no-parent

act like:

  git branch -d

in that it would require a "--force" when the commit to which the
current branch head points would be left dangling. In fact, we
could go one step further:

  git commit --no-parent

should require "--force" unless there exists another branch head
that points to the exact same commit as the current branch head; this
would tacitly enforce the notion that a new branch should be created
prior to the use of "--no-parent".
