From: Jari Pennanen <jari.pennanen@gmail.com>
Subject: Re: Configurable .gitignore filename?
Date: Tue, 5 Mar 2013 12:28:49 +0200
Message-ID: <CACoicvK77mepwk-n9ZQ7TtCnMZfqDVycg_CgH5zHE3u6=KxHog@mail.gmail.com>
References: <CACoicv+Hq=d5fJ7PXYdyvOdWmc3-GbFrsAf2Ze7dnQTzjExXnw@mail.gmail.com>
	<vpqzjyjp8y0.fsf@grenoble-inp.fr>
	<CACoicvKMWSjU6Lf-2PsCShzqGiX-=2xF9+W0EtrHUzWPU7-T_A@mail.gmail.com>
	<CAJDDKr55ayTpzXPG3j5czY=-W08L8QjhMmjqWdRpoWO=MpHdyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 11:29:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCp7U-00065H-TL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 11:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab3CEK2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 05:28:51 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39538 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab3CEK2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 05:28:50 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so10573106oag.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=U5u8GmadnDFImHmme4W1L6NyJ6x0qR+19G8cy+gJsrI=;
        b=SRlhhxfzMgSJIAWP/2QaLxphKkDkirIz4jTpDWlV0l+y1U1zYmXjRgk9/MWd6rdb4A
         MYcR4/o8mY79pV38qqokObv4hU3eR4Dtu9OLzCZpfTsCPPH5Bp69GmabQF/KQ6B31cWA
         c4feSyQdLCQcHrFJ+KWH/IonBTkoNPJaItmy3bsPTmTYegUxAX5AKuOKLEMeuSqG6Utj
         JdqddrgqYR4gRUGIg6bIF81bvrN2EvRSz3DWzgUmFsYyP3clAgZ//qIMlcu4wTAZ5BCZ
         8UvMaEMMcmQYK85kRDMfiSwCPEDffTQjCJwbhbzVnrIdiJOfabUfYs1mABLtEF1EOlkm
         k3eQ==
X-Received: by 10.182.222.101 with SMTP id ql5mr15839344obc.55.1362479330080;
 Tue, 05 Mar 2013 02:28:50 -0800 (PST)
Received: by 10.76.22.197 with HTTP; Tue, 5 Mar 2013 02:28:49 -0800 (PST)
In-Reply-To: <CAJDDKr55ayTpzXPG3j5czY=-W08L8QjhMmjqWdRpoWO=MpHdyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217442>

2013/3/5 David Aguilar <davvid@gmail.com>:
> On Mon, Mar 4, 2013 at 7:47 AM, Jari Pennanen <jari.pennanen@gmail.com> wrote:
>> I'm actually aware of that. Problem is the normal .gitignore files
>> must *not* be used in the second GIT_DIR at all, in my case it's for
>> syncing so I need to sync almost all files (including stuff inside
>> .gitignore), though I'd still like to retain some ignore files for
>> second GIT_DIR, e.g. like in rsync the .rsync-filter file.
>
> How about .git/info/exclude in the 2nd GIT_DIR?  Would that help?

The second GIT_DIR must not use the .gitignore files of the first
GIT_DIR, so it does not help.

Only way to skip the .gitignore files in git-add is to use "git add -f
." but that skips all excludes, including the .git/info/exclude. I
need to skip .gitignore files used by the other GIT_DIR and still have
some of ignore rules, IMO this is not possible at the moment.
