From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 22:01:32 +0200
Message-ID: <BANLkTikE8aMh6RUDzrh=SuOxvKxuPShQhQ@mail.gmail.com>
References: <4DC1934D.6070608@aldan.algebra.com>
	<4DC19955.7040503@kdbg.org>
	<7viptqdvrf.fsf@alter.siamese.dyndns.org>
	<4DC20461.4090703@aldan.algebra.com>
	<7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
	<4DC2FB0A.2090100@aldan.algebra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: "Mikhail T." <mi+thun@aldan.algebra.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:01:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4jy-00055h-SP
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107Ab1EEUBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 16:01:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48946 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1EEUBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 16:01:33 -0400
Received: by qwk3 with SMTP id 3so1739671qwk.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MsWno0FKMS3BZY59scpVhB7hoL0shI1y7rimbOqiISU=;
        b=LLLWLQiJQXvGKW/23fq60RRQad+s+wGv99MOVbHVuKFFQ0OZND+D5Mfmf/EVviUybn
         uBZbTBpvz444jbqrXVf04Fn1sssmlnhiKauB+GDDb0Pd0c/Iyk5ge6ZDd17IbVaN4RQX
         HJQGeVw8aNffRK7nk7yEyWVTtfu+A3uFpYSms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=je0iv40tXTURl48q/Cjx2eB/bprkcYHFRCwP4QQEM8PkGhNN5d0agB+u+lMSDzfGEo
         TREg/MVqKU2tHZhwLwIigk860pTLQ6WJpsQiE0cc1M8fXALFI8ABB8rEUu6EbjB+lFz0
         +dSm5DGA8pwYrSUY80ebJCh0x/GBdMhepcJbI=
Received: by 10.52.97.197 with SMTP id ec5mr292652vdb.112.1304625692091; Thu,
 05 May 2011 13:01:32 -0700 (PDT)
Received: by 10.220.201.135 with HTTP; Thu, 5 May 2011 13:01:32 -0700 (PDT)
In-Reply-To: <4DC2FB0A.2090100@aldan.algebra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172898>

On Thu, May 5, 2011 at 9:31 PM, Mikhail T. <mi+thun@aldan.algebra.com> =
wrote:
> On 04.05.2011 22:14, Junio C Hamano wrote:
>>
>> I think that is what exactly "blame -C -C" gives you.
>
> For that to be useful, one has to suspect, the file was derived by co=
pying
> something else... Simple "git log" will not suggest that -- unless th=
e
> commit message, that adds the new copy of a file points to it...

Maybe it should be the default (performance issues?)


> On 05.05.2011 14:02, Piotr Krukowiecki wrote:
>>
>> Maybe Mikhail wanted to say that if there's a git-mv as a shortcut f=
or
>> =A0 "cp old new ; rm old; add new"
>
> git-mv preserves the old's change-history in new, so it is more than =
the
> above, is not it?

It's the same IMO: log with --follow will follow both "copies" and "ren=
ames".


BTW, I don't understand why 'status' shows renames but not copies:

$ cp f fcp && git add fcp && git status
# Changes to be committed:
#	new file:   fcp

$ mv f fmv && git add fmv && git rm f && git status
# Changes to be committed:
#	renamed:    f -> fmv

I would expect sth like "copied: f -> fcp".
Not sure what about one file copied to multiple files, but I suppose
renames have the same problem.

It should not be a problem performance-wise...


>> then there should be a git-cp as a shortcut for
>
> Yes...



--=20
Piotr Krukowiecki
