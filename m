From: Shawn Pearce <spearce@spearce.org>
Subject: Re: security flaw with smart http
Date: Fri, 22 Jun 2012 10:54:28 -0700
Message-ID: <CAJo=hJvCC8_oFFMyc5Fkweg6A6cSV6z+UxeCkvnU34KQfYx91w@mail.gmail.com>
References: <87fw9ns0cp.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Kanis <ivan.kanis@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si84M-0003TS-Sy
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755928Ab2FVRyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:54:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41361 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab2FVRyt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:54:49 -0400
Received: by pbbrp8 with SMTP id rp8so3851982pbb.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 10:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1MvdRLqht0XSgCJB0DxjXAcIKIegbkRX2ZPdeXurYkA=;
        b=NyuLaaqO76Og7Ds7suB17W4m8fUYGM3/9yhqvaV9d1rTCXHI+Q9izZT8TG9kPo6Sgz
         rKB69gwbogHVskrwzxzgrEmBjXBTqQFi2CpkUXIQ9n0Y/6fQdWSRrM7koQMCGQI1T6Yl
         bTwxrVXzh1J3tzjy7upZ6vh3tdWeflPpymFTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=1MvdRLqht0XSgCJB0DxjXAcIKIegbkRX2ZPdeXurYkA=;
        b=kG9VfY/dg0dZ377rvy9YATowVqlP7V9geGetM5tPTduzR1kZie4rXwXbNpGhj7Viug
         UwzzadzscqhfmPni2WgfFuqcG/j0vdfXZs0gnJs21snlkZbgRTCsVOkxiJVbYYV4q9ok
         UvMBeRu8/K47/VPIlMIJ5Y0CZ/xxCG/u4vL5e8OusQlErJQi3sM5RAtuOj6FQLZO4Jk/
         zOvHcwnGQGykywvKXJECMz0CDC+NuxDgvYEdcY4gLw9sCqEeymdJXfC2tG060pVmQ4Qc
         jmPrxTx9NNobNCPd/s9zBGVBQGuwryVeLCQclKqXEZEbaAAejEbPW0CKKBWSZXHu94n8
         L5AQ==
Received: by 10.68.200.232 with SMTP id jv8mr11685279pbc.161.1340387689349;
 Fri, 22 Jun 2012 10:54:49 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Fri, 22 Jun 2012 10:54:28 -0700 (PDT)
In-Reply-To: <87fw9ns0cp.fsf@kanis.fr>
X-Gm-Message-State: ALoCoQnEPzAH2KxB4NdYRfHPm7OKi2uCD5JIWsWSfuYf7z3MPeFCSqivucXYvj+NdrDhQgtzQ96l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200452>

On Fri, Jun 22, 2012 at 3:12 AM, Ivan Kanis <ivan.kanis@googlemail.com> wrote:
> I think we found a security flaw with git http smart backend. We are
> running git version 1.0.7.4 on our server. Adding random words after the
> password and the authentication still succeeds.

git http-backend does not handle authentication or authorization. This
is handled in your web server. You should consult your web server's
documentation, and maybe its configuration files.

> It's very easy to reproduce, say the username is ivan and the password
> is the word secret:
>
> % git pull
> Username: ivan
> Password: secretfoo
> Already up to date.
>
> Pull succeeds although the password is wrong! Can someone try to
> reproduce with a more up to date git server?

Git is freely available under the GPLv2 license. I believe it is
possible for you to attempt experiments yourself with more up-to-date
versions if you wish.
