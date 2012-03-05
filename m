From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH v2] mergetools: add support for DeltaWalker
Date: Mon, 5 Mar 2012 09:22:05 -0500
Message-ID: <CAFouetgZOgsiA_85N+=CfC5wXOg8PWFJxfw6U0grgs9SYEFsAA@mail.gmail.com>
References: <1330694867-7601-1-git-send-email-tim.henigan@gmail.com>
	<7vaa3ybpat.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4q7gmFeHuGM5hFruduHw-3mGa+CMU=U6X0jjXUsJLsvw@mail.gmail.com>
	<7vmx7x5ml0.fsf@alter.siamese.dyndns.org>
	<CAFouetjZ0kQMnAPdNey5kSEmq+fmQqq+fC51hcT+9k6T8c6uOw@mail.gmail.com>
	<CAJDDKr6toChs8KpnAbjxeemBZT1AT1Uk9Ajk7DWBREuM6yFMzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Ynq-00071w-Uw
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596Ab2CEOWH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 09:22:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63302 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2CEOWG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 09:22:06 -0500
Received: by iagz16 with SMTP id z16so5586960iag.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DH8cODfzT4aiiSPDP8lqIdg0VFrGDAGYdG5uF3iygrA=;
        b=d4+BLtpEl0bLI7tCP3nzw6E63rtqn42nfVmImh4yG0kMlp5qi3W4auuc7OWK//UxSa
         9xLZmt7ceOT/6OYuEySzbfmqa8Jx7k2o+rCUmV8zx6zeR0dUy8teHPYgLbA5Y1wkbB7T
         T5/WDd/jB8808krG5PNFHG9X/MGpIwmV8m3QrwNIhXXllPTCA9auKLXomy9Yc4FwjOXr
         /nR+T1LzsF1I6EQWYbgMZ7o09jVvdoJN5U8zTo326QSWXKcPmYCICwaj+lvpAHcm9ZvM
         N4fbsRZlPiFP2K2hBOzSH/chBNk5hY5Xq95dEkOh1T61AqmegXGGvn9JgDrW+ptxZTo+
         84eg==
Received: by 10.50.140.106 with SMTP id rf10mr5684157igb.36.1330957325702;
 Mon, 05 Mar 2012 06:22:05 -0800 (PST)
Received: by 10.42.218.65 with HTTP; Mon, 5 Mar 2012 06:22:05 -0800 (PST)
In-Reply-To: <CAJDDKr6toChs8KpnAbjxeemBZT1AT1Uk9Ajk7DWBREuM6yFMzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192245>

On Sun, Mar 4, 2012 at 9:10 PM, David Aguilar <davvid@gmail.com> wrote:

> Thanks, that makes a lot of sense. =C2=A0It looks like they have a bu=
g. =C2=A0Do
> they know about it?

I have not reported the problem to them yet.


> Can you mention this in a comment so that someone doesn't copy/paste
> it into another tool in the future?

Will add a comment in v4.


> If they fix it then we may want to consider only supporting the newer
> version and remove the $PWD. =C2=A0Does the OS X version have this bu=
g too?

I don't have a OS X environment to test on.  However, I did just find
out that the bug is not present on Ubuntu 11.10.  On Ubuntu, it works
with or without $(pwd)/.  The two platforms have different Java JDKs,
so that could be a factor.


> I didn't notice any other production shell scripts in git using $PWD.
> There is one use of `pwd` in git-stash.sh and it's used in a few
> tests, as is $PWD, but $(pwd) is the most prevalent overall. =C2=A0I =
don't
> know the reason $PWD is avoided in the git shell scripts (though
> portability is often the reason).
>
> Deltawalker is not currently available on any of the platforms where
> this would be a concern, but we may still want to use $(pwd) for
> consistency with the other commands. =C2=A0Does that work instead?

$(pwd) works...I will make this change in v4.
