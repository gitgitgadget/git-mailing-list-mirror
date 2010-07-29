From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] t/t5800-remote-helpers.sh: Skip with prereq on 
	python <2.4
Date: Thu, 29 Jul 2010 02:03:32 +0000
Message-ID: <AANLkTimZ5GFMn3p3UxgWrY1sMpguA4PZ0F=oGtT02JJQ@mail.gmail.com>
References: <1280313299-721-1-git-send-email-avarab@gmail.com>
	<1280313299-721-4-git-send-email-avarab@gmail.com>
	<20100729011602.GG29156@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:03:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeITD-00020H-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0G2CDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 22:03:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33194 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab0G2CDe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 22:03:34 -0400
Received: by fxm14 with SMTP id 14so16653fxm.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dnkqzODvE4PWuSuu2/PHnhWWIDDRPQELlD1dDeT+Wwk=;
        b=bEE2fBVr3VW4uhcxCu2w1PlDjEzPUCibPqq2sspWdzqJA2nG1l/Vv7AqUFQZRLeu8n
         28iJTc+MqVAfYBAo8hxMYuhrnJAa6ZZPLnhfmqIlEcu6+/P3RtcPzeCi7jH1HDREDcDM
         3nmUdFcy7mqgGi4pYqcX+EXOv4XA3H8Nd2SEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m0OC7vWljtnYEqII1Hka0y7hONbXMtLmez1sB3SRs4XARX+s85s8mwGXHU0Z7xaT9x
         bTRxP+BmY1zYVRuGih+FfYmIrMee6sTAP7Vbrt90245Zmm8uC5QjebQ8KSFbXabzAhcF
         4K+QDb1kE/omT0QFQh0WoWW+/iAcb1V92YZxg=
Received: by 10.223.122.146 with SMTP id l18mr10829814far.82.1280369013042; 
	Wed, 28 Jul 2010 19:03:33 -0700 (PDT)
Received: by 10.223.126.131 with HTTP; Wed, 28 Jul 2010 19:03:32 -0700 (PDT)
In-Reply-To: <20100729011602.GG29156@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152147>

On Thu, Jul 29, 2010 at 01:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the t/t5800-remote-helpers.sh test to skip with the the
>> three-arg prereq form of test_expect_success instead of bailing out.
>
> Right:
>
>> +++ b/t/t5800-remote-helpers.sh
>> @@ -13,13 +13,11 @@ if sys.hexversion < 0x02040000:
>> =C2=A0 =C2=A0 =C2=A0sys.exit(1)
>> =C2=A0'
>> =C2=A0then
>> - =C2=A0 =C2=A0 :
>> -else
>> - =C2=A0 =C2=A0 skip_all=3D'skipping git remote-testgit tests: requi=
res Python 2.4 or newer'
>> - =C2=A0 =C2=A0 test_done
>> + =C2=A0 =C2=A0# Requires Python 2.4 or newer
>> + =C2=A0 =C2=A0 test_set_prereq PYTHON_24
>> =C2=A0fi
>
> And as a bonus, this makes the test clearer. =C2=A0Nice.

Yup, <prereq> is really nice in all regards.

> I would suggest dropping the "Requires Python 2.4" comment, or
> maybe moving it somewhere else with a change to explain that
> it is git-remote-testgit that requires Python =E2=89=A5 2.4
> (rather than the remote helper facility in general).

I put it there to make the connection between 24, 0x02040000, and 2.4.

I think trying to avoid confusion like that isn't a problem in a test
file, it's pretty obvious from the context that the prereq only has to
do with the test. Someone looking up remote helpers is going to do
that in the documentation, not in some t/ test file.

Thanks for your continuing & detailed reviews b.t.w.
