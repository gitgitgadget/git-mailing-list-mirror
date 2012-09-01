From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sat, 01 Sep 2012 15:59:06 +0200
Message-ID: <504214AA.9080706@kdbg.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org> <5041BC94.7000304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 15:59:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7oEa-0006fT-09
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 15:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685Ab2IAN7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 09:59:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:40147 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754382Ab2IAN7K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 09:59:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0E2B713005A;
	Sat,  1 Sep 2012 15:59:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 0E52A19F391;
	Sat,  1 Sep 2012 15:59:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5041BC94.7000304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204631>

Am 01.09.2012 09:43, schrieb Marco Stornelli:
> Il 31/08/2012 23:35, Johannes Sixt ha scritto:
>> Am 31.08.2012 16:09, schrieb Marco Stornelli:
>>> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'};
>>> $text=<FILE>;
>>> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr
>>> =~ s/\n//g;
>>> +print $addr;'`
>>
>> The quoting is broken in this line (sq within sq does not work).
> 
> I don't understand what you mean, I'm using this script and it works
> perfectly.

Look how you write:

  perl -e '... $ENV{'PATCHTMP'} ...'

That is, perl actually sees this script:

  ... $ENV{PATCHTMP} ...

(no quotes around PATCHTMP). That my be perfectly valid perl, but is not
what you intended.

-- Hannes
