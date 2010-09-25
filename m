From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 3/4] rev-parse: add tests for git rev-parse --flags.
Date: Sat, 25 Sep 2010 10:29:07 +0000
Message-ID: <AANLkTin+tokb+kmbLWm6CH7T1eqNijNyGvjz6becpxD7@mail.gmail.com>
References: <1285405454-12521-1-git-send-email-jon.seymour@gmail.com>
	<1285405454-12521-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: robbat2@gentoo.org, casey@nrlssc.navy.mil, git@vger.kernel.org,
	brian@gernhardtsoftware.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 12:29:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzS0I-0000XQ-Pe
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 12:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209Ab0IYK3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 06:29:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54318 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab0IYK3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 06:29:08 -0400
Received: by iwn5 with SMTP id 5so3105778iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L5kT2o/qlCOshxniqoPVbAIiBe6UIT/3y1LouM1z884=;
        b=vlFz+v+86jT8zot+YDM8KdCDuYNRYPWJ55BgyPb/ThvD340x09J9MHKHsNLK3I05HS
         5smeNwB46HuR4V04EJkSTObxcVNpQhyNT+dePF4adL5daDcJRt08QTYq+/BIHybrGPVq
         ssrME+SlOPNxdNdeFgxIhz9BgFOTmDJbfOTW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=agZcHqwVmyPAfOmGChUdiiqL/pF4ejG7NradoaCjS8rFInG5L1/NaojK9ENX6BLmXj
         McSbgX+ssja6x9Q6sZ1ZQMDL+Sm0BJscJI2ODyL9Voo7YudW6KGNIorB4eE39BV1ogP2
         h4qYcrNTJ8LXnq/EoyWxzZQ0L9fVYLW6F7JPk=
Received: by 10.231.85.206 with SMTP id p14mr5271506ibl.89.1285410547837; Sat,
 25 Sep 2010 03:29:07 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 03:29:07 -0700 (PDT)
In-Reply-To: <1285405454-12521-5-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157143>

> +test_expect_success 'git rev-parse --flags -> ""' \
> +'
> + =C2=A0 =C2=A0 =C2=A0 output=3D$(git rev-parse --flags) &&
> + =C2=A0 =C2=A0 =C2=A0 expected=3D"" &&
> + =C2=A0 =C2=A0 =C2=A0 test "${output}" =3D "${expected}"
> +'
> +
> +test_expect_success 'git rev-parse --flags X -> ""' \
> +'
> + =C2=A0 =C2=A0 =C2=A0 output=3D$(git rev-parse --flags X) &&
> + =C2=A0 =C2=A0 =C2=A0 expected=3D"" &&
> + =C2=A0 =C2=A0 =C2=A0 test "${output}" =3D "${expected}"
> +'
> +

Please use test_cmp throughout the test instead:

    >expect &&
    git rev-parse --flags >actual &&
    test_cmp expect actual

etc.
