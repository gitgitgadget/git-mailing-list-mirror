From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v4 1/7] Add infrastructure for translating Git with 
	gettext
Date: Wed, 2 Jun 2010 10:56:05 +0000
Message-ID: <AANLkTinzZUaFBzNHzxBA94ECeUKdejVGqSQF1TUtOrrk@mail.gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
	<1275440764-26153-2-git-send-email-avarab@gmail.com>
	<alpine.DEB.2.00.1006021006590.23247@ds9.cixit.se>
	<AANLkTilClUTkrpnMhBTlcBZC-r2OemT4m22bDnc6fRPy@mail.gmail.com>
	<alpine.DEB.2.00.1006021109010.23247@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jun 02 12:57:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJldw-00087H-Bn
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 12:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab0FBK4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 06:56:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64482 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab0FBK4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 06:56:06 -0400
Received: by gye5 with SMTP id 5so1987003gye.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2PfGwDzGrcnET1Bgvi7Z1utRqEC/bOLTMktY01AlmDo=;
        b=Aw37VpK5/3p6gSnr2+MZPcUJ70Ap5IRxnythH9sd7Leg3e1xt4YkQj8d/C85Kg/Mjw
         kHmgR98G1dWPQurdQ/0Q6YjUjY5EV2Onp0PDFq5B9bhQUkMN1ohVGq/spizsjAlyV+8N
         OLNZQq1OQmGYzXbjSdi5Ad/Y5hL8f+ZpMxQt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mmFvbbkwFvKrR0noHEZXlREfGg2MLAZtUjXZM891pJ6/8mkEEGwcvRynosUnNDTwbI
         VDSBgKPsnW9bfpm4hSy1xCEuF9pWd8O8Xx5kSY9j/QddrtO8PnB/IQhK0Ft+7JHCKB/2
         BI32YuLkC7jkhIx5N0L9HPqPcN36viQmWM+Ck=
Received: by 10.231.184.73 with SMTP id cj9mr9726115ibb.1.1275476165778; Wed, 
	02 Jun 2010 03:56:05 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 2 Jun 2010 03:56:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006021109010.23247@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148243>

On Wed, Jun 2, 2010 at 10:11, Peter Krefting <peter@softwolves.pp.se> w=
rote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> Making things like wt-status.c translatable is going to be hard to d=
o
>> properly. It uses a lot of lego (sticking strings incrementally toge=
ther),
>
> However, preparing them for translation is probably going to make the=
m
> better anyway, as this kind of string building is incredibly brittle,=
 even
> for English strings.

Yeah, but they aren't better as they are now. Personally I'd rather
incrementally add translation support correctly than do an incomplete
job of it and wait for the complaints (and subsequent fixes) to come
in.

But maybe that's counter-productive. Just making the English strings
translatable as-is is still going to make most of Git translatable,
and it isn't going to be that bad for languages like German and
=46rench.

Maybe worse is better :)

> You also have to look out for pluralisation issues, fortunately Gette=
xt does
> have support for the various types of plural forms that are used, so =
it
> should be possible. The problem is just identifying where they are ne=
eded.

Yeah. I'm going to support pluralisation (and maybe msgctxt) across
the C-Perl-Shell stack when there's a need for it. I haven't found any
message in Git yet that requires it, but then again I haven't looked
hard either.

It would be useful to have an example of a message that could use
pluralization, even better examples in all of C, Perl and Shell.

>> and due to the coloring of output this'll be particularly hard to co=
nvert.
>
> Is the colouring based on knowing the contents of the actual text, or=
 is it
> enough to know the markers? I admit not having looked at the colourin=
g code
> at all...

There's nothing wrong with coloring in particular, it's just that due
to the nature of the current implementation code that does coloring
ends up being a bad offender in the "assemble the strings a few bytes
at a time with strcat()" department.

That can be fixed, it just takes a bit of time and tedium.
