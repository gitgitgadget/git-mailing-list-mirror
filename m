From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC 0/3] add/commit -u/-a/-A
Date: Sat, 26 Feb 2011 11:30:08 +0100
Message-ID: <4D68D630.9000608@drmicha.warpmail.net>
References: <cover.1298644872.git.git@drmicha.warpmail.net> <7vr5aw9b7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:29:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHOb-0007Rs-Ax
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab1BZK3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:29:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36731 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab1BZK27 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 05:28:59 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 35DF7208DF;
	Sat, 26 Feb 2011 05:28:58 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 26 Feb 2011 05:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kQU9a45vVs01ekklW17yNKsz/LY=; b=ils5rm1AZE2PV6Sd5FCCveUAKzpMJo4wbwW7h/o2zNE9CDjfsOw02juutnM2bkMky+866AVp/2aXdeAmaa285DpzBLRNAtySWsCav6kAXWGdsA23orOwZjDy+S+vTmuVFCwTSQDli3caB2P5VHAXsPw/K45zZWT6b1D4LNOjSyY=
X-Sasl-enc: A8k3N9GneZuNLlxIm4iVosQO/sut0CEzd27Ms6SKXUj3 1298716137
Received: from localhost.localdomain (p54859741.dip0.t-ipconnect.de [84.133.151.65])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 67B3A448667;
	Sat, 26 Feb 2011 05:28:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vr5aw9b7m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167971>

Junio C Hamano venit, vidit, dixit 25.02.2011 20:16:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> It comes before Jeff's series from p^3u which refactors add/commit and
>> implements "commit -A".
> 
> What's that topic, and what's p^3u?

p^3u = ppp = proposed potential pu (or something)

Sorry for the TeX notation.

In "Re: Why doesn't git commit -a track new files" (which I failed to
reference from this series), Jeff and I have been discussing how to make
the add-related options of add and commit homogeneous and less
surprising (see the OP). Nobody objected there, so I assumed everyone to
agree... The two problems addressed here are:

- "add -u" and "commit -a" are "the same" (as far as additions go, and
when used without pathspec) but are named differently

- "add --all" and "commit --all" are named the same but do different
things (-A resp. -a).

I care about consistency, not so much about actual names.

I don't think we use upper case long options, or I would have suggested
"--All" as long form of "-A".

You see, "commit --all" seems to promise more than it does - one really
has to know what "all" is qualified by.

And, similarly, "add" always updates the index, it always is about the
updates in the files which are selected, so "-u/--update" doesn't make
much sense to distinguish it from other uses of "add". That's the
reasoning that lead us to having "-a = -u" for add, and that lead me to
renaming "-a = --all" to "-a = --tracked". I wouldn't mind
"--all-tracked" here. and I would have left it and renamed "-A = --all"
to "-A = --foo" if I had had a good "--foo".

Michael
