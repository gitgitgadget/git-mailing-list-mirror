From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn test suite failures due to Subversion race
Date: Mon, 12 Feb 2007 22:17:48 -0800
Message-ID: <7vps8e1sz7.fsf@assigned-by-dhcp.cox.net>
References: <45CFDFDE.8080907@uwaterloo.ca>
	<20070212103822.GA21413@localdomain> <45D1239C.4040706@gmail.com>
	<20070213032137.GA28534@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Spang <mcspang@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 07:17:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGqzC-0007ke-A2
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 07:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXBMGRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 01:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbXBMGRu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 01:17:50 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46248 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161095AbXBMGRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 01:17:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213061750.PXBB1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 01:17:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NuHo1W00q1kojtg0000000; Tue, 13 Feb 2007 01:17:49 -0500
In-Reply-To: <20070213032137.GA28534@localdomain> (Eric Wong's message of
	"Mon, 12 Feb 2007 19:21:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39500>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks for the patch.  Just one portability nit below, otherwise:
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
>> +poke() {
>> +	touch -r "$1" -d +1sec "$1"
>> +}
>
> I'm not sure that -d is portable.  However,
>
>   perl -e '@x = stat($ARGV[0]); utime($x[8], $x[9] + 1, $ARGV[0])' "$1"
>
> should work on any platform git-svn runs on.

Sounds sensible, as git-svn wants perl-svn libraries already
anyway.
