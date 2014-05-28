From: David Lang <david@lang.hm>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 11:23:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 28 20:23:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpiVS-00062L-8D
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbaE1SXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:23:15 -0400
Received: from mail.lang.hm ([64.81.33.126]:57448 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbaE1SXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:23:14 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s4SINACu013833;
	Wed, 28 May 2014 11:23:10 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250308>

On Wed, 28 May 2014, Dale R. Worley wrote:

>> From: Duy Nguyen <pclouds@gmail.com>
>
>> I don't know how many commands are hit by this. If you have time and
>> gdb, please put a break point in die_builtin() function and send
>> backtraces for those that fail. You could speed up the process by
>> creating a smaller file and set the environment variable
>> GIT_ALLOC_LIMIT (in kilobytes) to a number lower than that size. If
>> git attempts to allocate a block larger than that limit it'll die.
>
> I don't use Git enough to exercise it well.  And there are dozens of
> commands with hundreds of options.
>
> As someone else has noted, if I run 'git commit -q --no-status', it
> doesn't crash.
>
> It seems that much of Git was coded under the assumption that any file
> could always be held entirely in RAM.  Who made that mistake?  Are
> people so out of touch with reality?

Git was designed to track source code, there are warts that show up in the 
implementation when you use individual files >4GB

such files tend to also not diff well. git-annex and other offshoots hae methods 
boled on that handle such large files better than core git does.

David Lang
