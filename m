From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Thu, 11 Mar 2010 17:57:01 -0600
Message-ID: <soW-UavLAeDZXqfDG66SVvi7VeuMUeFh0aD4xLpANaibvx4i0auVpw@cipher.nrlssc.navy.mil>
References: <20100311163715.GE7877@thor.il.thewrittenword.com> <20100311222722.GB18292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Gary V. Vaughan" <git@mlists.thewrittenword.com>,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 12 00:57:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpsFf-0002Fl-4r
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 00:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab0CKX5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 18:57:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60964 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab0CKX5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 18:57:08 -0500
Received: by mail.nrlssc.navy.mil id o2BNv281016654; Thu, 11 Mar 2010 17:57:02 -0600
In-Reply-To: <20100311222722.GB18292@sigill.intra.peff.net>
X-OriginalArrivalTime: 11 Mar 2010 23:57:02.0028 (UTC) FILETIME=[8B4420C0:01CAC176]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142008>

On 03/11/2010 04:27 PM, Jeff King wrote:
> On Thu, Mar 11, 2010 at 04:37:15PM +0000, Gary V. Vaughan wrote:
> 
>> Actually, the test for setting NO_IPV6 at configure time is still
>> too optimistic and I have to manually pass '-DNO_IPV6' in CPPFLAGS
>> at build time on aix-5.2.0.0 and earlier, and irix-6.5 and older
>> for them to pick up the right branch.
> 
> Are you running 'configure' or just 'make'? If the latter, then the
> defaults for each platform are defined in the Makefile (e.g., see around
> line 790 of the Makefile where we turn off IPv6 for Solaris 2.7, but not
> 2.8). Patches to tweak the defaults for obscure platforms are welcome.
> 
> Also, now that I look at that, we seem to already have a
> NO_SOCKADDR_STORAGE flag that handles this case? Does setting that fix
> your problem without this patch?

NO_SOCKADDR_STORAGE is already set for Solaris 7, and still daemon.c can
not be compiled since ss_family started being used, I think in 15515b73.

I should probably speak up when things break, but I tend to remain silent
if I don't have the time to investigate.

-brandon
