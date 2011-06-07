From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 7 Jun 2011 06:45:26 -0500
Message-ID: <20110607114526.GA9846@elie>
References: <m339jps1wt.fsf@localhost.localdomain>
 <BANLkTinidLbQ_FcVEiGSK91uXYWaKk7MKA@mail.gmail.com>
 <201106051311.00951.jnareb@gmail.com>
 <BANLkTik+xhd5QQ09QiPSH1bFAndzipKtrw@mail.gmail.com>
 <7vwrgza3i2.fsf@alter.siamese.dyndns.org>
 <4DEC8322.6040200@drmicha.warpmail.net>
 <7vk4cz9i1b.fsf@alter.siamese.dyndns.org>
 <4DECE147.3060808@drmicha.warpmail.net>
 <7vd3ir9btd.fsf@alter.siamese.dyndns.org>
 <4DEDC124.3060302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTuj6-0001a6-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab1FGLpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 07:45:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50896 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1FGLpe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 07:45:34 -0400
Received: by iyb14 with SMTP id 14so3914495iyb.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VPEiNELDby3Jk9fc/VjFwmq7qhvgNISbOmBTFsV32l8=;
        b=l0Xd8o8INjkfUsVHeew4Wo/TQ7GLNYvMPAD7FODHQ+ZXb0TYihQzKDNEaA2ZqNlk1b
         viDb0lRmgiShb2W4eiuGrqfgS/1wrNzyVIrRB8SMR4M1AvXa3L4Uv//sKjyEZ/gkJAJ+
         xF8RoN0lUnqi+wSsXId2z9aDPCozckKpZxu18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NEqKhhgQO35v8/6iP4LcgJvwxSgGp0OgtHD5uiR6UkI6Su1OJE02lIDs4l16Xwu0F8
         TVL5ul4Q3WFV/f8AidjWppDUiPaJ2MHPYs3Rjqw8x8xt4G/jwNXaHYxNRcR3TwyOFt84
         om64mkmRwgy4axPOzxqtWgRxMmz/HApcvXnwg=
Received: by 10.42.18.200 with SMTP id y8mr9307279ica.452.1307447134174;
        Tue, 07 Jun 2011 04:45:34 -0700 (PDT)
Received: from elie (adsl-68-255-98-24.dsl.chcgil.ameritech.net [68.255.98.24])
        by mx.google.com with ESMTPS id hp8sm3580802icc.11.2011.06.07.04.45.32
        (version=SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 04:45:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DEDC124.3060302@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175200>

Hi,

Michael J Gruber wrote:

> I'm actually wondering whether there is any agreement on the sheer fact
> that there is a problem in the ui, namely having too many different
> commands or options (reset/commit/add/checkout resp. diff invocations;
> I've described that already) for different aspects of a "similar"
> concept (cp content version from A to B resp. diff it).

I agree that there is a problem --- a difficult learning curve that
means for example it took a year or so before I was used to the "git
diff describes the changes you are preparing" mnemonic for the various
0- and 1-tree git diff forms --- but I do not agree with your specific
characterization of it.  If there are too many ways to spell
operations of a certain class then we should be looking to deprecate
some of them, and that is a direction I do not think would be very
fruitful.

So I'd prefer to focus on actual UI bugs, of the form, "A reasonable
person tried this command, expecting this effect, and got some other
effect instead" or "A reasonable person was searching for a command
with this effect and the only solutions she came up with were
convoluted".

Example:

Long ago, I remember wanting to see what unstaged changes were in
the worktree --- that is, I wanted to compare the content of the
index to the worktree.  So, tell "git diff" to look at the index:

	git diff --cached

No, I should have used "git diff" and the model of "git diff" I had
was completely wrong.  How can we avoid this confusion?

One answer would be to adapt "git diff" to match a familiar model,
that of the ordinary "diff" command.  "diff" takes two arguments,
preimage and postimage, so that would be:

	git diff INDEX WORKTREE

If there were an unmerged path in the index, this would do a
three-way diff, just like "git diff" currently does.

That all sounds great, but I do not find it completely satisfactory.
One problem is that if this is the mental model people have of
"git diff", the three-way diff for a multiple stages, behavior of
"git diff <paths>", and so on, however they are spelled, will look
completely mystifying.  From the point of view of "this command
explains the changes in the worktree" they make sense, while from the
point of view of "compare A to B" they don't make much sense at all.
So this change just defers the learning process.

I think part of the problem in the current UI is that the
documentation never spells out the idea of what plain "git diff" is
for.  Worse, "--cached means to look to the index in place of the
worktree" doesn't seem to be spelled out anywhere except gitcli(7).  I
am not sure it is worth the headache of spelling the latter out
instead of changing the UI to be easier to explain.

Something like "git diff --index-only" would at least set people
thinking in the right direction --- "index only as opposed to what?".

With an INDEX pseudo-tree,

	git diff INDEX

is a synonym for "git diff", and to do "git diff --cached" one would
have to write

	git diff HEAD INDEX

I like the "rename --cached to --index-only" proposal more but am
not too satisfied with it, either.  In a way it is tempting to teach
people

	git diff-files -p;	# compare worktree to index
	git diff-index -p HEAD;	# compare worktree to HEAD
	git diff-index -p --cached HEAD;	# compare index to HEAD
	git diff-tree -p HEAD HEAD^;	# compare HEAD^ to HEAD

I wish there were some other alternative that can be learned more
gracefully.

Sorry for the longwinded, meandering message.  Still, I hope it
clarifies a little.

Jonathan
