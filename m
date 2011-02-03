From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Thu, 3 Feb 2011 13:46:03 -0500
Message-ID: <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 19:46:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl4C5-0000Za-2k
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 19:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab1BCSqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 13:46:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55035 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab1BCSqF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 13:46:05 -0500
Received: by yxt3 with SMTP id 3so605865yxt.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JmkHpLXdHTXmG/OOP9/E+Bj08QBoc+PT7UrNt9xxsyY=;
        b=qmLB53hyKrvfqPPhsThvumYYgD7X3vdj5agxGRfrwKdXZT6JL2+daTerrVUvjKYSvA
         qQXQoNdItjF8LzMZV4kPfse1EGbMlTsIsLXWnbzb5PYVtaenaIhzJ2aFgsXQEDFMHo9u
         qK/Zga5QYpSIGDW7zcryV8RuDB0cyCoq2xyVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hkstWafv8al0FKAJCNVIciJ1/NeCwfIKs0JCqgKEfwKUvOS8UKO+mZ6z7DPxZ856Dy
         /jdTfvi+tr4egjXLdPrVCZeIZLyMfHKELX4y+wnIAN94lvsqCCZTI7Gq7EZHV2Sxcqsq
         4TwDBngclsTG4r8GiOgnwEAJ/RO4sgBf/L21w=
Received: by 10.146.167.16 with SMTP id p16mr175652yae.6.1296758763724; Thu,
 03 Feb 2011 10:46:03 -0800 (PST)
Received: by 10.146.168.5 with HTTP; Thu, 3 Feb 2011 10:46:03 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1102030036420.12104@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165989>

On Thu, Feb 3, 2011 at 1:16 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 1 Feb 2011, George Spelvin wrote:
>
>> For what it's worth, I don't see the "cleanup".
>>
>> If it significantly reduced the size of the largest directory,
>> that would be a win. =C2=A0But moving everything into src/ doesn't
>> do that.
>>
>> If there's a way to divide the source into cohesive subunits, that
>> would be great. =C2=A0A programmer could ignore whole subdirectories
>> when working on something.
>>
>> But just moving the whole existing pile into a subdirectory "because
>> everyone else does it" is not a reason; that's superstition.
>
> There is no superstition here, simply basic elegance.
>
> When you pick up a book from a shelf, do you see the actual content o=
f
> the book printed right from the inside of the cover page, and the tab=
le
> of content tossed in the margin? =C2=A0Would you construct a book you=
rself
> that way?
>
> A nice source tree should be organized with a minimum of hierarchical
> structure. =C2=A0To a newbie wanting to contribute to Git, it is rath=
er
> frightening to cd into the git directory and see that ls generates mo=
re
> than 280 entries. =C2=A0That simply looks sloppy. =C2=A0And this gets=
 much worse
> after a make.
>
> The top directory should make different things stand out much more
> clearly, like a preface and a table of content. =C2=A0You have the
> documentation here, the source there, the tests there, a clearly visi=
ble
> README file, etc. =C2=A0If the src directory has about the same relat=
ive
> number of files after a move that's fine. =C2=A0At least you should e=
xpect
> _only_ source files in there (and possibly their by-products), and no=
t
> other types of data buried into the mix.
>
>> Having to type "src/" a lot more often is definitely a downside.
>
> Come on. =C2=A0This is a rather egocentric argument without much subs=
tance.
>
>> Heck, that's one thing I actively dislike about GNU autoconf convent=
ions.
>
> This has _nothing_ about any autoconf convention. =C2=A0GNU autoconf =
requires
> stupid things like having a bunch of files such as CREDITS, INSTALL,
> CHANGELOG, and other whatnots even if you have nothing to put in them=
,
> in which case they still have to be there but empty. =C2=A0It also di=
ctates
> the exact name your directories must have, etc.
>
> I'm not proposing a tree reorganization because GNU autoconf commands
> it, but rather because this is a sensible thing to do.
>
>> If there's a compelling reason to change, could someone please descr=
ibe it?
>
> It's about the third time I'm putting forward arguments for this.
> Please see the list archive.
>
> P.S. the netiquette on busy mailing lists recommends that you preserv=
e
> all the email addresses that were listed as recipients on the message
> you reply to. =C2=A0That would be highly appreciated.
>
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I'm not a hacker, but a user who had sometimes peeked into the git
sources. Unbelievable mess... Impossible to see the structure in
command line interface.
I totally agree with Nicolas here.
=46olders were invented for a reason.

IMHO
src for source code
build for build by-products
tests for tests

Come on, give us some love, please!;)

Thanks,
Eugene
