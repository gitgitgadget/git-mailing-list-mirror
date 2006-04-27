From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 11:56:22 -0700
Message-ID: <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net>
References: <20060427101254.GA22769@peppar.cs.umu.se>
	<Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 27 20:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZBf9-0003If-9i
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 20:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWD0S4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 14:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWD0S4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 14:56:24 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11704 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964928AbWD0S4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 14:56:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060427185623.HFUG21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 14:56:23 -0400
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
	(Nicolas Pitre's message of "Thu, 27 Apr 2006 09:23:47 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19239>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 27 Apr 2006, Peter Hagervall wrote:
>
>> Answering the call Linus made[1], sort of, but for a completely
>> different program.
>> 
>> Anyway, it ought to be at least as portable as the shell script, and a
>> whole lot faster, however much that matters.
>> 
> [...]
>> +	for (i = 0; i < 16; i++) {
>> +		subdir[0] = hex_digits[i];
>> +		for (j = 0; j < 16; j++) {
>> +			subdir[1] = hex_digits[j];
>> +			if (access(subdir, R_OK | X_OK))
>> +				continue;
>> +			chdir(subdir);
>> +			if (!(dp = opendir("."))) {
>> +				error("can't open subdir %s", subdir);
>> +				continue;
>> +			}
>
> Looks like you're missing a chdir(".."); there.

Why would you even _need_ to chdir() anywhere, anyway?
