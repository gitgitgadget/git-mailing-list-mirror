From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 16:40:41 -0400
Message-ID: <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> 
	<7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> 
	<7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> 
	<20091022062145.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de> 
	<7vzl7h8fjp.fsf@alter.siamese.dyndns.org> <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com> 
	<alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Roundy <roundyd@physics.oregonstate.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:41:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WNT-0004iG-IN
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590AbZJZUk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 16:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbZJZUk5
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:40:57 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:34231 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756591AbZJZUk4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 16:40:56 -0400
Received: by ywh40 with SMTP id 40so8626015ywh.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SKGG4S04PN7U/xeaiqyT9/jbvI8RlS62y25U0IWTRPg=;
        b=KdZlhjFieVPWTUh40+ja7xqeQAnzgy0Ofxt2DWFTS/b4EW2f7HF2sT499tMuKXT++S
         e1coRHCSScQTkq+EY7Rsu5l4znXAdJeFBBnF8Is9boFCp/JTekkJuBFusaaB/0oGKKb4
         PxZRnYRjQUUafXElgqT1o8/7BS6qa+nW9cuEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xb+1/nYO3yt383HmhoOTYd+zFLQcPGuDdezA6Ho9AvXx4cqvH+wOZPvNSXEkSWrFIn
         UvnRaee83+UuZFen96VoX4vy8p5o+Y4i1j7rAyLIfcy1h0u+cgjee+DqYEDjeMdFbDWV
         FcqppzNohPnU3Hync7EUfD/zM56Tdsi8BRZnQ=
Received: by 10.150.104.13 with SMTP id b13mr24836018ybc.17.1256589661052; 
	Mon, 26 Oct 2009 13:41:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131269>

On Mon, Oct 26, 2009 at 4:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 24 Oct 2009, David Roundy wrote:
>> Perhaps a universal --plumbing flag would be handy?
>
> No. =A0Older Git versions do not know about it, so you cannot Just Mo=
dify
> Your Scripts. =A0So the benefit of --plumbing is dubitable.
>
> FWIW the same goes for --no-porcelain.

I suppose that, three years down the road, the existence of such an
option would be useful.  Until then, any change at all to any
command's interface seems to have the same problem as you describe.

That said, as a person who maintains a bunch of git-wrapping scripts
at work, it seems more straightforward to me to continue the
separation between plumbing vs. porcelain commands, rather than giving
each command two subtly incompatible modes.  It's much easier for me
to remember "don't use git checkout" than to remember "when you call
git checkout, make sure to use --plumbing, even though *today* it
works just fine without it."

I don't think there's actually a plumbing alternative to git-checkout,
however.  My git-subtree script (and another script at work) have
already had some bugs because of this (specifically, the differing
behaviour of git-checkout with and without a path specified).  Is
there something else I should be using in my scripts to be maximally
safe?

Have fun,

Avery
