From: David Brown <git@davidb.org>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 17:03:47 -0700
Message-ID: <20071015000347.GA13033@old.davidb.org>
References: <20071014221446.GC2776@steel.home> <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: 'Alex Riesen' <raa.lkml@gmail.com>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Andreas Ericsson' <ae@op5.se>,
	'git list' <git@vger.kernel.org>,
	'Make Windows' <make-w32@gnu.org>
To: Dave Korn <dave.korn@artimi.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 02:04:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhDRH-0003CG-9V
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 02:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761040AbXJOAD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 20:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761015AbXJOAD5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 20:03:57 -0400
Received: from mail.davidb.org ([66.93.32.219]:48669 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760933AbXJOAD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 20:03:56 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IhDQx-0003TA-Rs; Sun, 14 Oct 2007 17:03:47 -0700
Mail-Followup-To: Dave Korn <dave.korn@artimi.com>,
	'Alex Riesen' <raa.lkml@gmail.com>,
	'Johannes Schindelin' <Johannes.Schindelin@gmx.de>,
	'Andreas Ericsson' <ae@op5.se>, 'git list' <git@vger.kernel.org>,
	'Make Windows' <make-w32@gnu.org>
Content-Disposition: inline
In-Reply-To: <023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60931>

On Sun, Oct 14, 2007 at 11:59:35PM +0100, Dave Korn wrote:
>On 14 October 2007 23:15, Alex Riesen wrote:
>
>> Interprocess communication:
>> 
>> - it has only one argument (limited in size) passed to started
>>   programs, which means that there is no possible way to safely pass
>>   file and text arguments on command line (more than one, that is)
>
>  Whuh?
>
>http://msdn2.microsoft.com/en-us/library/y5zz48s1(VS.80).aspx

The MS exec* calls just concatenate all of the argv arguments, separating
them with a space into a single buffer.

Look at the general _exec* page:

   http://msdn2.microsoft.com/en-us/library/431x4c1w(VS.80).aspx

and read the first "Note" section.

If you know what the library on the other end is doing to re-parse the
arguments back into separate strings, it might be possible to quote things
enough to handle names with spaces, but it is hard.

David
