From: Sam Vilain <sam@vilain.net>
Subject: Re: Summer of Code project ideas due this Friday
Date: Sat, 12 Mar 2011 11:42:13 +1300
Message-ID: <4D7AA545.4050006@vilain.net>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <4D7A1325.1090003@miseler.de> <20110311125259.GA777@LK-Perkele-VI.localdomain> <AANLkTin30fZURU-PxddSai5Qzfqjtwej=maGssyr2b7W@mail.gmail.com> <4D7A2D47.9010101@miseler.de> <AANLkTinKnfiE9zQwYxfCX8VhRfgJhQopDbqBA+oQLL0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Miseler <alexander@miseler.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 23:42:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyB2R-0003tA-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 23:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab1CKWmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 17:42:22 -0500
Received: from vilain.net ([60.234.254.246]:50744 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab1CKWmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 17:42:21 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 15ED52E0B2; Sat, 12 Mar 2011 11:42:20 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.1.83] (arcturus.local [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id AE45E2E0A6;
	Sat, 12 Mar 2011 11:42:13 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTinKnfiE9zQwYxfCX8VhRfgJhQopDbqBA+oQLL0w@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168930>

On 12/03/11 03:27, Nguyen Thai Ngoc Duy wrote:
> On Fri, Mar 11, 2011 at 9:10 PM, Alexander Miseler <alexander@miseler.de> wrote:
>> This may all be aiming to short. IMHO the best solution would be some
>> generic way for the client to specify exactly what it wants to get and to
>> get just that.
> But how do you define "what it wants to get"? Pros and cons are
> different and depend on that defintion.
>
> Git's way of saying now is "I have these commits, give me these
> branches (cutting at certain depth)". A near future extension would be
> "I have these commits _restricted to these paths only_, give me...".
> If it's broken half way, start again.
>
> The bundle way is basically Git's way except that the remote side says
> "I've got this bundle, fetch it here, then you can ask us again for
> the rest in a normal way".
>
> mirrorsync (aka gittorrent) says "I have this commit, give me objects
> so that I can have this commit", which leaves the (probably) huge
> initial commit out of view.
>
> My way is "give me a chain of deltas starting from this SHA-1". A big
> blob can be considered as a history of smaller pieces.
>
> The last way of saying is just "give me this object", which would be a
> big waste of bandwidth.
>
> Your move :)

Just FWIW, I recently produced some diagrams and demonstrated the
resumable clone algorithm; speed is currently very limited by the
implementation at 15 minutes to slice up git.git; but I'm playing with
libgit2 to see if I can make a more optimal version.

See http://vilain.net/comp/git/gittorrent/commit_reel.html

Sam
