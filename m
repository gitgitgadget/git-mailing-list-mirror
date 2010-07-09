From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] war on echo in scripts
Date: Fri, 9 Jul 2010 11:52:35 +0000
Message-ID: <AANLkTint6AfhwKdeizt-YVt4O6AZbLG9A5h6ipJyQyIQ@mail.gmail.com>
References: <20100706225522.GA31048@genesis.frugalware.org>
	<7vpqyz278o.fsf@alter.siamese.dyndns.org>
	<20100707091633.GB31048@genesis.frugalware.org>
	<AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
	<20100707094620.GC31048@genesis.frugalware.org>
	<7v7hl6stna.fsf@alter.siamese.dyndns.org>
	<20100708103552.GF31048@genesis.frugalware.org>
	<20100708171418.GA18229@burratino>
	<m2k4p58tum.fsf@igel.home>
	<20100709024633.GA13739@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 13:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXC8R-0006hg-6C
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 13:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab0GILwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 07:52:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55704 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817Ab0GILwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 07:52:36 -0400
Received: by iwn7 with SMTP id 7so2091434iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rn67gPlAH5Jrxlrx25gXH2Bv0FmG002OIjhk7ib3DDU=;
        b=jTmTpO26FgMdh0GewRVsE8nx/TrM/PpVa2BqC+Evnh/i8s6XCenC/v2qdwgPhQ0CrC
         PotiM2DnmWArK7EbmjHZId/ygW8oPjooISaK8oqBMhGYXyBEevZMkA7McKByu8TXSTGG
         K8juVwi8VYMAzlyYIF/Td3YGmj4puC/PDcwOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e/Fdx53whsLlg8K2R9YT8ByuN8WkjaU6oCr5tgu4mB9Nwev90qzJ0AC9eAz5QXxrPm
         n/9p+ecsR154WRqUr+yUDVmObPmZnPZlTEAZyhiJ3YIHmlEMoeV0mddCdjxWP1+KRZa3
         qm+9pBufGmHXp9JKVHrnNOjhbuvkuw4XYTHOs=
Received: by 10.231.184.16 with SMTP id ci16mr9870796ibb.23.1278676355629; 
	Fri, 09 Jul 2010 04:52:35 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 9 Jul 2010 04:52:35 -0700 (PDT)
In-Reply-To: <20100709024633.GA13739@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150654>

On Fri, Jul 9, 2010 at 02:46, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Andreas Schwab wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> =C2=A0die() {
>>> - =C2=A0 =C2=A0echo >&2 "$@"
>>> + =C2=A0 =C2=A0printf >&2 '%s\n' "$@"
>>
>> You probably want to use "$*" here, though it wouldn't matter for th=
e
>> uses of die in this file.
>
> Hmm, maybe something like this would be easier.
> [...]
> +echo() {
> + =C2=A0 =C2=A0 =C2=A0 printf '%s\n' "$*"
> +}
> +

Overriding builtins like this isn't portable.

(Via H.Merijn Brand): This fails on the old HP-UX 10.20 bourne shell:

    > cat xx.sh
    #!/bin/sh

    echo ()
    {
    perl -le'print "Done!"'
    }

    echo 1
    echo Klaar
    > sh xx.sh
    xx.sh[3]: The operation is not allowed in a restricted shell.:
echo is a shell builtin.
    1
    Klaar
