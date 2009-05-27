From: Sam Vilain <sam@vilain.net>
Subject: Re: RFE: "git bisect reverse"
Date: Thu, 28 May 2009 11:08:08 +1200
Message-ID: <4A1DC7D8.2050601@vilain.net>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> 	<4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> 	<efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com> 	<20090527211836.GA14841@localhost> <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 28 01:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9SEs-00004s-Da
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 01:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbZE0XIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754938AbZE0XIl
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 19:08:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:55532 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbZE0XIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 19:08:41 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E07CA21C3F6; Thu, 28 May 2009 11:08:37 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id E4D4221C3E9;
	Thu, 28 May 2009 11:08:31 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <efe2b6d70905271507s187babe9yf19a25268ab0b95e@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120128>

Ealdwulf Wuffinga wrote:
> The question is how to avoid skips, which gain no information. You say
> 'if we choose a commit close to the skipped one, we will likely have
> to skip the that one'. This is what I meant by 'the idea is that the
> probability that a commit is broken is greater if it is close in the
> DAG to a known-broken commit'. Maybe you are reading this as 'bad
> commit', but this is not the sense in which Sam is using the term.
>
> For git-bisect, Sam and H Peter are proposing a heuristic to trade off
> between information gained and likelihood of testing a bad commit. For
> bbchop, I am already doing calculating the information gain directly,
> so if I can incorporate the probability that a commit is broken - has
> to be skipped - then the trade-off will happen automatically.
> Therefore it would be useful to have some plausible theory as to how
> the probability of a broken commit should be calculated, given some
> known-broken and known-not-broken commits.
>   

Sounds like interesting stuff, can you make a patch out of it?

Actually it occurs to me that for projects which can successfully
rebuild with just 'make' for each new revision and have a stable commit
policy, walking through commits forwards like that is probably the right
thing to do, because it's relatively cheap and should make progress in
the lowest amount of time.  So the current behaviour should probably
still be available.

Sam
