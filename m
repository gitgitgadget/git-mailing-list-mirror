From: david@lang.hm
Subject: Re: looking for suggestions for managing a tree of server configs
Date: Sat, 13 Oct 2012 21:57:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1210132153040.6253@asgard.lang.hm>
References: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm> <7vpq4l1x86.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNGGb-0005is-A6
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab2JNE5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:57:20 -0400
Received: from mail.lang.hm ([64.81.33.126]:41136 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2JNE5T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:57:19 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id q9E4vH04021418;
	Sat, 13 Oct 2012 21:57:17 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vpq4l1x86.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207611>

On Sat, 13 Oct 2012, Junio C Hamano wrote:

> david@lang.hm writes:
>
>> I've got a directory tree that holds config data for all my
>> servers. This consists of one directory per server (which is updated
>> periodically from what is currently configured on that server), plus
>> higher level summary reports and similar information.
>>
>> today I have just a single git tree covering everything, and I make a
>> commit each time one of the per-server directories is updated, and
>> again when the top-level stuff is created.
>
> It is quite clear to me what you are keeping at the top-level files,
> but if a large portion of the configuration for these servers are
> shared, it might not be a bad idea to have a canonical "gold-master"
> configuration branch, to which the shared updates are applied, with
> a branch per server that forks from that canonical branch to keep
> the machine specific tweaks as differences from the canonical stuff,
> instead of having N subdirectories (one per machine).

In an ideal world yes, but right now these machines are updated by many 
different tools (unforuntantly including 'vi'), so these directories 
aren't the config to be pushed out to the boxes (i.e. what they should 
be), it's instead an archived 'what is', the result of changes from all 
the tools.

The systems are all built with a standard image, but the automation tools 
I do have tend to push identical files out to many of the systems (or 
files identical except for a couple of lines)

David Lang
