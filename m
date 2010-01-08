From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Fri, 8 Jan 2010 15:16:37 -0500
Message-ID: <32541b131001081216p27d7e29bu269755db895128@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vskal5c11.fsf@alter.siamese.dyndns.org> 
	<20100106191825.6117@nanako3.lavabit.com> <alpine.DEB.1.00.1001061219180.11013@intel-tinevez-2-302> 
	<7vocl7yxef.fsf@alter.siamese.dyndns.org> <20100107200509.6117@nanako3.lavabit.com> 
	<7vtyux3bx1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTLGb-0004Cb-JM
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 21:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab0AHUQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 15:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079Ab0AHUQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 15:16:59 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:62931 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0AHUQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 15:16:58 -0500
Received: by ywh6 with SMTP id 6so19818361ywh.4
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3agzzqyGw/tYDv1HiQo+tsRPIuG0tifl6fIzLKB7lrA=;
        b=GaZAE4o/RE1o7d+pgAShMXTe3L61Gh/2qQMFtwgSqjFdoMiyaUUCglTXshABYoR9Oj
         Y0A0asJbytL3Wjhhk3nyUVyK+guxZeGVTkFmRFhIW1EfRuXNngeF/qKQ1qFxafTr6ABg
         pcwwirLPlLfSsS7sfbC4eN1xZPeIpfQ/knTEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aCbVvaMlenwti9H9is1SFeUmNRHk6Eg2lQnckcAodd5QhLQz8T8EKer1+dGL+1TmL8
         +mhqj3yUZmCh69iyaJRaoyjGfjA8AOfjtKhNv4TvCQvO934y7QrQVnBwPYZSQLDxaeYh
         POgbjaAafaPscaL793ZsWhasThbbdtE3bSSMc=
Received: by 10.151.88.42 with SMTP id q42mr6084398ybl.75.1262981817502; Fri, 
	08 Jan 2010 12:16:57 -0800 (PST)
In-Reply-To: <7vtyux3bx1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136468>

2010/1/7 Junio C Hamano <gitster@pobox.com>:
> I am a bit unhappy about the duplication. =A0The text of this functio=
n is
> different from the one in "rebase" proper, but they implement essenti=
ally
> the same logic. =A0I was tempted to suggest having a common helper fu=
nction,
> but as Dscho mentioned "rebase -i" implementation does not share much=
 with
> "rebase" (even though it shares the external command line interface f=
rom
> the end user's point of view), and I don't see a readily available pl=
ace
> (other than in git-sh-setup) to do so.

Is there a reason that non-interactive rebase can't just be
implemented as "git rebase -i" but without actually launching an
editor to edit the commit list?

This would resolve any other inconsistencies between the two as well,
notably that non-interactive rebase sometimes refuses to do the rebase
I requested because "Current branch master is up to date," while
interactive rebase is willing to do it.  (Personally I prefer the
latter behaviour, since I don't like tools that think they're smarter
than me :))

Avery
