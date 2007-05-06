From: Michael Spang <mspang@uwaterloo.ca>
Subject: Re: [PATCH/RFD 4/3] t7300: Tests for git-clean using filenames with
 spaces/punctuation
Date: Sun, 06 May 2007 15:14:04 -0400
Message-ID: <463E28FC.9080209@uwaterloo.ca>
References: <463E1705.2090201@gmail.com> <463E19F6.9000906@uwaterloo.ca> <7vr6ptbx5g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 21:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkmBd-0007Ru-Bu
	for gcvg-git@gmane.org; Sun, 06 May 2007 21:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXEFTOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 15:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXEFTOR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 15:14:17 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:65234 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100AbXEFTOQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 15:14:16 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46JEBwN026654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 15:14:12 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <7vr6ptbx5g.fsf@assigned-by-dhcp.cox.net>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 15:14:13 -0400 (EDT)
X-Miltered: at mailchk-w01 with ID 463E2903.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 4c509a2a-2a4c-4a49-9dd9-d733dc188950
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46364>

Junio C Hamano wrote:
> Michael Spang <mspang@uwaterloo.ca> writes:
> 
>> Is this even properly solvable without making clean a builtin or
>> writing git-unescape?
> 
> If you know how to use "xargs -0" and are willing to depend on
> the -0 GNU extension, then the answer is yes.

Right. But I do not think xargs can call a shell function. git-clean
does not just call git-rm directly. I guess git-clean could call
itself through xargs, but that might become confusing.

> I do not use git-clean myself, as I do not see what (I think) it
> tries to solve as a problem to begin with, so obviously I do not
> care too deeply about the command's implementation --- I just
> let it be there because there seem to be others who want it ---
> but if I were asked an advice on the right direction to proceed,
> I would probably suggest rewriting it in C.

That seems like the cleanest solution to me as well.

Cheers,
Michael Spang
