From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Wed, 31 Mar 2010 02:12:44 +0530
Message-ID: <f3271551003301342j2fcefee6l1e9c9fa2d012bc11@mail.gmail.com>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com> 
	<20100330183748.GA10647@progeny.tock> <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com> 
	<20100330201007.GA26121@LK-Perkele-V2.elisa-laajakaista.fi> 
	<f3271551003301315i4bee002dm572e179819dbb1cd@mail.gmail.com> 
	<20100330202511.GC10977@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 22:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwiHK-000126-PQ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 22:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab0C3UnI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 16:43:08 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:63817 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab0C3UnH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 16:43:07 -0400
Received: by gxk27 with SMTP id 27so5055492gxk.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=efeQUv5D4jBQLaz2xPEknBbzV6sbEeLO4xHYHsGVIMc=;
        b=APJF2KYfiKfVdtdqIP8pYsUTCo56e/Ghs4jjN5BIHdsrSaG852wyYQ6t7lGZ6KzhZ4
         Se8F4/iwtsnaZECqi2X8SQyg54AN4qLSFW7XFqiJ0WNPD6xyOzs69Sz6HsICjizf4/Eu
         DVIun4DU4yPKjL2i6VgQaZqpUN0oSMnRH3TbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=w60Co7mDJZU9tqZq4GrW46h6lpD6KSq2NkqWGjenKObpYNUUEeg4Inpw0vgCLHZ2hG
         8Itjx3g4DczNDjucOX4J0RBAOyGtxv1myZbwv8L1j3yKr+J0zYQV1Wk5+dRgp6kyH+Sq
         NUifbbsbhEbncS+uO44DCEbhQAlQANsr57IyQ=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 13:42:44 -0700 (PDT)
In-Reply-To: <20100330202511.GC10977@progeny.tock>
Received: by 10.91.58.11 with SMTP id l11mr786061agk.0.1269981784864; Tue, 30 
	Mar 2010 13:43:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143601>

Hi,

On Wed, Mar 31, 2010 at 1:55 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hmm. =A0urls.txt is not currently its own page; instead, it is includ=
ed
> in git-clone(1) and so on. =A0I hope to change that this weekend.

My thoughts exactly. The giturls(7) idea will have to be dropped. It
looks like we have to post a patch for urls.txt to include some
introductory text and turn it into giturls(1), a manpage in its own
right. Then we have to remove references to urls.txt from all the
documents and make them point to gituls(1). I suspect the whole thing
will have to be done bit by bit, and go through several reviews. I can
help out a bit, but I wait for you to write most of it first.

One very realistic problem: Ambiguity between general URLS, "URLS
recognized by Git", and "arbitrary strings that perform the same
function as URLS".

> More to the point, wouldn=92t "URL recognized by Git" mean a string
> like fd::3,4 rather than the 3,4 that is passed to =91git remote-fd=92=
?

That falls under the <transport>::<address> category, but Ilari might
very well come up with a totally new syntax for a remote helper he
writes tomorrow.

> Also worth keeping in mind: we want to support third-party helpers, t=
oo.
> So it is hard to have one centralized document that completely explai=
ns
> all possible URLs.

Okay, I'll try to word it accordingly then. "URLS recognized by git,
and arbitrary URL-like strings recognized by that specific remote
helper program".

-- Ram
