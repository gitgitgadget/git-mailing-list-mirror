From: Chuck Lever <cel@citi.umich.edu>
Subject: slow "stg push" on NFS
Date: Mon, 19 Sep 2005 15:01:14 -0400
Organization: Network Appliance, Inc.
Message-ID: <432F0AFA.3050401@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030407040802020206070805"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:03:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHQtB-00005J-Vb
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVISTBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVISTBP
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:01:15 -0400
Received: from citi.umich.edu ([141.211.133.111]:18714 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932578AbVISTBO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 15:01:14 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 780C31BB7B;
	Mon, 19 Sep 2005 15:01:14 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8895>

This is a multi-part message in MIME format.
--------------030407040802020206070805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi catalin-

still looking at this problem.

thanks to the several recent patches that add fast-forward support, CPU 
utilization seems to no longer be a problem in general.  what appears to 
be happening is that each push operation deletes and recreates 
everything in the working directory.

for shared file systems, creating and deleting files will always be 
synchronous.  anything we can do to eliminate the need for deleting and 
recreating files that are not changed by a commit would be great.

(i've also noticed that an "stg pop / stg push" sequence causes 'make' 
to rebuild everything -- possibly due to the same reason?)

am i all wet here?

--------------030407040802020206070805
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


--------------030407040802020206070805--
