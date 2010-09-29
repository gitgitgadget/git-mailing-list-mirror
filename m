From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Wed, 29 Sep 2010 18:45:57 +0000
Message-ID: <AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-3-git-send-email-newren@gmail.com>
	<7vd3rwo22t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 20:46:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P11fH-00016W-RW
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 20:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100Ab0I2Sp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 14:45:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65336 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab0I2Sp5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 14:45:57 -0400
Received: by iwn5 with SMTP id 5so1349434iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YtAddNH58OmPBosReh+55wvTjWyFDbmRtTCLd3jGG1c=;
        b=w7D/u+8P38SsnbihYDkB1OgucdAXVvAV3t9c8/A1RV3pheYfiDYYfW0XXNLBEsZVFA
         PBmC/eB5hg+nUe3f0noKk3V5ALrXRL8Nb2a5tzZCm+MxFqt9PMU/fXHdvfa8SjxMGkvQ
         LZldaitAuXZfO4ODSdJP1r6BT0jKJLGL6DX10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZBvCQvhWwlTMVKZX5DaAL/HVfwvTbv/WmZG/6mhNBcUtfMSB/XCkgysmcwuEkvBk6s
         fJF88a2xqOoRsOMGxdHDYdoFUT9yFMj+ESB5cZN/ZI1f/1WVNeUnKsuKQvSpYR/ofyPh
         PozZt+XeSVm2Rj32DkA7KGvLvMfiVxzO+rOlg=
Received: by 10.231.187.194 with SMTP id cx2mr1273246ibb.165.1285785957118;
 Wed, 29 Sep 2010 11:45:57 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 11:45:57 -0700 (PDT)
In-Reply-To: <7vd3rwo22t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157588>

On Wed, Sep 29, 2010 at 18:07, Junio C Hamano <gitster@pobox.com> wrote=
:
> Elijah Newren <newren@gmail.com> writes:
>
>> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> =C2=A0t/t4017-diff-retval.sh | =C2=A0 30 ++++++++++-----------------=
---
>> =C2=A01 files changed, 10 insertions(+), 20 deletions(-)
>>
>> diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
>> index 6158985..6605e12 100755
>> --- a/t/t4017-diff-retval.sh
>> +++ b/t/t4017-diff-retval.sh
>> @@ -28,37 +28,29 @@ test_expect_success 'git diff --quiet -w =C2=A0H=
EAD^ HEAD' '
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git diff --quiet -w HEAD^ HEAD
>> =C2=A0'
>>
>> -test_expect_success 'git diff-tree HEAD^ HEAD' '
>> +test_expect_code 1 'git diff-tree HEAD^ HEAD' '
>> =C2=A0 =C2=A0 =C2=A0 git diff-tree --exit-code HEAD^ HEAD
>> - =C2=A0 =C2=A0 test $? =3D 1
>> =C2=A0'

It also looks like this will pass for for all exit codes that *aren't*
1, because if $? !=3D 1 +test_expect_code will get the exit code of
1. But if it's 1 then test $? =3D 0 will return 0, right?

>> -test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
>> +test_expect_code 0 'git diff-tree HEAD^ HEAD -- a' '
>> =C2=A0 =C2=A0 =C2=A0 git diff-tree --exit-code HEAD^ HEAD -- a
>> - =C2=A0 =C2=A0 test $? =3D 0
>> =C2=A0'
>
> It probably is better to simply drop "test $? =3D 0" and keep the
> expect-success, no?

Yes.
