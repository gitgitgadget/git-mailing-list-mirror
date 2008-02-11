From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Mon, 11 Feb 2008 11:11:53 +0100
Message-ID: <200802111111.54187.jnareb@gmail.com>
References: <200802081828.43849.kendy@suse.cz> <200802110242.27324.jnareb@gmail.com> <alpine.LFD.1.00.0802102059260.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOVeN-0002qU-Bq
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYBKKMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 05:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbYBKKMA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:12:00 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:9729 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYBKKL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:11:59 -0500
Received: by an-out-0708.google.com with SMTP id d31so1131089and.103
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9zjlOMr77cERFcP/bfeqpTQmiY95E4QAESe4pGJjniI=;
        b=XafN7hxUbcr4fQc5tJdYXja78Y7RqwqV2BQY3ISdcmkiRFKOBZ9ZROp44fDHHgAT4k94yYIBxXhAMF1IsyYkooCktvOF5vTSnE9up1E04yfArPYWhus2o7SlwZcxLnvpAZB7tSguDo7zcgwJ+e2JgtiQzgNA3xMv+WLT+NIQ5F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Rhd64fqfwJpyCSZZ7nwAMR2JQQhZiWcUqAbPt+TuFErlxT3rJ4J4nMm4XjHxSpQswUh3MLdIT1p8GXa3jCu1nMpmihRVPIynafwXH+Tuw56UA1lTGhx7Gf9QgyLYWWB8lFrxY7gH0QynHCnv/1TIIxSpRZ6DF2PK09ksFNiYl44=
Received: by 10.100.120.15 with SMTP id s15mr17029305anc.17.1202724718753;
        Mon, 11 Feb 2008 02:11:58 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.19])
        by mx.google.com with ESMTPS id 1sm39508174nfv.3.2008.02.11.02.11.56
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 02:11:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.00.0802102059260.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73499>

On Mon, 11 Feb 2008, Nicolas Pitre wrote:
> On Mon, 11 Feb 2008, Jakub Narebski wrote:
>> On Sun, 10 Feb 2008, Sean napisa=B3:
>>> On Sun, 10 Feb 2008 00:22:09 -0500 (EST)
>>> Nicolas Pitre <nico@cam.org> wrote:
>>>
>>>> Finding out what those huge objects are, and if they actually need=
 to be=20
>>>> there, would be a good thing to do to reduce any repository size.

>> IIRC Dana How tried also to deal with repository with large binary
>> files in repo, although in that case those had shallow history. IIRC
>> the proposed solution was to pack all such large objects undeltified
>> into separate "large-objects" kept pack.
>=20
> That was to solve a completely different problem which wasn't about=20
> space saving, but rather to save on 'git push' latency.

Sorry, my mistake.

Although in Dana case separating large blobs into non-packed loose
objects (her patches), or separate kept non-delta large blobs only
pack (proposed solution), were shared over networked filesystem.
So the amortized size of repository was smaller... ;-ppp

--=20
Jakub Narebski
Poland
ShadeHawk on #git
