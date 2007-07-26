From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 08:52:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260841490.27738@beast.quantumfyre.co.uk>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
 <7vps2fc196.fsf@assigned-by-dhcp.cox.net> <20070726031838.GO32566@spearce.org>
 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707260614500.14781@racer.site>
 <46A8378A.6050201@xs4all.nl> <Pine.LNX.4.64.0707260737170.14781@racer.site>
 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
 <20070726071316.GE18114@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: hanwen@xs4all.nl, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:52:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDy99-000737-3K
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545AbXGZHwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757503AbXGZHwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:52:16 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:51656 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756667AbXGZHwP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 03:52:15 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id B6EBDC6153
	for <git@vger.kernel.org>; Thu, 26 Jul 2007 08:52:12 +0100 (BST)
Received: (qmail 20176 invoked by uid 103); 26 Jul 2007 08:52:12 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3770. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032338 secs); 26 Jul 2007 07:52:12 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 26 Jul 2007 08:52:12 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070726071316.GE18114@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53803>

On Thu, 26 Jul 2007, Shawn O. Pearce wrote:

> Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
>> 2007/7/25, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>> Did you succeed in adding perl?
>>
>>> It is not that important, because I plan
>>> to make git-gui the main user interface with this installer.  But Junio
>>> keeps adding Perl scripts (ATM add -i and remote) that I have to convert
>>> later...
>>
>> I don't see what this is good for.
>
> What git-gui is good for?  Its a GUI.  For people who perfer to use
> mice and push buttons over keys and a command prompt.  A large number
> of people in this world (many of them on Windows) like these things.
> Me, I'm more command line than I am GUI, yet I develop git-gui.
> So I find myself using it a lot, just so I can eat my own dogfood.
>
> Or do you mean Dscho's other point about rewriting tools into C?
>
>> I would suggest to making a clear
>> decision of what are recommended languages, and move everything else
>> to contrib/ .. Currently, C and bash seem the most reasonable choice,
>> but you could decide for perl, but then the consequence should be that
>> the bash scripts are translated into perl. Having both bash and perl
>> serves no purpose, and will lead to duplication of library code to
>> interact with the git binary.

Well, that really doesn't make much sense from the Linux POV.  Bash, perl 
and C are all well supported languages, each with its own set of 
strengths.  The tools that are being written are true parts of git - not 
optional contributed bolt-ons.

Admittedly it would probably increase the motivation to make everything 
built in if only C programs were allowed outside of contrib - but git 
would probably have not got where it is in that case.

> Sure, but there's some stuff that shell is good at, and other stuff
> that Perl is good at.  Forcing everything into one mold while we
> prototype new features is really limiting.
>
> But both are slower on fork challenged systems than using native C.
> Look at git-fetch for example; my ~400+ branch repository is taking
> upwards of 5 minutes to run a no-argument, no-changes git-fetch in.
> All sh and fork overhead.

I have a repo with ~9000 refs - it's what motivated me to start rewriting 
fetch in C ...

times for fetch to decide there were no changes (on Linux, local XFS 
disk):

pure-shell: ~45 mins
shell + C (fetch--tool): ~30 secs
pure C: ~0.5 secs

(the C version isn't the current version that Daniel has, but rather an 
older incomplete version that I had got far enough to do that much - so 
it may actually be slightly slower now ...)

-- 
Julian

  ---
If you want to travel around the world and be invited to speak at a lot of
different places, just write a Unix operating system.

    -- Linus Torvalds
