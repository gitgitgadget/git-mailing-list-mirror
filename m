From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 26 Sep 2011 17:32:14 +0200
Message-ID: <4E809AFE.6010901@alum.mit.edu>
References: <4DF6A8B6.9030301@op5.se> <1315511619144-6773496.post@n2.nabble.com> <1315529522448-6774328.post@n2.nabble.com> <201109251443.28243.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 17:32:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8DAU-0002cC-V0
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 17:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab1IZPc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 11:32:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55072 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1IZPc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 11:32:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8QFWEiJ021441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 26 Sep 2011 17:32:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <201109251443.28243.mfick@codeaurora.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182123>

On 09/25/2011 10:43 PM, Martin Fick wrote:
> A coworker of mine pointed out to me that a simple
> 
>   git checkout 
> 
> can also take rather long periods of time > 3 mins when run 
> on a repo with ~100K refs.  
> 
> While this is not massive like the other problem I reported, 
> it still seems like it is more than one would expect.  So, I 
> tried an older version of git, and to my surprise/delight, 
> it was much faster (.2s).  So, I bisected this issue also, 
> and it seems that the "offending" commit is 
> 680955702990c1d4bfb3c6feed6ae9c6cb5c3c07:

I'm still working on changes to store references hierarchically in the
cache and read them lazily.  I hope that it will help some scaling
problems with large number of refs.

Unfortunately I keep getting tangled up in side issues, so it is taking
a lot longer than expected.  But there's still hope.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
