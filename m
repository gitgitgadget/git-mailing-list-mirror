From: david@lang.hm
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:14:34 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqBqM-0003JP-8h
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYJOTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYJOTO0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:14:26 -0400
Received: from mail.lang.hm ([64.81.33.126]:49712 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbYJOTO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:14:26 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9FJDnhq001953;
	Wed, 15 Oct 2008 12:13:49 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98298>

On Wed, 15 Oct 2008, david@lang.hm wrote:

> On Wed, 15 Oct 2008, Andrew Morton wrote:
>
>> Date: Wed, 15 Oct 2008 11:56:54 -0700
>> From: Andrew Morton <akpm@linux-foundation.org>
>> To: git@vger.kernel.org
>> Subject: Untracked working tree files
>> 
>> I often get this (running git 1.5.6.rc0 presently):
>> 
>> y:/usr/src/git26> git-checkout linux-next
>> error: Untracked working tree file 'arch/x86/kernel/apic.c' would be 
>> overwritten by merge.
>> 
>> which screws things up.  I fix it by removing the offending file, which
>> gets irritating because git bails out after the first such instance, so
>> I need to rerun git-checkout once per file (there are sometimes tens of 
>> them).
>
> what I do when I run into this is "git reset --hard HEAD" which makes all 
> files in the working directory match HEAD, and then I can do the other 
> checkout.

I think you can also do git checkout -f head to force the checkout to 
overwrite all files

the fact that git will happily leave modified things in the working 
directory appears to be very helpful for some developers, but it's also a 
big land mine for others.

is there a way to disable this?

David Lang
