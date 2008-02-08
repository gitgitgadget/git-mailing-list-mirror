From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Fri, 8 Feb 2008 02:43:19 +0000 (UTC)
Message-ID: <pan.2008.02.08.02.43.21@progsoc.org>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	<20080205050741.GA4624@coredump.intra.peff.net>
	<pan.2008.02.06.21.56.35@progsoc.org>
	<20080207042332.GA7632@sigill.intra.peff.net>
	<pan.2008.02.07.10.15.05@progsoc.org>
	<20080207232337.GR30368@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 03:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNJDe-0007d3-0J
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 03:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755666AbYBHCn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 21:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755597AbYBHCn2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 21:43:28 -0500
Received: from main.gmane.org ([80.91.229.2]:48386 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479AbYBHCn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 21:43:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JNJD3-00076C-56
	for git@vger.kernel.org; Fri, 08 Feb 2008 02:43:25 +0000
Received: from 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk ([82.35.82.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:43:25 +0000
Received: from wildfire by 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:43:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73027>

On Fri, 08 Feb 2008 02:23:37 +0300, Dmitry Potapov wrote:

> On Thu, Feb 07, 2008 at 10:15:02AM +0000, Anand Kumria wrote:
>> On Wed, 06 Feb 2008 23:23:33 -0500, Jeff King wrote:
>> 
>> > Googling for your error message turns up only one other instance: a
>> > bug in pidgin where the result was "this seems like a bug in gnutls."
>> > I hate to say "it's not our bug" without knowing exactly what is
>> > causing it, though. And it does seem odd that it works with 1.5.3.8.
>> > I wonder if there is some difference in the way we are calling curl
>> > that matters.
>> 
>> It appears that git 1.5.3.8 on Debian links to libcurl3-gnutls whereas,
>> at least for me, git 1.5.4 on Debian links to libcurl4-gnutls (or
>> libcurl4-openssl).
> 
> Have you tried Git 1.5.4 with libcurl3-gnutls? It seems the package from
> Debian unstable is built with it. I have backported Git 1.5.4 to Etch
> with libcurl3-gnutls and I have not noticed any problems with https

Yes. I've tried the Debian git 1.5.3.8 and git 1.5.4 with whatever they 
are linked to (libcurl3-gnutls as you point out).

When I decided to build & bisect to see if I could troubleshoot, I ended 
up building with libcurl4-gnutls-dev installed first. When compiled 
against libcurl4-openssl-dev things works. 

So it definately seems specific to how git uses libcurl and how it, in 
turn, uses gnutls.

Anand
