From: Phil Hord <hordp@cisco.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 09:39:42 -0400
Message-ID: <4E03421E.1000208@cisco.com>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Maarten Billemont <lhunath@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 15:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZk8M-0005wj-EE
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 15:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759355Ab1FWNjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 09:39:44 -0400
Received: from sj-iport-2.cisco.com ([171.71.176.71]:30361 "EHLO
	sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab1FWNjo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 09:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=883; q=dns/txt;
  s=iport; t=1308836383; x=1310045983;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=ey2TUpVCK6cfofHSgn7m3+9plXTfuN6v5hhF4abVejA=;
  b=cjjdebSRIz9S1H26YABgov9vmIT5hFpZL6xSC2U84gJxmYLpjd1GIEJW
   F6AibxmTfMZA4PQuLbiwgm4idSmOMw6RsItQXtY9pbfLWkCBPULzj/unt
   Y1BjxTPOtW5AvSoOxVaj+Fnca1u3F2HrZPa3CbvbP8ljM/cIXiV5fcVi0
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAOdAA06rRDoH/2dsb2JhbABSpx53qkSeK4YtBJFyhGWLRQ
X-IronPort-AV: E=Sophos;i="4.65,413,1304294400"; 
   d="scan'208";a="384283781"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by sj-iport-2.cisco.com with ESMTP; 23 Jun 2011 13:39:43 +0000
Received: from [10.117.80.99] (rtp-hordp-8912.cisco.com [10.117.80.99])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p5NDdgdO008874;
	Thu, 23 Jun 2011 13:39:43 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110623093942203
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176270>

On 06/23/2011 07:13 AM, Maarten Billemont wrote:
> When I initialize 2/3 submodules of my git repository and do git subm=
odule update, all is fine: Only the 2 submodules that I need are update=
d.
>
> When I run a git submodule sync to update the URLs that may have been=
 changed in .gitmodules, it ADDS the URL of the submodule that was NOT =
initialized, thus "initializing" it.
>
> Now, when I run git submodule update, it starts checking out the thir=
d module and my workflow is broken.
>
> git submodule sync should not add entries to .git/config, only update=
 existing ones.--

Maarten,

Is it enough to similarly limit 'submodule sync' the same way you did
with 'submodule init'? Like this:
git submodule sync -- A B

=46rom 'git help submodule':
"git submodule sync" synchronizes all submodules while "git submodule
sync =97 A" synchronizes submodule "A" only.

Phil
