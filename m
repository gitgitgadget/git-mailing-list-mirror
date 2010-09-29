From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Wed, 29 Sep 2010 14:30:19 -0600
Message-ID: <AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-16-git-send-email-newren@gmail.com>
	<7viq1omiv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 22:30:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13IQ-0002aX-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab0I2UaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 16:30:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57524 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0I2UaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 16:30:21 -0400
Received: by fxm4 with SMTP id 4so266710fxm.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pm4b+J2Px3lRFPV5FqDjdc91UH6s9ry8Rqw1E3vCUGE=;
        b=xo1UUDeczi7/24LT2vPeA3cVHSjyxUfNVJYcjVchA1D7WXFRxuBZhArB3ovxfN81e3
         CMRS/uHHlEM3mJ4s1C2O4/+0pr823KpdE81mSpl4Pt68OJyepaKza7WshpGPbNwItmb1
         iRfRGLAcuFbQBwO6YbU2DPZpwxb59lPquf3c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FfBxiqqkPgBpwefcKj2iMP1Mmy3WLE0AJiSVCT0vzRnoU3EUvDrJlcU1uW0GCcoRey
         wxMDdYPNucaz2o6si+AyuwS9qOhUXpNXOBvibtq8nVqy9X9wnkBOuT7x94fR/EKXbsU2
         APO4UBVVIuJIbmkIWua23gIydcw0m67YLcp04=
Received: by 10.223.116.137 with SMTP id m9mr2549748faq.16.1285792219851; Wed,
 29 Sep 2010 13:30:19 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Wed, 29 Sep 2010 13:30:19 -0700 (PDT)
In-Reply-To: <7viq1omiv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157602>

Hi,

Thanks for all the reviews.  I'll fix things up.  One question on this
last one...

On Wed, Sep 29, 2010 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>
>> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>> @@ -175,8 +175,8 @@ test_expect_success 'init with init.templatedir =
set' '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" =C2=A0init.templatedir "${HOME}/templatedir-source" &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir templatedir-s=
et &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd templatedir-set =
&&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_TEMPLATE_DIR &=
&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_TEMPLATE_DIR;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NO_SET_GIT_TEMPLATE=
_DIR=3Dt &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export NO_SET_GIT_T=
EMPLATE_DIR &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git init
>> @@ -187,7 +187,7 @@ test_expect_success 'init with init.templatedir =
set' '
>> =C2=A0test_expect_success 'init --bare/--shared overrides system/glo=
bal config' '
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_config=3D"$HOM=
E"/.gitconfig &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.bare false &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.sharedRepository 0640 &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir init-bare-sha=
red-override &&
>> @@ -202,7 +202,7 @@ test_expect_success 'init --bare/--shared overri=
des system/global config' '
>> =C2=A0test_expect_success 'init honors global core.sharedRepository'=
 '
>> =C2=A0 =C2=A0 =C2=A0 (
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_config=3D"$HOM=
E"/.gitconfig &&
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unset GIT_CONFIG_NOGLOBA=
L;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git config -f "$tes=
t_config" core.sharedRepository 0666 &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir shared-honor-=
global &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd shared-honor-glo=
bal &&
>
> These three hunks look wrong as they break the && cascades. =C2=A0All=
 others
> (including the change to 7502) look Ok.

They break the && cascades, but aren't the && cascades already
inherently broken due to the unportable return value of unset?

> Personally I do not agree that ";" at the end is explicit enough as
> t/README seems to think. =C2=A0If we want to be explicit, I'd say we =
should do
> so by saying something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unset VAR ;# can fail

That makes sense.  Alternatively, I asked in an earlier posting of
this series whether it would it make sense to add a
  portable_unset () {
    unset $* || true
  }
helper function to test-lib, and just use it instead of unset?  That
would allow proper chaining everywhere.  Thoughts?
