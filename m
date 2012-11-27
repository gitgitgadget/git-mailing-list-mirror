From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: gitpacker progress report and a question
Date: Tue, 27 Nov 2012 09:51:01 +0100
Message-ID: <CAMP44s0ctVh3cbJF3rykGKn-ZH5qQfwaX-=G+MT1jhU6vK=WYw@mail.gmail.com>
References: <20121115212818.GA21558@thyrsus.com>
	<CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
	<20121126220108.GB1713@thyrsus.com>
	<CAMP44s2+NDyL2Vf=iKR09f-YUnp=G2BCiYj-+qKuP7JA-+YkmQ@mail.gmail.com>
	<20121126234359.GA8042@thyrsus.com>
	<CAMP44s3=VpMv-S2eV9rXRaH9U3SvaR8B6Dto=vAmVQ_XB1uBXg@mail.gmail.com>
	<20121127072700.GA23169@thyrsus.com>
	<CAMP44s1=sjWypEN3zzC=aPqZYnBFU0C+Dhrh3zj=jY57PHJ6wg@mail.gmail.com>
	<20121127083639.GA26935@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Tue Nov 27 09:51:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdGsv-000611-VT
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 09:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758574Ab2K0IvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 03:51:04 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51280 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758396Ab2K0IvC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 03:51:02 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so12220017oag.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nfVk1A1TwQRe7QRGjhYDWrmIkZ3KtHfoDIHEUe8Go/M=;
        b=cfESupYnGR5pHjk8AMTfkBLVpHahzvj2ZiAviL0tILKha3Rt7XSKGBnaezveaFZn3G
         Cz/qyUTYD5ZEWxW40kPKH3j9qB4GN+5+5rmBCrdJXvRSEbeLV0wIM5tGs+NZSW9H8X6J
         9LIWcYt9WIOHEeOcZqNMyaOK5+GWjcF2Nv0mxnXbhJepzZRq9U0hZ47x2sw7BGPKFMfs
         cqTvO4tLjjAF27eF42jQWoyITGj5x0hs6ypmsiKcgU7avPnVPq09vx6YGJqC69FyjPeQ
         yGyHt8MvogDEbWCCBf84w69AaE1AauvVuNBjIJMS2cph8/j87a+zEv8cMeB3msnIw+7e
         us9g==
Received: by 10.60.172.229 with SMTP id bf5mr11621070oec.81.1354006261645;
 Tue, 27 Nov 2012 00:51:01 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 00:51:01 -0800 (PST)
In-Reply-To: <20121127083639.GA26935@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210550>

On Tue, Nov 27, 2012 at 9:36 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> Most of those old projects have a linear history,
>
> INTERCAL didn't.  There were two branches for platform ports.

Fine:

tag v0.1 gst-av-0.1.tar "Release 0.1"
tag v0.2 gst-av-0.2.tar "Release 0.2"
checkout port1
tag v0.2-p1 gst-av-0.2-p1.tar "Release 0.2 p1"
checkout port2 v0.2
tag v0.2-p2 gst-av-0.2-p2.tar "Release 0.2 p2"
checkout master
tag v0.3 gst-av-0.3.tar "Release 0.3"

Problem solved.

>> But different commit/author and respective dates, and merges? Sounds
>> like overkill.
>
> I felt it was important that the metadata format be able to specify
> git's entire metadata and DAG semantics.  Otherwise, as sure as the
> sun rises, *somebody* would run into a corner case not covered, and
> (quite rightly) curse me for a shortsighted fool who had done a
> half-assed job.

I'm willing to bet that won't happen.

> I don't do half-assed jobs.  Not ever, no way, nohow.

So you prefer code that is way more complicated that it needs to be,
and with a higher likelihood of introducing bugs? There's a point of
diminishing returns where the code that nobody uses causes bugs for
real use-cases. That's not good.

I prefer code that does one thing, and does it well. And when the need
arises, evolve.

Cheers.

-- 
Felipe Contreras
