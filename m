From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn --stdlayout 's little quirk.
Date: Mon, 22 Aug 2011 11:01:07 +0200
Message-ID: <4E521AD3.4040204@drmicha.warpmail.net>
References: <20110820183504.GA32179@dcvr.yhbt.net> <1313919482.36626.YahooMailClassic@web29501.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, madduck@madduck.net,
	git@vger.kernel.org
To: htl10@users.sourceforge.net
X-From: git-owner@vger.kernel.org Mon Aug 22 11:01:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvQNk-0002cV-Af
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab1HVJBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 05:01:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50155 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752941Ab1HVJBK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 05:01:10 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7C35C209C5;
	Mon, 22 Aug 2011 05:01:09 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 22 Aug 2011 05:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=zc+pMlTu9psLgONeUw+Qce
	DRojk=; b=hPI85+H5gjTcRh7gYYSq+tl3T7reaq60Djh+td0bOdN48tD6XG6RdG
	jdZfa0ThXh8g2Lj+dEbQtcXx29Ad5+fL8TT8FsJ4gLTOGdX+vKZ5Io9MfjnErbMO
	nauU/Xl2S/URdmPci01JjrhX6JqvX0Q4ZLdasJLnBg4c2qwkuOdIg=
X-Sasl-enc: uvb2Dv2XVRLmWMbfB9sL8V6fINVOlQSdUu/sUavUxClj 1314003669
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AE2649E0335;
	Mon, 22 Aug 2011 05:01:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <1313919482.36626.YahooMailClassic@web29501.mail.ird.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179851>

Hin-Tak Leung venit, vidit, dixit 21.08.2011 11:38:
> --- On Sat, 20/8/11, Eric Wong <normalperson@yhbt.net> wrote:
> 
>>> I think I found a small bug in git 1.7.6. Having
>> "trunk" at the end of
>>> the url in combination of --stdlayout is wrong, but it
>> looks like that
>>> git-svn tries to cope, but doesn't go try far enough:
>>>
>>> Doing this:
>>> ----------------
>>> git svn clone --stdlayout http://quick-settings.googlecode.com/svn/trunk/
>> android-quick-settings
>>
>> --stdlayout expects the "root" path of the code you're
>> interested
>> in (not necessarily the SVN repository root, but in this
>> case they
>> could be the same).
>>
>> Try the following instead:
>>
>> git svn clone --stdlayout \
>>   http://quick-settings.googlecode.com/svn
>> android-quick-settings
> 
> I know this is the correct way - what I meant was that, having "trunk" at the end is wrong but git-svn appears to try to correct it automatically, but haven't quite succceeded.

It is not trying to do that at all. git-svn is trying to figure out what
the "base path" is in an svn repo which possibly hosts multiple repos,
and that is what the message reports.

Michael
