From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Odd results writing a Git pre-receive hook to syntax check PHP
 files.
Date: Mon, 30 Aug 2010 16:30:00 +0200
Message-ID: <4C7BC068.7030909@drmicha.warpmail.net>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com> <4C7B8E1E.6050708@drmicha.warpmail.net> <AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com> <20100830141602.GF2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:30:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5NA-00027o-BT
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364Ab0H3OaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:30:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56969 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718Ab0H3O37 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:29:59 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3A1F76F2;
	Mon, 30 Aug 2010 10:29:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 30 Aug 2010 10:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=SVOeoOsam0ytq+Z/Dzmu8rZH/JE=; b=Yz3tnaOByu0kS0oC6l6p6yS2CUdEnVsqA+OkXuj3+un/XiBf94skODzSqzp80oVSCj9Oiy5kfyx9K1I5Dsfoeh63ocEyXdLAuBdhof9ueHzL8DcjX1h4JzTMqLHBOIbbvInxP44tbyho8Zx4wFI9W6IGFudwJHvjvG/KrNHbACc=
X-Sasl-enc: vBv1m0ol8yRhguVqXKlUS87yXo52kePqdGgmnwKZmxyJ 1283178598
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9161E5EBBF0;
	Mon, 30 Aug 2010 10:29:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100830141602.GF2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154813>

Jonathan Nieder venit, vidit, dixit 30.08.2010 16:16:
> Chris Patti wrote:
> 
>> That's great, thanks!  That gets me the file names.  Now, how do I get
>> to the contents of each file?
> 
> Why not "git diff --raw" (or its plumbing equivalent "git diff-tree")?

That's what I meant by "diff family" ;)
In fact, "git diff --raw --name-only oldrev newrev" gives the nicest
listing.

It seems Chris has to check full file contents, i.e. he'll have to loop
over this list (as before), but I guess he'll need to replace his "show
$blob" by "show newrev:$filename" (or, alternatively, parse the output
of "diff --raw" without "--name-only" for the blob sha1).

Michael
