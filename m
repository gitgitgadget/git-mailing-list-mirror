From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v6] submodule: add 'deinit' command
Date: Wed, 6 Mar 2013 07:52:46 +0100
Message-ID: <20130306065246.GB4064@sandbox-ub>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
 <511BEA75.6000002@web.de>
 <7vip5w6l8s.fsf@alter.siamese.dyndns.org>
 <5121384B.10009@web.de>
 <7v38wufu5t.fsf@alter.siamese.dyndns.org>
 <51227EFE.6030908@web.de>
 <51351018.20301@web.de>
 <20130305072944.GA4677@sandbox-ub>
 <7vppzdvoj1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 07:53:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UD8E3-00083u-VA
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 07:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab3CFGwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 01:52:54 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:51311 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3CFGwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 01:52:53 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UD8DW-0006XC-Uf; Wed, 06 Mar 2013 07:52:47 +0100
Content-Disposition: inline
In-Reply-To: <7vppzdvoj1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217497>

On Tue, Mar 05, 2013 at 07:45:22AM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> >> +			if test -z "$force"
> >> +			then
> >> +				git rm -n "$sm_path" ||
> >> +				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
> >
> > Minor nit. IMO, there is an indentation for the || missing here. Maybe
> > Junio can squash that in on his side?
> 
> Sorry, but I do not see an indentation nit here.  The format looks
> perfectly sane to me and in fact any other indentation would be
> wrong.
> 
> Puzzled...

Wouldn't you write this code snippet like this to make clear that there
is another conditional?

	if test -z "$force"
	then
		git rm -n "$sm_path" ||
			die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"

It seems it is not clear in the code base either. Some places do
some do not indent:

  git grep -A 1 '||' *.sh

Except for the testsuite I just assumed that this style was common,
because for me it makes the code much easier to read.

It seems it is not, so forget my comment.

Cheers Heiko
