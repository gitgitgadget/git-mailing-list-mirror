From: Eric Montellese <emontellese@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Wed, 26 Jan 2011 11:23:45 -0500
Message-ID: <AANLkTim8h7RGk59b7jsKjBEdEKaC77S7Nm2NYAE5R3i2@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com>
 <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 17:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi8Vf-0000CQ-Pg
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 17:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524Ab1AZQqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 11:46:14 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49750 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab1AZQqN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 11:46:13 -0500
Received: by bwz15 with SMTP id 15so1349561bwz.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Myt2U3WYu84/BJUYleATXLaluMcOpciLMu8JZa4Wsdc=;
        b=R6hhBUN0q1fKA4D6nOIkII4u+29PNpE21jpRP0Dx4ZOH6e1MVIkJbOi0qqDU1P8Naq
         Ax9+6g53VhsMbACXMqnJcSGk/choTy4ckzQXSnAhgn+h+juV18zSqp9bR0PNJ+YnJfyF
         HnS/lie5VKvK0sBNpsoC4qrCtekbTM4DZe2Vs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oNVlPoT2seSeSA+S8LhrYn12oJeSWq5xKDXL2+gN8Nc7ZSts9voumIMCW5pD0/XkfM
         VPtwVG8Y6dgIYIhSQTgYExvXZLxCAcXHTudXgxQQFmX3Q4yNJg+zBY14s7BvvQUxgUTP
         W03LtL+2SkhQTvASQzRzhBv3swT7yGgRtSESc=
Received: by 10.204.70.137 with SMTP id d9mr654043bkj.141.1296059669962; Wed,
 26 Jan 2011 08:34:29 -0800 (PST)
Received: by 10.204.60.11 with HTTP; Wed, 26 Jan 2011 08:23:45 -0800 (PST)
In-Reply-To: <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165522>

Good stuff!

So, it seems like there are at least a few decent ways to work around
the git binaries problem -- but my question is, will something like
this become part of mainline git?  (and how is such a decision made
and by whom?)

It does seem that there is a real need for a solution like this, and a
lot of the core code to handle it has already been written (perhaps
even by multiple folks); it's just in need (as Peff said) of a
polished and configurable script.  If one were to exist, would it
become part of mainline git?

Thanks,
Eric






On Tue, Jan 25, 2011 at 10:42 PM, Scott Chacon <schacon@gmail.com> wrot=
e:
> Hey,
>
> Sorry to come in a bit late to this, but in addition to git-annex, I
> wrote something called 'git-media' a long time ago that works in a
> similar manner to what you both are discussing.
>
> Much like what peff was talking about, it uses the smudge and clean
> filters to automatically redirect content into a .git/media directory
> instead of into Git itself while keeping the SHA in Git. =A0One of th=
e
> cool thing is that it can use S3, scp or a local directory to transfe=
r
> the big files to and from.
>
> Check it out if interested:
>
> https://github.com/schacon/git-media
>
> On Sun, Jan 23, 2011 at 6:14 AM, Pete Wyckoff <pw@padd.com> wrote:
>> peff@peff.net wrote on Fri, 21 Jan 2011 17:24 -0500:
>>
>> Just a quick aside. =A0Since (a2b665d, 2011-01-05) you can provide
>> the filename as an argument to the filter script:
>>
>> =A0 =A0git config --global filter.huge.clean huge-clean %f
>>
>
> This is amazing. =A0I absolutely did not know you could do this, and =
it
> would make parts of git-media way better if I re-implemented it using
> this. =A0Thanks for pointing this out.
>
> Scott
>
