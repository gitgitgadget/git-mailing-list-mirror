From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 16:41:42 +0200
Organization: gmx
Message-ID: <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org>
References: <552E628C.7040809@debian.org>
 <552E6D07.5030903@drmicha.warpmail.net> <552E732E.20107@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	git-owner@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 16:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiOVm-0005zb-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 16:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbbDOOlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 10:41:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:57718 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbbDOOls (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 10:41:48 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MOkQc-1Yl8Kn1mYY-006Agj; Wed, 15 Apr 2015 16:41:43
 +0200
In-Reply-To: <552E732E.20107@debian.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:ub6D8NMi7gXvyrD/9/A8L5xPuaDPW7GpuMnPpLh2s/ueEOFf9B/
 Ah2ufkIVUcijKc7wYOX4F4PrO55bmHpM+oz3nsETflU/89kkFkSgMUlO5YEIP54EFD3A0O8
 V+KqnMJeXjM+AwdUE3ANm/2BVNb6HR3fXO9h0FOxkIb9eUuRU4087Jf5ny1xyQ1pTaQJeHf
 cXm5JwBeqZbbMOp8AAzKA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267202>

Hi Praveen,

On 2015-04-15 16:18, Pirate Praveen wrote:
> On Wednesday 15 April 2015 07:22 PM, Michael J Gruber wrote:
>> What would that require git to do, beyond taking whatever you tell it
>> (using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for ssh?
> 
> May be support git+mosh as a protocol, since it is not a drop in
> replacement. It is redesigned remote shell. The ideas it uses for
> session resumption needs to be reimplemented. This will need support
> from git, because it needs server side to be modified. Use SSP to return
> the the current progress for a particular session (it uses AES session ids).

It will need support from Git alright, but not as much as from mosh, see my other reply: Mosh was not designed for non-interactive use. That support would have to be added before we can go any further.

> So when a client connect with a session id, git server side can respond
> with the current state, how many objects received in that session, and
> client can continue from where it stopped. Client also will need to
> store session information.

No, the protocol can stay exactly the same, once you have a way to communicate non-interactively via mosh.

Ciao,
Johannes
