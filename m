From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: Patch-level-format conversion
Date: Thu, 16 Jun 2011 00:28:14 +0200
Message-ID: <BANLkTi=w1SP6zEZGs1WQ_2L0bWQ2cneNSQ@mail.gmail.com>
References: <BANLkTimRArtFBqA4BFASjkS9BC1sbSfUJQ@mail.gmail.com>
	<20110615205507.GB27172@elie>
	<BANLkTim8bdVGo8u_HzZpE_5+xmPe_O+_Dw@mail.gmail.com>
	<7v39jakajn.fsf@alter.siamese.dyndns.org>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyZQ-0005VX-O6
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178Ab1FOW2Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 18:28:16 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62434 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305Ab1FOW2P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 18:28:15 -0400
Received: by qyg14 with SMTP id 14so506821qyg.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C/fNOQMl/7K4oKpRThl+5+1ElUFnqIdxx2eksZ7CJTs=;
        b=q4QigMJUBj1Dfq20pXeJ2ZlQ5Hvm1TKVYvIvWu2THdXSPM+BCqKvo7NS4RESZL6Skq
         sfKv9Z8StCWaw2kAg/Ldy9jBNnpkqGkHonYqGzOAgsY5lI4CRFe0Ed6hQTrbaFAqfXyV
         phalkxQZQcTpcXW+ZOnLeq51q2fR7zPozFcfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=PYncVBSlIUKLrVsJ89oAy9ZEnpLjmf+NINk8kIx8/glkSgajJXg6PtjthYxqImW1Kp
         qFTfIXtA8HMACkBhJEz+3cB2PdLvUAkPRWqLT9pL54ukXnNySbZTrBmkesHCUSaTkoGh
         JDwIG/SxewVa3c3wJtnC4IuE45cKmG2vuHCNQ=
Received: by 10.229.117.95 with SMTP id p31mr179197qcq.97.1308176894846; Wed,
 15 Jun 2011 15:28:14 -0700 (PDT)
Received: by 10.229.55.148 with HTTP; Wed, 15 Jun 2011 15:28:14 -0700 (PDT)
In-Reply-To: <7v39jakajn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175855>

Hi Junio,

On Thu, Jun 16, 2011 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Sedat Dilek <sedat.dilek@googlemail.com> writes:
>
>> I played a bit with git format-patch and git diff and got some helpf=
ul
>> hints from friends of #grml and #quassel.de.
>> Attached is the README.txt I produced some hours ago.
>>
>> Regards,
>> - Sedat -
>>
>> Q: How to generate freetz-conform patches out of a GIT repository?
>>
>> A. Follow these instructions.
>>
>> ### Checkout freetz development branch
>> svn co http://svn.freetz.org/trunk/ freetz-trunk
>> cd freetz-trunk/
>>
>> ### Get latest revision
>> revision=3D$(LC_ALL=3DC svn info | grep "Last Changed Rev" | awk {'p=
rint $4'})
>> echo $revision
>>
>> ### Turn freetz-trunk source-dir into a GIT repository
>> git add --ignore-errors ./ ; git commit -m "`basename $PWD` SVN revi=
sion $revision"
>
> Wouldn't "add ./" add all the cruft in .svn (and its huge "pristine"
> subdirectory)? =C2=A0Why --ignore-errors?
>

I used to use it after reading the blog-post in [1].

>> ### Edit some files and save changes
>> $EDITOR file1 file2
>>
>> ### Extract patchset
>> git format-patch --no-prefix --no-numbered $FIRST..$LAST
>
> You would need to record your own changes made by the $EDITOR step in
> commits before asking format-patch to make patch files out of them, b=
ut I
> do not see that step.
>

Ooops, yeah missed the git commit command(s) :-(.
Thanks for the pointer!

> Also it is unclear how you determine $FIRST and $LAST. =C2=A0FIRST mu=
st name
> the commit that is the _parent_ of your first commit (i.e. your sampl=
e
> command line tells $FIRST to be excluded).
>

It's just an example...
IIRC I really did "git format-patch --no-prefix -19" (extract last 19 c=
ommits).
Hmmm, remember I got no "origine" for initial commit...

>> ### Some git format-patch options explained:
>> =C2=A0 =C2=A0 =C2=A0 --no-prefix: Do not show any source or destinat=
ion prefix.
>> =C2=A0 =C2=A0-n, --numbered: Name output in [PATCH n/m] format, even=
 with a single patch.
>> -N, --no-numbered: Name output in [PATCH] format.
>>
>>
>> - Sedat Dilek <sedat.dilek@gmail.com> (15-Jun-2011)
>

- Sedat -

[1] http://who-t.blogspot.com/2009/06/git-patches-from-tarballs.html
