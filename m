From: demerphq <demerphq@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 20:43:48 +0100
Message-ID: <9b18b3111002031143h63aaa6bpa4c91d140a769bb0@mail.gmail.com>
References: <20100203174041.GC14799@spearce.org>
	 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
	 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
	 <20100203192658.GP9553@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncl8m-0000sq-IQ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339Ab0BCTnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 14:43:53 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:33170 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab0BCTnu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 14:43:50 -0500
Received: by bwz19 with SMTP id 19so435865bwz.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=8cqeK73RgF2fFOXHnpvwzLOgrKtd7PrfSN9+9NRy/6M=;
        b=bY5dIezHPQ1KUZSdsHIncX8ryQ1H8PBZmLdpYd6r+PqSp8KD7/MXxWInfWAeNattMC
         849G70M+QsWE9X4L1oYOTjZXbkyrni7+5r0RsnrCiAJaLAFYPf6QwDfHYcqgCFLxq1Ad
         NxMFBB/wTlyujyfrJNU27aP9/PrqTF3fX24O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LRTxLYkCB0JULBDgnpglSaAQPKrNS+2m3pmWleV8gugojwXrALnrCPTQdAfacxQPQB
         vqSww4bYAH0vcYXyIu8emfHBzZPeEY/r5mohv2WW2oSzFBCKiIqyw8w6x9aTWSBfFE3M
         Iu3LEMsNeQ7kcQewlhBsWyDFtv8Gdv5sHf6FA=
Received: by 10.239.193.77 with SMTP id h13mr3398hbi.74.1265226228388; Wed, 03 
	Feb 2010 11:43:48 -0800 (PST)
In-Reply-To: <20100203192658.GP9553@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138871>

On 3 February 2010 20:26, Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Feb 03, 2010 at 08:01:17PM +0100, demerphq wrote:
>> Shouldn't an old git just ignore headers from a new git?
>>
>> I mean, forget about the fact that somebody is doing something naughty
>> with the git protocol, ask youself if you want this rule to basically
>> prevent any backwards compatible changes with older gits.
>
> We have done similar changes in the past and if there would be such
> a change, we can phase-in it over the course of several releases.
> I think the fall-out would not be that bad; we have some experience
> with even making Debian-stable Git compatible with new stuff. ;-)
> Also, what if any extra header would be essential and we _wanted_
> non-compatible Git to break down on it?

Right. The only solution i can see would have had to have been
implemented already. And that would involved some headers being marked
"pass through", some "marked throw away on cherry-pick" and some
"choke horribly if you find this and dont know what it is".

And even with somethng like that one wonders if  notes arent really a
better alternative to user defined headers anyway?

> On the other hand, allowing this preventively would apparently have
> the immediate effect of alternative implementations users happily
> starting to use it, and then to get to the data, people would demand
> git-core support as well. _And_ so far everyone seems really really
> fairly sure we don't want the headers and it's not likely to change.


Yes, right understood.

>
> P.S.: On the other hand, I think that change was probably just
> misguided, not malicious. And I wouldn't be that hard on Dulwich,
> it's an early-0.x software after all, it's allowed to crash and have
> protocol issues. ;-)

Heh. I have no opinion on Dulwich. Didnt even know it existed until this mail.

Yves




-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
