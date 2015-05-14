From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: determine a linux kernel version of a patch file
Date: Thu, 14 May 2015 19:25:05 +0200
Organization: gmx
Message-ID: <041beaedd8018f1759158e488b29a42b@www.dscho.org>
References: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pawel Por <porparek@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 19:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yswsk-0001aA-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 19:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbbENRZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 13:25:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:57796 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908AbbENRZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 13:25:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MLvLE-1Ypcxa2Qyy-007nxi; Thu, 14 May 2015 19:25:06
 +0200
In-Reply-To: <CAJmOuExq3WF26Gufr5bAA7w3=EMxJ80NKMXf8Dgi0TK7kVXStA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:lCYBsbpFoKEAocTrXoPJ4YKYQ4XIEkFbCxaZWBqwFgjFWNlv1mc
 n8FRqP2SK/a4w0yL6+IPtZv2XDIKI0JjHfnTCcNpsJbybBWrnwH/ucPPZuYRFI2MJN1wrgb
 bGLiHbp3BZLX2XudHmno6FdCq/M2TLZki72qhNDnxYwcNuq1mVZXREnaZP0E+unUIJI+MUF
 tV5v58o/DNBHvsPIZgryw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269051>

Hi Pawel,

On 2015-05-14 19:08, Pawel Por wrote:

> Most patches contain the index line. Is it the well known git index
> (staging area) ?
> Can I use the index to find the exact kernel version from which a
> patch was created.
> Please look at an example patch sent to LKML:
> https://lkml.org/lkml/2015/5/14/497
> 
> It contains the following index line:
> index 8dd1e55..9b0c81e 100644
> 
> I tried to find it using "git log" but I couldn't.

If you call `git log --raw` (possibly adding --all) and then search for 8dd1e55, you should at least get to the revision when this file was changed to the revision that served as base for the patch. To make it faster, you could call `git log --raw -- <filename>`. That would also have the advantage that you could scroll up again to see which revision, if any, modified the file again, giving you kind of a commit range from which to pick.

Ciao,
Johannes
