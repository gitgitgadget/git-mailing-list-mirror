From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: [PATCH] http authentication via prompts
Date: Thu, 05 Mar 2009 09:15:29 -0600
Message-ID: <49AFEC91.10009@gmail.com>
References: <49AF25BF.5060706@gmail.com> <alpine.DEB.1.00.0903051149280.6524@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 05 16:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfFJh-0003jT-Tk
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 16:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbZCEPPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 10:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZCEPPR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 10:15:17 -0500
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:44713 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165AbZCEPPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 10:15:16 -0500
Received: from adsl-70-130-205-156.dsl.stlsmo.swbell.net ([70.130.205.156] helo=[192.168.1.108])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1LfFI0-0005PG-PW
	for git@vger.kernel.org; Thu, 05 Mar 2009 09:15:12 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903051149280.6524@intel-tinevez-2-302>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112310>

My thought was that if you had a password you didn't care about you could put it in the config.
It does ask you for a password with getpass, It compiles under cygwin, I havent tried it under
windows. However the man page for getpass shows the source so coding up getpass directly isn't a
big deal.

Junio, I'm new to this patch game and using Thunderbird. What's the best way
to wrap the patch?

-Mike

Johannes Schindelin wrote:
> Hi,
> 
> Disclaimer: if you are offended by constructive criticism, or likely to 
> answer with insults to the comments I offer, please stop reading this mail 
> now (and please do not answer my mail, either). :-)
> 
> Still with me?  Good.  Nice to meet you.
> 
> Just for the record: responding to a patch is my strongest way of saying 
> that I appreciate your work.
> 
> On Wed, 4 Mar 2009, Mike Gaffney wrote:
> 
>> Currently git over http only works with a .netrc file which required 
>> that you store your password on the file system in plaintext. This 
>> commit adds to configuration options for http for a username and an 
>> optional password. If a http.username is set, then the .netrc file is 
>> ignored and the username is used instead. If a http.password is set, 
>> then that is used as well, otherwise the user is prompted for their 
>> password.
> 
> From the subject, I would have expected a way to type in the password 
> instead of storing it.  (Think getpass()... which would pose problems 
> with Windows support, of course.)
> 
> FWIW by having it in .git/config (which is most likely more world-readable 
> than $HOME/.netrc ever will be) does not provide any security over .netrc.
> 
> And I doubt that http.username is a good choice: what if you have multiple 
> http:// URLs with different usernames/passwords?  So would it not make 
> more sense to make this remote.<name>.user and ...password?
> 
> Ciao,
> Dscho

-- 
-Mike Gaffney (http://rdocul.us)
