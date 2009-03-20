From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 14:39:21 +0100
Message-ID: <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>
	 <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
	 <20090319214001.GA6253@blimp.localdomain>
	 <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de>
	 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>
	 <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 14:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkexz-0001Eu-Hh
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 14:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbZCTNjZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 09:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbZCTNjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 09:39:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:35698 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZCTNjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 09:39:25 -0400
Received: by yw-out-2324.google.com with SMTP id 5so975724ywb.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2009 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z/WP+a6G41eE8MTDlifoqPFx5xGuTxr3Hj0eWpxG7Rc=;
        b=dqUe29qJ6ft3go3thN2c+pj7jDpPPMOqcuwzroPM0PYoyAjDi6wuhVpuB6QrYYpSXe
         GcnS5zNuU0RlXllKRkL3iXunLlQ1endvz0AT+j2Gv4D29FcQwUqwOVqsNF5amdvFRCEf
         K6kg/aNb+aMTZ9AbDmAEDAPq5wgCq+WvylAbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aYXcu88tIrIT1OJ3ya6Bbber12wjL0IhsEKQhtIcGM75RUt1JzLuIfNxJryZUTt6vB
         W1QPBOJBzy4tozRKZ5NMuRtC9pcjRQXRKGwJ1CMRTxa3LavH0RuGMn01gD50Jp+X8iXz
         uAPOPvjMMuLz+FoFo3uWEkp7ZP27j5nEBkmVI=
Received: by 10.100.43.10 with SMTP id q10mr4028079anq.1.1237556361925; Fri, 
	20 Mar 2009 06:39:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113956>

2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 20 Mar 2009, Alex Riesen wrote:
>
>> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> > Now, we _do_ have msysGit, you _do_ have shown the capability to f=
ix
>> > issues when they arise, so I do _not_ see any obstacle why you sho=
uld
>> > not go msysGit, rather than staying with the pain of trying to sta=
y
>> > POSIX-compatible, but not quite all the time.
>>
>> I understand. It is not pure POSIX compatibility I seek. I just can'=
t
>> use MinGW port, because I absolutely must use the cygwin environment
>> (for "hysterical" reasons) and they don't play well together (tried,
>> yes. Conflicting libraries, but you already know that).
>
> Maybe we can work on those conflicting libraries? =C2=A0After all, we=
 do have a
> "rebase.exe" tool now (for all those as puzzled by the naming as I wa=
s:
> the rebase.exe tool can shift the memory range used by a .dll so that=
 it
> does not overlap with that one of another .dll).

As long as they can be made to coexist I'm fine. Wasn't the problem
that MinGW/MSYS used cygwin1.dll if it were in PATH? Or was it
something else with their supporting libraries?

My other problem is that the cygwin programs, and the worst of all - a
proprietary compiler based on cygwin, must be in PATH. AFAIR, the
presence of cygwin in PATH broken shell scripting.
