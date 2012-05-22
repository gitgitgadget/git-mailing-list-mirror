From: Martin Fick <mfick@codeaurora.org>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 23:51:16 -0600
Message-ID: <3b77e2a3-872a-41c1-9a51-0f219a549c04@email.android.com>
References: <4FB9F92D.8000305@alum.mit.edu> <201205211215.14455.mfick@codeaurora.org> <20120521194114.GA28358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 07:54:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWi3d-00022J-9V
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab2EVFyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 01:54:50 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:9138 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab2EVFyu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 01:54:50 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6718"; a="193379320"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 May 2012 22:54:49 -0700
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 0870010004A9;
	Mon, 21 May 2012 22:54:47 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <20120521194114.GA28358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198178>



Jeff King <peff@peff.net> wrote:

>On Mon, May 21, 2012 at 12:15:13PM -0600, Martin Fick wrote:
>
>> Of course, we use Gerrit, so features tend to be called 
>> changes and each change may get many revisions (patchsets), 
>> so all of these get refs, but I think that it might be wrong 
>> to consider that out of the ordinary anymore.  After all, 
>> should a version control system such as git not support 100K 
>> revisions of features developed independently on separate 
>> branches (within Gerrit or not)?  100K is not really that 
>> many when you consider a large project.  Even without 
>> Gerrit, if someone wanted to track that many features 
>> (likely over a few years), they will probably use up tons of 
>> refs.  
...
>
>Anyway, my point is that we don't even have to talk about "reasonable"
>or "absurd". Git should be fast even on absurd cases, because 99% of
>the work has already been done, and the last 1% is easy.

I hope you are right, but I don't quite completely share your optimism.  Some of that last 1% is perhaps last exactly because it is hard.  More specificaly, I am talking about the git protocol's ref advertisement on connection.  This has been considered a known issue for many years, yet it has not been fixed because it is hard to fix since it requires breaking the protocol in a non backwards compatible way.  I would be delighted if you had an easy fix for this rather fundamental ref scaling issue? We talked with Junio and Shawn and they agreed that it would be reasonable to put forward a proposal which does break backwards compatibility. So if there is a chance that there still may be another way, I hope it is found before this gets underway (no, I don't really expect that to happen),

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
