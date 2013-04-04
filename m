From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 04:44:45 +0530
Message-ID: <CALkWK0mcii_YGqiQTxhSOfgzn7MOHO0TEO3Rx3cRQLOi1ij5Tg@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
 <7vy5cyexuf.fsf@alter.siamese.dyndns.org> <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
 <7vli8xgahc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:15:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtNt-0001bz-AL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765052Ab3DDXP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:15:29 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:60775 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764821Ab3DDXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:15:28 -0400
Received: by mail-bk0-f54.google.com with SMTP id q16so1839462bkw.27
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UU+nBeNhW+cT1Tnc3bBHuOq3R68bEJthkKSkjxE8btM=;
        b=hAqxgJvNBfUWL1M8ciiD7SVvC8dBNfzU4t7XkA6N0DUSOcn2OX8Gs6OZJaQ/g4Y83S
         Ddc16F087tl5fgIZ8EYrKhNSnRX6Hy8C+LJ4/GgtlK51/JVgSPlSBvmncrf2dxzkeJdR
         +wFIsyzC3SijMNm45rfH3A7oYQ0FJPObG3yR8yGo23zI9tcOggOfmLqVDsd3k+1NHytr
         ETaxuxccE/ZKdraaCvjbf3VQuINmFkoJJkjtQvUsh9Efzy2v9xqOfsERGAmC37+ZXVLm
         E+zbO8d7o2kQVWU6VQCDK2LT7KUwetB9t6gZsuCXaCE1ku4Il0i3rnNFv+Y1FFHeco66
         PC0g==
X-Received: by 10.205.74.136 with SMTP id yw8mr5764818bkb.129.1365117325779;
 Thu, 04 Apr 2013 16:15:25 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Thu, 4 Apr 2013 16:14:45 -0700 (PDT)
In-Reply-To: <7vli8xgahc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220124>

Junio C Hamano wrote:
> "git log -p .gitmodules" would be a way to review what changed in
> the information about submodules.  Don't you need "git log-link" for
> exactly the same reason why you need "git diff-link" in the first
> place?
>
> So you may not have suggested it, but I suspect that was only
> because you haven't had enough time to think things through.

What is this git log -p .gitmodules doing?  It's walking down the
commit history, and picking out the commits in which that blob
changed.  Then it's diffing the blobs in those commits with each
other.  Why is git log -p <link> any different?  We already know how
to diff blobs, and we just need a way to diff links.
