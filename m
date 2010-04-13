From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Tue, 13 Apr 2010 12:30:08 -0400
Message-ID: <p2l76c5b8581004130930rf5558655n4bb1f6d0c659498d@mail.gmail.com>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
	 <20100410042609.GA24295@coredump.intra.peff.net>
	 <h2x76c5b8581004101510hc1d15f42u7e48dafbc275c998@mail.gmail.com>
	 <20100411102255.GB20484@coredump.intra.peff.net>
	 <y2s76c5b8581004110706p7b63900aqf90f9c1462a1f637@mail.gmail.com>
	 <q2z76c5b8581004120709t860ff112i5dd057327b94ad0e@mail.gmail.com>
	 <4BC3389C.4090807@viscovery.net>
	 <w2t76c5b8581004120828p8e1e5c49m7bcc53c8c3e68d06@mail.gmail.com>
	 <4BC3407C.10701@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 13 18:30:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1j0F-0006Fm-TQ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 18:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab0DMQaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Apr 2010 12:30:11 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45386 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0DMQaK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 12:30:10 -0400
Received: by bwz19 with SMTP id 19so5422bwz.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cvlftl3E5zM1bRZTU3rEsmzh/rcD12iZXs+doOCJr48=;
        b=ib/eNhcPbUb/M79g2YlqH8+srSiQEFEO29BqN4NPdxJ9yXvS6vGxbSO9yBEbles+sc
         YWw4FtTYkqwyl97rf1nmeBL5jW/6jUe5O2gb3ay99aA+87OWyeslEFZ5yKTa0sV3hqtV
         k5ZsbjZX+uoCr35y7gKX7MWbgmpQzL9sdIC/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E3zGFdGmx01/aaMkAhK1VPDeyEjrXL+NnnpfhQLy6PXeUdVblIP0/3WMKoJ/aGPV7A
         1GkKOaQC63kdsWIAEhpwD6hMiEkCX3IFp8MpKNLjgbd3ws1mb/7wCZWbGGAvrk99W3Es
         drXgBeybLs8xflN4zuMdA2bCsxdFi160dbObM=
Received: by 10.204.70.8 with HTTP; Tue, 13 Apr 2010 09:30:08 -0700 (PDT)
In-Reply-To: <4BC3407C.10701@viscovery.net>
Received: by 10.204.84.220 with SMTP id k28mr7147800bkl.70.1271176208353; Tue, 
	13 Apr 2010 09:30:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144821>

>
>> Come on! Please, please, explain me why it behaves DIFFERENTLY:
>>
>> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
>> $ git rebase --onto master topic
>> First, rewinding head to replay your work on top of it...
>> fatal: Not a range.
>> Nothing to do.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=3D=3D=3D=3D=
=3D=3D=3D=3D topic..HEAD is not a range, agreed
>>
>>
>> esajine@ESAJINEWWW /c/git_repos/test2 (topic)
>> $ git rebase -i --onto master topic
>> Successfully rebased and updated refs/heads/topic. <=3D=3D=3D BUG =E2=
=80=93 here it
>> printed me =E2=80=9Cnoop=E2=80=9D in file to edit, when I exited it =
should do nothing,
>> but it still did something and I double checked it.
>
> A historical accident, so to say. The implementor of interactive reba=
se
> felt the "noop" behavior was useful, and I agree, FWIW.
>
> -- Hannes
>

IMHO this "noop" behavior seems to be identical to "git reset --hard
master" - the result is the same. Frankly, I don't understand what is
useful in such thing being HIDDEN in "incorrect call" of interactive
rebase...

Thanks,
Eugene
