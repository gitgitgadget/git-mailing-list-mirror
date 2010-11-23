From: =?ISO-8859-1?Q?Tarek_Ziad=E9?= <ziade.tarek@gmail.com>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 14:47:13 +0100
Message-ID: <AANLkTi=G1ZpiaRN8vWYBJ33_ZOXo1t616X5gQU+jNda_@mail.gmail.com>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
	<AANLkTinvM6OhLdeKt5MqEeNhZJx63X+KzOy_ngEsy0A2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 23 14:47:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKtDN-0007xt-OM
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab0KWNrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 08:47:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51381 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0KWNrP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:47:15 -0500
Received: by bwz15 with SMTP id 15so7105486bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sKkkbyBt2rWJvBVZZTI6yFGScsa63U/kWyceSNKEywc=;
        b=EkU1YsZOOdaL/OZ4tfiUNgJvDBqTgYvvfHgOEbPKhE75YCumkAnGvXug2MckC9y9cV
         ivebCTCxQColaVAJC5yB40z9WOYGauo7jgBfwxoHtDc+7yWyS2RPBnABFFc/WjHanXdu
         H254O5fxSXJ2VWJYfk/LyTDAAR4gqtfhZANyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D068O5Nd80SLRLpZ+wBh63yMzmaFSUt0zNUnQux/W/j8avXdJ57EvVj6MdxHdIuE2f
         S1VO8gb+sIl+rrPP51Fu+Nxkxgd2alm9P9kXCzuS10VBc/VbfriKw5hByz+X1n5nzZPv
         XS2xG9PH+irmQtvHW2U/5J/q0uOdsRN1Ssx54=
Received: by 10.204.52.136 with SMTP id i8mr6672198bkg.96.1290520033570; Tue,
 23 Nov 2010 05:47:13 -0800 (PST)
Received: by 10.204.54.207 with HTTP; Tue, 23 Nov 2010 05:47:13 -0800 (PST)
In-Reply-To: <AANLkTinvM6OhLdeKt5MqEeNhZJx63X+KzOy_ngEsy0A2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161962>

On Tue, Nov 23, 2010 at 2:22 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Tue, Nov 23, 2010 at 1:23 PM, Tarek Ziad=E9 <ziade.tarek@gmail.com=
> wrote:
>> Hello,
>>
>> I am new to Git and I tried to run "git st"
>>
>> I have found one small bug: "status" is not listed in the help scree=
n
>> Git displays in that case.
>>
>> $ git st
>> git: 'st' is not a git command. See 'git --help'.
>>
>> Did you mean one of these?
>> =A0 =A0 =A0 =A0reset
>> =A0 =A0 =A0 =A0stage
>> =A0 =A0 =A0 =A0stash
>>
>
> This isn't strictly speaking a bug. Git uses Levenshtein distance
> (http://en.wikipedia.org/wiki/Levenshtein_distance) to figure out wha=
t
> to suggest. If any command has a sLevenshtein distance of less than 6
> (given our coefficients), then all commands with that distance is
> suggested. But perhaps we should do something different
>
> But perhaps we could do better. We have some commands that are
> considered more "important", ie the ones listed when doing "git help"
> without "--all". "status" is one of these. Perhaps these commands
> should always be included if they are below the Levenshtein distance
> threshold or something?
>

Oh, interesting ! Levenshtein is great for typos but highly depends on
the fact that the word I am entering has about the same length as the
command I am looking for.

When I typed "st" I was thinking about an alias/shortcut. So the
question would be: is "st" a common alias in the git community for the
"status" command ?

If the answer is yes, and if there are other common aliases used out
there, I would suggest keeping the Levenshtein distance as it is now,
but complete the list of suggestions by using a "common aliases
mapper."

Cheers
Tarek

--=20
Tarek Ziad=E9 | http://ziade.org
