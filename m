From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [OT] CDPATH (was: Re: [PATCH] Fix tests when using bash_completion)
Date: Mon, 23 Apr 2007 23:57:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704232351530.8430@beast.quantumfyre.co.uk>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
 <7vvefmeqs6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk>
 <7vvefmdab8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Ron Parker <ron.parker@mobot.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 00:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7TW-0004IY-Kf
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbXDWW53 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754464AbXDWW53
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:57:29 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47218 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754458AbXDWW52 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2007 18:57:28 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 91BD7C61CD
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 23:57:27 +0100 (BST)
Received: (qmail 10716 invoked by uid 103); 23 Apr 2007 23:56:30 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3147. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.035727 secs); 23 Apr 2007 22:56:30 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Apr 2007 23:56:30 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vvefmdab8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45376>

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> (I'm not the only one who thinks CDPATH is ick am I? :S)
>
> CDPATH is Ok as long as it stays as an interactive shell
> variable.
>
> Sadly, if you google for "CDPATH environment", you would see
> many many hits.  That variable is not meant to be used as an
> environment variable.

True - though personally I tend to use more discriminate shell functions 
anyway.

>
> Something like this in .bashrc is acceptable:
>
> 	case "$PS1" in
>        '')
>        	;; # do not do useless thing for noninteractive
> 	?*)
>        	CDPATH=my:favorite:path
>                . $HOME/.bash-completion
> 		;;
> 	esac
>
> but people usually are way too careless than that and export
> CDPATH to the environment, and that is where breakages start.

I guess part of the problem is that a lot of these people don't actually 
understand the difference between shell variables and environment 
variables, or why the distinction is useful.  Plenty of people seem to do 
"export FOO=..." by rote.

-- 
Julian

  ---
Anyone can hold the helm when the sea is calm.
 		-- Publius Syrus
