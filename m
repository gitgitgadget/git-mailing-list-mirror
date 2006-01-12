From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] stgit: fix clone
Date: Thu, 12 Jan 2006 09:51:17 -0500
Organization: Network Appliance, Inc.
Message-ID: <43C66CE5.1050009@citi.umich.edu>
References: <1137017966.10975.8.camel@dv> <43C58916.6030409@citi.umich.edu>	 <43C58AF3.10606@citi.umich.edu> <b0943d9e0601120354u73489c74j@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060904030009070106040201"
Cc: Pavel Roskin <proski@gnu.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 15:52:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex3nR-0001TQ-DV
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 15:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbWALOvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 09:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWALOvU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 09:51:20 -0500
Received: from mx1.netapp.com ([216.240.18.38]:43595 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1030430AbWALOvU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 09:51:20 -0500
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx1.netapp.com with ESMTP; 12 Jan 2006 06:51:20 -0800
X-IronPort-AV: i="3.99,360,1131350400"; 
   d="vcf'?scan'208"; a="283068365:sNHT21931728"
Received: from svlexc02.hq.netapp.com (svlexc02.corp.netapp.com [10.57.157.136])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id k0CEpJ4P004245;
	Thu, 12 Jan 2006 06:51:19 -0800 (PST)
Received: from exsvl02.hq.netapp.com ([10.56.8.60]) by svlexc02.hq.netapp.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 12 Jan 2006 06:51:19 -0800
Received: from [10.98.12.56] ([10.98.12.56]) by exsvl02.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 06:51:18 -0800
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0601120354u73489c74j@mail.gmail.com>
X-OriginalArrivalTime: 12 Jan 2006 14:51:18.0959 (UTC) FILETIME=[A5660BF0:01C61787]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14564>

This is a multi-part message in MIME format.
--------------060904030009070106040201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 11/01/06, Chuck Lever <cel@citi.umich.edu> wrote:
> 
>>Chuck Lever wrote:
>>
>>>seems to me the "git clone" script should create an environment where
>>>"git-rev-parse --git-dir" ought to work correctly.
>>
>>stgit/main.py does a special stack.Series('master') just for the clone
>>command.  it really shouldn't do this -- the crt_series.init() in the
>>clone command ought to be fixed to do this properly.
> 
> 
> If the stack.Series() doesn't get a parameter, it will try to get the
> default branch using 'git-symbolic-ref HEAD'. Any command run outside
> a tree (and which doesn't have the -h option) would fail. The clone
> command is the only one allowed to run outside a tree and that's why I
> passed a default branch name. This is to avoid the creation of another
> stack.Series() object later when the git tree was cloned.
> 
> See the attached patch for a different fix and let me know if there
> are any issues with it. I should probably release 0.8.1 with the fixed
> bugs.

looked at the patch.  that's what i had in mind.  the extra exception 
processing in Series.__init__ is a nice touch.

--------------060904030009070106040201
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------060904030009070106040201--
