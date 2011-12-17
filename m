From: Pete Wyckoff <pw@padd.com>
Subject: Re: BUG: git-p4: can't add files with special chars
Date: Sat, 17 Dec 2011 08:27:54 -0500
Message-ID: <20111217132754.GB31271@padd.com>
References: <4EE6688A.2030105@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 14:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbuJ2-0000NN-A2
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 14:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1LQN17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 08:27:59 -0500
Received: from honk.padd.com ([74.3.171.149]:58304 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752191Ab1LQN16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 08:27:58 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id DA9EF1C89;
	Sat, 17 Dec 2011 05:27:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8C1FC31466; Sat, 17 Dec 2011 08:27:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EE6688A.2030105@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187384>

luke@diamand.org wrote on Mon, 12 Dec 2011 20:48 +0000:
> I just noticed this today. You can't add a file from git to perforce
> that contains a p4 special character (@,#,% or *).
> 
> There is code to cope going the other way round (p4 file with
> special character in it) but if you create a file in git and then
> try to git-p4 submit, it fails.
> 
> I've just tried a quick and simple fix, and it turns out that it's
> not that easy as the special characters get expanded to %40, %2A and
> so-on. The % seems to get further expanded by python...

Entertaining.  Probably p4_add() and friends should stop using
system.  And add option "-f" when wildcards are detected.  I
wouldn't be surprised if this turned into a larger set of issues.

		-- Pete
