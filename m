From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 11:15:19 +0100
Message-ID: <4D678137.7060707@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph>	<7v7hcp2vi6.fsf@alter.siamese.dyndns.org> <20110224194514.2ca47772@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 11:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psul7-0006Nw-JW
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 11:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542Ab1BYKSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 05:18:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36576 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932539Ab1BYKSi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 05:18:38 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DB1C42074E;
	Fri, 25 Feb 2011 05:18:37 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 25 Feb 2011 05:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UVJs/c/3Hhb3fyz5ZA54r/kgxNE=; b=hKsWGsPnKlSE0YR2tB67DA95Eyh7ZizLBahCl6FyC0FYX/MnyS/fnbOv6WTuxvIJ9vXJ04RVjje/AAupjFpDPYK7PGMajGy9hGLRApFHNRRRC6CJtOn6Ex0y4uBjJtqCMs3v4h3ncy/tYOqxdZvCrst3hw+Zww4mjsOhvVEG58w=
X-Sasl-enc: fI0SabCWhizewdrp6+7Vf41NT7ZvDGnKgSmJAwnqfj0r 1298629117
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B1CB40A2B4;
	Fri, 25 Feb 2011 05:18:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224194514.2ca47772@glyph>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167897>

Marco venit, vidit, dixit 24.02.2011 19:45:
> On 2011-02-24 Junio C Hamano <gitster@pobox.com> wrote:
> 
>>> I don't understand why there's not switch (is there?) for commit to
>>> commit new and deleted files, like -A for git add?
>>
>> Historical accident.  In the early days of git, there was no .gitignore
>> mechanism, so a mode that operates on everything under the working tree
>> was almost always an undesired thing to have (think *.o files).
>>
>> Then .gitignore mechanism came, and "add ." has become usable.  But
>> "commit -a" has been widely used way before that.
>>
>> If you look at "commit -a" within that context, you would understand why
>> it should only look at the paths git knows about.
>>
>> Of course, "add -A" is a much later invention.  The option was named "-A"
>> with capital letter, even though there is no "add -a".
>>
>> This was because I knew we would eventually want to have "commit -A" that
>> grabs everything and new files (honoring the gitignore mechanism), and
>> aimed for consistency between "add -A" that I was adding, and "commit -A"
>> that was yet to be written.  See 3ba1f11 (git-add --all: add all files,
>> 2008-07-19).
>>
>> I think it now is sensible to add "commit -A" if somebody is inclined to
>> do so.  Nobody felt the need for it strongly enough to do so, it seems.
> 
> Thank you for the detailed explanation.
> 
> To sum this up: -A would be a nice-to-have feature but it's not necessary to
> implement since we have add -A. But if I'm willing to implement it myself I'm
> free to do that.

Marco, please don't cull cc on this list. I haven't been aware of this
new subthread nor your answer in the other one (being culled).

Your questions have been answered in the subthread with Jeff already,
and we've laid out a way forward for the implementation.

Michael
