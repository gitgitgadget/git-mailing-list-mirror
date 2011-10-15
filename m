From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: interrupting "git rebase" (Re: git rebase +)
Date: Sat, 15 Oct 2011 14:44:14 -0500
Message-ID: <20111015194414.GB12893@elie.hsd1.il.comcast.net>
References: <loom.20111013T134405-495@post.gmane.org>
 <4E96E5E1.7010103@viscovery.net>
 <20111014052653.GA5052@elie.hsd1.il.comcast.net>
 <CAOeW2eFK5vSKmf+nxzD-6yh5CWZRv4WqSerbSXTPtXmtNeNjxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Adam Piatyszek <ediap@wp.pl>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 21:44:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFA9q-0003R1-VY
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 21:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1JOTo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 15:44:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48312 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657Ab1JOTo0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 15:44:26 -0400
Received: by ywp31 with SMTP id 31so1220119ywp.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3QRLsDzVbavZkCnTRBbHNz4CQSuByPH53DdIvU38u+o=;
        b=dbwHsieQFMiH/WM4jKBfKGPKMiIBmlKBvE7SltQLn/73uiVDQt8y8FCUrOrD8Flk9A
         Jm/KYmTiZ0Eu2cUeLkIRl+Jk+9ZRLeoREmQ4DqGnHSXR8fOP7SoZ7scDhlWaTAopckAf
         2HEl6hbWOtvd6N/EK8m8F2PLtEVAMHGIBmvP4=
Received: by 10.236.154.3 with SMTP id g3mr17595485yhk.18.1318707865713;
        Sat, 15 Oct 2011 12:44:25 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d63sm411931yhl.10.2011.10.15.12.44.24
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 12:44:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOeW2eFK5vSKmf+nxzD-6yh5CWZRv4WqSerbSXTPtXmtNeNjxg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183672>

(+cc: Ram)
Martin von Zweigbergk wrote:
> On Thu, Oct 13, 2011 at 10:26 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> Johannes Sixt wrote:

>>> Hitting Ctrl-C during git-rebase results undefined behavior.
[...]
>> Wait, really? =C2=A0That's bad, and unlike most git commands.
>
> If Ctrl-C is pressed while the state is being written, it could be
> left with incomplete information, yes. It has been like that forever =
I
> think. I'll put it on my todo list, but it will not be my top priorit=
y
> (and I have very little git time now anyways).

Sorry for the lack of clarity.  That actually sounds fine to me
already, as long as the intermediate state is easy to recover from
(which doesn't match what I usually think of as "undefined behavior").

So it sounds like I was worrying needlessly.

[...]
>> By the way, what happened to the "git rebase --abort-softly" synonym
>> for "rm -fr .git/rebase-apply" discussed a while ago?
>
> I think we simply did not agree on a syntax, but here was also some
> discussion about future plans for the sequencer. I remember seeing
> some discussions about making "git reset --hard" remove the sequencer
> state, but I don't remember the conclusion. It is not clear to me wha=
t
> is ok to implement in git-rebase nowadays and what would just be
> double work if it needs to be re-implemented in the sequencer.

I believe a good rule of thumb is that you can always pretend the
sequencer just doesn't exist, and cc Ram when you are unsure. :)

Certainly, a lot of sequencer features were inspired by "git rebase".
Improvements to "git rebase" are only likely to make future
improvements to "git sequencer" easier.  Part of what helps here is
that "git rebase" is a shell script, so it is a little easier to
prototype features there.

Thanks!
Jonathan
