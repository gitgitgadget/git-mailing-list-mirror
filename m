From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 20:13:55 -0400
Message-ID: <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
References: <4BC6EECE.6060408@gestiweb.com> <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com> 
	<7vr5mggt9a.fsf@alter.siamese.dyndns.org> <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_Mart=EDnez_Mart=ED?= <desarrollo@gestiweb.com>,
	git@vger.kernel.org, deavidsedice@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ZCS-0004ll-OP
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab0DPAOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 20:14:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50481 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0DPAOP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 20:14:15 -0400
Received: by gyg13 with SMTP id 13so1040914gyg.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=oMLUWkimap2kMxkJ/EqraSImM3Q0j7GznyJFxNJICKE=;
        b=kyYckTjmQMYWnm8XOx2n7bU2S3CjQKGuCq90GpS5OZsCZPuUZRZul44zJERvaHneDc
         r5aXdDP07qCMdd9MaD39NDNqpGu5R9EXZzwggVL1YI3fQp2KEAH5J2tJtNxATmhcIDnR
         DxQqAE+X+YmunFXqHzvu0jWpWYy+HP2jK0DJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iI2PjQlX85smccVnQRBCrY0FaRhjD2UPDsJm00ZQATXBDdbuyZ9dhFeKOtor1DY63+
         sxg2O0GxPhRZiDVuQzFk1iyYuDE2Gd0m037LtwuEyN5KNxc//UHtvqrZ/jLYzdjOxzXh
         QaiBXI+Ht9CZEGN4xmW4r9HU9OUPwGQD71gTE=
Received: by 10.151.143.6 with HTTP; Thu, 15 Apr 2010 17:13:55 -0700 (PDT)
In-Reply-To: <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
Received: by 10.150.7.1 with SMTP id 1mr918082ybg.191.1271376855118; Thu, 15 
	Apr 2010 17:14:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145038>

On Thu, Apr 15, 2010 at 8:06 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Thu, Apr 15, 2010 at 8:01 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Avery Pennarun <apenwarr@gmail.com> writes:
>>
>>> So what git tries to do is reduce the diff output of a merge commit
>>> down to just the "unexpected" parts: the parts that are different f=
rom
>>> what you'd get if you just merged in the individual changes in the
>>> obvious way.
>>
>> This (and everything you said after this paragraph) is not quite cor=
rect.
>> What is shown is the pieces that do not match either of the parent.
>>
>> So if you have a conflicted merge and resolve it by taking what one =
side
>> did literally (think: "merge -X ours"), that hunk becomes uninterest=
ing
>> because the end result matches what one of the parents had.
>
> Hmm, but David also said:
>
>>>> git show commit:path shows empty file:
>>>> $ git show dac6a95f5:facturacion/facturacion/scripts/lineasfactura=
scli.qs | wc
>>>> =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>
> The output seems to match neither parent in any way, and yet the
> simplification has resulted in no diff at all. =A0Strange, no?
>
> Avery
>

 mkdir testy
 cd testy
 git init
 cp /etc/profile .
 git add profile
 git commit -m root
 git checkout -b a master
 cat /etc/profile >>profile
 git commit -a -m test1
 git checkout -b b master
 cat /etc/profile | tr A-Za-z a-zA-Z >profile
 git commit -a -m test1b
 git merge a
   # produces a conflict
 true >profile   # blank the file
 git commit -a -m resolved
 git show HEAD:profile
   # no output

Note that if you instead replace the file with a nonempty (but
different) file, you get something appropriate as the output.

Have fun,

Avery
