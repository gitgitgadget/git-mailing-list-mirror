From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] Make test-lib.sh emit valid TAP format
Date: Mon, 14 Jun 2010 22:29:29 +0000
Message-ID: <AANLkTik4Zxh5cKUEn1_yoNGKvNSudILvEVEAqeeElmB0@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<1276096943-32671-2-git-send-email-avarab@gmail.com>
	<m31vc9p93t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 00:29:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOI9w-0002Ko-6S
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 00:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab0FNW3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 18:29:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59555 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0FNW3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 18:29:30 -0400
Received: by iwn9 with SMTP id 9so3803933iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eFbiN/g8/61guMaEZmhZwwcEZ2pl3Hb3lvRf+l0+F4Q=;
        b=eJLXqMLBUjiqKBAwc2tkrU0QcaeuV50/OaxuIM+jB0kd7DaZmopf83syMc5LjaB8S7
         isIvZ6NUPSUeK8QjOo+oLUJnjm3nt8Z988ckHYbyZnmd+fVYmmjeQogJ5vwJXvJ3fOiZ
         pMUHgQ7UGc5dWHSBje6Wq3r6sigWzlBcettdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZbjpxDHiovnGJcV93KXVAL8i8XRdRc/zU0Q3H36/26NDZZpAXR0CCtKUKJQ6hrZiMg
         VDn2/RmZfjiF79AN05I7ZZ+Y8cIyOw3Tzy4+tJfejBqNxK+rMhCIKTHNLaaxC/tj1s6g
         k1V59igCJOqYgcUNZXagOuJk7DSWBGUncX11M=
Received: by 10.231.170.1 with SMTP id b1mr6370343ibz.13.1276554569598; Mon, 
	14 Jun 2010 15:29:29 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 15:29:29 -0700 (PDT)
In-Reply-To: <m31vc9p93t.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149143>

On Mon, Jun 14, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> TAP, the Test Anything Protocol, is a simple text-based interface
>> between testing modules in a test harness. test-lib.sh's output was
>> already very close to being valid TAP. This change brings it all the
>> way there. Before:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0* =C2=A0 ok 1: sigchain works
>> =C2=A0 =C2=A0* passed all 1 test(s)
>>
>> And after:
>>
>> =C2=A0 =C2=A0$ ./t0005-signals.sh
>> =C2=A0 =C2=A0ok 1 - sigchain works
>> =C2=A0 =C2=A0# passed all 1 test(s)
>> =C2=A0 =C2=A01..1
>
> How failing test looks like before and after the change?
>
> How test_expect_failure, i.e. known breakage (TODO test) looks like
> (both in known broken, and in accidentally fixed version) before and
> after the change?
>
> How does '--verbose' and '--debug' output looks like before and after
> the change?

I'll submit a version with an updated commit message. The gist of it:

 * It's now ok/not ok instead of ok/failed
 * --debug and --verbose work just like before
 * Other things look like before, but may be changed to make TAP like
it (e.g. prefixing comments with #)
