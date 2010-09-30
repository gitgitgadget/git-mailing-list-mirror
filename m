From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Pull request for msysGit patches
Date: Thu, 30 Sep 2010 22:52:23 +0000
Message-ID: <AANLkTino48m1s7Zj5FrPuFqsmDR27isTd3o4w=WuRBqK@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<7vocbhsn03.fsf@alter.siamese.dyndns.org>
	<AANLkTinpSwuhT1_wtqNBeXLCud-F0bLBUgbohdtPp+8R@mail.gmail.com>
	<8739sqj2tt.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	bert Dvornik <dvornik+git@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 01 00:52:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1RzK-0003zQ-B0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 00:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab0I3WwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 18:52:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62010 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab0I3WwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 18:52:23 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so2997292iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PJi6RhRyUhN3uD28jrHaaM8RGWOH15xbeIJ7qx7OdmQ=;
        b=ZN521uqdCkBHgf3cfr7Vz8/vPkmJU5a2Pt8q9Lb11dKmy+Q+cIZ08GljOHHhm9i183
         L/BuETFlSrmyqpoDr+HpgMzWtNOBS7jMN+Cr4gXOKrgVv95ZZQQpxzOyMj20+BAKhTho
         RZFOFCurzQZvnS/CdgaI6vR6o1vXBDn+ADCW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E5OBpMmwoW5bJp3/OB2qSYF/WAFs57h2qXylmau5QiLdNCnQIIMk9aUEKsWQIUy/AC
         +qw0XQ1ECH1aGmbEO6ygW1E9t2hx/6ZBWbIGhpyN9nOVwqSjPF76zLv8t9uDaL2xmtX9
         NX+hLDsYZ01yHqDUZ3kyd7y2RuTHGXZZ+P7Hk=
Received: by 10.231.15.138 with SMTP id k10mr4581715iba.17.1285887143062; Thu,
 30 Sep 2010 15:52:23 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 15:52:23 -0700 (PDT)
In-Reply-To: <8739sqj2tt.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157720>

On Thu, Sep 30, 2010 at 22:15, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>On Tue, Sep 28, 2010 at 19:10, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>>> git-send-email.perl
>>>
>>> Similar comment as is_absolute_path(), although in Perl environment=
 I
>>> suspect we can just use an existing package without adding our own.
>>
>>It seems to me that the code added by Erik Faye-Lund in
>>33b2e81f84875bf515b4c0de830eeddfd04227dc and this new code in
>>"send-email: handle Windows paths for display just like we do for
>>processing" by bert could both be replaced by:
>>
>> =C2=A0 =C2=A0use File::Spec::Functions qw(file_name_is_absolute);
>> =C2=A0 =C2=A0file_name_is_absolute($some_path);
>>
>>And by doing so we'd also be compatible with e.g. VMS. Can the people
>>with the odd non-Unix systems maybe try this out and see if it works?
>>:)
>
> I just looked into using this function with msysGit. Unfortunately it
> doesn't work as our perl is msys-compiled and doesn't recognise c:\ a=
s
> an absolute path. It's using the unix path functions.
> Possibly we could use a native perl if the git perl functions were
> making more use of these platform-abstracting functions. Ultimately t=
his
> is the right way to go.

That sounds like something msysGit needs to patch in its Perl
build. The path functions on Windows account for drive letters, but if
they're just using the Unix versions on not-quite-Unix that might
break.
