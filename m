From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Sun, 19 Jul 2015 10:40:48 +0200
Message-ID: <55AB6290.2090003@kdbg.org>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
 <55AB49C1.8010105@kdbg.org> <fadc4ff7e755913a4c6076165556b56c@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bdwalton@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 19 10:41:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGk9m-0005Hs-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 10:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbbGSIky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 04:40:54 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:61965 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751377AbbGSIkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 04:40:53 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mZ05G1dGPz5tlC;
	Sun, 19 Jul 2015 10:40:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D743152BE;
	Sun, 19 Jul 2015 10:40:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <fadc4ff7e755913a4c6076165556b56c@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274206>

Am 19.07.2015 um 09:37 schrieb Johannes Schindelin:
> On 2015-07-19 08:54, Johannes Sixt wrote:
>> Am 18.07.2015 um 17:21 schrieb Ben Walton:
>>> -	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
>>> -	mv -f file+ file &&
>>> +	perl -pi -e "s/CHANGE_ME/change_me/" file &&
>>
>> This is problematic. On Windows, perl -i fails when no backup file
>> extension is specified because perl attempts to replace a file that is
>> still open; that does not work on Windows.
>
> Let's qualify this a bit better: it actually works with the SDK of
> Git  for Windows 2.x.

Good to know!

> I really wonder why the previous ">file+ && mv -f file+ file" dance
> needs to be replaced?

The sed must be replaced because some versions on Solaris choke on the 
incomplete last line in the file.

-- Hannes
