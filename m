From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t3000 (ls-files -o): modernize style
Date: Sun, 11 Jul 2010 09:10:34 +0000
Message-ID: <AANLkTinR4hnLkIbPxxD2f4k6PLpVwALpxKIQHLOvT2hr@mail.gmail.com>
References: <20100711042025.GA7424@burratino>
	<m3d3uul8pd.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 11:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXsYb-0002wU-9C
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 11:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0GKJKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jul 2010 05:10:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38997 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab0GKJKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jul 2010 05:10:35 -0400
Received: by iwn7 with SMTP id 7so3663291iwn.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zHYwTZ6nD30sm0Y3M4T2SF3lDraVTk3J3mHMwQbEPTg=;
        b=QInQdZfSM0oIEv6xkQFADfN5OSDm1NabEQlBMXD1SYB59PYuywMeRgrrtHwoYVrT3A
         WIMS20F3Nf0REVLChic7SyRaoHrFreS4iUivpwMibQ+kgHQxot4ht089g/iUQb5oDQXW
         rsLXaj56Uw5QDwyx9cqZbuaRpxh/0uIchDoDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ucXeMcQPPNvCR7wF/VLZw4KrYb0nlA5/HBBUu1Ftdleqmburltv2eTbL0pOKOdlq/j
         dfoo8CFRequX1N0yPKuAvjCFVh45TWKaEJgcSEOsWvH0ZPcIgsi72YhtJsg1oa7jujoD
         lBYGSOWr4wSRTIICC/jMR1Kq0ggUr6CcA3NE8=
Received: by 10.231.39.69 with SMTP id f5mr11929212ibe.53.1278839434674; Sun, 
	11 Jul 2010 02:10:34 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 11 Jul 2010 02:10:34 -0700 (PDT)
In-Reply-To: <m3d3uul8pd.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150770>

On Sun, Jul 11, 2010 at 08:33, Jakub Narebski <jnareb@gmail.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> This script is part of the second batch of tests, from the same day
>> the test infrastructure was added to git. =C2=A0Update it to use a m=
ore
>> modern style in the spirit of v1.6.4-rc0~45^2~2 (2009-05-22).
>> In particular:

On the patch:

    Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

>> =C2=A0- Put setup code inside test assertions, to avoid unexpected
>> =C2=A0 =C2=A0breakages and avoid stray output without -v (as t/READM=
E
>> =C2=A0 =C2=A0recommends); and
>
> O.K., but...
>
>> -cat >expected1 <<EOF
>> -expected1
>> -expected2
>> -expected3
>> -output
>> -path0
>> -path1
>> -path2-junk
>> -path2/file2
>> -EOF
>> -sed -e 's|path2/file2|path2/|' <expected1 >expected2
>> -cat <expected2 >expected3
>> -echo path4/ >>expected2
>> -
>> +test_expect_success 'setup: expected output' '
>> + =C2=A0 =C2=A0 cat >expected1 <<-\EOF &&
>> + =C2=A0 =C2=A0 expected1
>> + =C2=A0 =C2=A0 expected2
>> + =C2=A0 =C2=A0 expected3
>> + =C2=A0 =C2=A0 output
>> + =C2=A0 =C2=A0 path0
>> + =C2=A0 =C2=A0 path1
>> + =C2=A0 =C2=A0 path2-junk
>> + =C2=A0 =C2=A0 path2/file2
>> + =C2=A0 =C2=A0 EOF
>> +
>> + =C2=A0 =C2=A0 sed -e "s|path2/file2|path2/|" <expected1 >expected2=
 &&
>> + =C2=A0 =C2=A0 cp expected2 expected3 &&
>> + =C2=A0 =C2=A0 echo path4/ >>expected2
>> +'
>
> ... I don't think it is really needed. =C2=A0There isn't anything the=
re
> that can fail, and there isn't anything there that produces any
> output.

The disk could fill up. In any case I like the test style of using
setup tests instead of stray setup code inside the tests themselves.

> BTW. do all sane shells that can be used to run test suite support
> '<<-' here-doc redirection operators? =C2=A0Is it in POSIX?

I don't know. But it's POSIX enough that nobody's complained about it
thus far, it's used in a lot of existing code:

    $ ack -l '<<-EOF'
    t/t1012-read-tree-df.sh
    t/t7005-editor.sh
    t/t3507-cherry-pick-conflict.sh
    t/t7401-submodule-summary.sh
    t/t7201-co.sh
    t/t4132-apply-removal.sh
    t/t4041-diff-submodule-option.sh
    contrib/hooks/post-receive-email
