From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: use catfile() to concatenate files
Date: Tue, 14 Sep 2010 19:55:47 +0000
Message-ID: <AANLkTim7y3qUqQ4TN4w9+5qwR-uLmCP=dTKnMUSnqUrP@mail.gmail.com>
References: <1284490944-16964-1-git-send-email-avarab@gmail.com>
	<7v7hio86tz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 21:56:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovbc0-00032R-Vm
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281Ab0INTzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 15:55:50 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43613 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab0INTzr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 15:55:47 -0400
Received: by gyd8 with SMTP id 8so2569280gyd.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ji2sK2PAF1nwe+QvZNUeIZ3TZEw+lhSngidMxitY7Rk=;
        b=NI2v4HeWnPEtccFmMlFk5ZmVPp06vCc0EOTexBXaikV7h11rcivDAt+OQq7ii9fF/+
         Bv3Rxg3CKio9idThP3dzYE6t7AsR7kmzjMGSOqHKpAAD3hDIoJcNHFgLJtClDJeka6gh
         TA8LObRSy9usNDSQjtoVwkFgT/ZuiiHbDlneU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=taOranN/jYX6vYhfJpJuXD352O/4DqAoqTxNhAODzaq58QsE+3DDkySM7JEeh290/U
         IIuugH1fogU4UJaqdV09gLoRHviMkWb3fuP8xwsoI8YvGYaPt1sk7Z2+EIXDP2Bz2Qe1
         zyEgxGNc2gvRmvOfOcqyXOsLPmmS01rWIlRUM=
Received: by 10.150.195.4 with SMTP id s4mr688422ybf.273.1284494147274; Tue,
 14 Sep 2010 12:55:47 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 14 Sep 2010 12:55:47 -0700 (PDT)
In-Reply-To: <7v7hio86tz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156206>

On Tue, Sep 14, 2010 at 19:26, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Change send-email to use Perl's catfile() function instead of
>> "$dir/$file". If send-email is given a $dir that ends with a / we'll
>> end up printing a double slashed path like "dir//mtfnpy.patch".
>>
>> This doesn't cause any problems since Perl's IO layer will handle it=
,
>> but it looks ugly.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>
> If you mentioned in the proposed log message that File::Spec::Functio=
ns
> have been with us since Perl 5.6.1, it would have saved me (and other=
s)
> some time worrying about the portability issues.

I thought you might trust me to write portable code by default :)

Anyway, I forgot to mention it. But one can use the corelist(1)
program to see when what modules appeared in perl core:

    $ corelist File::Spec::Functions
    File::Spec::Functions was first released with perl 5.00504
