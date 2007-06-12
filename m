From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC][PATCH 00/10] Sparse: Git's "make check" target
Date: Tue, 12 Jun 2007 18:37:18 +0100
Message-ID: <466ED9CE.3000800@ramsay1.demon.co.uk>
References: <4669D2F2.90801@ramsay1.demon.co.uk> <466A5204.6060200@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: linux-sparse-owner@vger.kernel.org Tue Jun 12 19:45:23 2007
Return-path: <linux-sparse-owner@vger.kernel.org>
Envelope-to: gcps-linux-sparse@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAQk-0003AW-3r
	for gcps-linux-sparse@gmane.org; Tue, 12 Jun 2007 19:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXFLRpU (ORCPT <rfc822;gcps-linux-sparse@m.gmane.org>);
	Tue, 12 Jun 2007 13:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbXFLRpU
	(ORCPT <rfc822;linux-sparse-outgoing>);
	Tue, 12 Jun 2007 13:45:20 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:2215 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752997AbXFLRpT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Jun 2007 13:45:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1HyAQd-000Eza-Bf; Tue, 12 Jun 2007 17:45:16 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <466A5204.6060200@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49977>

Josh Triplett wrote:
> Ramsay Jones wrote:
>> fix most of those problems. (the output from "make check" was about 16k
>> lines at one point!). Git also tickled a bug in sparse 0.2, which resulted
>> in some 120+ lines of bogus warnings; that was fixed in version 0.3 (commit
>> 0.2-15-gef25961).  As a result, sparse version 0.3 + my patches, elicits 106
>> lines of output from "make check".
> 
> One note about using Sparse with Git: you almost certainly don't want to pass
> -Wall to sparse, and current Git passes CFLAGS to Sparse which will do exactly
> that.  -Wall turns on all possible Sparse warnings, including nitpicky
> warnings and warnings with a high false positive rate.

I have to say that, my initial reaction, was to disagree; I certainly want to
pass -Wall to sparse! Why not? Did you have any particular warnings in mind?
(I haven't noticed any that were nitpicky or had a high false positive rate!)

...  You should start from
> the default set of Sparse warnings, and add additional warnings as desired, or
> turn off those you absolutely can't live with.  

Why not "-Wall -Wno-nitpicky -Wno-false-positive" ;-)

... Current Sparse from Git (post
> 0.3, after commit e18c1014449adf42520daa9d3e53f78a3d98da34) has a change to
> cgcc to filter out -Wall, so you can pass -Wall to GCC but not Sparse.  

Yes, I noticed that. Again, I'm not sure I agree.
I didn't comment on that patch, because my exposure to sparse is very limited.
So far I've only run it on git, so I can hardly claim any great experience with
the output from sparse. However, 105 lines of output (which represents 71 warnings)
for 72,974 lines of C (in 179 .c files) did not seem at all unreasonable.

>> [Note: As far as the NULL pointer warnings are concerned, I don't much care either
>> way. I just used that as an example (also note patch 02). Having said that, I
>> do think that the "NULL is the only one true null pointer" brigade need to
>> chill out a little; in fact I remember when 0 was the *only* null pointer.]
> 
> And at one point prototypes didn't exist either. :)

Yes, but that was actually an improvement to the language ;-)

(As I say above, I don't really care about the NULL pointer example; I hope
the main point was not lost)

All the Best,

Ramsay Jones
