From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH V2 1/3] strbuf: add tests
Date: Tue, 7 Jun 2016 10:44:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606071042290.28610@virtualbox>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr> <20160606151340.22424-2-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	peff@peff.net, mh@glandium.org, gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 10:45:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACdE-0006Ll-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbcFGIo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 04:44:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:49182 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304AbcFGIoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 04:44:55 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MOw4N-1b4Rzp3eR5-006QvV; Tue, 07 Jun 2016 10:44:19
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160606151340.22424-2-william.duclot@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:h1x0EwJH3GDWtwSlUnwBEGn6EosG3nyhtgyG+3zJEjEUi/Z0Xlw
 gQafpkk1PJfhABt7Ic4wIzUkiC1wpCrVoUF3gwh8+1RmqtEIq4Xygg985RF82AXqBd4/MBQ
 ZmqL3+4bf+FMGoqcLvmuNbA35SO8nhbenFV01rOtLQGXIQHD6PlEaL5M3eHlC5PHMLijuPI
 JBPlR7W1XY1qzhnLS08Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DwJwUflRcvI=:FXP4yOiZa8v35s9cMiN18D
 ETeqMZ9hmv5/SNABDrbTPxsTZqgkX9m/RlcaeHyRKye3Qnb4sImsclci6jegmDYLO2bzkc2/K
 gVAc8iNVSaWxGiKk63YNA5tF4HQcoVW37fBNZ8hEy/9aZyl0re3JCQ02Gn3ed9p+vX24BNxcu
 FxTU18RJ8u875If6StQ/WYTvo3cqEdTvnxlvZlQODjb2tlWPPC7ruk/O5EfIQqjH47splsS3t
 v4vMgQsK/a8X8guLVEFyL0OEWRvhFPbjMzyNPSzAX2YD0UfZiSg88DmMDoj5cM51qkHiLlGY3
 7GWzhuuf50/yj8gGs2y2627Lr05VPG2a0OqZ2eTzLW3iDwq39Q1gckhzDQsrYvzL9EVZggKsn
 liHYvuyo4w6Guo6WWjqyxielIg1QPGqyu0Fxelr2q/sJJXwfRCEyDBIe7VHnUOwMO/kV513LN
 xTB9AZUbQt4JFgqfM8XMS96egp2EjWHuAwnEzLZoRvbx488jQDi9vNj1QQv+G9j9PFWunFr5q
 1Wm6VH/w2Wv6xc8fmmyzQAnwBo6gSw9y1XTUXn8iVoSwkl69QplvpHzotuoQXA+7WGB7gFtdE
 /bI4P2c8zoH25SELQWifcYH3ACMymN09dkQh0elCYkVF5zzsSf95dAWYZ8PyEhm43yk9yrv3Z
 Z6oVd51THeeKOIsAZ5Rpw3ioc4/sQmXYPxYSeX2krOwNQS6L9ZUvONgXTAsHRggiBGLee6LlV
 GEWh48PaBquePmavdOL8d7CK102RnGZ8F47a1ujoLcN/uZMFdNsyYnDaodOcSXpZUVBr3yAJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296616>

Hi William,

On Mon, 6 Jun 2016, William Duclot wrote:

> +	enum {
> +		MODE_UNSPECIFIED = 0,
> +		MODE_BASIC_GROW ,
> +		MODE_STRBUF_CHECK,
> +		MODE_GROW_OVERFLOW
> +	} cmdmode = MODE_UNSPECIFIED;
> +	struct option options[] = {
> +		OPT_CMDMODE(0, "basic_grow", &cmdmode,
> +			    N_(" basic grow test"),
> +			    MODE_BASIC_GROW),
> +		OPT_CMDMODE(0, "strbuf_check_behavior", &cmdmode,
> +			    N_("check the strbuf's behavior"),
> +			    MODE_STRBUF_CHECK),
> +		OPT_CMDMODE(0, "grow_overflow", &cmdmode,
> +			    N_("test grow expecting overflow"),
> +			    MODE_GROW_OVERFLOW),
> +		OPT_END()

I found it to be really helpful to keep as much consistency as possible
(Git's source code is complicated enough, no need to make it even more
complicated).

In this particular instance, I would suggest to rename either
MODE_STRBUF_CHECK or strbuf_check_behavior to match the other one.

Ciao,
Johannes
