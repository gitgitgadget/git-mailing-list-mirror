From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 17:01:55 +0100
Message-ID: <4D6680F3.1000205@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph> <4D6672F7.4020101@drmicha.warpmail.net> <20110224154908.GA29309@sigill.intra.peff.net> <4D667F1A.5060408@drmicha.warpmail.net> <20110224160027.GA30275@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:05:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdgt-0000kR-Be
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756125Ab1BXQFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:05:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45219 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752306Ab1BXQFN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 11:05:13 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1208520B6F;
	Thu, 24 Feb 2011 11:05:13 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 24 Feb 2011 11:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1pP3mhsm5WsIOSrZfE8+zZvaG/Y=; b=JFZzZWzwQOP4TT/DGfgUT4ojlC+ekvZ/ZF85nUSFANNGLKh5BwiuW1mVUXec39z65wdp5mFII/vCgSwD+/PBzZ3gNHMlLvKXqUb0/wEOEJTUEqvb9DFTYEwRzVXLnBxjypzYS/yaJyIDQ7fXHsOxIkYMmbgjRpjmP1IA99nX7WM=
X-Sasl-enc: a3tw/7gTrhXp56oaZj9hATmluS8y/8kqDMScDlQue/FQ 1298563512
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3303A401638;
	Thu, 24 Feb 2011 11:05:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224160027.GA30275@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167829>

Jeff King venit, vidit, dixit 24.02.2011 17:00:
> On Thu, Feb 24, 2011 at 04:54:02PM +0100, Michael J Gruber wrote:
> 
>>> But as you mentioned, it is sadly not as trivial as just adding a
>>> new way to call "git add". So I think nobody has simply cared
>>> enough to implement it to date.
>> 
>> How about this program:
>> 
>> - refactor add, commit to share the "add parts"
> 
> Sounds good.
> 
>> - homogenize interface: replace "add -u" by "add -a" (hidden 
>> compatibility thingy of course)
> 
> I like it.
> 
>> - hom. interface: allow "-a pathspec" for commit
> 
> What would it do? It would just behave like "git commit -i
> pathspec"?

It should do what "-u pathspec" does for add: limit "all tracked" to the
pathspec. I know it's the same as without "-a", but why bail out on it?

> 
>> - have commit -A
> 
> Sounds good.
> 
>> Oh, and do "commit -n" what one would expect [1.8.0] :)
> 
> Yeah, I like that, too.
> 
> Are you volunteering to work on it all? :)

I've done all the careful planning already, laid out in nice steps. Now
it's your time ;)

OK, I'll do "-n".

Michael
