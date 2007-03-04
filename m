From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 03 Mar 2007 19:42:06 -0800
Message-ID: <7vwt1x7jzl.fsf@assigned-by-dhcp.cox.net>
References: <200703032032.47158.johannes.sixt@telecom.at>
	<200703032121.59468.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Mar 04 04:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNhc1-0007Hq-5w
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 04:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbXCDDmK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 22:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbXCDDmK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 22:42:10 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42247 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030578AbXCDDmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 22:42:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304034207.SQBU3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 22:42:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WTi71W0091kojtg0000000; Sat, 03 Mar 2007 22:42:07 -0500
In-Reply-To: <200703032121.59468.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sat, 3 Mar 2007 21:21:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41344>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Saturday 03 March 2007 20:32, Johannes Sixt wrote:
>> If the file system does not support symbolic links (core.symlinks=false),
>> merge-recursive must write the merged symbolic link text into a regular
>> file.
>
> But how to resolve such a conflict if core.symlinks=false?
>
> It turns out that git-add cannot honor the symlink property recorded in the 
> index because read_cache.c:add_file_to_index() will find only entries at 
> stage 0, but the conflicting entries are at stages 2 and 3. Can there be 
> something done about that?

You can always use --index-info.
