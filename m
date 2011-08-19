From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 11:07:53 -0700
Message-ID: <CAOTq_ptdf3NvoeQXzdABdnU50w1ZwL=wnF6rPJvZpnqcU64-+g@mail.gmail.com>
References: <7vhb5fev8a.fsf@alter.siamese.dyndns.org> <14776204.81375.1313675595871.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:08:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTUS-0004VT-5U
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989Ab1HSSIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 14:08:15 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50975 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab1HSSIP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 14:08:15 -0400
Received: by yxj19 with SMTP id 19so2377398yxj.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2L3v+PLDi1okrS7eFZwUoCS1NZQy03tAX8O2BmzBV8g=;
        b=S4dhMQ0Evqnn1XyvB6TYiWnd1lw/w4dOM0XJUNqSrJC+BVYzy7nIT5UOWQ7H0gSoOA
         Rlr4uLvqJy21uHTucyxqEkjMoC/a5g0+evTiNA6Yxgjkn1cICTzOfCoKXxwuVRRdQR7T
         i7cS7qLs1kOuPYg5jVt7DW4o1t00quJUFBeBU=
Received: by 10.236.153.98 with SMTP id e62mr333063yhk.40.1313777294232; Fri,
 19 Aug 2011 11:08:14 -0700 (PDT)
Received: by 10.236.95.131 with HTTP; Fri, 19 Aug 2011 11:07:53 -0700 (PDT)
In-Reply-To: <14776204.81375.1313675595871.JavaMail.root@mail.hq.genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179714>

On Thu, Aug 18, 2011 at 6:53 AM, Stephen Bash <bash@genarts.com> wrote:
>
> Should case insensitive matches be added to the tests? =A0This mornin=
g I discovered coworkers working on branches foo and Foo thinking they =
were on the same branch... =A0Rather trivial to clean up, but certainly=
 caused some confusion in the office.
>

I can certainly see the use-case, but there's definitely a step-change
between "this branch has the same name as something else", and "this
branch is going to confuse you". When trying to change the code to be
a warning as Junio suggested, I did think about expanding the
definition of ambiguous to include things that are merely confusing;
however it's not clear where to stop (i.e. should we warn about
<remotename>/<anything>, foo and f00, a branch called "=A0" [the
non-breaking space]). There's probably an argument for more general
warning, but I don't think I understand when it should be shown
well-enough.

Conrad
