From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 12:43:39 -0700
Message-ID: <CAJsNXT=Q3wOEJR6wR+e3pMM=PZLbj-9AWF+aT7i-HhkYLMOxiQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
	<CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
	<CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com>
	<CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:50:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIj-0001DP-KL
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2JCTnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:43:53 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55903 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab2JCTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:43:52 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so3051245wib.1
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Qt29GCnGPCcSY8Tyavy6gndPDRMLInUWkw/0H6s6cy0=;
        b=tSvZBwn3vn24HuXzvmBm8rHKcwZFVAEYgPNjJTXth/NjcosyvV+a1VON+kBdtbVnoi
         srZJuMh+1lHkgmQbeB091/9DoRl/TNb2neDSrQ+nKvFyikmu6fgolmVX7DbvIN+Ddqd/
         Gakj5xhcAoqRM0k2YqwbEsLm/6M3PX+f1gCXJmbh5LICgcaPTJMARAPhVRlPY9n5nG5b
         XCOu4R+yc6x+31pxfIrOxuGPaPrbrZJ/9aO/ow59pb2ifvB2IWLyFAO5phNqgVNICt/5
         F8llTpWB9nuoZSXsX/dtgyWKSQ4Q44zqY7eD3lJ45neQa/a/Tu01f6yZ4UDH579bOson
         JT2w==
Received: by 10.216.142.148 with SMTP id i20mr1703501wej.21.1349293423934;
 Wed, 03 Oct 2012 12:43:43 -0700 (PDT)
Received: by 10.194.42.1 with HTTP; Wed, 3 Oct 2012 12:43:39 -0700 (PDT)
In-Reply-To: <CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
X-Google-Sender-Auth: rLrbwoOjNJppZcxJtDYD8KDw97A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206926>

On Wed, Oct 3, 2012 at 10:34 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> HI PJ,
>
> take a git commit without --allow-empty: if the trees are equal, it
> creates no commit,
> and if the trees are different it creates one.
> Take then a git commit --allow-empty: if the trees are equal it may
> create a commit or
> not depending on the parent, message, author and date; if the trees
> are different it
> creates a commit.
> So, the statement does not apply to commits in general.

But that same thing applies to git commit without --allow-empty.  If
you create the same object twice then only one copy is stored,
regardless of how you create it.  In fact, the commits you were
creating in your example were orphans, so --allow-empty couldn't have
had an effect on them in any case.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
