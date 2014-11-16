From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Don't make $GIT_DIR executable
Date: Sun, 16 Nov 2014 07:14:21 +0100
Message-ID: <546840BD.2090507@alum.mit.edu>
References: <1416036379-4994-1-git-send-email-mhagger@alum.mit.edu> <20141115075030.GA31043@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 16 07:14:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpt6o-0004Jy-30
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 07:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbaKPGOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 01:14:39 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44178 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbaKPGOj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2014 01:14:39 -0500
X-AuditID: 12074413-f792c6d000000bc8-cb-546840c0c03f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0A.0C.03016.0C048645; Sun, 16 Nov 2014 01:14:24 -0500 (EST)
Received: from [192.168.69.130] (p4FC97A4A.dip0.t-ipconnect.de [79.201.122.74])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAG6EMHn032441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 16 Nov 2014 01:14:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141115075030.GA31043@dcvr.yhbt.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqHvAISPE4H6bgEXXlW4mi4beK8wW
	C/8dZbfY35TkwOKxc9Zddo+Ll5Q9Pm+S82iecp41gCWK2yYpsaQsODM9T98ugTtj+qZLbAUz
	OSt69l9ga2DcyN7FyMkhIWAiceb7HUYIW0ziwr31bF2MXBxCApcZJU7PP84I4Zxnkjj64zsL
	SBWvgLZE883FrF2MHBwsAqoSj4+JgITZBHQlFvU0M4HYogJBEif3XGeHKBeUODnzCVirCFD5
	xxkvmEFsZoFcieM929lAxggLmEv83GYDEhYSyJJo6nvEBBLmFDCW2NeZDVGtJ7Hj+i9WCFte
	onnrbOYJjAKzkCyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNK
	NzFCAll4B+Ouk3KHGAU4GJV4eDdYZIQIsSaWFVfmHmKU5GBSEuVdYAsU4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMK7xhQox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
	4NW3B2oULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VpfDEwTkFSPEB75UDaeYsL
	EnOBohCtpxgVpcR5tUASAiCJjNI8uLGw9PSKURzoS2HeTpAqHmBqg+t+BTSYCWgw47FUkMEl
	iQgpqQZGif5OtyOXugy7eE2Eg5Oa7ZMW6LzmlBa9VfN+Ucc/3wSuxvsbtvbZGEVKtIW5X05I
	vRznss3a/PsvrR3WDGazd9942dv4qr0/aVH+wkCZTb6LPhx7zbnuhds/lcTegBVP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2014 08:50 AM, Eric Wong wrote:
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Michael Haggerty (2):
>>   create_default_files(): don't set u+x bit on $GIT_DIR/config
>>   config: clear the executable bits (if any) on $GIT_DIR/config
> 
> Thanks, I should've noticed this earlier :x
> Tested-by: Eric Wong <normalperson@yhbt.net>
> 
> Since the damage is done, perhaps removing +x from $GIT_DIR/config on
> _any_ git operation would be appropriate.

I believe that the u+x bit on the config file should be pretty harmless.
Nobody is likely to try to execute their config files, and even if they
do, the file contents are unlikely to resemble a script enough to do
anything bad.

So my feeling is that it is unnecessary to make every git invocation try
to remove the u+x bit on the file. Thus I'd rather skip the code clutter
and extra system call, limiting cleanup attempts to when the config file
is being rewritten anyway.

But if other people are more alarmed than I am about having executable
config files, I could certainly be persuaded that the extra effort is
justified.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
