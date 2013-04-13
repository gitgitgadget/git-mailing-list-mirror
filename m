From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Sat, 13 Apr 2013 10:37:56 +0530
Message-ID: <CALkWK0=qigG40C7Htv0Yt6ZrgP+vgsauRe=2rWuAuq7UJ47rfw@mail.gmail.com>
References: <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net> <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
 <20130410222334.GC6930@sigill.intra.peff.net> <CALkWK0nvTisYCFjxwuGaBbWawwBahzeBHZ84rFkUYL8sjJuxvw@mail.gmail.com>
 <7vppy0hhk7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 07:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQshi-0006rd-EP
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 07:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab3DMFIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 01:08:38 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:49722 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab3DMFIh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 01:08:37 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so2982356iad.10
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XnWxB0BYClAg5PZgvhA08w9nzrwNjZ1dhPPHH/1Sd0A=;
        b=GoX2ij8Bi2/jLHAkNXCVcqmfXtdHGhF8urfnzQSjBjts/Jtd4OePDcoEGDKv82FZ61
         ZUL1iqAtgGNS/PIdTaVFm9XFdPVyfjE/V4DJhttRyniLPhGho/R8ruV8eg/iK7Fthknf
         TAwy5MV781FEBD5FE80jiQOd2MoNNqs2Q3QNJ76A8k/uO+j0UsFbqkkKY1WV3bj8fFvk
         a1HUnGH0j+m82AH7UpREn5KmV3Dmv45/Cf2R4N9snT7JBqEKjDi8XDuHECplxeEvnDSQ
         w+ougvXr/TTbEgHY6mzEAzIR/Sm0n83UGVU85d9Grf5pigdF1VqkTmCuDSAe6MgGqSRE
         r1UQ==
X-Received: by 10.50.17.71 with SMTP id m7mr878219igd.14.1365829717072; Fri,
 12 Apr 2013 22:08:37 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 12 Apr 2013 22:07:56 -0700 (PDT)
In-Reply-To: <7vppy0hhk7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221049>

Junio C Hamano wrote:
> When pushing into other kinds of repositories (e.g. you can update
> some but not all of the branches, or you want to touch only some of
> them and not others even if you have enough privilege to update any
> of them) or when you do not "batch" and push out one branch as work
> on it is done, while other branches that you would eventually
> publish are still not ready, "matching" is not for you.

I agree that we need to get a "batching" push.default corresponding to
"matching" for multiple-remote setups.  However, I think we should
hold it off until my implicit-push patch is finished.  After using it
for a few days, I'll get a good idea about what this new push.default
setting should look like.

> If "implicit-push" branch at "ram" is updated by other people and
> you may have to pull back from, you would need this for "git pull"
> (without arguments) while on that branch, I guess.  But I got the
> impression from your scenario that "ram" won't be updated by anybody
> but you.
>
> So I am guessing that this may not be needed.

In my opinion, it is a fundamental mistake to have more than one
person working on a branch.  There is one exception to this rule: it
is alright when there are only two people working on it, and one of
them is a "reliable fast-forward-only read-only upstream".  Let me
illustrate this with an example: I sometimes find myself working on
the master branch of git.git (fetch from origin: git/git.git, publish
to ram: artagnon/git.git).  This is because origin/master is an
"reliable fast-forward-only read-only upstream" (read-only in the
sense that it can only be updated with a git fetch).  My interaction
with it is limited to 'git rebase origin/master' on the master branch.
 I will never find myself manipulating it, and the rebase will never
fail unless my patches conflict with the new upstream.

As to why the setting is needed: I often work on more than one device*,
and I suspect a lot of people do this today.  I always fetch all
changes on my private branches before beginning work, unless I want to
end up in a confusing mess (I often rewrite history).

> This becomes necessary only if you use push.default set to "current"
> (or "upstream").  If you mistakenly say "git push" (no other
> arguments), without this configuration you will end up pushing the
> branch out.

Right.  The objective is to get 'git push' to _always_ DTRT.

> It may be that adding push.default=current-but-do-not-create-anew
> could help.  It is a cross between 'matching' and 'current', to say
> "consider pushing out the current one, but only when the other side
> already has one", and may help people who do not "batch".

Hm.  I would argue that exploding push.default options is unhealthy,
and that we should move towards thinking of more fine-grained control
with different orthogonal options.  I'll first do it for pull
(autostash has been in progress for some time); then we can port the
relevant options to push.

* I still haven't made much progress on a design for config-sharing.  I
think I'm missing something big.
