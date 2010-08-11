From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git thinks a failing command doesn't exist
Date: Wed, 11 Aug 2010 20:10:23 +0000
Message-ID: <AANLkTi=78rrF5aK0ku27haLhDp6a=W86EGc_RihdaHVW@mail.gmail.com>
References: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
	<20100811192554.GA8106@coredump.intra.peff.net>
	<AANLkTik3QmyP3sygbd36VhUQtdK-z81vqVAoAcPofFO+@mail.gmail.com>
	<20100811194841.GA8689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 11 22:10:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHd8-0005L3-GT
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602Ab0HKUKZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 16:10:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50760 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab0HKUKZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 16:10:25 -0400
Received: by fxm13 with SMTP id 13so397632fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UGEPUiwmnVKhHOUI0/cddftm5RrXodlE6rYgUlG6iGE=;
        b=YQNRWlITsM1Xq3pl9k5D2Zlp//qTumdqoxS7QFnN+kd7ag4Re8D7zll3S8+ymBamz2
         3x8yd1CKWr/bjh2l7Dd/lzuM3j0lts/v4zENVx22u2TC5NrrnfauSuTAkrMfSXdhmsvm
         yatBT3FMD96+oK3fFhQ+p8/ZM+frd1Hb0n/nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GhlZ+wHzq2iMNSpGu/+Ub9QzxwwbcIPVqJKjE7ng2ADJdYknGLno2PIy7Tiqr6Nben
         vLUbW9f5iftFsRkKPbxrFyrsEojlmUuvZo7YeuHv8ZXOMwhcW1nswfuZNSiZ/nC3LeQp
         U4VRj8C/JMvG1nou5SyrNcdnEcwCCTdJWMF7w=
Received: by 10.223.106.8 with SMTP id v8mr2614290fao.104.1281557423876; Wed, 
	11 Aug 2010 13:10:23 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 13:10:23 -0700 (PDT)
In-Reply-To: <20100811194841.GA8689@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153299>

On Wed, Aug 11, 2010 at 19:48, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 11, 2010 at 07:45:14PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> > So either your shell is producing that exit code for a different c=
ase,
>> > or git is broken.
>>
>> My shell is Debian /bin/dash 0.5.5.1-6.
>
> Hmm, I can't reproduce here, and I am also using dash as my shell.
>
>> Unfortunately the error with rebase was some one-off thing that I
>> couldn't reproduce. I'm not even sure /what/ I did to make it happen=
=2E
>
> OK. The code is _supposed_ to work as you expected, so if it happens
> again, I guess try to reproduce and we'll go from there.

git-rebase must have exited with a code of 127. I tried every exit
code from 1 to 255, and 127 is the only one that does this:

$ head -n2 git-rebase
#!/bin/sh
exit 127

$ ./git rebase --continue
git: 'rebase' is not a git command. See 'git --help'.

Did you mean this?
        rebase
