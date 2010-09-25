From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 15/16] Add missing &&'s throughout the testsuite
Date: Sat, 25 Sep 2010 19:38:27 +0000
Message-ID: <AANLkTi=5_vAu=X0Rg9WeOko1DrYsF6dc=FeHGfUHsUzd@mail.gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
	<1285441627-28233-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 21:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozaa3-0001Ou-1o
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab0IYTi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 15:38:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50766 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab0IYTi2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 15:38:28 -0400
Received: by iwn5 with SMTP id 5so3418509iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k3kQNqUqthRPepY+VkJGE2QLD08HQWq8HCsH3dTlc7Y=;
        b=gdvOngEM1lOnA7gDuTidr0q8f9gM+hrHagXmnU3Y97nXBppRNooADfPec3GKL7df8W
         Qp9cN1lAkymAcEKOKj9EDq2Zgpd83F1pSQdUNLRNIpiUrzNyZLuOSv014iXgM+0PHXoA
         U8+ghWF8lA6hRCAcGiqDqw8P4L68Zb5W528Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RHI1b0dPWBcLNor1Q7HrACSejNbX/JdN+TSetuyG7LPrmQ6/FkF4Na6i2u9Hkn9G1s
         x6OyRlwGDEZ1ZEa/tUCfy0obNCmfCrWKi/7F45lYZwsZ7n8wn4ionYbIQGknFJ8aD9kB
         DqZVgS3lu0gOTt5GZKzwXAlu2t1cjZDzDCgyw=
Received: by 10.231.146.134 with SMTP id h6mr6131830ibv.170.1285443507450;
 Sat, 25 Sep 2010 12:38:27 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 12:38:27 -0700 (PDT)
In-Reply-To: <1285441627-28233-16-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157192>

On Sat, Sep 25, 2010 at 19:07, Elijah Newren <newren@gmail.com> wrote:

> + =C2=A0 =C2=A0 =C2=A0 cat <<EOF >.gitattributes
> +[attr]notest !test
> +f =C2=A0 =C2=A0 =C2=A0test=3Df
> +a/i test=3Da/i
> +onoff test -test
> +offon -test test
> +no notest
> +EOF &&
> + =C2=A0 =C2=A0 =C2=A0 cat <<EOF >a/.gitattributes
> +g test=3Da/g
> +b/g test=3Da/b/g
> +EOF &&
> + =C2=A0 =C2=A0 =C2=A0 cat <<EOF >a/b/.gitattributes
> +h test=3Da/b/h
> +d/* test=3Da/b/d/*
> +d/yes notest
> +EOF
> =C2=A0'

Why is the && at the end of the EOF, on my system with dash:

    $ cat /tmp/meh.sh
    #!/bin/sh

    cat <<EOF >/tmp/file
    foo
    bar
    EOF &&
    cat <<EOF >>/tmp/file
    foo
    bar
    EOF

    $ /bin/dash /tmp/meh.sh ; cat /tmp/file
    foo
    bar
    EOF &&
    cat <<EOF >>/tmp/file
    foo
    bar

The && should be directly after /tmp/file, no?
