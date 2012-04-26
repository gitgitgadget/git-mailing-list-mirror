From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git.pm
Date: Thu, 26 Apr 2012 12:17:50 -0700
Message-ID: <xmqqy5pi8fq9.fsf@junio.mtv.corp.google.com>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 21:17:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUCU-0007gh-51
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 21:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab2DZTRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 15:17:53 -0400
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51377 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab2DZTRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 15:17:52 -0400
Received: by faaa25 with SMTP id a25so1989faa.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 12:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=qwF++Z13KUMSKLnwA3UgLGc2hy07KLBJ0/8H19rZBHE=;
        b=LFfah2tgGriKXhvEXZlujHS1yMY+LyqGO6O65kR/v3RlaPhrK0RdBThy9OUlRNeNu8
         jW+aNFo3WzgxjXzL9ph/mTTlhPUiwec75NVQMHWYaNVyx6T0u5GPP5D9HzGcCd/xH0KT
         zPBxOVbJFd5Xd8u3/QPxoSQtIdIJ7acxO/t/dI9tTxR9e+lFs3NXNn834MSjEKQH+IkH
         0lPif3DSMYHDPjApoX8Q8n+aPlz3h4xJSc6xUVeWSwheAUmQEM+LZmphiXGJqvTQKfws
         1fp91xnc2L87nPd9YL++V0AwevtvgnNW3usqVbmko0KqfKvOUquuzgGL1PFgUSK52Ed2
         bdPQ==
Received: by 10.14.127.10 with SMTP id c10mr2413933eei.2.1335467871224;
        Thu, 26 Apr 2012 12:17:51 -0700 (PDT)
Received: by 10.14.127.10 with SMTP id c10mr2413922eei.2.1335467871108;
        Thu, 26 Apr 2012 12:17:51 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si3681092eef.2.2012.04.26.12.17.51
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 12:17:51 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E1E9E20004E;
	Thu, 26 Apr 2012 12:17:50 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 31787E125C; Thu, 26 Apr 2012 12:17:50 -0700 (PDT)
In-Reply-To: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
	(Subho Banerjee's message of "Thu, 26 Apr 2012 09:45:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmD463IzlxD0OobIQgyjqe49kYfZ+fwLJspUgPs+6pDQWycGnpVTR2uOX9UgXzuis1rYdZV0pRJpPK0PsRrbxjpk9OfMvWnPbT75nke+T3TdxkEecd/qIk+o6yi2stoxVEIavlh6obW5kgc5M2gbkIrd6+Sn2HMnF3WkkfMw0MsZgKaR/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196394>

Subho Banerjee <subs.zero@gmail.com> writes:

> ... If some of you could give
> me some of your time in terms of advice on what exactly is needed for
> the module, I am willing to work over the summer to get this module
> production-ready.

Well, that sounds as if the module is currently not production ready,
but it has been used in the wild for quite a long time.

> I see in the code that it says that the API is experimental. Is
> there any absolute need for backward compatibility, or can I try to
> redesign the API somewhat extensively?

Being experimental merely means that we do not support out of tree
users; it does not mean you are allowed to break it in any way for the
in-tree users.
