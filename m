From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 19:10:26 +0100
Message-ID: <45D35092.8040901@xs4all.nl>
References: <200702140909.28369.andyparkins@gmail.com> <slrnet5p5h.s9h.siprbaum@xp.machine.xx> <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, junkio@cox.net,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:11:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOax-0005RO-02
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXBNSKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXBNSKy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:10:54 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:2912 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXBNSKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:10:53 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1EIAHOe077134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Feb 2007 19:10:17 +0100 (CET)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39714>

Johannes Schindelin escreveu:
> The settings in /etc/gitconfig can be overridden in ~/.gitconfig,
> which in turn can be overridden in .git/config.

> +#define ETC_GITCONFIG "/etc/gitconfig"

> +		if (!access(ETC_GITCONFIG, R_OK))
> +			ret += git_config_from_file(fn, ETC_GITCONFIG);

this is a stupid idea.  

This should use the path given as the --sysconfdir argument to configure. 
If the configure result is not available, it should default to $prefix/etc/ 

It should be possible to install private copy of Git without being affected
by system wide defaults.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
