From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Possible feature request for merge and pull
Date: Wed, 28 Jul 2010 21:21:21 -0400
Message-ID: <AANLkTikP+5GxyWbXNcKeOtQoOEGAT9v313jAum+q-1LV@mail.gmail.com>
References: <AANLkTim6JAPrSVaSaGZ72xtfFnUUcYeWT8vpL3rYuwki@mail.gmail.com>
	<AANLkTinRvq71GS5WVdWs9zP5QSJ=TjCWBgTfRGn2Qub0@mail.gmail.com>
	<AANLkTikA2jWu76aPUNG+B7Nwc9eDzoU93VcGvUFWR0Ri@mail.gmail.com>
	<20100729010341.GA25732@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 29 03:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeHoO-00080z-34
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 03:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0G2BVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 21:21:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65121 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0G2BVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 21:21:22 -0400
Received: by ywh1 with SMTP id 1so19267ywh.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 18:21:21 -0700 (PDT)
Received: by 10.100.60.9 with SMTP id i9mr8399677ana.47.1280366481441; Wed, 28 
	Jul 2010 18:21:21 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Wed, 28 Jul 2010 18:21:21 -0700 (PDT)
In-Reply-To: <20100729010341.GA25732@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152140>

On Wed, Jul 28, 2010 at 9:03 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 28, 2010 at 04:49:11PM -0400, Avery Pennarun wrote:
>
>> It sounds like --log and -m are currently incompatible, in that -m
>> overrides --log, and that's not the desired behaviour. =A0Bradley: t=
his
>> is probably a relatively easy fix to make, in case you're looking to
>> get into some git hacking. :)
>
> Really? I get:
>
> =A0$ mkdir repo && cd repo && git init &&
> =A0 =A0echo content >file && git add file && git commit -m one &&
> =A0 =A0echo content >>file && git commit -a -m two &&
> =A0 =A0git checkout -b other HEAD^ &&
> =A0 =A0echo content >file2 && git add file2 && git commit -m three &&
> =A0 =A0git merge --log -m "custom message" master &&
> =A0 =A0git show
>
> =A0commit fa21035ea5f5437e8664a5d249e7ab88ee3f0e75
> =A0Merge: d12be4a 4dc5cba
> =A0Author: Jeff King <peff@peff.net>
> =A0Date: =A0 Wed Jul 28 20:50:39 2010 -0400
>
> =A0 =A0 =A0custom message
>
> =A0 =A0 =A0* master:
> =A0 =A0 =A0 =A0two
>
> which seems to be what was asked for. So is the problem just that
> git-pull does not take "-m"?
>
> -Peff
>

--log is supposed to include one-log summaries of each of the merged
commits, right? It's not doing that for me when when I do 'git merge
--log -m "message" <branch>'. Instead, it's only using the message I
specified with -m.

One difference is that I'm merging topic branch into master but that
shouldn't make any difference.

Your right that the other part of the request is to add -m to pull.
