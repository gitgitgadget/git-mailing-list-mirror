From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 10:49:11 +0100
Message-ID: <4D6B6F97.8030409@drmicha.warpmail.net>
References: <cover.1298821535.git.git@drmicha.warpmail.net>	<4D68D630.9000608@drmicha.warpmail.net>	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>	<4D6B5D09.8010806@drmicha.warpmail.net> <vpqwrkkpkea.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzmR-0002HK-OF
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1B1Jwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:52:35 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57553 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753128Ab1B1Jwe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 04:52:34 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B6E3A205AC;
	Mon, 28 Feb 2011 04:52:33 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 28 Feb 2011 04:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kmTcBb2DC99FbFTOIv3ZTR9x49U=; b=XCudqttCjFVc9i56Dhyfaalmrc+V6PFPTB85P9vcSZJlukGAnyektcSGMn3J1f/yBiqmLdtzEUA9RhkZJ5CcDFthbJZ5NOdH9SE7flamvBjgSN4VxqPgO6My6QnAtoHU8EWvfyaNNH7H48LU4Pt9GNg3Np4N2cg3G5dlbwaCA8Q=
X-Sasl-enc: JZnScFG5qRKTIgWLuNUe8HVTHKhHBpKXAkifF8nZh3RX 1298886753
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A00E1442233;
	Mon, 28 Feb 2011 04:52:32 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <vpqwrkkpkea.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168092>

Matthieu Moy venit, vidit, dixit 28.02.2011 10:40:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> But just how useful is our default that "git add" is a no-op?
> 
> I dont care very much myself, but if you consider "git add ." as a
> potentially destructive operation (discards changes that may be precious
> in the index), then it's good that "git add" is a no-op.
> 
> Many beginners will try commands expecting to get a help message or a
> hint on how to use it when ran without argument (principle of least
> surprise)
> 
> Like:
> 
> $ ls
> file1 file2
> => oh, so "ls" lists files.
> $ rm
> rm: missing operand
> Try `rm --help' for more information.
> => ok, so rm needs more operands
> 
> A user typing "git add" just "to see what happens" may be disapointed to
> have all its files added. In particular since "git add" is silent by
> default, hence
> 
> # let's see what happens ...
> $ git add
> $ 
> # ok, nothing happened ...
> # continue hacking without noticing that a bunch of files have been added.

No no, I said "add" would default to what "-u" does now (see below).

A user "starting to experiment with add" while have nothing in the index.

> Mercurial has taken the other way, making "hg add" add everything by
> default, and some users do complain:
> 
> http://osdir.com/ml/version-control.mercurial.general/2007-08/msg00316.html

Since when do we care about them (as in "hg", not in "users", mind you...).

> If you change this for Git, you'll have people complaining about
> backward compatibility plus people complaining about least surprise :-(
> 
>> - "add" should be about tracked paths by default (default pathspec "."),

See, here!

>>
>> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
>>
>> - "-A,--all pathspec" (default pathspec ".") be about tracked and
>> untracked paths (whether add or commit).
> 
> Today, "git add ." adds new content in tracked files, and new files, but
> doesn't notice files deletions. Did I miss something, or is there no way
> to do that with your proposal?

What in

> That would need a proper migration
> plan etc., and some thinking about -i/-o. Just brain-storming.

reads "proposal" to you?

Besides, current "git add ." is a really strange thing, doing more and
less than "git add -u", mixing "update" with "track", but not
completely. What is it even good for? ;)

(We could have an option for that, of course. Have I mentioned "radical"?)

Michael
