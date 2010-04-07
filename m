From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] Add option to git-commit to allow empty log messages
Date: Wed, 7 Apr 2010 14:28:06 +0000
Message-ID: <t2u51dd1af81004070728q491ae158gd6808f6ef4165b21@mail.gmail.com>
References: <20100406055530.GE3901@coredump.intra.peff.net>
	 <1270543235-8570-1-git-send-email-avarab@gmail.com>
	 <7vsk77g7um.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWEp-0008VZ-RN
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757982Ab0DGO2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 10:28:10 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:37559 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab0DGO2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 10:28:08 -0400
Received: by bwz1 with SMTP id 1so871872bwz.21
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vWvIBzX2mPob84I7SJ8nyu1usKPBlxDofm7Ym8/J+ec=;
        b=OTVYYOqzc8V3s6vYxfzHOJJan/xFntXSQ8A3Xa+YCCEA7fIGtl3CgY6sedZEtojOsx
         UBuJQu8OLA3nnD60jOCqwpEXBlM8lsecZNNiVWfuuoY8/6p//cEeG3U1Aikib7yUfD9M
         Vgk6PCs+rRZYhsd9NbAznbp3mdE5+Jj7cd9ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w7l/aRfuaZgVbzJMB74lVOX5v4l6fduREHDguTYxc0kf6fvSSaIzD2TtRJ5XEXpHDD
         nXREqcWKN4CbegDmZlN2gYLxfNl2C0zaFTxnnyu5AWHoXdyHZytTR4d9XBqm7lUmVhqB
         g/mRqSEpum/91fxGyqbwfNQJhtigMjeyYeOcY=
Received: by 10.204.121.195 with HTTP; Wed, 7 Apr 2010 07:28:06 -0700 (PDT)
In-Reply-To: <7vsk77g7um.fsf@alter.siamese.dyndns.org>
Received: by 10.204.83.26 with SMTP id d26mr6138242bkl.157.1270650487069; Wed, 
	07 Apr 2010 07:28:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144221>

On Wed, Apr 7, 2010 at 05:16, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> diff --git a/t/t7510-commit-allow-empty-message.sh b/t/t7510-commit-=
allow-empty-message.sh
>> new file mode 100755
>> index 0000000..d7dc0da
>
> I do not think a separate script is worth it. =C2=A0I'd just add test=
s to t7500.
>
>> +test_expect_success 'a basic commit in an empty tree should succeed=
' '
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo content > foo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit -m "initial c=
ommit"
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 commit_msg_is "initial commit"
>> +'
>
> No need for this, especially if this becomes part of t7500.
>
>> +test_expect_success 'Commit no message with --allow-empty-message' =
'
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "more content" >> f=
oo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf "" | git commit -=
-allow-empty-message
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 commit_msg_is ""
>> +'
>
> No need for subprocess, nor printf piped to the command.
>
>> +test_expect_success 'Commit a message with --allow-empty-message' '
>> + =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "even more content"=
 >> foo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit --allow-empty=
-message -m"hello there"
>> + =C2=A0 =C2=A0 ) &&
>> + =C2=A0 =C2=A0 commit_msg_is "hello there"
>> +'
>
> Ditto.
>
> You are falling into the same trap as everybody else does when showin=
g off
> your shiny new toy. =C2=A0A missing but very necessary test is that "=
commit"
> with your patch does still fail when an empty message is given withou=
t the
> new option.
>
> It takes a conscious effort to carefully make sure that your shiny ne=
w toy
> does not trigger when it shouldn't, especially when you are so excite=
d by
> seeing it work when it should.
>
> But that is part of the art of writing good test scripts.

Thanks for shepherding the patch and committing it, and for pointing
out what I could have done better. I'll try not to make similar
mistakes with future submissions.
