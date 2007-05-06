From: Michael Spang <mspang@uwaterloo.ca>
Subject: Re: [PATCH 2/3] dir.c: Omit non-excluded directories with dir->show_ignored
Date: Sun, 06 May 2007 16:18:55 -0400
Message-ID: <463E382F.8080708@uwaterloo.ca>
References: <463E1705.2090201@gmail.com> <463E19D4.4030400@uwaterloo.ca> <alpine.LFD.0.98.0705061239460.25245@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 06 22:20:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HknDM-00087o-Pi
	for gcvg-git@gmane.org; Sun, 06 May 2007 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbXEFUTk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 16:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755258AbXEFUTk
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 16:19:40 -0400
Received: from services10.student.cs.uwaterloo.ca ([129.97.152.18]:33803 "EHLO
	services10.student.cs.uwaterloo.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755261AbXEFUTj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 16:19:39 -0400
Received: from [10.100.100.102] (rn-wan3a10.uwaterloo.ca [129.97.219.111])
	(authenticated bits=0)
	by services10.student.cs.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id l46KJ2vu029604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 16:19:02 -0400 (EDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <alpine.LFD.0.98.0705061239460.25245@woody.linux-foundation.org>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (services10.student.cs.uwaterloo.ca [129.97.152.13]); Sun, 06 May 2007 16:19:03 -0400 (EDT)
X-Miltered: at mailchk-m02 with ID 463E3836.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: ClamAV version 0.90.2, clamav-milter version 0.90.2 on localhost
X-Virus-Status: Clean
X-UUID: 4c20dd44-b4eb-44d6-b936-a70178224b87
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46372>

Linus Torvalds wrote:
> 
> On Sun, 6 May 2007, Michael Spang wrote:
>> @@ -461,7 +462,7 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
>>  			memcpy(fullname + baselen, de->d_name, len+1);
>>  			if (simplify_away(fullname, baselen + len, simplify))
>>  				continue;
>> -			if (excluded(dir, fullname) != dir->show_ignored) {
>> +			if ((exclude = excluded(dir, fullname)) != dir->show_ignored) {
> 
> Style issue: please write this as
> 
> 			exclude = excluded(dir, fullname);
> 			if (exclude != dir->show_ignored) {
> 
> instead. 

Okay. Will fixup after waiting a bit for more comments.

Thanks,
Michael Spang
