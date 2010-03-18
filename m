From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 15:02:59 -0400
Message-ID: <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL03-0001Io-CX
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470Ab0CRTDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 15:03:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:55362 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0CRTDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:03:01 -0400
Received: by qw-out-2122.google.com with SMTP id 8so448645qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JjOovOb2UAuctSGagOoiM2PihfxY3C7Kj2ZutoafFbM=;
        b=g969DV51LYhykZHHMGU8sMQJeZ45ct7KpddQjZmunhRxm4HeTqyqBl1v9b0NbHEiln
         28TRbHjFiCTaAk4i4MfsrlOsJfwMA5dIEXl2Ii/R36T+I6bImcchalSneRTQw5m0KaxB
         x1SBXBIVFFMfgGe9HYaDrC9KRrwK3wqh3gfxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xz5hNw8zs0aMBrCQNWmQQJFo9occNYYjIfGo6Fbtnb5EOX+iqK+GQMKteO3otyIoj4
         v1z4K6JdfD8a3S+x2PuxJ2s+txKylr/wjq0PSHvKVzkLgWDxuuWUcPi4JSeQWy2BqM3K
         yONcFvg8S8M0lYWslwJF7PO72Grwja1SjF2QE=
Received: by 10.229.232.149 with SMTP id ju21mr3048396qcb.87.1268938979603; 
	Thu, 18 Mar 2010 12:02:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142492>

On Thu, Mar 18, 2010 at 1:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 18 Mar 2010, Michael Witten wrote:
>>
>> Short Version:
>> -------------
>>
>> Rather than use a (name,email) pair to identify people, let's use
>> a (uuid,name,email) triplet.
>
> Even shorter version: NO.
>
>> Long Version:
>> ------------
>
> UUID's are some total crazy shit. It's like XML. If you think you nee=
d
> them, you're almost certainly wrong. If it's about identifying a uniq=
ue
> piece of hardware, ok. If it's about identifying people, no.

We could hash people emails and then build a .mailmap equivalent thus
hiding their identity.

Several things needed to be combined to build that mailmap.
1) a lot of hand work to identify aliases and misspellings
2) work with google to translate email addresses into human names when
names were missing
3) a list of all of the email addresses that had been checked, to make
it easy to identify new ones.

The trouble with hashing it is that all of the tools that use it will
need to be rewritten.

I'd really like to see a more global database constructed that links
commits, lkml discussions and the various distribution bug databases
but apparently it is too much of a threat to developer privacy. You
can achieve the same effect with a few hours in google throwing out
bunches of false positives.  It would be cool to be looking at a
subroutine, poke a button and then see all of the human oriented
history around it instead of just the diffs.

>
> How about you walk around with a bar-code tattooed to your forehead? =
Don't
> like the idea? Then think about having to care about a uuid in your
> projects. Same deal.
>
> Nobody is going to associate themselves with a uuid. It's not how hum=
ans
> work. It's degrading, and it's work-for-no-gain to anybody who doesn'=
t
> have OCD.
>
> So in practice, the only thing that would happen is that people make =
up
> random uuid's and they'd be different for every single machine they h=
ave,
> because absolutely NOBODY would ever bother to try to save and move t=
heir
> uuids around.
>
> So when you point out that emails aren't unique, or that people chang=
e
> their emails over time, please realize that the emails are _more_ sta=
ble
> than a uuid would ever be. Because an email actually has some emotion=
al
> attachment to the person in question. Yes, they change. So do real na=
mes
> too (which change more seldom, exactly because people are way _more_
> emotionally attached to their real names).
>
> uuid's? I can pretty much guarantee that for me, it would be differen=
t for
> every single machine I have. Because I could just not be bothered to =
care.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
