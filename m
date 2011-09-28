From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Wed, 28 Sep 2011 15:06:27 +0000
Message-ID: <CAMOZ1Bs5GKE19nd+9sVQuEH+zRCug0OTGXAqpDjEgq=_pKzZxA@mail.gmail.com>
References: <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <e88b6e560cab4ed1937dd191b4180387-mfwitten@gmail.com> <4E81F080.7010905@drmicha.warpmail.net>
 <CAMOZ1BsvnZ7PyfjOJURX+B7vCZcYheLS4pissGvPNjEivbYXtw@mail.gmail.com>
 <7v39fhyk21.fsf@alter.siamese.dyndns.org> <4E823359.7080602@nextest.com>
 <DBCBE20265964ECCA5B9724DAC74D83B@PhilipOakley> <20110927214213.GC5176@sigill.intra.peff.net>
 <CAMOZ1BvzWDPQ_e3Y5H8CX4wQwL5xf3xVvZvRL3gQPcB_kCGBbw@mail.gmail.com>
 <20110927233549.GA10434@sigill.intra.peff.net> <7vpqiltsky.fsf@alter.siamese.dyndns.org>
 <CAMOZ1BvL85xsQpZdez4VJ+dH4NoQ9RkthHY9OsmdnnaZ_tFnFg@mail.gmail.com>
 <vpqty7wok5a.fsf@bauges.imag.fr> <CAMOZ1Bu8UiV+Z0+0CLjxSv5Zic8i4=aGxnzmLc+H7c2T-P4avw@mail.gmail.com>
 <vpq4nzwoj1o.fsf@bauges.imag.fr> <CAMOZ1Btw7Bf3_ejZef_SdRojyVeM94knyz9Gw+SEqFtrrpBVsA@mail.gmail.com>
 <vpq39fglo8y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Raible <raible@nextest.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 28 17:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8viw-0002oo-OS
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 17:07:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab1I1PG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 11:06:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59112 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1I1PG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 11:06:57 -0400
Received: by qyk7 with SMTP id 7so9287132qyk.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QwNNbhhhKbSk0d/C5E3c0gKAnib08GZlAJ+HRUSPTig=;
        b=Fj9fp1ZsgS0b6JPs+nLCs+9FGqd90AUqv7igscW4RAcQ/SgtmPmy1Ev6k61M+dAc7E
         tjWXNuc40+TsyWavTZ6T1ApVNXjVBuMx1B/1sz51UraLVDVn5gyK60ZDa5MbKJKzbgVm
         ZA8E+yPm36rvDX9ueUrvn/fZ0fXSRznxMPYSk=
Received: by 10.229.41.69 with SMTP id n5mr6803857qce.279.1317222417201; Wed,
 28 Sep 2011 08:06:57 -0700 (PDT)
Received: by 10.229.233.6 with HTTP; Wed, 28 Sep 2011 08:06:27 -0700 (PDT)
In-Reply-To: <vpq39fglo8y.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182331>

On Wed, Sep 28, 2011 at 14:45, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>>> Even if you use it normally:
>>>
>>> # I want to create a new root commit with a different tree
>>> git checkout -b new-project
>>> # hack for a while
>>> git status
>>> # ?!? why are files shown as 'deleted', 'moved', 'modified', I said I
>>> # was creating a new project!
>>>
>>> Also, with your proposal, we would need to add two flags to "commit"
>>> (--no-parent and --force), which is one of the first command beginners
>>> learn, while in the current state we have just one for "checkout" to do
>>> the trick, and newbies do not use or read the doc for checkout, so it's
>>> not scary for them.
>>
>> Well, those are mildly interesting scenarios. I can only say that I don't
>> think we should cater to people who either have amnesia or work casually
>> on a repository for short bursts every few months or so.
>
> How is the "git status" issue above linked to any kind of amnesia?
>
> When hacking to create a rootless commit, it seems legitimate to me to
> run "git status", and it seems _very_ confusing that "git status" still
> refers to the commit you don't want as parent.

I think "confusing" is perhaps the wrong word. How about "annoying"?

I suppose it is true that neither "--orphan" nor "--no-parent" is good
enough alone. For instance:

  # I want to create a new root commit with a slightly different tree
  git checkout --orphan new-project
  # hack just a bit here and there
  git status
  # ?!? My slight alterations are obscured by hundreds of these
  #     "new file" status notifications!

> (I don't get the relation between your reply and the paragraph right
> above it either)

Is that a passive aggressive French way to state that I didn't respond
to your concern?

I think it's moot now, anyway, given that both "--orphan" and
"--no-parent" quite possibly have their logical purposes. However,
perhaps:

  git checkout --orphan

should be renamed:

  git checkout --no-parent

in order to match:

  git commit --no-parent
