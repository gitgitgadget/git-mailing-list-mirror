From: "C. Michael Pilato" <cmpilato@collab.net>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 12:48:11 -0400
Organization: CollabNet, Inc.
Message-ID: <4C3DEA4B.9090507@collab.net>
References: <20100709142910.GB20383@debian> <20100713201105.GN13310@ted.stsp.name> <20100714153206.GH25630@jack.stsp.name> <20100714160149.GA7561@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Sperling <stsp@elego.de>, 
 "dev@subversion.apache.org" <dev@subversion.apache.org>,
 Bert Huijben <rhuijben@collab.net>, 
 Daniel Shahaf <d.s@daniel.shahaf.name>,
 Will Palmer <wmpalmer@gmail.com>, 
 David Michael Barr <david.barr@cordelta.com>,
 Jonathan Nieder <jrnieder@gmail.com>, 
 Sverre Rabbelier <srabbelier@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: dev-return-5006-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 14 18:49:07 2010
Return-path: <dev-return-5006-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-5006-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OZ58s-0008Ea-S1
	for gcvsd-dev@lo.gmane.org; Wed, 14 Jul 2010 18:49:07 +0200
Received: (qmail 72479 invoked by uid 500); 14 Jul 2010 16:49:05 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 72471 invoked by uid 99); 14 Jul 2010 16:49:04 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 16:49:04 +0000
X-ASF-Spam-Status: No, hits=-0.0 required=10.0
	tests=SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of cmpilato@collab.net designates 204.16.106.198 as permitted sender)
Received: from [204.16.106.198] (HELO sp-exchfea.sp.corp.collab.net) (204.16.106.198)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 16:48:57 +0000
Received: from [204.11.125.142] ([204.11.125.142]) by sp-exchfea.sp.corp.collab.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jul 2010 09:48:13 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
In-Reply-To: <20100714160149.GA7561@debian>
X-Enigmail-Version: 1.0.1
X-OriginalArrivalTime: 14 Jul 2010 16:48:14.0025 (UTC) FILETIME=[59D12B90:01CB2374]
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151009>

On 07/14/2010 12:01 PM, Ramkumar Ramachandra wrote:
> Hi Stefan,
> 
> Stefan Sperling writes:
>> Playing with svnrdump and comparing its output to the output of
>> svnadmin dump --deltas, I noticed that:
> 
> Thanks for testing!
> 
>>  - svnrdump doesn't dump revision 0.
>>    It should dump revision 0, because that revision can contain important
>>    revprops such as metadata for svnsync (svn:sync-last-merge-rev etc.)
> 
> Yeah, I forgot to ask about this: passing 0 as an argument to the
> replay API doesn't seem to work. Why? How do I dump revision 0 then?

You fake it, just like the code behind 'svnadmin dump' does.  :-)
Seriously, Revision 0 is nothing but a revision header and revision
properties.  There is no node data to transmit.

-- 
C. Michael Pilato <cmpilato@collab.net>
CollabNet   <>   www.collab.net   <>   Distributed Development On Demand
