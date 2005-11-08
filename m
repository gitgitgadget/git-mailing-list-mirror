From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Errors cloning over http -- git-clone and cg-clone fail to fetch
 a reachable object...
Date: Tue, 8 Nov 2005 12:54:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511081252070.2649@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90511061354k5378a92ckc427841f90ec8b4@mail.gmail.com> 
 <46a038f90511061852h5cdf9539o34f69b4deb9f041a@mail.gmail.com> 
 <20051107043737.GI3001@reactrix.com>  <46a038f90511062050geee7e73qddcd52e3a2ec86df@mail.gmail.com>
  <20051107171446.GA4070@reactrix.com> <46a038f90511071837g474bdc44vf60dd0758511f24c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 12:55:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZS3N-0003Ky-Tc
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 12:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVKHLyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 06:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVKHLyO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 06:54:14 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1242 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965150AbVKHLyN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 06:54:13 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6FAF613F003; Tue,  8 Nov 2005 12:54:12 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 458D0B50F2; Tue,  8 Nov 2005 12:54:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA2B4B50EA; Tue,  8 Nov 2005 12:54:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 824B513F213; Tue,  8 Nov 2005 12:54:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90511071837g474bdc44vf60dd0758511f24c@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11327>

Hi,

On Tue, 8 Nov 2005, Martin Langhoff wrote:

> On 11/8/05, Nick Hengeveld <nickh@reactrix.com> wrote:
> 
> > You might try this to see exactly what request/response headers
> > curl thinks are passing back and forth.
> 
> It definitely looks like it's doing a few requests in parallel and
> getting them mixed up. BTW, this repo is public and sitting on a box
> that doubles up as kernel mirror -- feel free to hit it ;-)

It could be a similar problem to what I experienced in http-push: 
Uninintialized memory due to the code path. Can you run

	valgrind --leak-check=yes --show-reachable=yes git-http-fetch...

and check for jump depending on uninitialized memory?

Hth,
Dscho
