From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Sat, 19 Mar 2016 22:01:31 -0400
Message-ID: <CAPig+cQOHAWLnDi0LmfJH2vb7mv9CABcx=dyU8DezDunZbfpVQ@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
	<CA+DCAeRe4ak1Ni7CADpJdd-=+dvKTTepHY6dYNfQV3ADpz5f6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 03:01:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahSgT-0007Bk-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 03:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbcCTCBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 22:01:34 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35841 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932829AbcCTCBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 22:01:32 -0400
Received: by mail-vk0-f65.google.com with SMTP id z68so120620vkg.3
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=q/qxDmW/GtBjxY3uBUQbfcAzrpHIpc2Rv+BqSVhkgKE=;
        b=cO6jYdQ5CHV8PJdxp2WW4RfRS1l1bP0iDqXv3TuQ11DcraiUwk72LtWygxeMMC9ZU2
         MFNLwnHihocw3iWAcgHTZ/zzVOSHdrzd/kcI4N/TDHGKoNsYl+F/hpDxGKQv5O5t0Dgz
         xp50MfKaFTckdx9kDwIscx/cPuXu66HXXXnDObobOnCOffOvGIp64ovm1yyEyro5NAzF
         1FzEgJCWBTUMPZtJJXz/0kaj1jEVOtUaPG5A73+AUEH+Ei7+HRt/BIC5ydslRJaGt54Q
         dfhpfnpvPQs4Uhkhn6KeuZudbQm6QObJ18ODi3/4IrTaL/d3a+LC71JodaidRdimACqx
         9Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=q/qxDmW/GtBjxY3uBUQbfcAzrpHIpc2Rv+BqSVhkgKE=;
        b=Ra1aGe+rUf/WkK8VwmF+brlBSbqTQXXY2RvGFaccGFw/E7vIiiY72aC1jrnEKvbJaG
         bsCDULCECpcGkK/+YhPEC+yfM30csB9K/8soGkIpew23BiW7kKWCH3IX8VNPcL4v/Lda
         JVKhIk+uRSDZjgSQ9Cxlm+hYw9T787bp9/+A3G+ZHRlZTyNciV3z9atkUiGtj6cPFNoG
         1NIwD9fPfauQIF/v89WtQ01DzMCtRXNsp4XY20TfWxsC5fnbgPrNgXzZf4CcaGlHDXVc
         g+xqwOARUJCcRQukbKLZmdAAOVKXFxRmJvkZHieKpqlHzAKnJxZoE2l5B1hdJsYzwfoU
         Ywuw==
X-Gm-Message-State: AD7BkJIdDL1PZFj5+hiz0ixGsfPBcNWcx/vDkP1J04IIYniikcxC/nFhK+k0uqcK4IQlF19Jo8xPOrl0nZeFlQ==
X-Received: by 10.31.21.4 with SMTP id 4mr25481405vkv.151.1458439291816; Sat,
 19 Mar 2016 19:01:31 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 19 Mar 2016 19:01:31 -0700 (PDT)
In-Reply-To: <CA+DCAeRe4ak1Ni7CADpJdd-=+dvKTTepHY6dYNfQV3ADpz5f6Q@mail.gmail.com>
X-Google-Sender-Auth: 8egKoQutAuMEXmTDv2V24KOx0ck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289327>

On Fri, Mar 18, 2016 at 11:17 AM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> On Fri, Mar 18, 2016 at 9:54 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '
>>
>> Why do titles of some of the new test titles have a ":" after "rebase"
>> while other don't?
>>
>> Also, how about normalizing the titles so that the reader knows in
>> which tests rebase.autostash is 'true' and in which it is 'false'?
>> Presently, it's difficult to decipher what's being tested based only
>> on the titles.
>
> If it's so then how about the tests titles to be the following:
>
> * pull --rebase: --autostash works with rebase.autoStash set true
>
> * pull --rebase: --autostash works with rebase.autoStash set false
>
> * pull --rebase: --no-autostash works with rebase.autoStash set true
>
> * pull --rebase: --no-autostash works with rebase.autoStash set false
>
> Earlier I tried to keep it as less verbose as possible (and probably
> made it hard to decipher). Does the above titles seems short and
> informative to you? If so then I will use them instead of earlier ones.

Those are better. If I was doing it, I'd probably drop the unnecessary
":", "works with", and "set", so:

    pull --rebase --autostash & rebase.autoStash=true
    pull --rebase --autostash & rebase.autoStash=false
    pull --rebase --no-autostash & rebase.autoStash=true
    pull --rebase --no-autostash & rebase.autoStash=false

or something, but that's a very minor point.

>> Finally, shouldn't you also be testing --autostash and --no-autostash
>> when rebase.autostash is not set?
>
> If rebase.autoStash is not set then config.autostash will remain zero
> through out the process. What I want to point out is that rebase.autoStash
> , if not set, is equivalent to being set false. So adding tests regarding
> "--[no-]autostash with rebase.autoStash unset" seems equivalent to tests
> " pull --rebase: --autostash works with rebase.autoStash set false" and
> "pull --rebase: --no-autostash works with rebase.autoStash set false".

Yes, but what you've described is how the current *implementation*
works, whereas the tests should be checking expected *behavior*. So,
while we both know that under the current implementation, checking:

    pull --rebase --autostash & rebase.autoStash unset

is the same as checking:

    pull --rebase--autostash & rebase.autoStash=false

some future change to the implementation could (accidentally) break
this equivalence, and we want to protect against such breakage by
checking behavior, not implementation.


Also, I forgot to mention a couple other missing tests you should add:

    * pull --autostash (without --rebase) should error out
    * pull --no-autostash (without --rebase) should error out
