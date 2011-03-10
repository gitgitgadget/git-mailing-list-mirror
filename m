From: Vicent Marti <tanoku@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 13:33:46 +0200
Message-ID: <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com> <20110310101332.GC26851@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: libgit2@librelist.com, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxe8F-0004wO-8f
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 12:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307Ab1CJLeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 06:34:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58480 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1CJLeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 06:34:07 -0500
Received: by wwa36 with SMTP id 36so1825824wwa.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 03:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=69Eft9m9sesgo9eLPo5q2b+0LXbBIO2Hfm9DLYqZttc=;
        b=FWHotr3jCIVSB2HeChIRtJ2wtO+BGoc42YqhelZ2Y1XEDfL7oPyHtBLvK2W5G9I/Bi
         8w85SI30l0cDfINrYTeJmTRcLykGeCuOsPMU7HjbVRG0ekwc6AhvGHRnbydVUm9kn3Nz
         k5zvrlTFcqmUDWxNjXtjJ2/EyX8PRc/ClZrSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qBmQqM+X1P43AazdtVxMM2mzlB/I1vZ2D3vFv5tQh7fP5bR8hps+3eGLFfG3x/ge3g
         f4jAMxewVOmVCF33nMNOu/g1N3zl9dBCl9qFwQh1z66PFrPew7UziA3l09QOxo6abHTy
         2XnFO/Jf7TrcfFG1MLcfIcM8YlR9U1U7gD2sI=
Received: by 10.216.67.194 with SMTP id j44mr6788421wed.41.1299756846092; Thu,
 10 Mar 2011 03:34:06 -0800 (PST)
Received: by 10.216.244.10 with HTTP; Thu, 10 Mar 2011 03:33:46 -0800 (PST)
In-Reply-To: <20110310101332.GC26851@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168809>

Hey Jonathan,

I think that right now it would be a quite daunting task to start
replacing parts of git.git with libgit2. The architecture changes
required would be quite significant, because of the way that git.git
and libgit2 are designed (Unix-only, non-reentrant/cross-platform,
reentrant), and the biggest "feature" of libgit2, being able to
compile all platforms (including native MSVC) would just now show
because of the amount of original git.git code that would still be
left on the code base. On top of that, the API for the library is not
yet stable, so that integration may end up being kind-of-wasted work.

So, personally, I don't know anybody interested on mentoring *that*
specific task, but I'm certainly interested on mentoring a "help
complete libgit2" task: the earlier we stabilize the library, the
earlier tasks like this one will be viable. Maybe on the next SoC? :)

Oh, and thanks for reminding me I need to put that task on the wiki
before Friday.

Cheers,
Vicent Marti



2011/3/10 Jonathan Nieder <jrnieder@gmail.com>:
> Hey Vicent et al,
>
> Vicent Marti wrote:
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 there have
>> been proposals to merge parts of libgit2 into the original Git clien=
t;
>> however, this is not one of our priorities (we are designing git.git
>> to be embeddable in Git backends and GUI programs), and the library =
is
>> not yet stable enough for that kind of job. We'll see what the futur=
e
>> brings -- git.git would certainly benefit from some of our code, if
>> anything because it's (slightly) faster and cleaner than the origina=
l
>> implementation.
>
> I've been thinking that it would be interested to start this work
> early on, partially so that libgit2 and git.git can get to know each
> other better so to speak (which could help libgit2 along nicely and
> help git get past some old limitations, I think). =A0So I'm thinking =
of
> proposing stealing some of your code, with an eye toward eventually
> making git "just another libgit2 user", as a Google summer of code
> project idea.
>
> Is that a sane idea? =A0Is there any particular subset of the lib tha=
t
> would be an interesting place to start? =A0Do you forsee any obstacle=
s?
> Do you know anyone who might be interested in mentoring such a
> project?
>
> Admittedly I'm not so familiar with libgit2 yet, so I'm willing to
> believe the answers might be no, no, yes, and no. ;-)
>
> The Google Summer of Code application deadline is this Friday
> (March 11) at 23:00 UTC. =A0If this does seem like a sane thing to do=
,
> it might be nice to put it on the ideas page at:
>
> =A0https://git.wiki.kernel.org/index.php/SoC2011Ideas
>
> Thanks for your work.
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
