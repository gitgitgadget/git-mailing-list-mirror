From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: undocumented =?UTF-8?Q?core=2EsharedRepository=3D=32=20set=20?=
 =?UTF-8?Q?by=20git=20init=20--shared=3Dworld?=
Date: Tue, 07 Jul 2015 10:14:28 +0200
Organization: gmx
Message-ID: <b9f56a351da062698ad629d77d3752b7@www.dscho.org>
References: <20150706192547.GA15396@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Jul 07 10:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCO1X-00014Z-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 10:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbbGGIOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 04:14:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:51168 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711AbbGGIOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 04:14:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVsUW-1ZWIRx0U48-00X6jE; Tue, 07 Jul 2015 10:14:29
 +0200
In-Reply-To: <20150706192547.GA15396@kitenet.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:wJ56RntX34yRYVXsH/F9BYMsPx4kwwn9liOkcP6+fRW9Di97VYl
 yIx0/wodqsN+4lq6s4VzuX3v8fBHtYhA2LP2rQdwf9qI3/YzQXiUVKV6ys9R+y/ex96toN0
 0Zgm8U9dPTsKuFZoBync8C6iguJ/zW+2lNbUTcbibnKMrnRgfgicEQzCV49hwhkUOqfkK/j
 LY8j7XtSSVmP2HNxZrraA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BY6A5bLw3z8=:AhKXAfM0Xrt07sECj4ML3c
 JISUF89trh9zVR5eL94cl8eicjRKjShNZe+/NDyuAsty6ljEI0j+PzQXpBoJInFeTWm9wJe7H
 +xPwna6vWnzXLAcb5pN6pdo/qLBC9bAFU3SYXM7z8gajsoL88MRd6ElCSzp6Ff6/dk3LoAPlz
 wAEkwfEiwuelOhTt9O6Snjzg8Gj7siUt6mD4x+jlO3ROGnIkYOo2UIlsPNd7fiTOL2l8Lg+P+
 FVfMmxzA7P0LNzuWmv71qGyu1vbi8oVjVR/unTM3khhxAcrxg/xGPXc/UZIcNvdHb4wSHew5P
 7zQJjRG3YCW5b6h6uy0geXPeoZ5WFi1erEi0gZc2cQ7tfGp7nP4hUOYwrq+keM8TYjzfb+ky5
 taLnI89ZyGvGlfk++dzYJT5gcUsygg03mVUXxi3j+ni+N0RYSJkPM7k2rDUYY0Vy0P/B7tG1j
 1XRBD8JU1EkAIHyvfwcFpP0PdjgbJ2fZI6Bs0p5jjzjj/DbJLBq03GrIpQYY3uLoMFj/hSuDD
 CUvRBwwVeiWXJH4J1m9lfegf0BsfJmIcqlq5pv24JfVMK4jw5goECoFdXP8HbVhAOVbQlTyeS
 FkwWXFTkGRZdYeiSO9Eqg2+Ro64Gm6RcLPxOGdEKydQA9N3hQitAXzskBWscQaEB3p+124ucb
 mN5RjVwVh7my+cgSghisDn0tv5Bayy8M18YvVgNDW2uJXIp0H9aBYSLcTnckEn+kVJbE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273489>

Hi Joey,

On 2015-07-06 21:25, Joey Hess wrote:
> joey@darkstar:~/tmp>git init --shared=world testrepo
> Initialized empty shared Git repository in /home/joey/tmp/testrepo/.git/
> joey@darkstar:~/tmp>grep shared testrepo/.git/config 
> 	sharedrepository = 2
> 
> This magic value of 2 seems to be undocumented, as is the magic value of 1
> that's equvilant to "group".
> 
> I think it would be better to have git init put in "world" or "group" and not
> these magic values. Anyway, I suppose they ought to be documented too.

The rationale can be found here: https://github.com/git/git/blob/v2.4.5/builtin/init-db.c#L413-L418

		/* We do not spell "group" and such, so that
		 * the configuration can be read by older version
		 * of git. Note, we use octal numbers for new share modes,
		 * and compatibility values for PERM_GROUP and
		 * PERM_EVERYBODY.
		 */

I am sympathetic to your wish, of course, and I am sure that you understand why we cannot simply break other people's setups to satisfy it.

Ciao,
Johannes
