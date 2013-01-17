From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 01:46:07 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF32209AD2@xmb-rcd-x15.cisco.com>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz>
 <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:46:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TveZ6-0003vk-K8
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 02:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663Ab3AQBqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 20:46:14 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:20112 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758560Ab3AQBqJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 20:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=691; q=dns/txt; s=iport;
  t=1358387169; x=1359596769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZG58yaqhWQYpBaTUP4dN3qcRBUVfMbUr9UXAdh5Ih6E=;
  b=ATECqGkR9gUiAEYXSuaxGDEFuyVsVfrxLddU8ZDLK2WGQZxVtvGj+EmU
   F2tdAQbQ/1h3ijFN2wHTkMHMMyRBnFHU/eq/vI1en2RGxAAn2DnYg5BIR
   rN38EUvQ/pzlPcxxsmzP6Gu2OOYjcdwRPXXATQL4FEYNPkWSC/le5va9T
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap0FAIpW91CtJV2b/2dsb2JhbABEhXe4DxZzgh4BAQEDATo/BQsCAQgVDRQJBzIUEQEBBA4FCIgLBQG5LJBXYQOmVYJ1giQ
X-IronPort-AV: E=Sophos;i="4.84,483,1355097600"; 
   d="scan'208";a="163572066"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-4.cisco.com with ESMTP; 17 Jan 2013 01:46:09 +0000
Received: from xhc-rcd-x14.cisco.com (xhc-rcd-x14.cisco.com [173.37.183.88])
	by rcdn-core-4.cisco.com (8.14.5/8.14.5) with ESMTP id r0H1k8CV027937
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Jan 2013 01:46:08 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-rcd-x14.cisco.com ([173.37.183.88]) with mapi id 14.02.0318.004; Wed, 16
 Jan 2013 19:46:08 -0600
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30QapFxgO7vxkcSpqZYTWiS/u7TwAOT+SAAAxmn8D//67SgIAAYueA
In-Reply-To: <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213834>

> From: David Lang [mailto:david@lang.hm]
> 
> Linus says that git does not have "proper locking", so think about it,
> what do
> you think will happen if person A does git add a/b; git commit and person
> B does
> git add c/d; git commit?

Sorry, I wasn't clear. My assumption is that a shared repository on a network file system will either be: 

1. a bare repository that is normally accessed only by "git push" and "git pull" (or "git fetch"), the central repository model.

2. a repository where only one user does "git add" and "git commit", while other users will do "git pull", the peer-to-peer model (you pull changes from me, I pull changes from you).
