From: Davi Reis <davi.reis@gmail.com>
Subject: Re: Do not let lstree output recursively when a directory whose name
 is a prefix of the others is given in the path list.
Date: Thu, 9 Sep 2010 11:26:09 -0700
Message-ID: <AANLkTikZ11-3QhOxoW096cdA4LryuZQiegg=GLMO0BJB@mail.gmail.com>
References: <1284010826-81989-1-git-send-email-davi.reis@gmail.com>
	<vpqzkvr5u73.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 09 20:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otlp9-00075l-Ud
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab0IIS0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 14:26:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64742 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab0IIS0K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 14:26:10 -0400
Received: by bwz11 with SMTP id 11so1385109bwz.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=blquUIY/co23fhGbNkgnangYN7cvI7V/VdYIh/DdqIs=;
        b=DD0WygvLezci5c1SxJiLh6vDVaFm9Et23IQOQuJ8T5e6AXfOUAHki0U12Sh1gcDnOu
         UL6112BgX3SKBLHQQmoIJ1f7Jo2kUucy1Z1+4Id5HKWNVLwKJsRXsIRqz8fdc3cTyaBX
         oaPeBsYS9Bla3npiuNGc5d4DAdEzm8qYUFUTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fi3yy2b02lU1RhbtYm1B7815zP1xnVll2thaM3HVswomj5tuPlXUKK3+g7EIx/nwIh
         VNXlPKtCD0Uyrv7O17D4sBw0s1DpdQoFizVy5/hZjqD5WsDp/n/BNDzopuW/eHXH4YVh
         eu2YMmHzYMKIq8B3XL9PIUL5nCShfB7O2ks3c=
Received: by 10.204.51.145 with SMTP id d17mr39985bkg.20.1284056769489; Thu,
 09 Sep 2010 11:26:09 -0700 (PDT)
Received: by 10.204.76.20 with HTTP; Thu, 9 Sep 2010 11:26:09 -0700 (PDT)
In-Reply-To: <vpqzkvr5u73.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155872>

I added the test and used git-sendemail again, but I guess it ended up
in a different thread. Is this good enough or is there some formal
path that I should take? Any help appreciated.

On Wed, Sep 8, 2010 at 11:04 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> davi.reis@gmail.com writes:
>
>> Here is how to reproduce the bug:
>>
>> git init
>> mkdir prefix && touch prefix/a && git add prefix/a
>> mkdir prefixdir && touch prefixdir/b && git add prefixdir/b
>> git commit -a -m "If -r is not given, ls-tree should not show files =
in subdirs."
>> git ls-tree --name-only HEAD prefix =A0# works as expected
>> git ls-tree --name-only HEAD prefixdir =A0# works as expected
>> git ls-tree --name-only HEAD prefix prefixdir =A0# shows file, not d=
ir
>
> That's so close to a real test-case... You should incorporate this in
> your patch (e.g. in t/t3101-ls-tree-dirname.sh), to make sure such bu=
g
> never happens again.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>



--=20
[]s
Davi de Castro Reis
