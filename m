From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] diff: Make numstat machine friendly also for renames
Date: Tue, 08 May 2007 21:59:23 -0700
Message-ID: <7vd51azj6c.fsf@assigned-by-dhcp.cox.net>
References: <11785850223782-git-send-email-jnareb@gmail.com>
	<200705080345.26817.jnareb@gmail.com>
	<7vhcqo5b64.fsf@assigned-by-dhcp.cox.net>
	<200705081433.58931.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 06:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleGw-000307-SH
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968860AbXEIE70 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968840AbXEIE70
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:59:26 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43536 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934992AbXEIE7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:59:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509045925.RWOQ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 00:59:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wszQ1W0071kojtg0000000; Wed, 09 May 2007 00:59:24 -0400
In-Reply-To: <200705081433.58931.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 8 May 2007 14:33:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46660>

Jakub Narebski <jnareb@gmail.com> writes:

>> The --stat format is for human consumption, and --numstat (be it
>> with -z or without) is for machines, so I am not opposed to a
>> format change that gives information that is already computed
>> but currently is hard to parse.  If the format change breaks
>> existing scripts, we might want to do --numstat-extended,
>> though...
>> 
>> For example, I do not see a reason not to add "R98" in there.
>> I.e.
>> 
>> 	added deleted status TAB "src" (TAB "dst"){0,1} LF
>> 	added deleted status NUL "src" (NUL "dst"){0,1} NUL
>> 
>> where the dst path is present only when status says it is a
>> rename/copy, just like the --raw format.
>
> That is a good idea, but wouldn't it break existing scripts? Well,
> break more than a bit hacky idea of using NUL NUL as separator between
> pre-image name and post-image name.

I think both would break equally.  That's why I hinted --numstat-extended,
but I think the information is getting to be about --machine-readable, and
not necessarily about "stat" anymore.
