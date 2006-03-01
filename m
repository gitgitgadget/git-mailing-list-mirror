From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 01 Mar 2006 09:39:13 -0800
Organization: Network Appliance, Inc.
Message-ID: <4405DC41.8020700@citi.umich.edu>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>	 <44037A5C.6080409@gmail.com> <b0943d9e0602281445w7160d915y@mail.gmail.com>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090605060607070400000905"
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 18:42:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVKG-0005Op-Dj
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCARjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCARjV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:39:21 -0500
Received: from citi.umich.edu ([141.211.133.111]:31122 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932420AbWCARjT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:39:19 -0500
Received: from [10.58.48.111] (nat-198-95-226-230.netapp.com [198.95.226.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Chuck Lever", Issuer "CITI Production KCA" (verified OK))
	by citi.umich.edu (Postfix) with ESMTP id 94D3A1BC8D;
	Wed,  1 Mar 2006 12:39:18 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0602281445w7160d915y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16995>

This is a multi-part message in MIME format.
--------------090605060607070400000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On 27/02/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> 
>>An idea (untested, I don't even know whether it's feasible) would be to
>>check which patches were merged by reverse-applying them starting with
>>the last. In this situation, all the merged patches should just revert
>>their changes. You only need to do a git-diff between the bottom and the
>>top of the patch and git-apply the output (maybe without even modifying
>>the tree). If this operation succeeds, the patch was integrated and you
>>don't even need to push it.
> 
> 
> I attached another patch that should work properly. It also pushes
> empty patches on the stack if they were merged upstream (a 'stg clean'
> is required to remove them). This is useful for the push --undo
> command if you are not happy with the result.
> 
> I'll try this patch for a bit more before pushing into the repository.

i think this is a cool idea.  but it seems still to require a bit of 
convention on the part of the maintainer.

if maintainer X takes a patch "a" from developer Y, but modifies patch 
"a" before committing it, then your nifty automated mechanism will still 
have trouble merging developer Y's stack when Y pulls again.

the convention might be that maintainers who accept patches will always 
accept exactly what was sent, and then immediately apply another commit 
that addresses any issues they have with the original commit.  this is 
also a good idea so that the history contains the exact attribution of 
each change.

--------------090605060607070400000905
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


--------------090605060607070400000905--
