From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Wed, 14 Feb 2007 11:07:35 -0800
Message-ID: <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, junkio@cox.net,
	git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Feb 14 20:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHPTf-0004GH-S9
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 20:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbXBNTHh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXBNTHh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 14:07:37 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61995 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457AbXBNTHg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 14:07:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214190735.PYSI4586.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 14:07:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PX7b1W00P1kojtg0000000; Wed, 14 Feb 2007 14:07:36 -0500
In-Reply-To: <45D35092.8040901@xs4all.nl> (Han-Wen Nienhuys's message of "Wed,
	14 Feb 2007 19:10:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39725>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Johannes Schindelin escreveu:
>> The settings in /etc/gitconfig can be overridden in ~/.gitconfig,
>> which in turn can be overridden in .git/config.
>
>> +#define ETC_GITCONFIG "/etc/gitconfig"
>
>> +		if (!access(ETC_GITCONFIG, R_OK))
>> +			ret += git_config_from_file(fn, ETC_GITCONFIG);
>
> this is a stupid idea.  

Stupid probably is too strong a word, but I think I'd agree we
should default it to $(prefix)/etc and have distros override it
in the Makefile.
