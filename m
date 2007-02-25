From: Mark Levedahl <mlevedahl@verizon.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 18:55:32 -0500
Message-ID: <45E221F4.4080900@verizon.net>
References: <45E1E47C.5090908@verizon.net>
 <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
 <7vfy8urngi.fsf@assigned-by-dhcp.cox.net>	<45E1FC1C.4090409@verizon.net>
 <7v649qrkzg.fsf@assigned-by-dhcp.cox.net> <45E20BC2.3000305@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 00:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLTDc-0004KY-RM
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 00:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXBYXzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 18:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbXBYXzi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 18:55:38 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:34260 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbXBYXzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 18:55:37 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JE100MS8MGEP4E2@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 25 Feb 2007 17:55:28 -0600 (CST)
In-reply-to: <45E20BC2.3000305@verizon.net>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40597>

Mark Levedahl wrote:
> Junio C Hamano wrote:
>> The size field among other fields is to cache the last lstat(2)
>> information so that later "is the path modified?" question can
>> be answered efficiently.  So the size should in general match
>> both blob and filesystem but on CRLF filesystems it is compared
>> against and updated with the data from the filesystem.  There
>> could be a subtle bug that when updating an index entry we might
>> be incorrectly storing the size of the blob, but I haven't
>> checked.
Never mind: I should have triggered off the observation that something 
was changing the file, but as far as I know git does not change the 
working directory on commit and the autoCRLF code does not introduce 
that "feature". My trusty old editor (visual slickedit) occasionally 
corrupts its macros and starts doing strange and wonderful things, 
always something I never saw before. In this case, I had foo open 
(absent crlf endings) in it and and the editor was apparently re-saving 
all of its files in the middle of my tests as I flipped between various 
windows. Killing the editor stopped the behavior, rebuilding all the 
macros from scratch got rid of the problem for good.

So, after all that, it appears that the index does reflect the size in 
the working repository and the problems I was having were nothing to do 
with git.

Sorry for the noise.

Mark
