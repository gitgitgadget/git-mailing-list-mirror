From: Johan Herland <johan@herland.net>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 12:59:42 +0200
Message-ID: <200907131259.42313.johan@herland.net>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Peter Voss <info@petervoss.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 13:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQJGj-0003zw-TC
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 13:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbZGMK76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 06:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbZGMK76
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 06:59:58 -0400
Received: from sam.opera.com ([213.236.208.81]:37319 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266AbZGMK75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 06:59:57 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n6DAxgF2024302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Jul 2009 10:59:51 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123185>

On Monday 13 July 2009, Peter Voss wrote:
> Hi,
>
> I want to use the git submodule feature to move part of my code to a
> different repository at github.
>
> The issue is that developers should use different repository URLs for
> the submodule depending on whether they have commit rights or not.
>
> At the beginning I was using the public URL to set-up the submodule:
> git submodule add git://github.com/x/mymodule.git mymodule
>
> The issue is that some developers are working behind a firewall that
> blocks the git protocol. These could only use the git@github.com:x/
> mymodule.git URL to get access.
> But other developers can only go through the public URL git://
> github.com/x/mymodule.git. So whatever I use it won't work for
> everybody.
>
> What's the best way to deal with that? Could I set-up different
> repository URLs for one and the same submodule and use which one is
> appropriate?

You might be able to pull this off using relative submodule URLs. If the 
submodule URLs in .gitmodules are relative (i.e. ../foo.git or 
similar), they will be resolved to absolute URLs using the origin URL 
of the super-repo. I.e. if you cloned the super-repo from 
git://github.com/x/mymodule.git, the ../foo.git submodule will be 
cloned from git://github.com/x/foo.git, and if you cloned from 
git@github.com:x/mymodule.git, the submodule will be cloned from 
git@github.com:x/foo.git.

Hope this helps,


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
