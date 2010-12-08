From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git format-patch should honor notes
Date: Wed, 08 Dec 2010 11:24:18 +0100
Message-ID: <4CFF5CD2.2000009@drmicha.warpmail.net>
References: <4CFEACC5.70005@redhat.com> <20101207221151.GC1036@sigill.intra.peff.net> <4CFF3FE4.4080104@warpmail.net> <201012081112.12112.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Blake <eblake@redhat.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Dec 08 11:26:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQHEX-0003GR-M1
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab0LHK0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:26:41 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44039 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753759Ab0LHK0k (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 05:26:40 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3D7173B4;
	Wed,  8 Dec 2010 05:26:40 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 08 Dec 2010 05:26:40 -0500
X-Sasl-enc: OwtrGsZHscKksf5FFuknpjOkMj7aUxKto/EAyGy/pOIw 1291803999
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4BBE75E89E9;
	Wed,  8 Dec 2010 05:26:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <201012081112.12112.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163184>

Johan Herland venit, vidit, dixit 08.12.2010 11:12:
> On Wednesday 08 December 2010, Michael J Gruber wrote:
>> Also, in order to be really useful, I would need a place to store the
>> cover letter also. I was experimenting a while back with a design for
>> annotating branchnames which "basically" worked but haven't had time
>> to really implement it. If I remember correctly, I had to set up some
>> "bogus" refs to keep my notes from being garbage collected and was
>> still figuring out the best place to put them. I'll dig it up when I
>> have time to.
> 
> I believe the last time the issue of adding notes to branch names was 
> discussed, the consensus was that rather than using notes, they could 
> be stored using a custom entry in the config file, e.g.
> 
>   git config branch.mybranch.description "Description of mybranch"
> 
> I might have misremembered this, though.

They certainly "could". The question whether they "should" depends on
what they are used for:

- config is neither versioned nor easily shareable; perfect for your own
scratch notes to go away once work is done

- notes are versioned and can be shared (I don't need to tell you...);
perfect for longer term annotations you want to keep

Note that "sharing" here includes also pushing to your backup repo and
cloning around. I'd certainly put patch series cover letters in the
second category.

Michael
