From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 16:54:02 +0100
Message-ID: <4D667F1A.5060408@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph> <4D6672F7.4020101@drmicha.warpmail.net> <20110224154908.GA29309@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:57:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsdZF-0004Au-Uv
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab1BXP5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 10:57:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45955 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754834Ab1BXP5U (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 10:57:20 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ACE4C205BD;
	Thu, 24 Feb 2011 10:57:19 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 24 Feb 2011 10:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9mPqzcSEXmxeJbmiAUGZlgZG6FA=; b=ubItjYmcG0xH7zziZtNnmFkt3rj0+oCVlSvNcbHIS4xZAW/DxWjATpHGFcnSSLZo0zUpweZerXwqu3SS82OvJ0uygFesBsO/o2aBGwRfZiZB1yr8ttwdbZ2lQXXkL5yU1EdfhUqsF/awTknEgLkiRMI5ysJBWi9GoPACzkW6TnM=
X-Sasl-enc: QqY9d6N9UV0sxAuMptJYzmSEzD/EqWJ2gzBKI98iTIFY 1298563039
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E630441726;
	Thu, 24 Feb 2011 10:57:19 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224154908.GA29309@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167825>

Jeff King venit, vidit, dixit 24.02.2011 16:49:
> On Thu, Feb 24, 2011 at 04:02:15PM +0100, Michael J Gruber wrote:
> 
>> "commit -A" does not exist, so that "git add -A && git commit" is your
>> only way.
>>
>> [...]
>>
>> Also, "-A" supports a very "un-gitty" way of using git. This makes it
>> unlikely that someone cares to implement it... (By "un-gitty" I don't
>> mean a matter of personal taste, but a matter of fruitful habits.)
> 
> Actually, I would find "git commit -A" useful. Not as part of my normal
> project workflow, but would be a great shorthand for one-off debuggings
> (e.g., "echo content >>file && git commit -A -m msg", which Just Works
> whether it is the first or a later commit).
> 
> But as you mentioned, it is sadly not as trivial as just adding a new
> way to call "git add". So I think nobody has simply cared enough to
> implement it to date.

How about this program:

- refactor add, commit to share the "add parts"
- homogenize interface: replace "add -u" by "add -a" (hidden
compatibility thingy of course)
- hom. interface: allow "-a pathspec" for commit
- have commit -A

Oh, and do "commit -n" what one would expect [1.8.0] :)

Michael
