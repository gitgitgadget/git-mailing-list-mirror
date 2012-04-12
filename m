From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] tests: add initial bash completion tests
Date: Fri, 13 Apr 2012 02:18:45 +0300
Message-ID: <CAMP44s37znvnw+n3NsFj+ZVuxwPhrordJA0ko0LV9udPS+i3aQ@mail.gmail.com>
References: <1334181423-4391-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2Ug91_sQ-XR3ck2k+x+eQRt9PNRRBOUnkrnNRhY6fEpw@mail.gmail.com>
	<7vmx6g6e2i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SITHx-0005hr-8k
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649Ab2DLXSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 19:18:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54563 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2DLXSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 19:18:46 -0400
Received: by eaaq12 with SMTP id q12so620726eaa.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=L7WP102vkShzTt8Ec4RPWcPlZ/1nS48aIxFznecNR98=;
        b=EeLHi7hA6fWuiAs7lOToGEP+Vl7OWvl7t+TeVd/WWKKe0zpOF+dhCF+HG1ZtdPJdFK
         Q33Zt751wyZzLHdpTuESVHw4mn33JHr3iuCtBYWHjKARHk2Aa5BCa/2pPy2ujHSMxwpF
         Ot3Izdqj5JTCyng7cHvz7h9/WpcN69jO2foGe8IpbU33Yw4pfsdBCxcGNxpI53LciLY9
         XGRHRRhf/3ZPPKWrpRRTwldmhAuWOpGfmlBp+9KstCjiZ9yjzW6yDGYeiK44voQS5CIq
         eGf6l/JtrZwWvfeslifVh7v7CLUo2Ic0DxqpKjyh9PjQC/xmBPgR7rp4op+7+yCifHOc
         Ln0Q==
Received: by 10.14.127.129 with SMTP id d1mr7069eei.59.1334272725777; Thu, 12
 Apr 2012 16:18:45 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Thu, 12 Apr 2012 16:18:45 -0700 (PDT)
In-Reply-To: <7vmx6g6e2i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195387>

On Thu, Apr 12, 2012 at 8:43 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 12, 2012 at 12:57 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>
>>> +test_expect_success 'double dash' '
>>> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-\EOF &&
>>> + =C2=A0 =C2=A0 =C2=A0 --paginate
>>> + =C2=A0 =C2=A0 =C2=A0 --no-pager
>>> + =C2=A0 =C2=A0 =C2=A0 --git-dir=3D
>>> + =C2=A0 =C2=A0 =C2=A0 --bare
>>> + =C2=A0 =C2=A0 =C2=A0 --version
>>> + =C2=A0 =C2=A0 =C2=A0 --exec-path
>>> + =C2=A0 =C2=A0 =C2=A0 --html-path
>>> + =C2=A0 =C2=A0 =C2=A0 --work-tree=3D
>>> + =C2=A0 =C2=A0 =C2=A0 --namespace=3D
>>> + =C2=A0 =C2=A0 =C2=A0 --help
>>> + =C2=A0 =C2=A0 =C2=A0 EOF
>>> + =C2=A0 =C2=A0 =C2=A0 test_completion "git --"
>>
>> There's a mistake here ^.
>
> Yeah, good eyes! =C2=A0... ah, wait, it is your bug ;-)

Not my eyes, further tests =3D/

Do I need to resend the patch?

--=20
=46elipe Contreras
