From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 23:13:15 +0100
Message-ID: <1131833595.25203.10.camel@blade>
References: <1131800663.29461.11.camel@blade>  <4375EA80.7070405@op5.se>
	 <1131802238.29461.18.camel@blade>  <43766687.2000007@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 23:14:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3cW-0002Ip-N9
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVKLWNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVKLWNJ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:13:09 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:53657 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964844AbVKLWNI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:13:08 -0500
Received: from blade (p5487E170.dip.t-dialin.net [84.135.225.112])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id jACMDNGB004898
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sat, 12 Nov 2005 23:13:24 +0100
To: Lukas =?ISO-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <43766687.2000007@etek.chalmers.se>
X-Mailer: Evolution 2.5.1 
X-Virus-Scanned: ClamAV 0.85.1/1169/Fri Nov 11 22:28:05 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11713>

Hi Lukas,

> > you are right. It is exactly what I was looking for. I just saw it some
> > minutes ago, when I pulled the latest git tree. However to make an old
> > GCC 2.95 happy, the attached patch is needed.
> > 
> > I am not sure if it is fully working. It deletes a lot of old packs, but
> > in case of the linux-2.6 tree it leaves on additional behind.
> > 
> > .git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.idx
> > .git/objects/pack/pack-4d7682fb8230fef33eb518fa8e53885ec675795e.pack
> > .git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.pack
> > .git/objects/pack/pack-b3c6fbdfa36a326815de6358885c7a570a986b1b.idx
> > 
> > The 4d76... is the current pack, but the b3c6... is an old one that is
> > not needed anymore.
> 
> This is most likley because the pack b3c6... contains unreachable objects.
> git-pack-redundant only makes sure that all objects present in packfiles
> still are present in packfiles after the redundant packs have been removed.
> 
> Thus, unreachable objects will also be considered as required.
> 
> Note that I haven't checked if this is the cause in this particular case,
> but I have the same packfiles (I use the HTTP transport too).

maybe these packs are from a previous bad update. The cloned repository
I found it, is actually quite old. When I checked it with some others it
seems that it works perfect.

> I'm thinking of the possibility passing a list of objects to be ignored
> on stdin to git-pack-redundant. This would hopefully solve this problem.

Sounds good, but I don't even know what objects are involved in this
case and stops it from being marked as redundant.

Regards

Marcel
