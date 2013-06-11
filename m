From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: New feature discussion: git rebase --status
Date: Tue, 11 Jun 2013 10:23:25 -0700
Message-ID: <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan>
	<vpqbo7c4wen.fsf@anie.imag.fr>
	<CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSI7-0006la-9H
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab3FKRX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:23:27 -0400
Received: from mail-ve0-f180.google.com ([209.85.128.180]:51729 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab3FKRX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:23:26 -0400
Received: by mail-ve0-f180.google.com with SMTP id pa12so5903333veb.39
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Sh2LkB6Q1xmKypnrmfl1P7o84Hw2B3MWDyeXT81aoVE=;
        b=dT9kzxF1tClfLL8dnAJNahsGp6LAfk2WKLZi3aq459eiPQJKKWPiaFk19Ltl5f6C4M
         X36aPAxEx0kFcXGypSzj+kZ/J3LkQOHEh2IxnOTP69LASJLXbMeNJoZfId4kx96d6phb
         lzL+G1LgbLI7gEABycOFD28Wgd65BtagYgd4Ry7mJ2d7e+t3uiIRT41BUj0BgaEQ+fdf
         6iewteL5yRijkvksrHstWRTLinYuVTBlh6IuZG041BfXncMRkh6TjzW1bR2kA0k5pBMZ
         4EG2nzD0ViHNS5ZQcx/xnCgK1AtbEMdYdi9nrsGJqqqczhQSnXbZeQp1VN/lAtk7liM+
         rUZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Sh2LkB6Q1xmKypnrmfl1P7o84Hw2B3MWDyeXT81aoVE=;
        b=HE8C7J/oa77q1KgMtrUNjKb7T8XLZhqgLhTwGFXc3nsOfc9vQQxCYoArEnHl9IRyt2
         r7YzGmYhzatIR4Zmq1B9o4VtSft4zwCM/fAuXlWUnlMc0BUKCYKMSsYirylCN9Jr5ZTc
         PDJbKLaYS2t+xK/+M8pVtTQagBPBEhh0rEcho=
X-Received: by 10.58.236.42 with SMTP id ur10mr5201862vec.48.1370971405852;
 Tue, 11 Jun 2013 10:23:25 -0700 (PDT)
Received: by 10.220.8.71 with HTTP; Tue, 11 Jun 2013 10:23:25 -0700 (PDT)
In-Reply-To: <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
X-Google-Sender-Auth: rkq407mr2HiWSGhvzVA4v5vDjgc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227471>

On Tue, Jun 11, 2013 at 10:18 AM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
>
> Having "git status" display (even more) "context sensitive"
> information during "git rebase" or "git merge" would be very welcome.
> Please, if at all possible, don't make that a separate command.

I agree. The rebase state etc is something that would be much better
in "git status" output, and would avoid having people learn about
another new flag to random commands.

                Linus
