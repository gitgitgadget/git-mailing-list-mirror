From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 22:12:50 +0000
Message-ID: <32541b130908271512h255834adl5a606054f6ab20e4@mail.gmail.com>
References: <1251387045053-3527289.post@n2.nabble.com> <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com> 
	<20090827164657.GA17090@atjola.homenet> <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com> 
	<20090827204835.GC4399@coredump.intra.peff.net> <20090827213426.GD4399@coredump.intra.peff.net> 
	<7v7hwpors9.fsf@alter.siamese.dyndns.org> <20090827215007.GA6231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 00:13:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgnDc-0004YT-PY
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 00:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZH0WNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbZH0WNL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 18:13:11 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:47245 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbZH0WNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 18:13:10 -0400
Received: by gxk1 with SMTP id 1so1805788gxk.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=csr8cYGfOdIxJJMk1V6+IL4qTCocO0dsyH3eTtb5p+Y=;
        b=EMjCG6Rzq0TzEipbil1sOywBf2eSZSgDSosDDSNkFXYByMWtcHKZstAJ+p/gbuOYJ4
         pvERT8Cxy1W8Gpl0zr53aWri5GDArcB4gL8PdQpCyuT6QfhNN1Dhl+RkkJYSckd/qw+B
         X0LQtBUQxE7UPoeZq2MrJjl5ZEhhoraJptjNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vw+7DIG1l75fS5alOwCCCokbhqNkaYM1siouACGk+jrXDzZkQULLF04AxCoLQJoQRL
         kf7vnot4jr0oK8v4W3twsy73J//cD3i1M64FSuf2iJdK1NOtJ6+v0s6IshL2yU0PXp1W
         7nZE7iRy5NI3bRBHd7bF6vTXMwUwdhgFOqjNc=
Received: by 10.150.118.35 with SMTP id q35mr690391ybc.218.1251411190105; Thu, 
	27 Aug 2009 15:13:10 -0700 (PDT)
In-Reply-To: <20090827215007.GA6231@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127224>

On Thu, Aug 27, 2009 at 9:50 PM, Jeff King<peff@peff.net> wrote:
> I don't think the colon is the issue. Consider the same situation, bu=
t I
> say:
>
> =A0# but today let's demo it first
> =A0$ git fetch origin master
> =A0$ git checkout -b demo FETCH_HEAD
>
> I'm still screwed. The issue is that you consider your configured
> refspec destinations to be precious, and not merely a cache for what'=
s
> happening on the remote side.

Is the "precious remote ref" concept perhaps an imaginary one?

After all, if I *really* care about the prior state of the remote, I
can just make it a remote branch.  And if (as often happens) I just
want to know what's new in that ref since last time I merged, it's
simply

   git log master..origin/master

This works even if master has extra commits vs. origin/master, since
the double-dot invokes git-merge-base.

I think this might be a much more common than the case where people
actually want to see "what's changed since last time I checked what's
changed."  At least, the latter question has never been very
interesting to me, or if it is, it's easy for me to tell by eye.

Avery
