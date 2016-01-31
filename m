From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 15:50:40 +0100
Message-ID: <56AE1F40.8060509@kdbg.org>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 15:50:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPtKy-0008S3-LO
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 15:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbcAaOuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 09:50:44 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:34137 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757218AbcAaOuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 09:50:44 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3ptb1Y0v68z5tlG;
	Sun, 31 Jan 2016 15:50:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AA7515314;
	Sun, 31 Jan 2016 15:50:40 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285149>

Am 31.01.2016 um 15:03 schrieb Aaron Gray:
> Hi,
>
> I think I have found a possible difference in behaviour between
> Windows git commandline distro and Linux git
>
> basically If I do a :-
>
>      git mv logger.h Logger.h
>
> I get the following :-
>
>      fatal: destination exists, source=lib/logger.h, destination=lib/Logger.h
>
> It looks and smells like a bug to me !

Not really. When you attempt to overwrite an existing file with 'git 
mv', you get this error message on both Windows and Linux.

The difference is that logger.h and Logger.h are the same file on 
Windows, but they are not on Linux. Hence, when you attempt to overwrite 
Logger.h on Windows, you see the error because it exists already (as 
logger.h).

As a work-around, you can use -f.

-- Hannes
