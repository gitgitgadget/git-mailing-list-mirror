From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Tue, 10 Mar 2009 09:08:58 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903100905050.14797@yvahk2.pbagnpgbe.fr>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com> <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 09:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgx5a-0000YE-AO
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 09:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZCJIL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbZCJIL5
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 04:11:57 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:47319 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbZCJIL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 04:11:56 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2A8Bl3U008878;
	Tue, 10 Mar 2009 09:11:47 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112790>

On Mon, 9 Mar 2009, Junio C Hamano wrote:

> The version of libcurl on my box is 7.18.something, and it does not seem to 
> ask for password when the URL has only username but not colon-password. I 
> also expected it to ask for password when $HOME/.netrc has login but not 
> password for a given machine, but that does not seem to happen either. 
> Perhaps the version is too old.

No, that's entirely expected. libcurl has no "prompt the user if no password 
was given" logic but instead delegates that work to the application.

There was once functionality for this (removed in October 2003) but it was 
broken and violated internal guidelines so we cut out and threw that code 
away.

More recently there have been people interested in re-implementing this "the 
right way" but so far it hasn't been made and thus the application is left to 
perform this task.

-- 

  / daniel.haxx.se
