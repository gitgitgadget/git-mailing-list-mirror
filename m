From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 6 May 2009 15:23:40 -0400
Message-ID: <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com>
References: <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com> 
	<32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com> 
	<20090430222808.GH15420@raven.wolf.lan> <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com> 
	<20090501142811.GI15420@raven.wolf.lan> <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com> 
	<20090502215852.GJ15420@raven.wolf.lan> <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com> 
	<20090504211423.GK15420@raven.wolf.lan> <20090506185224.GM15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 21:24:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1miw-0006Xe-GI
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 21:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbZEFTYC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 15:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZEFTYA
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 15:24:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:60999 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZEFTYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 15:24:00 -0400
Received: by yx-out-2324.google.com with SMTP id 3so172313yxj.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=5z09t/jySKSC0Nt/UrErU5fENZKRs/iKwnyGkvnr1W8=;
        b=CUgPei+L/l6OP7a5tpy/msBePyCdzMfIypASb8HmtKu39MhR8J8d9vqyDeW8+OTKao
         UKZDLtp5Arja7fJA6QCtpYrFTunrdv0bGA2UB0WzqK5wLGkrx+yUYfuM75mXDym4NYUt
         T359IB0KaCUZaWj5YjR1edGJKT07jl1uluhac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=h8K8kkIajmvMScaK4G6bS0POlSsT7IH7bJJ15w2+JFb6wcZtQcOl7Lutem4H/myqBt
         LF3fStQGyl7YxHegRHbQV5AX7G/v99YCxSwi2SwI10cn1kZQ55MZP+759KfXLEYXx9IY
         m85AEfuJAjH0Lmtyxmr3/AnDShG7KdCrLaYuM=
Received: by 10.151.73.1 with SMTP id a1mr2872414ybl.203.1241637840164; Wed, 
	06 May 2009 12:24:00 -0700 (PDT)
In-Reply-To: <20090506185224.GM15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118374>

On Wed, May 6, 2009 at 2:52 PM, Josef Wolf <jw@raven.inka.de> wrote:
> Here's what I have at this point:
>
> =A0 =A0 =A0 =A0 =A0 =A0 ------------------S1TRUNK
> =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /
> =A0 --hs1--O1--c2...c2-------S1
> =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 `+++++++. =A0 =A0/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ =A0/
> =A0 --hs2--O2--c1...c1--S2
> =A0 =A0 =A0 =A0 =A0 =A0\ =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 -------------S2TRUNK
>
> =A0 hs1, hs2: =A0 =A0 =A0 =A0 history imported from svn-1 and svn2, r=
espectively
> =A0 O1, O2: =A0 =A0 =A0 =A0 =A0 the svn-1-orig and svn-2-orig tags
> =A0 c1, c2: =A0 =A0 =A0 =A0 =A0 cherries picked from hs1 and hs2, res=
pectively
> =A0 S1, S2: =A0 =A0 =A0 =A0 =A0 svn-1 and svn-2, the local tracking b=
ranches
> =A0 S1TRUNK, S2TRUNK: the remotes/svn-X/trunk branches
>
> I would have expected a symmetrical diagram. =A0But it turns out that=
 the
> connection marked with plusses is still at O1 instead of S1. =A0So it=
 takes
> no wonder that the c2 cherries get re-applied to the s2 branch on the
> next merge.

That's a well-drawn diagram, but unfortunately I'm still confused.
What is the "connection marked with plusses" and does it have a name?
It *looks* to me like both S1TRUNK and S2TRUNK should be okay, but
it's hard to tell what has actually happened here.

If you could post a screenshot of 'gitk --all' it might help.

Avery
