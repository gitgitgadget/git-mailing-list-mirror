From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: mutt aliases file not working
Date: Fri, 29 Oct 2010 09:04:04 -0700
Message-ID: <4CCAF074.2080701@linux.intel.com>
References: <4CC89BC4.8080009@linux.intel.com> <4CCAA735.1030805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 29 18:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBrR7-0002gk-2p
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 18:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866Ab0J2QEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 12:04:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:24451 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932683Ab0J2QEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 12:04:06 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 29 Oct 2010 09:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.58,260,1286175600"; 
   d="scan'208";a="621583136"
Received: from unknown (HELO [10.255.12.221]) ([10.255.12.221])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2010 09:04:05 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <4CCAA735.1030805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160336>

On 10/29/2010 03:51 AM, Michael J Gruber wrote:
> Darren Hart venit, vidit, dixit 27.10.2010 23:38:
>> For whatever reason, which I'm sure is user error, I haven't been
>> able to get mutt aliases to work, while mailrc works fine:
>>
>> $ mkdir aliases.git
>> $ cd !$
>> $ git init
>> Initialized empty Git repository in /home/dvhart/aliases.git/.git/
>> $ echo "joe Joe Blow joe@foobar.com">  muttaliases
>
> How about:
>
> echo 'alias joe Joe Blow<joe@foobar.com>'>  muttaliases

Indeed, that fixes it. I checked my reference for the mutt aliases 
format and apparently missed the "alias " clearly printed out there. My 
apologies.

The git send-email man page is surely sufficient for users of mutt, 
mailrc, pine, elm, gnus as they already have working configurations, but 
for those of us that use a different MUA and just want to get some sort 
of an address book for git, it would be nice to define these formats - 
it would only take one line per format type.

Thanks!

Darren Hart

>
>> $ git add muttaliases
>> $ git commit -m "aliases file"
>> [master (root-commit) b71ae4a] aliases file
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>   create mode 100644 muttaliases
>> $ git config sendemail.aliasesfile `pwd`/muttaliases
>> $ git config sendemail.aliasfiletype mutt
>> $ cat .git/config
>> [core]
>> 	repositoryformatversion = 0
>> 	filemode = true
>> 	bare = false
>> 	logallrefupdates = true
>> [sendemail]
>> 	aliasesfile = /home/dvhart/aliases.git/muttaliases
>> 	aliasfiletype = mutt
>> $ git send-email --to joe -1
>> /tmp/l0xCEC7o3d/0001-aliases-file.patch
>> Who should the emails appear to be from? [Darren Hart<darren@dvhart.com>]
>> Emails will be sent from: Darren Hart<darren@dvhart.com>
>> Message-ID to be used as In-Reply-To for the first email?
>> (mbox) Adding cc: Darren Hart<darren@dvhart.com>  from line 'From: Darren Hart<darren@dvhart.com>'
>>
>> From: Darren Hart<darren@dvhart.com>
>> To: joe
>>
>>      ^ when using a mailrc fail this expands to joe@foobar.com
>>
>> Cc: Darren Hart<darren@dvhart.com>
>> Subject: [PATCH] aliases file
>> Date: Wed, 27 Oct 2010 14:29:10 -0700
>> Message-Id:<1288214950-13695-1-git-send-email-darren@dvhart.com>
>> X-Mailer: git-send-email 1.7.1
>>
>> Send this email? ([y]es|[n]o|[q]uit|[a]ll): ^C
>>
>> $ stty: standard input: Input/output error
>> ^C
>>
>> Am I doing something obviously wrong?
>>
>


-- 
Darren Hart
Embedded Linux Kernel
