From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Thu, 14 Jan 2010 01:00:24 +0200
Message-ID: <20100113230023.GA9171@Knoppix>
References: <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
 <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
 <20100113191802.GA8110@Knoppix>
 <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
 <20100113200629.GA8383@Knoppix>
 <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
 <20100113210414.GA8535@Knoppix>
 <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 00:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVCCZ-0002mp-GV
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 00:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065Ab0AMXAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 18:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034Ab0AMXAb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 18:00:31 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:58577 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947Ab0AMXAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 18:00:31 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id A46FC13BAB5;
	Thu, 14 Jan 2010 01:00:29 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05E989A01A; Thu, 14 Jan 2010 01:00:29 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 68FC44065;
	Thu, 14 Jan 2010 01:00:25 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001131403u162bc6ebpd551ed19aadde7fb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136892>

On Wed, Jan 13, 2010 at 05:03:45PM -0500, Avery Pennarun wrote:
> On Wed, Jan 13, 2010 at 4:04 PM, Ilari Liusvaara
> 
> This is still not very illuminating.  How do you know your replacement
> will not have these same failure modes? 

No client-side fallbacks, key auth works pseudonymously. That takes
care of them pretty well.

> If you solve your main
> annoyances with ssh, how do you know you won't introduce any new
> annoying failure modes? 

Ensuring that at least some information make back to client (presuably
enough to figure out the problem).

And then there are few failure modes that can't be helped no matter what
I do (like mistaking protocol for P2P, git:// suffers from that as well).

> *Why* can't ssh be fixed to solve the  problem?

Client side fallbacks (may be desired or not!), service not being
able to intervene on wheither to allow client or not in case of
keypair auth.

>  Will I have to generate and manage yet another new set of
> keys to use the new system?

Yes. 

> You seem to be positioning your implementation as a competitor to
> *all* of ssh, https, and straight TLS (including stunnel),

Only to smart http://, smart https:// and ssh://. 

> and
> moreover, presenting it as superior to all three.  This is surely
> possible (they all suck differently), but it's going to be hard to
> convince people.  And if your new security protocol *only* works with
> git, it loses points automatically against other solutions. 

The general design would be applicable to applications besides git, but
this implementation is git-specific.

And making it work like stunnel? On server-side that could work, but
not on client side (and it would take quite extensive changes to 
git-daemon).

> (Even if
> ssh is hard to set up, I've *already set it up*, so any new
> alternative starts with an immediate negative score.)

Well, if you like SSH more, then use ssh://...

-Ilari
