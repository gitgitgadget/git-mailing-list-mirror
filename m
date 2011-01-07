From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Fri, 7 Jan 2011 21:04:49 +1100
Message-ID: <AANLkTikWKdUE1JoBPmQF-NyacTtoKKD0NZYu_arsqoiW@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home> <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home> <20110107052207.GA23128@sigill.intra.peff.net>
 <20110107053119.GA23177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 11:05:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb9CQ-0005Vd-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 11:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab1AGKFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 05:05:24 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46101 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab1AGKFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 05:05:22 -0500
Received: by bwz15 with SMTP id 15so17157747bwz.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 02:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=uuFSqIZ2SFCmqlxgANSI+7SKKLYvMEm50n9Pn87gpTY=;
        b=w4F8T/iIlbFuSWdtcT5ED9WZwchhV92KQgZgOkgznYTGQBem6JRVDhqL6EevMxSXb9
         U9hGlkqj4Lqu+KuEAl3AkcQ4VcrR+OtIWev/TucgeDCoHbc+rx3m4W/MdUep0ahCu3RO
         r1h6ACGiH4jwFq9/HOQk2F5fD5gzN8zS8O/s8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=HMvTGTvxJ7Dd9gGWloFaBT1e/E4uagFa0o3MVN4pGH//n5lF90uiM0JMxIIVJszu3D
         mw1qBD25YD6HThHxAU5bJ67IgdPZlxrfi4BdraxPLCzSmwsC+eux5WIjXx1cbVHNls8o
         eVSw1Yo1AsTDY6t1d1SsQF2Ev7GWHC6HCgJQ4=
Received: by 10.204.117.71 with SMTP id p7mr900782bkq.187.1294394720650; Fri,
 07 Jan 2011 02:05:20 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Fri, 7 Jan 2011 02:04:49 -0800 (PST)
In-Reply-To: <20110107053119.GA23177@sigill.intra.peff.net>
X-Google-Sender-Auth: fXDCyamwVAmVrnMgUU_1BRosNEk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164703>

On Fri, Jan 7, 2011 at 16:31, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 07, 2011 at 12:22:07AM -0500, Jeff King wrote:
> the reason I am
> interested in this expanded definition of mirroring is for a few
> features people have been asking for:
>
> =A01. restartable clone; any bundle format is easily restartable usin=
g
> =A0 =A0 standard protocols

This is very important to me. I have failed to establish an initial
repo for a few larger projects, some apache projects and opentaps most
recently. It is getting _really_ frustrating.


> =A02. avoid too-big clones; I remember the gentoo folks wanting to
> =A0 =A0 disallow full clones from their actual dev machines and push =
people
> =A0 =A0 off to some more static method of pulling. I think not just b=
ecause
> =A0 =A0 of restartability, but because of the load on the dev machine=
s

And of course the lack of restartability causes an ongoing increase in
the load on the machines delivering those large clones.


> =A03. people on low-bandwidth servers who fork major projects; if I w=
rite
> =A0 =A0 three kernel patches and host a git server, I would really li=
ke
> =A0 =A0 people to only fetch my patches from me and get the rest of i=
t from
> =A0 =A0 kernel.org

This is not so much of a problem - can already be handled by cloning
your linux-full.git to a private dir, and only publishing your shallow
"personal patches only" clone, or better still, just a tar-ball of
your 3 patches, or email them, or etc.


So I agree with the big issues being restartable large clones and
lowering server loads.

Zen
