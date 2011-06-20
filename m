From: Massimo Manca <massimo.manca@micronengineering.it>
Subject: Re: Undo last commit?
Date: Mon, 20 Jun 2011 14:08:10 +0200
Organization: Micron Engineering
Message-ID: <4DFF382A.5030206@micronengineering.it>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com> <m31uyrutx7.fsf@localhost.localdomain> <20110619003718.GA5628@elie> <201106191237.55825.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010801040606010607080900"
Cc: Jonathan Nieder <jrnieder@gmail.com>, Mike <xandrani@gmail.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 14:09:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYdHz-0008H8-6O
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 14:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab1FTMJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 08:09:06 -0400
Received: from mp1-smtp-2.eutelia.it ([62.94.10.162]:60868 "EHLO
	smtp.eutelia.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752535Ab1FTMJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 08:09:05 -0400
Received: from [127.0.0.1] (ip-66-238.sn2.eutelia.it [83.211.66.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.eutelia.it (Eutelia) with ESMTP id D06BCC7DE9;
	Mon, 20 Jun 2011 14:09:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; it; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <201106191237.55825.jnareb@gmail.com>
X-Antivirus: avast! (VPS 110620-1, 20/06/2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176065>

This is a multi-part message in MIME format.
--------------010801040606010607080900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,
I several times made the mistake of a wrong commit also if generally the
error born for a wrong add expecially:

git add . in a directory with some files that haven't to be managed by git.

So, as wrote in some emails here, if I wrote something like:
git commit -m "Added file.c" -a

I tryed to solve with:
git commit --amend -m "Added file.c" -a

hoping to have a status like before the commit and then sending:
git reset .

hoping to have a status like that before the wrong add.
But this is not what git status say so, my solution to solve commi
problems is ALWAYS:

git reset --soft HEAD^

that for my point of view works better then all others permitting to
redo last add and commit to solve not only a -m problem but also a wrong
git add command.

Il 19/06/2011 12.37, Jakub Narebski ha scritto:
> On Sun, 19 Jun 2011, Jonathan Nieder wrote:
>> Jakub Narebski wrote:
>>> Mike <xandrani@gmail.com> writes:
>>>> % git reset --hard HEAD~1
>>> Errr... here you screwed up.  This reset state of you working area to
>>> the state at last commit, removing all your changes to tracked files.
>> Or rather, here we screwed up.  Jakub and others gave some useful
>> advice about how to recover, so let's consider how the UI or
>> documentation could be improved to prevent it from happening again.
>>
>> * In this example if I understand correctly then the index contained
>>   some useful information, perhaps about a larger commit intended for
>>   later.  To preserve that, you could have used
>>
>> 	git reset --soft HEAD~1
>>
>>   which would _just_ undo the effect of "git commit", leaving the index
>>   and worktree alone.
> Another issue is that Mike haven't realized that `--amend' option can be
> used *in combination* with other "git commit" options, which means that
> the solution to his problem was using "git commit" as it should have
> been done, but with '--amend' added.
>  
> I'm not sure if git documentation talks about 'git reset --soft HEAD^',
> and when to use it; from what I remember it encourages use of 
> 'git commit --amend' instead (which was I guess most often used reason
> of using soft reset before there was '--amend').
>
>> * Another situation that comes up from time to time is making a change
>>   that just turned out to be a bad idea.  After commiting it, you might
>>   want to discard the erroneous change, like so:
>>
>> 	git reset --keep HEAD~1
>>
>>   The "--keep" option uses some safeguards to make sure that only the
>>   committed change gets discarded, instead of clobbering local changes
>>   at the same time.
>>
>> * In the early days of git, the "--keep" option did not exist.  So a lot
>>   of old documentation recommends to do
>>
>> 	git reset --hard HEAD~1
>>
>>   which is the same if you don't have any local changes.
> Yes, it would be good idea to examine git documentation (tutorials,
> user's manual, manpages, perhaps "Git Community Book" and "Pro Git"
> too) to encourage use of new safer options of hard reset, namely
> '--keep' and '--merge' instead of '--hard'.
>  


--------------010801040606010607080900
Content-Type: text/x-vcard; charset=utf-8;
 name="massimo_manca.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="massimo_manca.vcf"

YmVnaW46dmNhcmQNCmZuOk1hc3NpbW8gTWFuY2ENCm46TWFuY2E7TWFzc2ltbw0Kb3JnOk1p
Y3JvbiBFbmdpbmVlcmluZyBkaSBNYXNzaW1vIE1hbmNhDQphZHI6Ozt2aWEgZGVsbGEgRmVy
cmllcmEsIDQ4O1BvcmRlbm9uZTtQTjszMzE3MDtJVEFMSUENCmVtYWlsO2ludGVybmV0Om1h
c3NpbW8ubWFuY2FAbWljcm9uZW5naW5lZXJpbmcuaXQNCnRlbDt3b3JrOiszOSAwNDM0IDE4
NTYxMzENCnRlbDtmYXg6KzM5IDA0MzQgMTg1MTAzMiAvIDE3OCAyNzMgMzU0Mw0KdGVsO2Nl
bGw6KzM5IDM0OSA0NTA0OTc5DQp1cmw6aHR0cDovL3d3dy5taWNyb25lbmdpbmVlcmluZy5p
dA0KdmVyc2lvbjoyLjENCmVuZDp2Y2FyZA0KDQo=
--------------010801040606010607080900--
