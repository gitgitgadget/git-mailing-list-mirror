From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: gitweb.cgi bug
Date: Sat, 8 Feb 2014 11:29:13 -0500
Message-ID: <0FE68796-BA98-4DF7-AD30-C42D78A87DCE@kellerfarm.com>
References: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>
To: Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 17:29:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCAmP-0006tQ-Le
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 17:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbaBHQ3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 11:29:17 -0500
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:49480 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393AbaBHQ3Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Feb 2014 11:29:16 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.206])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s18GTFIK027206
	for <git@vger.kernel.org>; Sat, 8 Feb 2014 11:29:15 -0500
Received: (qmail 26881 invoked by uid 0); 8 Feb 2014 16:29:15 -0000
X-TCPREMOTEIP: 23.28.12.255
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?192.168.0.103?) (andrew@kellerfarm.com@23.28.12.255)
  by 0 with ESMTPA; 8 Feb 2014 16:29:14 -0000
In-Reply-To: <CAE8XmWqH__rx+OvO-xOejWz_TrQitJ2rHJgp1gxOzNVNmrkJmQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241838>

On Feb 8, 2014, at 8:37 AM, Dongsheng Song wrote:

> I have an git repo PROJECT.git, the full path is /srv/repo/git/PROJECT.git,
> when I set git_base_url_list in gitweb.conf:
> 
> @git_base_url_list = qw(https://192.168.30.239/repo/git
>                            git@192.168.30.239:repo/git);
> 
> I got the result:
> 
> https://192.168.30.239/repo/git/PROJECT.git
> git@192.168.30.239:/PROJECT.git
> 
> This is wrong, it should be (without the leading '/')
> git@192.168.30.239:PROJECT.git

There is no way to generate a fetch url of 'git@192.168.30.239:PROJECT.git' in gitweb.

If one of the base urls was 'git@192.168.30.239:.', then you could get a fetch URL of 'git@192.168.30.239:./PROJECT.git'

In general, though, I like to stay away from relative paths.  Weird things can happen, like HTTP works but SSH doesn't, because the home directory for SSH changed because you used a different user.

 - Andrew
