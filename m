From: Max Horn <max@quendi.de>
Subject: Re: Bug on OS X...
Date: Fri, 28 Jun 2013 14:44:57 +0200
Message-ID: <9DD46E0F-FA9C-4C60-A1CE-03EAAD823967@quendi.de>
References: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Jun 28 15:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsYOX-0002Q3-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 15:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841Ab3F1NHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 09:07:15 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45543 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754149Ab3F1NHO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 09:07:14 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2013 09:07:14 EDT
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1UsY2s-0003WS-4D; Fri, 28 Jun 2013 14:44:58 +0200
In-Reply-To: <CAEBDL5VeE7dyo_A7904SBNSvf834xdGyyuk=vE44wXoRVJ-nkg@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1372424834;6f5994d3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229194>


On 27.06.2013, at 12:17, John Szakmeister wrote:

> I wanted to look at some OpenWRT bits this morning and ran into an
> issue cloning the packages repository when setting up the package
> feed.  The feeds script executes this under the hood:
> 
>   git clone --depth 1 git://nbd.name/packages.git feeds/packages
> 
> When trying to run the command directly on OS X, I see:
>   :: git clone --depth 1 git://nbd.name/packages.git
>   Cloning into 'packages'...
>   remote: Counting objects: 4728, done.
>   remote: Compressing objects: 100% (4013/4013), done.
>   remote: Total 4728 (delta 158), reused 3339 (delta 94)
>   Receiving objects: 100% (4728/4728), 3.85 MiB | 1.79 MiB/s, done.
>   Resolving deltas: 100% (158/158), done.
>   error: unable to find 9f041557a0c81f696280bb934731786e3d009b36
>   fatal: object of unexpected type
>   fatal: index-pack failed
> 
> I tried on Linux, and it succeeded.  I tested with both 1.8.2 and
> 1.8.3.1.  Unfortunately, I don't have time to dig through what's wrong
> at the moment so I thought I'd put it out there for others.

I am unable to reproduce this on Mac OS X 10.7.5 with git 1.8.3.1 nor with current git maint. Command run inside /tmp, which is on a normal HFS+ volume (using the default settings, i.e. the FS is case insensitive).


$ git --version
git version 1.8.3.1.42.ge2652c0
$ git clone --depth 1 git://nbd.name/packages.git
Cloning into 'packages'...
remote: Counting objects: 4711, done.
remote: Compressing objects: 100% (3998/3998), done.
remote: Total 4711 (delta 157), reused 3326 (delta 94)
Receiving objects: 100% (4711/4711), 3.85 MiB | 0 bytes/s, done.
Resolving deltas: 100% (157/157), done.


Cheers,
Max
