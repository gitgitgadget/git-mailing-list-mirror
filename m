From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: How to keep different version numbers in different branches?
Date: Mon, 5 Apr 2010 15:36:51 -0400
Message-ID: <n2x32541b131004051236m3a800c57k41536729ae3f192@mail.gmail.com>
References: <hpcscv$umg$3@dough.gmane.org> <y2i32541b131004051151v8f4b8774q360c04ecdb046778@mail.gmail.com> 
	<vpqd3ydr9g6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Kelly <steveire@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 05 21:37:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nys76-000362-Ec
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 21:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab0DEThQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 15:37:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63879 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab0DEThN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 15:37:13 -0400
Received: by gwb19 with SMTP id 19so1334283gwb.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/V6thWvoOCnq2FPhhegvKFcj3SkfATPYBVNa1hdMJJI=;
        b=INcmuJ8RpV9HIinO75Vz76KJJN6EILumHxvv3j1Qv7zv46vaXOOLr+fPRp+iyBxMoA
         bexqn1vxiTylUmmPXWurUZECpjDkbiFMKYJ3psLo36C+vuSm6Sx8y6JbXdPKHDZcbnW8
         vMxZ+cc+KdiVqXlr/9EcAqGs0bNcaRS9DSCVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=al5pjuRUq7t/ZHnobfPApT2kudnJSYXeQgxMMp3GVFc6dWi8fkKvbHjuQFD9qwSvVz
         MSzS5D9+vwZZ2HDTG9JdrA3fsSnWn8IRIjcqQQVnj3bqrveJDjN3JjTBMzXSDRT5rSLT
         /5aKzyVODzCae/PBAniciTzbvtI+dmRf/wTo0=
Received: by 10.150.199.19 with HTTP; Mon, 5 Apr 2010 12:36:51 -0700 (PDT)
In-Reply-To: <vpqd3ydr9g6.fsf@bauges.imag.fr>
Received: by 10.150.252.13 with SMTP id z13mr6658117ybh.76.1270496231577; Mon, 
	05 Apr 2010 12:37:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144055>

On Mon, Apr 5, 2010 at 3:22 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> You can even make sure it _never_ happens, by making a one-commit
> release branch which changes the version number for each release. Thi=
s
> one-commit is never merged in anything:
>
> =A00.1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0.2
> =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0v =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v
> --o--o--o--o--o--o--o--o---o--o--o <--- master branch
> =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/
> =A0 =A0o--o--o--o--o--o--o--o--- ... =A0<--- maintainance branch
> =A0 =A0 =A0 =A0 =A0 \ =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0o <- 0.1.1 =A0 =A0 o <- 0.1.2
>
> Here, the maintainance branch never changes the version number in
> README & friends.

This works too.  In fact, I even do it on one of my projects.
However, I find it a little annoying, because then I don't know which
version to tag: the pre-number-changed version, or the
post-number-changed version.

The latter sounds like the obvious answer, but if I do that, then "git
describe" never says anything useful on my master branch.  But if I do
the former instead, then the tag doesn't accurately reflect the
version I *actually* released.

I've never found an adequate solution to this problem, other than not
including the version number in the repo at all.

Have fun,

Avery
