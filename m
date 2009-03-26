From: Anton Gyllenberg <anton@iki.fi>
Subject: Re: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 16:35:00 +0200
Message-ID: <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com>
References: <22719363.post@talk.nabble.com>
	 <20090326130213.GC3114@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gilbert Liddell <gliddell@totalrepair.co.uk>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 15:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmqhC-0006cJ-LO
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 15:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbZCZOfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 10:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757937AbZCZOfF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 10:35:05 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:51156 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbZCZOfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 10:35:03 -0400
Received: by ewy9 with SMTP id 9so593603ewy.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 07:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=ajViMLrulYy6Grok7NlH30bIOJT200Jmn5jYvvwXNtM=;
        b=p6xxdlHtgadmavg019Si/lchoOnu9lglrELEiSjaLJEb8eKtpK+JUJi9i2vyrKaYIF
         IvVXUMIq3fI0gtiYvRIIU2YgPnEXGms1DuwHFVdU8smDr0Rk2vU9dUUz+9xZHV/nh+Ip
         ioS1RjDFW8VMAgP933OtHGtpXc4qbygq3iBIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VLUkYXAZeffkS9MUQ8wko6lkB0PHtGcG7i5XkKJLMXuTe//oTnJRVLkqBj+n9yLCfG
         Y4incomZStw2DUm72aI4dFUyO1Rd654uC97tLAgNKQyMDr+rX7sRKF/AC5heE8Aex5DV
         fhtlzjHutawEE0nFUXCGfwNIoJXdmpwMt0Iio=
Received: by 10.210.34.5 with SMTP id h5mr706073ebh.59.1238078100147; Thu, 26 
	Mar 2009 07:35:00 -0700 (PDT)
In-Reply-To: <20090326130213.GC3114@atjola.homenet>
X-Google-Sender-Auth: df9e2df3c93cf246
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114784>

2009/3/26 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.03.26 03:31:53 -0700, Gilbert Liddell wrote:
>> This morning i decided to test the clone with the full project i'm w=
orking
>> on (11,000 files) and I get the error message Checksum mismatch: vn2=
=2Esln
>> 0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260
>> got: e71db1010a0da06ea76d4163c452df72
>>
>> Can someone help with why this error is happening? Is there an issue=
 with
>> the GIT clone and large repositories?
>
> Which git version is that? There was some bug in git-svn that caused =
it
> to fill the disk with temporary files, without noticing that those fi=
les
> get truncated when the disk is full. That was fixed in some 1.6.0.x
> release IIRC.

I don't know if this is the same issue, but the I get a similar error
on the public twisted-python repository on both windows and linux,
with several different versions and plenty of free disk space. As this
is a publicly accessible repository it should be easy to reproduce:

git svn init -s svn://svn.twistedmatrix.com/svn/Twisted twisted
cd twisted
git svn fetch -r 13611:HEAD

This ultimately dies with the following error:
W: +empty_dir: trunk/doc/core/howto/listings/finger/finger
r13612 =3D f6d995ac255e3dfa08a517a6e72fbcfe63feaaa0 (trunk)
Checksum mismatch:
branches/foom/--omg-optimized/twisted/internet/cdefer/cdefer.pyx
264b0c5f7b3a00d401d1a5dcce67a3734f0eede3
expected: c7ccddd195f132926e20bab573da7ef3
     got: f006323ff4714ca52c0228ce6390d415


I found this a long time ago but never got around to analyze or report =
it.

Anton
