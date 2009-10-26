From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/3] git checkout --nodwim
Date: Mon, 26 Oct 2009 18:01:29 -0400
Message-ID: <32541b130910261501n32046cc5s12283a8e3981d04e@mail.gmail.com>
References: <7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <7v7huspjg0.fsf@alter.siamese.dyndns.org> 
	<32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> 
	<20091022062145.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0910220226270.4985@pacific.mpi-cbg.de> 
	<7vzl7h8fjp.fsf@alter.siamese.dyndns.org> <117f2cc80910240759oa9f57e7h67f06816d37e328c@mail.gmail.com> 
	<alpine.DEB.1.00.0910262111340.4985@pacific.mpi-cbg.de> <32541b130910261340g1988caednc17f3d159ec00d26@mail.gmail.com> 
	<20091026212628.GC27744@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 23:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2XdU-0002Dt-GK
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZJZWBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZJZWBp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:01:45 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:41885 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbZJZWBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 18:01:44 -0400
Received: by gxk8 with SMTP id 8so235629gxk.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TsCmR1Z81LoCdhA73NgCXuKDIdasJ2RL+9hrg9MHJSM=;
        b=lGUxoJr67Smwe+8u3RSeI6pTHZSa3VT/1GG3Mt2JX4psecT11UY+bnYrnBqPrqbrIB
         2ASzhN2L0/SCis4uhUZo/wIRQHyKh7ol2C8t9EbAYfM/x6ltVZXbS41r5p0qfHtPL8gW
         28BmhryAJQqYTfBa/Kp6u3BHGQHoQAWTG6XMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NjlwJy08S3TuSf/zkeTksEKYRFgIm7Xy4+EDuEh68RXQ1cGa5V5cbPX+Q6h1rV24hw
         uwMi7BSFTXyw+bsdU7sP4w4m21r8bW32gYTqyPTHfidFYJF+pCv9NzSil1coeMhwPXfo
         LFndcMptqNSupdFWORY+wItje6Uk+oNF/2Xuc=
Received: by 10.150.114.14 with SMTP id m14mr4682737ybc.162.1256594509050; 
	Mon, 26 Oct 2009 15:01:49 -0700 (PDT)
In-Reply-To: <20091026212628.GC27744@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131274>

On Mon, Oct 26, 2009 at 5:26 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 26, 2009 at 04:40:41PM -0400, Avery Pennarun wrote:
>> I don't think there's actually a plumbing alternative to git-checkou=
t,
>> however. =A0My git-subtree script (and another script at work) have
>> already had some bugs because of this (specifically, the differing
>> behaviour of git-checkout with and without a path specified). =A0Is
>> there something else I should be using in my scripts to be maximally
>> safe?
>
> It's git-update-ref.

That would be similar to git commit, not git checkout, right?  Oh
wait, I see the confusion: git checkout does two things.  It switches
branches, and it checks out files from the index into the work tree.
I meant the latter meaning.

> Consider "git commit", for example. Does anyone
> actually script around "write-tree" and "commit-tree" these days, or =
do
> they just script around "git commit"?

Oh, I use those all the time.  They're awesome!  It allows you to
create commits without having a working tree, which lets me do very
interesting tricks.  git-subtree uses this heavily.

I'm probably a weirdo, though.

Have fun,

Avery
