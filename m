From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 02:25:26 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF32209B45@xmb-rcd-x15.cisco.com>
References: <A0DB01D693D8EF439496BC8B037A0AEF322098A4@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161617240.21503@nftneq.ynat.uz>
 <A0DB01D693D8EF439496BC8B037A0AEF32209A54@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161721110.21503@nftneq.ynat.uz>
 <A0DB01D693D8EF439496BC8B037A0AEF32209AD2@xmb-rcd-x15.cisco.com>
 <alpine.DEB.2.02.1301161756240.21503@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"ishchis2@gmail.com" <ishchis2@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:25:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvfAs-0006Pg-No
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 03:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757905Ab3AQCZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 21:25:29 -0500
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:3626 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab3AQCZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 21:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1443; q=dns/txt; s=iport;
  t=1358389528; x=1359599128;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ne6RFArQaBVaAhgssnHQdN/P+I6uqvUxET4tW7OXw8U=;
  b=NMaAVgju9dN6OGjypFXzHh8ktsZYOMhdjQEPZs2knvjd4QhUBYhwf5WP
   Dzc0DbQvtCb3Uf43l9MLEpPbAsqlMj2tZk8eJgNm/0Vk06zEIDEFJZWiD
   ypHgmBGHLUZpZpO1v7Yah6NKHb8ti9N0O3sggAdaqpWZ+Gtv5eL1AeXcl
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAG9g91CtJXHA/2dsb2JhbABEvgYWc4IeAQEBAwE6PwULAgEIFQMKFAkHMhQRAgQOBQiICwUBuSqQV2EDplWCdYIk
X-IronPort-AV: E=Sophos;i="4.84,483,1355097600"; 
   d="scan'208";a="163543055"
Received: from rcdn-core2-5.cisco.com ([173.37.113.192])
  by rcdn-iport-8.cisco.com with ESMTP; 17 Jan 2013 02:25:27 +0000
Received: from xhc-aln-x12.cisco.com (xhc-aln-x12.cisco.com [173.36.12.86])
	by rcdn-core2-5.cisco.com (8.14.5/8.14.5) with ESMTP id r0H2PRN0014711
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 17 Jan 2013 02:25:27 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-aln-x12.cisco.com ([173.36.12.86]) with mapi id 14.02.0318.004; Wed, 16
 Jan 2013 20:25:27 -0600
Thread-Topic: Question re. git remote repository
Thread-Index: Ac30QapFxgO7vxkcSpqZYTWiS/u7TwAOT+SAAAxmn8D//67SgIAAYueA//+mgwCAAGNekA==
In-Reply-To: <alpine.DEB.2.02.1301161756240.21503@nftneq.ynat.uz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213837>

> From: David Lang [mailto:david@lang.hm]
> 
> On Thu, 17 Jan 2013, Matt Seitz (matseitz) wrote:
> 
> > 1. a bare repository that is normally accessed only by "git push" and
> > "git pull" (or "git fetch"), the central repository model.
> 
> pulling from it would not be a problem, I could see issues with multiple
> pushes taking place (the underlying repository would not get corrupted, but you
> will very quickly hit conflicts where the push is not a fast forward and you
> need to merge, not just push)

How is that different on a network file system, as opposed to using http, ssh, or git-daemon?  Don't you get a "not a fast-forward" error, regardless of the protocol?

> > 2. a repository where only one user does "git add" and "git commit",
> while
> > other users will do "git pull", the peer-to-peer model (you pull changes
> from
> > me, I pull changes from you).
> 
> 
> pulling from a shared repository is probably safe, but I wouldn't bet
> against
> there being any conditions where a pull at the same time someone is doing
> an
> update being able to cause problems.

Why do you think there would be a problem?

> The normal thing is to do the pulls through git-daemon, and that does make
> sure
> that what you are pulling is consistant.

What does "git pull" via git-daemon do to ensure consistency that is different from "git pull" on a network file system?
