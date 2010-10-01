From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv4 14/15] Add missing &&'s throughout the testsuite
Date: Fri, 1 Oct 2010 00:48:29 +0000
Message-ID: <AANLkTim6ca=8pis2X8Xrc1bGB0YCtYRxCpY3pMdA0QvU@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-15-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 02:48:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Tng-00079P-AL
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 02:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab0JAAsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 20:48:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41839 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab0JAAsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 20:48:30 -0400
Received: by iwn5 with SMTP id 5so3110148iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uZwjTZkwqUkbTzKbbFplcoRGXRUA1gLOR1DswCVUTJg=;
        b=iTUmnOtIhJpOJl8cWj3m+4OgYsKeABZfgsiAE3oTXDEi/GS8ckUxivMZhjTQ8rijPQ
         5taw8yfOUKZqr5pRvg/YrY4fIgpCFijh8S2ZgdWvleYRwJs4QPo4ESXHfDfXiVEkTIsb
         UynJ3yayJyUHYWDP50n8v+dTWN/DdAivpJWTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OgQAalyj+/CDQQJkAasZv2ar7BYRjSON2lbZxT2C+3uCAd/9LzKQ8KYhYDqWyWJ3VY
         MSztZSJZ/IAtCg6m7erUalqAqbxNRIlAPzvCnyzxwQNCkVJct5NpxKNpwdhPzm+EkSgH
         AjSfxM8QvwXJrYj2KBLWxjLV5gW7nZCTuv9Oo=
Received: by 10.231.145.16 with SMTP id b16mr4667548ibv.198.1285894109838;
 Thu, 30 Sep 2010 17:48:29 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 17:48:29 -0700 (PDT)
In-Reply-To: <1285542879-16381-15-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157724>

On Sun, Sep 26, 2010 at 23:14, Elijah Newren <newren@gmail.com> wrote:

> =C2=A0test_expect_success 'did not use upload-pack service' '
> - =C2=A0 =C2=A0 =C2=A0 grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/ac=
cess.log >act
> - =C2=A0 =C2=A0 =C2=A0 : >exp
> + =C2=A0 =C2=A0 =C2=A0 grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/ac=
cess.log >act &&
> + =C2=A0 =C2=A0 =C2=A0 >exp &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp exp act
> =C2=A0'

This test started failing in pu, I'm presuming you didn't spot it
since you didn't run the tests with GIT_TEST_HTTPD=3D1.

Anyway, that grep should be a "! grep" to work with &&.
