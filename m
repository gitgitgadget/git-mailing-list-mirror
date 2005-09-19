From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects
 byproxy servers
Date: Sun, 18 Sep 2005 17:23:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0509181720290.14003@qynat.qvtvafvgr.pbz>
References: <20050913153858.GB24405@master.mivlgu.local> <43285B24.7050907@b-i-t.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 02:24:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH9Rw-0002ae-02
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 02:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVISAXp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 20:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVISAXp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 20:23:45 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:17113 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932280AbVISAXp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 20:23:45 -0400
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 18 Sep 2005 17:23:40 -0700
Received: from wlvexc02.digitalinsight.com ([10.201.10.15]) by wlvims02.corp.ad.diginsite.com with InterScan Messaging Security Suite; Sun, 18 Sep 2005 17:23:28 -0700
Received: by wlvexc02.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <T1SRBD7F>; Sun, 18 Sep 2005 17:23:26 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id T1S3L3NW; Sun, 18 Sep 2005 17:23:22 -0700
To: sf-git@stephan-feder.de
X-X-Sender: dlang@dlang.diginsite.com
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <43285B24.7050907@b-i-t.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8824>

On Wed, 14 Sep 2005, sf wrote:

> Sergey Vlasov wrote:
>> By default the curl library adds "Pragma: no-cache" header to all
>> requests, which disables caching by proxy servers.  However, most
>> files in a GIT repository are immutable, and caching them is safe and
>> could be useful.
>
> Is caching really safe? Because of compression one git object can have many 
> file representations.

only if you use different compression algorithums.

remember that git objects are identified by their sha1, if the sha1 is 
what you want (and the file matches the sha1 after you decompress it) then 
it really doesn't matter what it's on-disk representation is.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
