From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 03:48:17 +0530
Message-ID: <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:19:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsVI-0005M4-OV
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765238Ab3DDWTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:19:00 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:54792 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765142Ab3DDWS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:18:58 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so1823840bkc.31
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sbQakfcSYkZvmAMaRz9rrZQ3uHn+26eMg4MgI1ZMUP0=;
        b=uS/5X7RJKfqTRABESC5B2XnLSd/cG/uoo1VBwPMbuXdGLELLXJ/fdX3dmrh5eTw/R6
         CGLVLsq88dPknJOX07p4Pguu/RXMfMqNQceV2m3EAAoJ9khfCOtJ4Kk0klIDT7rfvHSY
         IUhWaJnUGLzjjEYz7peHJTDRkzF2JgG+VhuDlE53eUSNH8QKOkj7QeQNO18NbJt0mLsT
         lafn4wmiPWUOVICp+Y8rczPCmAMUdNgt1Eut8tLBdrpQRsWKV4lxPQR9S/qOg5zgXlad
         lH/V8/n/Vce7Hb1907FHYURaG68O9qW/Kssr6fjilqsBfg+F6u/OuM1546kEJtyldMaE
         HOdw==
X-Received: by 10.204.166.133 with SMTP id m5mr5741761bky.78.1365113937275;
 Thu, 04 Apr 2013 15:18:57 -0700 (PDT)
Received: by 10.204.36.10 with HTTP; Thu, 4 Apr 2013 15:18:17 -0700 (PDT)
In-Reply-To: <7vd2uagd10.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220115>

Junio C Hamano wrote:
> When you are changing information _about_ submodules (e.g. you may
> be updating the recommended URL to fetch it from), you can use the
> usual tools like "git diff" to see how it changed, just like changes
> to any other file.  If the information _about_ a submodule A is
> stored at path A, and at the same time you have a working tree that
> corresponds to the root of the submodule A at that path, it gets
> unclear what "git diff A" should report.  Should it report the
> change in the submodule itself, or should it report the change in
> the information _about_ the submodule?  By separating these two
> concepts to two different places, .gitmodules design solves the
> issue nicely.

git diff-link.  Just turn it into a buffer and diff as usual.
