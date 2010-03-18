From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:39:02 -0400
Message-ID: <46a038f91003181439lc343dafl6b9321a0b620de84@mail.gmail.com>
References: <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <4ba27424.9804cc0a.4b1f.11b1@mx.google.com> 
	<20100318204416.GM8256@thunk.org> <b4087cc51003181412s78d153c8t48984eb87eb75e0e@mail.gmail.com> 
	<46a038f91003181419n5d076bdbv18e32e292d7937a8@mail.gmail.com> 
	<b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 22:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsNRC-0004FC-MZ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 22:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0CRVjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 17:39:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47324 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0CRVjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 17:39:24 -0400
Received: by gwaa12 with SMTP id a12so1074316gwa.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Gyv4IOBcb6/nCWNlKD5mVdKuCBriV/He7PtXnnuBM1Y=;
        b=IKayZplJ3+iJM8uFZYXy0Nzwr0e4RlHYcNVg9k6J8KEFryr24r3cesA0IZY43C9Zcu
         e3fsPF4386t8KashjFFeboluqcwEP0KrxPnGyi59elcml++/FlRm020Da+skFUcJIvYW
         kBcj9HltZcPG45oQe+8WFbKTuLGZ8YDrQLQK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rTtMqMoHUcNG508bhu4ZHMrcU0zlyZnpSUaXyoje/IVrjHuo5TRwp3uUZpCOUCXKa8
         Cxv/650bvjyuNEyR3ItB8xeOnG3jPUOGHAilrJzNiEdelhmtS5VKtPFqN14xG+utSvTk
         0llFsaHw3LnJ2LrxCG3AwwVby27pgVzvqmj/s=
Received: by 10.101.39.1 with SMTP id r1mr5130498anj.101.1268948362184; Thu, 
	18 Mar 2010 14:39:22 -0700 (PDT)
In-Reply-To: <b4087cc51003181429v2998b95ei3f08360e6d2a5aa7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142524>

On Thu, Mar 18, 2010 at 5:29 PM, Michael Witten <mfwitten@gmail.com> wrote:
> On Thu, Mar 18, 2010 at 16:19, Martin Langhoff
>> What's the value? For me it'll be "Martin Langhoff". I already have that.
>
> Well, that's rather egotistical considering you're probably not the
> only Martin Langhoff in this world. I'd advocate something like
> "Martin Langhoff <martin.langhoff@gmail.com>".

So you are saying we should change the core datamodel of git to say...
what we already can say?

> At worst, things will be just like they have always been.

No, we'll have another way to have data mismatches. There are _more_
moving parts in your model. That's what Linus is pointing out.

This is a case where an ancillary "fixup table", in the form of
mailmap, works best. Don't move the fixup table to the core of the
datamodel, it just doesn't belong there.

Here's a hint: using your "uuid" model, I'll get some commits into a
project with the wrong uuid. Because I made a typo, or changed
machines (and a random uuid got created), whatever reason. So now in
my project I appear under 2 uuids.

What should we do in that case? Use mailmap to map the stray uuid to
the "real" one?... Have we done a lot of work to get back to square 0?

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
