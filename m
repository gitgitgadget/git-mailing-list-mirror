From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 07/15] t4019 (diff-wserror): add lots of missing &&
Date: Sat, 2 Oct 2010 21:03:43 -0600
Message-ID: <AANLkTikmf7NSC+ZDRr3tyK=6NdJnWPaE2KLRdZAJu1a-@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-8-git-send-email-newren@gmail.com>
	<7v4od8nzl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 05:03:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Erj-0002Hg-1f
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 05:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0JCDDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 23:03:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59940 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0JCDDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 23:03:44 -0400
Received: by fxm14 with SMTP id 14so1243519fxm.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lL+d81JzZoqjbd5OuDLGqHkY84zmaju/eul9O5ej92o=;
        b=H6qFKV8OxjkDqfmV/pp9lOom5qTvVxYz07iX8sUU5vWJHi+UcfG8qZxs5elqRivyYx
         st0/3veXm6q0qfxjVWUbUQfpZAiHR/I8KOc0g7R39Z2rgInhV/ZimatgMWc5IaSQS2be
         8dFStdgPi1Sx352xbfTThn5hvxUQZtc/yh0wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v0DTLwc+jRrEnlssnUcW1ltKPjkAjTI6Is/mmtmGrVnm/Sz5/nieu3M9ypdAp3mNt4
         1nm4L3j1bFlm5UwmJjlAd9diTlv9jD1bsERyAlBQF/vL0pAi4TDCkWooSzTz8wu49ZrZ
         e8fer6ytP3EnZm6iwqmqvQSnphgFz/BpAtka8=
Received: by 10.223.116.19 with SMTP id k19mr7387852faq.48.1286075023268; Sat,
 02 Oct 2010 20:03:43 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sat, 2 Oct 2010 20:03:43 -0700 (PDT)
In-Reply-To: <7v4od8nzl9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157817>

Hi,

On Wed, Sep 29, 2010 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Also add a test_might_fail in front of the final git_config --unset
>> core.whitespace as that value may have already been unset previously=
=2E
>
> In general, if a previous one that is designed to set a variable fail=
ed
> for whatever reason, the next one that does --unset without might-fai=
l
> will be broken. =C2=A0So...
>
[...]
>> + =C2=A0 =C2=A0 git config --unset core.whitespace &&
>
> ... I think you need might-fail in front of this one, and ...
[...]
>
>> + =C2=A0 =C2=A0 echo "F whitespace=3D-space" >.gitattributes &&
>> + =C2=A0 =C2=A0 prepare_output &&
>>
>> =C2=A0 =C2=A0 =C2=A0 grep Eight normal >/dev/null &&
>> =C2=A0 =C2=A0 =C2=A0 grep HT normal >/dev/null &&
>> @@ -107,9 +107,9 @@ test_expect_success 'without -space (attribute)'=
 '
>>
>> =C2=A0test_expect_success 'with indent-non-tab only' '
>>
>> - =C2=A0 =C2=A0 rm -f .gitattributes
>> - =C2=A0 =C2=A0 git config core.whitespace indent,-trailing,-space
>> - =C2=A0 =C2=A0 prepare_output
>> + =C2=A0 =C2=A0 rm -f .gitattributes &&
>> + =C2=A0 =C2=A0 git config core.whitespace indent,-trailing,-space &=
&
>
> ... this one, ...

I fixed the others you pointed out, but elsewhere you were talking
about git config --unset and the --unset option is not being used
here.  Is there another reason this config command needs one?
