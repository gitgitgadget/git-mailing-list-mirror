From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Tue, 12 Apr 2011 11:04:43 +0200
Message-ID: <4DA415AB.9020008@drmicha.warpmail.net>
References: <201104111912.47547.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:04:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ZWn-0000YT-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab1DLJEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 05:04:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:40657 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753944Ab1DLJEq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 05:04:46 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1336620A3D;
	Tue, 12 Apr 2011 05:04:46 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 12 Apr 2011 05:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=k4dBGZJ9IaUgYhNyw7A+iHAd7mU=; b=c+WLS8/5TkUb0llkIDVd90nXxqRT+McDuxTs4cFOGQaDN/yDNMtF0FppMuvRgkkME7cdEkRTVet0JeSUKoMuDhla/kZqxE8NHkbOvYbqNjhixp6I2z2z7BuzKl/Ij5MkAd14CvLfYpx7UZGNsXI9b2P2syKhTw2E4HOsriUZKr8=
X-Sasl-enc: B3f9wHJlIY9N3cqmOnNJVjO0ZZxNy6bCkWmRdoFHGhXq 1302599085
Received: from localhost.localdomain (p54858EA8.dip0.t-ipconnect.de [84.133.142.168])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 707FC406990;
	Tue, 12 Apr 2011 05:04:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <201104111912.47547.kumbayo84@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171382>

Peter Oberndorfer venit, vidit, dixit 11.04.2011 19:12:
> Hi,
> 
> i currently use a textconv filter to show contents of a zip like archive in a user readable format(as a list of contained files).
> 
> This works fine, except for merge commits.
> For merge commits i see the diff of the binary contents of the file.
> 
> Is this intentional?
> git help gitattributes mentions no such limitation.
> Anywhere else(gitk(on non merge commit), git gui blame) i see the the filtered textual representation of the file.
> 
> I tried 1.7.4 msysgit and current master
> 
> Greetings Peter

textconv is applied for "diff -m" but not for combined diffs (-c, --cc)
at the moment. They go through a completely different codepath, so it is
expected code-wise (not a bug per se) but not ui-wise.

Looking at the code and trying to dig something up atm...

Michael
