From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: pull-fetch-param.txt
Date: Wed, 04 Oct 2006 19:15:00 +0200
Message-ID: <4523EC14.6070806@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de>	<7vven1rfpj.fsf@assigned-by-dhcp.cox.net>	<45222B18.1090305@s5r6.in-berlin.de> <7v64f1np8i.fsf@assigned-by-dhcp.cox.net> <4523E120.6050007@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, srackham@methods.co.nz
X-From: git-owner@vger.kernel.org Wed Oct 04 19:21:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVALZ-0002Cz-7q
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 19:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161881AbWJDRPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161872AbWJDRPb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 13:15:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41121 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161881AbWJDRPa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 13:15:30 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k94HF1Pb001732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Oct 2006 19:15:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <4523E120.6050007@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28330>

I wrote:
> Junio C Hamano wrote:
>> Can you try reformatting the original
>>
>>> <refspec>::
>>> 	The canonical format of a <refspec> parameter is
>>> 	`+?<src>:<dst>`; that is, an optional plus `+`, followed
>>> 	by the source ref, followed by a colon `:`, followed by
>>> 	the destination ref.
>> to something like
>>
>>> <refspec>::
>>> 	The canonical format of a <refspec> parameter is
>>> 	`+?<src>:<dst>`; that is, an optional plus
>>> 	`+`, followed
>>> 	by the source ref, followed by a colon `:`, followed by
>>> 	the destination ref.
>> and verify that conjecture?
> 
> This hack does not help. The two `+` are still absent from the manpage
> (but as before, the `+` in the next paragraph is printed as desired).

After a few more experiments with different placements of backticks et
cetera, I found only the following variants to work with asciidoc 8:

(as mentioned, not compatible to asciidoc 7):
	`$$+$$?<src>:<dst>`; that is, an optional plus `+`, followed

(as mentioned, compatible)
	`\+?<src>:<dst>`; that is, an optional plus `+`, followed

(also OK, and this is probably the only really correct syntax)
	`\+?<src>:<dst>`; that is, an optional plus `\+`, followed

(also OK but misses the monospace formatting on the plus or on the plus
and questionmark)
	\+`?<src>:<dst>`; that is, an optional plus `+`, followed
	\+?`<src>:<dst>`; that is, an optional plus `+`, followed
	\+?`<src>:<dst>`; that is, an optional plus \+, followed
	`\+?<src>:<dst>`; that is, an optional plus +, followed

Note,
	`+``?<src>:<dst>`; that is, an optional plus `+`, followed
does _not_ work. It stops on invalid syntax in the intermediary xml
file. Also
	+\+?<src>:<dst>+; that is, an optional plus `+`, followed
or
	`+`+?<src>:<dst>+; that is, an optional plus `+`, followed
do _not_ work. They don't print what we want to see.
-- 
Stefan Richter
-=====-=-==- =-=- --=--
http://arcgraph.de/sr/
