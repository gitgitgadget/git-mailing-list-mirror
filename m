From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Build without BUILT_INS
Date: Mon, 23 Apr 2012 19:42:53 -0700
Message-ID: <xmqqmx61hmtu.fsf@junio.mtv.corp.google.com>
References: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 04:43:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMViY-0001Q3-2E
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414Ab2DXCm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:42:57 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:60032 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab2DXCm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:42:56 -0400
Received: by eaaq10 with SMTP id q10so5759eaa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 19:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=WRVuJ8Djc96JEqyKf2cRV0zgFptorHgZ3fOwXWFfzOk=;
        b=kNNpw4HfmF5nKzDGTujRTn6PVYgY2woeQ+97fAs1FcoCkHKL2VW2qrtjXiuV5xu48r
         nqaZ1mW/T48YE/tAVkZKtfEYibgVBZhoG/OSsWC4gikkqBLJLyUlmDj8YP3D7N5pbiRo
         6ECJFipnbUFsi27FA3TZsmwiXxiF7FI+tl1cYe/LyCiNvQzOwuDMhgdz/t/eU5nUi/ya
         chT5dF9nHhZYlPwpDCdGY2/Yie9AUaTiKdH9FkZjyxdz6G0k4+SXVLEv6OtG7x/JRGuY
         nxLjPm4D1103nO+SZlQd/aLZTXVtw2Ih6Ot0BK2UMRpgk08C6A0kt4MPjVSURukfwmlE
         sDpQ==
Received: by 10.213.19.197 with SMTP id c5mr1411714ebb.20.1335235374949;
        Mon, 23 Apr 2012 19:42:54 -0700 (PDT)
Received: by 10.213.19.197 with SMTP id c5mr1411705ebb.20.1335235374769;
        Mon, 23 Apr 2012 19:42:54 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si11638270eef.1.2012.04.23.19.42.54
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 19:42:54 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 90E6C5C0050;
	Mon, 23 Apr 2012 19:42:54 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id DFE7EE120A; Mon, 23 Apr 2012 19:42:53 -0700 (PDT)
In-Reply-To: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com>
	(Steven Penny's message of "Mon, 23 Apr 2012 21:19:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkHPze291axPYzBFYFG9fYuTWi5w4/U2/a2zugtc26fhW0j34fjMDGRSVFfT0gPClLFG+l8bxjGcWQSwZbnHoRgXd+shRrWwxCFvyvcLVmTdgWmnqLJCnb/QbamZpbs400kLDT94CezlkzdD7bw/NMnnqCh+YaBlIpvF9M0CUbBQFHYfvw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196182>

Steven Penny <svnpenn@gmail.com> writes:

> I would like to build Git for Windows without the hard links in libexec/git-core
>
> I tried doing
>
> make install prefix=/c/git BUILT_INS=
>
> and I get this error

Unsurprising.

What are you trying to do?  Are you trying to build a git that does not
know any of the built-in commands like "checkout", "commit", etc?  Or do
you still want a full-featured git, but because you know the code to
perform "git foo" for any builtin command "foo" is contained in git
executable itself, you want to "rm -f git-foo" from the filesystem?

The latter is a bad idea to begin with, as it will break older scripts
that trust the promise that by having git --exec-path early on the $PATH
older forms "git-foo" will always work.

If you really want to do so, the right way is not by mucking BUILT_INS
to empty.  I do not know how GfW is built, but if it uses our usual
Makefile, find the place where it installs the git-foo forms of links
after it installs the main git executable, and comment it out.

And no, it will *not* be a compilation option, as the resulting
installation will break the age-old promise we made to script writers.

Good luck, and have fun.
