From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Mon, 29 Apr 2013 23:51:03 +0530
Message-ID: <CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <7vhaipl2ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWshx-0003IU-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758507Ab3D2SVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:21:44 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:34532 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487Ab3D2SVn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:21:43 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so5854960iab.22
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lkMNU5vZQN/jbnOEcy8T96pCM/WeuFU4Z4hJkeZRTJY=;
        b=XLgn0fdVwCZT9m8kno2grSI8XVOAirLRAhuYCIa6yaQMZTWblHWjB6D4AIaWT8m8DT
         zvCWcPG7VlLGIn3ao3IQqePpqQGoNV7Ka2hYwNnvUBDKNds4GxsKtmIoLcFEXYH7ZNsn
         OgARC9j6K/b++HmIW7N6nFrYzEgZRdHuDyMlnX67AVuEydFjBgf9n5/r1KFbdrForq4N
         dPL3jHcdfXgRvcjcO5IRWvRnh8kD5mCgFT7NH+Z3CXkL5t6tOmrFR6FFnffKF6SE++iY
         +Md+quZHTty2sEgnH6ZjYPrFmHlt4IepKP2HmFgXQTp8tTacYZ5FUZ41jIMcKm2nuEVb
         qqXg==
X-Received: by 10.50.66.197 with SMTP id h5mr7862811igt.63.1367259703350; Mon,
 29 Apr 2013 11:21:43 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 11:21:03 -0700 (PDT)
In-Reply-To: <7vhaipl2ks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222840>

Junio C Hamano wrote:
> Please don't.  All of these clayoven, LICENSE, foom, loom are mere
> distraction.
>
>         ... goes and draws the diagram himself ...

Sorry, I'm finding it hard to draw this thing.  I'm only becoming
comfortable with reading it now.

>> $ git log rebase.autostash ^master
>
> That is range "F..H", which lists "H G D".
>
>> $ git log rebase.autostash --not $(git merge-base --all rebase.autostash master)
>
> The merge bases between F and H are B and C, so that is
> range "^B ^C H", which again lists "H G D".

Correct.  Equivalent.

>> $ git log rebase.autostash ^$(git merge-base rebase.autostash master)
>
> Depending on which one of B or C is chosen it is either one of these:
>
>  - range "^B H" which lists "H G D C"
>  - range "^C H" which lists "H G D B"
>
> neither of which is more useful than "H G D", as it shows irrelevant
> "other merge base" you did not pick.

Correction:

Range "^B H" lists "H G D A..C" while range "^C H" lists "H G D A..B".

In reality, it shows A..B, which is what I want and what am claiming
is "useful".

I want to what all happened since rebase.autostash forked off from
master (at D) all the way until its current tip (at H).  With
master..rebase.autostash, I'm only informed about a mysterious G (but
am clueless about the commits it introduced).  I don't _want_ to know
the "difference" between rebase.autostash and master (master includes
the A..B commits, which is why master..rebase.autostash is refusing to
show them to me).

>> $ git diff rebase.autostash ^$(git merge-base rebase.autostash master)
>
> This will show either "diff B H", which is work done by G and H, or
> "diff C H", which is work done by D thru H.

In reality, it shows "diff C H", which is what I wanted to know.  In
other words, it tells me "what happened since rebase.autostash forked
off from master".  Which is what I want to know.

In the previous email you said you didn't understand the topology, so
I explained it subsequently.  In this email, your claims have varied
from:

- It is Wrong or Not Useful to ask "tell me everything that happened
since my branch forked off from master"

- The question I'm asking is ill-formed (?)

- A..B is "sufficient" (for what?  it's answering an entirely
different question)

Now, I'm not claiming that it is _definitely_ useful.  I'm saying that
it gives an answer to what seems to be a valid question to me.

> You did not give anything new that hints that it might be worth
> spending time listening to you in this message. Should I do a "kill
> file for a few days" thing again?

I might be saying nonsense, but I don't appreciate this kind of
response at all.  Realize that I'm spending 3x the amount of time in
crafting this.  I'm the one proposing something new, and you're the
one defending what exists.  If anyone has the right to complain, it's
me.  Not you.
