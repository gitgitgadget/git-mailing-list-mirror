From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH] gitk: Take only numeric version components when computing
 $git_version
Date: Tue, 18 Jan 2011 10:12:06 +0100
Message-ID: <4D355966.7090707@debugon.org>
References: <4D231646.5080005@debugon.org> <1294360953.21006.2.camel@fixed-disk> <4D2C5F3E.2020007@debugon.org> <20110113192243.GA20625@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@MIT.EDU>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 10:12:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf7by-0004WL-V0
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 10:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1ARJMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 04:12:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64712 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1ARJMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 04:12:16 -0500
Received: from [172.20.2.23] (p5485547A.dip.t-dialin.net [84.133.84.122])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LnDWH-1QArOc1mG5-00hv4I; Tue, 18 Jan 2011 10:12:07 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
In-Reply-To: <20110113192243.GA20625@burratino>
X-Provags-ID: V02:K0:YHIfVbH3Wmkw0ZBlfQThzczlq1bLnXt6kKR3827aTKG
 jjPoqfV4CCUnC1gy6uqd31vTdzBVx2sy3c9e0+xnwMn3v0bLg1
 qtB6KsjgbCA6dPAP4MqTvX5uwjeqJ5J2BW11UsjUG8f+Rh4MIS
 F9wYbZfDzRjQbpWlM8n+yWgV7UUmiId6/H+zsJIxExhrs0WDCz
 HzfTTQamhvF+XD2EjD7Z4ZPVTT8iilWrpYwxVjQqco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165197>

Jonathan Nieder wrote:
> [...]
> So after building from a tarball generated with "git archive", "git version"
> produces v1.7.4-rc1, producing errors from gitk, but after building
> from the git repo or a tarball generated with "make dist", the version
> is v1.7.4.rc1 (which gitk accepts).
> 
> Anders's fix looks good to me for robustness reasons anyway, so
> 
>  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 

OK then. Junio? :)

> Maybe the substitution in GIT-VERSION-GEN should say something like
> 
> 		VN=$(echo "$VN" | sed -e 's/-\([^r]\)/.\1/g')
> 
> meaning the result for tagged rcs would not depend on whether git is
> present?  Alternatively, DEF_VER could be set to v1.7.4.rc1, which
> does not seem as nice to me.
