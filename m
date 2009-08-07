From: Nick Edelen <sirnot@gmail.com>
Subject: Re: [PATCH 0/5] Suggested for PU: revision caching system to 
	significantly speed up packing/walking
Date: Sat, 8 Aug 2009 00:53:12 +0200
Message-ID: <c77435a80908071553m6f7d5298p5ea68b9386198b3f@mail.gmail.com>
References: <op.ux8i6hrbtdk399@sirnot.private>
	 <alpine.DEB.1.00.0908061645470.8306@pacific.mpi-cbg.de>
	 <4A7AEFA8.5010001@drmicha.warpmail.net>
	 <c77435a80908061039p30b83511qb7c378cfd68a6cf6@mail.gmail.com>
	 <alpine.DEB.1.00.0908062030340.8306@pacific.mpi-cbg.de>
	 <4A7B95A8.2010000@vilain.net>
	 <alpine.DEB.1.00.0908070808340.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908071029580.16073@xanadu.home>
	 <c77435a80908071502y48d14a38h79eec14a1be8c6fb@mail.gmail.com>
	 <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZYJP-0003gW-0k
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 00:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbZHGWxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 18:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbZHGWxO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 18:53:14 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48559 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbZHGWxN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2009 18:53:13 -0400
Received: by ewy10 with SMTP id 10so1866392ewy.37
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TXTJJFd2lo+moWAnLSqpXAjQcsGJ+tpVk5qSSTQ4mok=;
        b=rxiRu6yGkNPc3gF+uHgmcYEspFeyW9vEE9dBbsPLm8yenT376JpHlMLa4xBECGlKaD
         yOLQUOHVWJ149NonNZ8/XgCUhUOKItT/UKCimCh7vm9wFO1W5+dSElKU5o1C8lavInkS
         AAGLUQBMhxzeGmdbcNZaV4JS9P41y/lnnU/PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O0k7ZpEsp3zE/7KQWcI3nUFqsXmIBhvFIRTgbd3UZJSjVieHqyAvX1GZkzHayGwXOe
         Lkm5h+j/Nc+xu+GkFDpmUSkxEyQGDBxUpP1nxwth2B6Ox67ncZBqaqluYQ/80guH6qoe
         VpEqO/AFRF3cJH9z+8iVmKOnX9YEB5AQ7PRPE=
Received: by 10.216.15.68 with SMTP id e46mr325249wee.225.1249685592890; Fri, 
	07 Aug 2009 15:53:12 -0700 (PDT)
In-Reply-To: <7vzlabp7e4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125234>

> Hmm. =A0.git/objects/ as of today is about 482M here, so we are talki=
ng
> about roughly 10% overhead?

Yes, that sounds about right.  The cache file for git's repository is
3MB, and my repo (partly packed) is ~35MB.

By the way, what would be the best way of posting a revised patchset?
Should I just reply to my older posts, or make new ones?
