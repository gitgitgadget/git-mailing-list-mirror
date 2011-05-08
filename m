From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/4] i18n: Add shell script translation infrastructure
Date: Sun, 8 May 2011 23:52:01 +0200
Message-ID: <BANLkTinOkM+MTwq46mvPs1G5fQmGvxknrg@mail.gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
	<BANLkTi=nTSf0CQWs-ODxw=P+eX=Dc7Yf-Q@mail.gmail.com>
	<BANLkTikmj_urw389ad0r86OR+26AvXTVzg@mail.gmail.com>
	<BANLkTinnv=hm80h=9P80t=3QvwS-BQ7D=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 23:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJBta-0003CJ-Ch
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 23:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300Ab1EHVwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 17:52:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33014 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab1EHVwD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 17:52:03 -0400
Received: by bwz15 with SMTP id 15so3562803bwz.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wVR3f1DAsGZ0EYOdnhzOS7zvpZ7jQYG/phSzl6DvOy4=;
        b=RwY2h0wdcIZ6CGCa3ktz8HxjkQ6iCRXeoYXOq2FlWspbm1ZCrY3sq++yob+x6Zb0R5
         rw70PuqwdBtGm1NOzfAL8LH7FKGpWbE0ZRQcq/2ozFIe5R8txpHCknfD15ZUSmZEgBJJ
         O3k7am4yBNoxr6mSFLBxj4g4gDnkEL73RDvto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W/0TtoJdMxOqtuZ8P0wlgZ1jpImQ57+KArl5PHeJvWjz4kz/w0Dx8O3KGGnPe7npCO
         ERznq0mlI9sgWksDIVQBeRzMbSVHNVxl9N0DJMgvm7dcOC6NMwI2MCXPS+uK6gEiAg1o
         pzPFv3J/MxnvZ93rhSYe7VCz/JcJBYhUNGRP4=
Received: by 10.205.83.199 with SMTP id ah7mr5504110bkc.146.1304891521816;
 Sun, 08 May 2011 14:52:01 -0700 (PDT)
Received: by 10.204.101.132 with HTTP; Sun, 8 May 2011 14:52:01 -0700 (PDT)
In-Reply-To: <BANLkTinnv=hm80h=9P80t=3QvwS-BQ7D=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173188>

On Sun, May 8, 2011 at 23:45, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> Heya,
>
> [+msysgit people]
>
> On Sun, May 8, 2011 at 23:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> On Sun, May 8, 2011 at 19:03, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>>> On Sun, May 8, 2011 at 14:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
>>>> This adds skeleton no-op functions to git-sh-i18n.sh analogous to =
the
>>>> gettext.c skeleton functions for C, adds *.sh scripts to the "pot"
>>>> target for message extraction, and updates the git-sh-i18n--envsub=
st
>>>> tests to use the new test_i18ncmp function.
>>>
>>> I seem to remember there were some concerns about performance with =
a
>>> previous version of this series. Have you done any before/after
>>> timings on, say, the git test suite? Or am I remembering incorrectl=
y?
>>
>> When I benchmark this on my (Linux) system it runs at 0% difference
>> between the current test suite and the one with this series.
>>
>> The concern was about Windows, where forks are more expensive, so
>> e.g. every time we shell out to sed/awk/perl/grep or
>> git-sh-i18n--envsubst we incur a larger speed hit than on Unix
>> systems.
>
> Perhaps one of the windows devs can benchmark this then? =C3=86var, w=
here
> do you have a pullable version of this series? Your github fork has
> quite a few branches.

It's ab/i18n-sh-only in git://github.com/avar/git.git

There was some discussion about this a while ago, not sure what came
out of that, but there were some msysgit patches involved IIRC.
