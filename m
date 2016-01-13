From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase
 can be 'interactive'
Date: Wed, 13 Jan 2016 07:51:33 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130751130.2964@virtualbox>
References: <cover.1452612112.git.johannes.schindelin@gmx.de> <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de> <xmqqk2nes6cc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFHW-0002xe-Su
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 07:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbcAMGvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 01:51:42 -0500
Received: from mout.gmx.net ([212.227.15.15]:57791 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037AbcAMGvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 01:51:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaoHI-1ZusoQ1pWa-00kNpx; Wed, 13 Jan 2016 07:51:34
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqk2nes6cc.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/V8J/ERX5gxgnshQZ+UCzY7ueI7CTSjaQvD0IXNvD83PI6MUK4X
 lBpe127Dq5oZL7wPBDpzSG852Xvhqn7ifn2RsAQsgRyQ27g/g3P/y9v8IeZyN8aPvTk/RIK
 vBO44BdEROXTMJ6aI+qKmJZbpFv13Z8FhZocJYtnQHN8iMzl50N7QcX6sCNKhUpzdTd20kL
 B0y4LOg/4zwpFSk8Yz8Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ahjaF1bLWP0=:qLwBmnuZPELePGKflI2Zc7
 ZGARvAQq+9kyC2e6jjGUFki4hZoYem9Iil6gjNlFlVNgAtG6tuzCYJvlQcvw2jj2ZtHwfjKkG
 WOeB+NLYFff34DimnGCii3ZMXrW7x9whMmDopPNOy9gPNp1n//uitTLhYxON60A13Edxcg3gf
 TYvwlZhg+kF3PNRFGTGWZbYvUmOqzYt/gmvDLZZgy/ui16nKJOQJchOBrySSmNxpU+Ogy9fdJ
 9WRm1vNwwFAEFhNdFLMPQRfm+lCPKThpWY95dI7jpIx34lKgZ18943Yh0zfGTo/jJt7B2WAWv
 egkS3CssQ8CtCMyGnpo8E+IqVizEV3wYHo8AqL45Ckc01SXIpIoFpWmosA/4GGMsVgnrGzDLB
 peMb+2s9l30Pj+myUo46REMKPpmIuojsg7uqvvCfmeIxEKB838f1MtO7gE5upYw62eImB74J1
 3RNEY5P8zOBPW8HAKkXoXfP/Pci9meua/kqmtD823VxzcdpbIehtLVX64qLRtULEZL8M/WKlv
 /Hf7Pwr/PCcKbJEezdAJL2Ub9Y8bkZ6KTKt83/lmFwpeaeGdtH6sT2PRN4GZejemDaqY7wwMC
 i3qgr4lg9fkNKUGl6PmmYweShoqiua5i4paLm8+f8idZ+9X7Su5EqQAIXB8KkmzRNm3CB2nrA
 wMrvkugnqGGZCZi12psJOJQRF4DDlYS8XQOcuuHp4g2amw2Vqn6Pw5LtJo6AfccddcMLR0+oL
 LyzJ4G9Ry4iLTy2Gjn9OZUqvBS9dp5hGar3ojSUhUXSBUV0iwbG7QBL5/HOAyMBZvDYlsMI7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283882>

Hi Junio,

On Tue, 12 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/remote.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 6694cf2..0af8300 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -251,7 +251,7 @@ static int add(int argc, const char **argv)
> >  struct branch_info {
> >  	char *remote_name;
> >  	struct string_list merge;
> > -	int rebase;
> > +	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
> >  };
> >  
> >  static struct string_list branch_list;
> > @@ -312,6 +312,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> >  				info->rebase = v;
> >  			else if (!strcmp(value, "preserve"))
> >  				info->rebase = 1;
> 
> This should become NORMAL_REBASE, I would think, even though the
> resulting machine code should be identical.

Fixed in v2.

Thanks,
Dscho
