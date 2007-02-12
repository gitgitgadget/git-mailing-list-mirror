From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Sun, 11 Feb 2007 21:36:26 -0500
Message-ID: <45CFD2AA.5090509@verizon.net>
References: <45CFA30C.6030202@verizon.net>
 <Pine.LNX.4.63.0702120028340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqodam$r17$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 03:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGR3R-0001qi-RA
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 03:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbXBLCgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 21:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbXBLCgb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 21:36:31 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:11816 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932931AbXBLCga (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 21:36:30 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDB00D92WKNGDN5@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 20:36:24 -0600 (CST)
In-reply-to: <eqodam$r17$1@sea.gmane.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39351>

Jakub Narebski wrote:
> Johannes Schindelin wrote:
>   
>> On Sun, 11 Feb 2007, Mark Levedahl wrote:
>>
>>     
>>> The major competing solutions git seeks to supplant (cvs, cvsnt, svn, 
>>> hg) have capability to recognize "text" files and transparently replace 
>>> \r\n with \n on input, the reverse on output, and ignore all such 
>>> differences on diff operations.
>>>       
>> Agree with transformations on input and output; disagree on diff.
>>     
>
> I wonder if this could/should be solved with adding some option to git-diff,
> similar to --ignore-space-change and --ignore-all-space...
>
> Just a [idle] thought.
>   
That would work. Assuming blobs are stored in with \n, diff just has to 
open files in 'rt' mode rather than just 'r' and the \r\n are 
transformed  on read so are never seen by git code. That is basically 
what Windows native tools do, but they also write files opened in 'wt' 
mode so \n become \r\n on output. Of course, if this were an option, 
users could look for line ending differences if they cared.

Mark
