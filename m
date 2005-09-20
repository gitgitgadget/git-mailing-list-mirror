From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: slow "stg push" on NFS
Date: Tue, 20 Sep 2005 13:56:05 -0400
Organization: Network Appliance, Inc.
Message-ID: <43304D35.3030601@citi.umich.edu>
References: <432F0AFA.3050401@citi.umich.edu> <1127201053.7019.13.camel@localhost.localdomain>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000206070703050107060108"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 19:58:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHmLm-0003gl-82
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 19:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVITR4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVITR4H
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 13:56:07 -0400
Received: from citi.umich.edu ([141.211.133.111]:51736 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964775AbVITR4G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 13:56:06 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 4E5881BB91;
	Tue, 20 Sep 2005 13:56:05 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1127201053.7019.13.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9010>

This is a multi-part message in MIME format.
--------------000206070703050107060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On Mon, 2005-09-19 at 15:01 -0400, Chuck Lever wrote:
>>what appears to 
>>be happening is that each push operation deletes and recreates 
>>everything in the working directory.
> 
> 
> The push operation only does a 'git-read-tree -u -m' which updates the
> filesystem. I haven't looked at the git-read-tree code but I suspect it
> only updates the files modified as a result of the merge operation. As
> Blaisorblade reported, if there are big changes between the new HEAD and
> the old bottom of the patch, like file removals and additions, it will
> indeed take more time since git-read-tree cannot deal with them and
> gitmergeonefile.py will be invoked for each file.

ja, indeed, gitmergeonefile.py is doing some heavy lifting in my case. 
however, i think the bogosity stems from something my new cache API is 
doing.  i can't reproduce this behavior with stock GIT.

--------------000206070703050107060108
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------000206070703050107060108--
