From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 21:08:39 +0200
Message-ID: <81b0412b0908281208h20aa6e81od3d6567fdffa0dec@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828180158.GA6940@coredump.intra.peff.net>
	 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
	 <20090828183958.GA11488@coredump.intra.peff.net>
	 <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
	 <alpine.LFD.2.00.0908281458370.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:08:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6ob-0002bT-RS
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZH1TIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 15:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbZH1TIj
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:08:39 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:38178 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZH1TIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Aug 2009 15:08:38 -0400
Received: by fxm17 with SMTP id 17so1745468fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aeHsh4aMuWmavwHNAoug1Zmkimn8TrOBLCgSWhE2Iho=;
        b=CTqIZrqBAB1H3AGGPWo19JpWM3uiHNJ+/4dMV4f6gIDZE33cJcyH1UQvu3TjU7vLXP
         ZHFdZkxciYcG4i7Wjcqc+AxbiBWlULQqkzrFU3LTaO0oxTe96v/13MfOlUydxfYUGBu9
         vgwI0hgl0+ntz618XrZpK0HvICRhy0lbsJ2lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MLNqKDjkFECFO9qWoXo+WVzBMpzVKCoUhS5u3uHMa5GKErkp9i36t3dzUNizFtFEOt
         vbzY9eUwWRspSWoQLwUvQAGLSaRqSNrsGhTkDktJvr1PxP0X/APsABLtGXAy0lHaEsID
         BcsEcfVQo2+LHY6XYPmZ15G89VL3Mm6GoBlgY=
Received: by 10.204.175.73 with SMTP id w9mr1240715bkz.24.1251486519829; Fri, 
	28 Aug 2009 12:08:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908281458370.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127334>

On Fri, Aug 28, 2009 at 21:00, Nicolas Pitre<nico@cam.org> wrote:
>> >> Microsoft's compiler and libraries? MacOSX?
>> >
>> > Are you saying you know those to be platforms with problems, or ar=
e you
>> > asking whether those platforms will have problems?
>>
>> Both: MS never had weak/vague linkage, but I don't know about MacOSX=
=2E
>
> This is not about weak or vague linkage. =C2=A0This is plain basic li=
nker
> feature where no library object needs to be linked if there is no sym=
bol
> to resolve.

Maybe I missed something, but wasn't the idea to overwrite gettimeofday
with a public gettimeofday, defined in one of the object files?
And shouldn't a linker complain regarding duplicated symbols, unless
the other (library) symbol is defined as a weak symbol, allowing
overriding it with another symbol of stronger linkage?

>> I suspect them to have the same deficiency, but I'd be glad to be wr=
ong.
>
> Are you able to test it?
>

Only the MS, but it is not interesting.
