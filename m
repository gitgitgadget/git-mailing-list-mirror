From: Johan Herland <johan@herland.net>
Subject: Re: Internal, corporate, shared hosting solutions
Date: Fri, 26 Sep 2008 20:17:15 +0200
Message-ID: <200809262017.15916.johan@herland.net>
References: <8B29890D-C03B-4ECE-9BEF-0A8E8EF7233E@netspot.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tom Lanyon <tom@netspot.com.au>, pasky@suse.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 26 20:18:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjHtp-0006UW-CO
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 20:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYIZSRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 14:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbYIZSRc
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 14:17:32 -0400
Received: from sam.opera.com ([213.236.208.81]:53192 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbYIZSRb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 14:17:31 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8QIHGDL008405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 26 Sep 2008 18:17:21 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <8B29890D-C03B-4ECE-9BEF-0A8E8EF7233E@netspot.com.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96881>

On Friday 26 September 2008, Tom Lanyon wrote:
> Hi list,
>
> I'm struggling. There's been a recent adoption of git here by our
> development staff, which is great. However, from an administrative
> point of view, I'm having trouble finding a solution to provide some
> kind of easy, shared, secure and accessible hosting solution to our
> developers.
>
> [...]

I'm pretty much in the exact same situation at $dayjob, and I'm 
researching some alternatives as well. So far there seems to be a 
couple of options:

1. Gitosis [1]. This is a fairly thin layer of Python scripts running as 
a non-privileged "git" user on the server. All users authenticate by 
registering their SSH key with Gitosis, and then access repos using 
this one "git" user over SSH. Further access control (i.e. read/write 
access to each repo) is done by Gitosis itself, and administered by 
cloning a gitosis-admin repo, changing some configuration files and 
pushing the result back to the server.

2. Gitorious [2]. Don't confuse this with the repo hosting service at 
gitorious.org. You can clone the software that runs gitorious.org and 
set it up on your own server. This is a much more heavy-weight 
Ruby-on-Rails application that provides a nice web interface for 
publishing and interacting with repositories. However, it is based on 
the same underlying principle of registering your SSH-keys with 
Gitorious, and running everything as a non-privileged "git" user.

3. repo.or.cz. I don't know much about how this work, and if it's easily 
deployed on an in-house server. However, the repo.or.cz admin (Petr 
Baudis, CCed) is active on this list, and can probably fill in the 
details.


Feel free to keep me updated on your progress.


Have fun! :)

...Johan


[1]: Gitosis: 
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
Get it at http://eagain.net/gitweb/?p=gitosis.git;a=summary

[2]: Gitorious: http://gitorious.org/
Get it at http://gitorious.org/projects/gitorious

-- 
Johan Herland, <johan@herland.net>
www.herland.net
