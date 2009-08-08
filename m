From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Sat, 8 Aug 2009 09:40:39 +0200
Message-ID: <c77435a80908080040l4c92c68du777fbff5a9a2aca2@mail.gmail.com>
References: <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <4A7B95A8.2010000@vilain.net>
	 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
	 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
	 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
	 <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
	 <7vfxc3ov8t.fsf@alter.siamese.dyndns.org>
	 <c77435a80908080027p6a8de468w68983bd81364cefd@mail.gmail.com>
	 <20090808073042.GA20951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 08 09:40:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZgXp-00019j-CH
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603AbZHHHkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933564AbZHHHkk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:40:40 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59962 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933522AbZHHHkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:40:39 -0400
Received: by ewy10 with SMTP id 10so1994768ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AynnjvxfzHpYqc6/4i6NgkZi7CJjLcefufdipE+PBkg=;
        b=VUDvhMPCkE36pcPhsfvu1MwjP4Ogsl6L8yoPA942NJBy4axFS0tEkoSjewBOE39MWb
         cZ+1LgrEOLt1ltBf2wj4j5A8sKZ3I5uZR+7O3j8FBKFmq4yJsWZ+NNjOMR6YPST/c63K
         rqybVW06vdI6thrIlyjq9VGawfbYwR3hOp+1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hGwblKh9/Oer1Lai/H5vbBpMwvhF0fx0sV0tVPctXJSWzAJAoQui+TYs8eRsGQEVeT
         n/xgjKb8TWOCprqbwRbGUTWk8FQvYm2oW34I9KHMv669lWJzac9uiy36DDo6NK/U0XZh
         R+3kjCkwQ2UXs7h2Emmsi+EuAQbMNz/9wqBDE=
Received: by 10.216.73.193 with SMTP id v43mr409327wed.157.1249717239593; Sat, 
	08 Aug 2009 00:40:39 -0700 (PDT)
In-Reply-To: <20090808073042.GA20951@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125261>

> That might be useful, but I was thinking more of an "alternates"-like
> mechanism between repos. So that the data is stored only once on disk
> and in the disk cache, which is helpful for sites like kernel.org which
> serve many similar repositories.

Oh, right.  Yes, that seems like it could work.  We'd have to be
careful that a shared cache slice wouldn' change (like in a fuse or
something), but other than that we could have something as simple as a
link.
