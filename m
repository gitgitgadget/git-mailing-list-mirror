From: Michael Tyson <michael@atastypixel.com>
Subject: Re: Cloning remote HTTP repository: Can only see 'master' branch
Date: Wed, 30 Jan 2013 11:06:31 +1100
Message-ID: <C0C712AF-7EAF-4594-ACDB-27D7ADE9B49F@atastypixel.com>
References: <83605E83-1110-449B-969D-AB43158376EA@atastypixel.com> <20130129082317.GA6396@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 01:07:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0LCY-0008IG-AX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 01:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab3A3AGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 19:06:33 -0500
Received: from bs4-dallas.accountservergroup.com ([50.23.201.241]:60135 "EHLO
	bs4-dallas.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452Ab3A3AGc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 19:06:32 -0500
Received: from 58-6-250-150.dyn.iinet.net.au ([58.6.250.150]:56988 helo=[10.1.1.7])
	by bs4-dallas.accountservergroup.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <michael@atastypixel.com>)
	id 1U0LCA-000Do0-UG
	for git@vger.kernel.org; Tue, 29 Jan 2013 18:06:31 -0600
In-Reply-To: <20130129082317.GA6396@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1499)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bs4-dallas.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - atastypixel.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214983>

Ah!  Lovely, thank you, Jeff!

Alas, it's a shared server so I'm limited to what the host provides, but that solves my problem.

Cheers!


On 29 Jan 2013, at 19:23, Jeff King <peff@peff.net> wrote:

> On Tue, Jan 29, 2013 at 04:54:13PM +1100, Michael Tyson wrote:
> 
>> I've a readonly git repository that I'm hosting via HTTP (a bare git
>> repository located within the appropriate directory on the server). I
>> push to it via my own SSH account (local repository with a remote
>> pointing to the ssh:// URL).
>> 
>> This has all worked fine so far - I push via ssh, and others can clone
>> and pull via the HTTP URL.
>> 
>> I've recently added a branch - "beta" - which pushed just fine, but
>> now cloning via the HTTP URL doesn't seem to show the new branch -
>> just master:
> 
> If you are using the "dumb" http protocol (i.e., the web server knows
> nothing about git, and just serves the repo files), you need to run "git
> update-server-info" after each push in order to update the static file
> that tells the git client about each ref. You can have git do it
> automatically for you by setting receive.updateServerInfo in the server
> repo's config.
> 
> If the server is yours to control, consider setting up the "smart" http
> protocol, as it is much more efficient. Details are in "git help
> http-backend".
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
