From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/4] compat/basename: make basename() conform to
 POSIX
Date: Wed, 13 Jan 2016 08:14:09 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130803440.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <a7375faaba405354b30bc19c6edbdb1ef7c68ab1.1452585382.git.johannes.schindelin@gmx.de> <56959EFF.6050207@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:14:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFdU-0000VW-Nv
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbcAMHOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:14:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:64333 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbcAMHOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:14:24 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlGoc-1ZjNBI0GLm-00b0bL; Wed, 13 Jan 2016 08:14:14
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56959EFF.6050207@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:o98sbpZnlEnCQX3wIcIKGnKZJUu5d2to4LV4OPPY1Hak5nlKRGy
 0G5IrlcHDV1vXB2p8cELbOALRw9J+2hFshh1iaUJq43qlBwEmPF97GCBvI4WqiCUTZ7uyIX
 IPQzwHGSFlHQ7QxC0n9IrfHwrGoZo/KgN0jRILL7DOJJWstqRLzGaTyRGj1NyFBRJDR/J8R
 8OIBuKFHl9W/P45Q0JNiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MMZynmhW7Ys=:zeYA94tFEuwhncj2IhMjf8
 CYO6n53UDScXxQWddwmfuSEirJ4FcW2292jMZkQGnP1iSxJF6xULYjKeuHrs57Ppn4G5vPbXz
 aeix7w1sGRGOcft+bLQie2hvUjef2CPDPic2ZAZNPloufb0O8Jdy3hQRPZpcTWsNmk+r1EFG1
 iwsFixtJ9MLcYXti9q0u66HqB+k18tvOhXtFpqUAvYStaHq6LNNb06J+Orv/Jw/rUU54s8RY7
 THayTDw20oIyq3sZdsB/sMnt7EGH/lVUU5XqMm/XA20EPspcp7QqsgMMXW0bucqMro70+Hbw4
 limIL6sMidzdbSlR4wuuKgmtZ8j0PstqB8NsRCfjMYaO2iLOV4AkPAQauatq1A3QCrOkF/gEk
 jLn09tt9ygDhCUQr/cQVeuFKBpvX2yvNuRl1B58Z7KwZKSrhywTBeZ4ZdA4Bgiw+pxgac/53S
 C9ukLTqOjWA/HUakeHnD4ZpIAHKWq0/sYxqYhQ7QLaJPjiGYW+vUh0T7onSlkHnUIv5yf6dWF
 DBBAyP0u0Rg5XnLi3wAeISiCl97VHJU3uk+o9BCh9Ft1M9Vd6FruRHvGjD/rb1+9fVIJ6OYdp
 36F6FEGpjlwyZAer639Uk2NXt02P49N33FgR0zaQhEiwvmmL54RO8gB3HIqSkFWZw5NX6z25w
 ArnwuQzEVIBTnvTiIeJF3WCt+KXi3F4SLLnqYnaB7hMQzRbuBs+ybzqUOot9B0qQEAtkJx99p
 5jtCI1jNTJun7+8zf5rQczDCv/CUVG2PNDHhWlRReoiIjlVqnHAfkGXgR+3yM6TTmc3RWD48 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283891>

Hi Ramsay,

On Wed, 13 Jan 2016, Ramsay Jones wrote:

> On 12/01/16 07:57, Johannes Schindelin wrote:
> > diff --git a/compat/basename.c b/compat/basename.c
> > index 9f00421..0f1b0b0 100644
> > --- a/compat/basename.c
> > +++ b/compat/basename.c
> > @@ -4,10 +4,24 @@
> >  char *gitbasename (char *path)
> >  {
> >  	const char *base;
> > -	skip_dos_drive_prefix(&path);
> > +
> > +	if (path)
> > +		skip_dos_drive_prefix(&path);
> > +
> > +	if (!path || !*path)
> > +		return ".";
> > +
> >  	for (base = path; *path; path++) {
> > -		if (is_dir_sep(*path))
> > -			base = path + 1;
> > +		if (!is_dir_sep(*path))
> > +			continue;
> > +		do {
> > +			path++;
> > +		} while (is_dir_sep(*path));
> > +		if (*path)
> > +			base = path;
> > +		else
> > +			while (--path != base && is_dir_sep(*path))
> > +				*path = '\0';
> >  	}
> >  	return (char *)base;
> >  }
> > 
> 
> I don't suppose it makes much difference, but I find my version
> slightly easier to read:

Yours is better documented, yes, but as I said, I started from what Git
already had and tried to provide as minimal changes as possible, to make
reviewing easy. In any case, I am very reluctant when it comes to
wholesale code replacements: in my experience, these frequently lead to
new, entertaining and unintended behavior. I worked with somebody who (for
the sake of charity) in the following I will reference only by his most
frequent commit message: Dr "Completely new version" (and yes, this was
the extent of the commit message). If you buy me a beer or three, I will
gladly tell you all the fun I had trying to find the regressions in that
code.

In short: please accept that my decision to build on the existing code
rather than replacing it had nothing to do with your code.

Ciao,
Dscho
