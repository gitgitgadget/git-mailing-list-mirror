From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Tue, 21 Dec 2010 16:09:10 -0600
Message-ID: <4D112586.2060904@Freescale.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Guy Rouillier <guyr@burntmail.com>, <git@vger.kernel.org>,
	Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>,
	Martin Langhoff <martin@laptop.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 23:09:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVAOH-0005Kc-FF
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 23:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0LUWI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 17:08:57 -0500
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:18181 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0LUWI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 17:08:56 -0500
Received: from mail133-tx2-R.bigfish.com (10.9.14.248) by
 TX2EHSOBE008.bigfish.com (10.9.40.28) with Microsoft SMTP Server id
 14.1.225.8; Tue, 21 Dec 2010 22:08:55 +0000
Received: from mail133-tx2 (localhost.localdomain [127.0.0.1])	by
 mail133-tx2-R.bigfish.com (Postfix) with ESMTP id 3FF6C1610450;	Tue, 21 Dec
 2010 22:08:55 +0000 (UTC)
X-SpamScore: -6
X-BigFish: VS-6(z329eq6celzbb2dK1432N98dN4015Lzz1202hzz8275dhz2dh2a8h637h668h61h)
X-Spam-TCS-SCL: 0:0
X-Forefront-Antispam-Report: KIP:(null);UIP:(null);IPVD:NLI;H:de01egw01.freescale.net;RD:de01egw01.freescale.net;EFVD:NLI
Received: from mail133-tx2 (localhost.localdomain [127.0.0.1]) by mail133-tx2
 (MessageSwitch) id 1292969333931894_4801; Tue, 21 Dec 2010 22:08:53 +0000
 (UTC)
Received: from TX2EHSMHS034.bigfish.com (unknown [10.9.14.249])	by
 mail133-tx2.bigfish.com (Postfix) with ESMTP id D7AD5B3805B;	Tue, 21 Dec 2010
 22:08:53 +0000 (UTC)
Received: from de01egw01.freescale.net (192.88.165.102) by
 TX2EHSMHS034.bigfish.com (10.9.99.134) with Microsoft SMTP Server (TLS) id
 14.1.225.8; Tue, 21 Dec 2010 22:08:52 +0000
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 oBLMBO7K003814;	Tue, 21 Dec 2010 15:11:24 -0700 (MST)
Received: from [10.82.121.87] (emmedve1-11.am.freescale.net [10.82.121.87])	by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id oBLM8irf029873;	Tue, 21
 Dec 2010 16:08:44 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101219 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20101220213654.GA24628@burratino>
X-OriginatorOrg: freescale.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164061>

Hello Guy,


On 12/20/10 15:36, Jonathan Nieder wrote:
> (+cc: Emil, some cvsimport people)
> 
> Guy Rouillier wrote:

Sometimes, on some particularly nasty CVS repos, I noticed better
results when using http://cvs2svn.tigris.org

>> I'm going to try sending this blind, as the mailing list has sent me
>> the promised authorization key after 24 hrs.
> 
> No problem.  Actually a subscription is not required --- the
> convention on this list is to always reply-to-all.
> 
>> I finally found the problems, both of which were reported in 2008
>> here:
>>
>> http://kerneltrap.org/mailarchive/git/2008/3/13/1157364
> 
> Seems to have received no replies[1].

I don't remember why, but that patch didn't get enough interest

>> I do see one possible issue with the supplied modifications.  At
>> work, we upgraded from CVS to CVSNT.  So, my home directory has both
>> .cvspass (from the original CVS) and .cvs/cvspass (after the
>> conversion to CVSNT.)  Sloppy housekeeping on my part, I admit, but
>> probably not uncommon.  The supplied patch would pick up the
>> original CVS file and would fail.  (BTW, this is true only of the
>> git-cvsimport.perl script itself; cvsps must shell out to the
>> installed CVS client (in my case, cvsnt), because when I invoked
>> that manually, it worked.)
>>
>> So, I would advise checking to see if both files exist, and if so
>> exit with an error.  Unless cvsimport wants to get real fancy and
>> shell out to the installed cvs client to try to figure out what is
>> installed, there is no way to tell which cvspass file is actively
>> being used.  I don't recommend trying to figure this out, as the
>> user's intent is unclear.
> 
> Thanks, sounds sane to me.  Care to write a patch?

If you care enough about this scenario, how about search for the
relevant <CVSROOT, password> in both files. If you find just one pair or
if you find a pair in both files and they are "equal" then just use it.
If you find two pairs, one in each file, use the one from the file with
a newer modified time-stamp. In a migration scenario such as this, you'd
imaging the "old" file will get stale after a while. Not perfect, but
some informational messages in case of a duplicate would help the user
clarify their intentions

Additionally/Alternatively just add a command line parameter to allow
the user to explicitly specify a cvspass file


Cheers,
Emil.
