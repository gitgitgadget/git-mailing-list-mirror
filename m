From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Wed, 29 May 2013 10:04:37 +0700
Message-ID: <CACsJy8Dvpn0u1i8M7uxsB=t4NE5v78=gYiY=XFC=KK7f4D=N=w@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
 <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com> <CALkWK0kv-5vAMsrtpPffBaSZrHfm98KNDL8Jw6_pSLsL=8=8iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 05:05:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWhQ-0001pY-9T
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759462Ab3E2DFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:05:10 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48597 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab3E2DFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:05:08 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so9983021obb.17
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SFsSJ4NL5LqMxwuJXIzrrsfN5xhDSrtMLqLJnKGQDJ4=;
        b=Ymn+63STOWjcB8OuiIYTm2e23gjpMnwtbmxV47cYwBPkjKJ6jfrqe0hbsds5wwCWkh
         GhBQ5eLMeCdjm3AuAANuhVp5rKSXUmoUNw9Jc5RAv6vdrRTkNhc3TNWZ7Rcn3WInguUs
         I32TwVF0Ifapfb6sBXVRbjhBcqNJkxHF8WiXhctX6os1biwduKlytmDk3GDxLYKM5aEH
         nWZndCm2WREU5Nhpl/DOcuHl53Pa5zAHrX+5P2tLSX2tT4RUfxuQTHH9KyVbeNSjDMoZ
         wJ1MK5+av7WjhiQRa6vhyiPleXQcecPdMhA2Nd3DfIh3XwtF2eg7a8mmykNiJ0Gl42Qr
         3gzg==
X-Received: by 10.60.150.146 with SMTP id ui18mr387911oeb.101.1369796708072;
 Tue, 28 May 2013 20:05:08 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Tue, 28 May 2013 20:04:37 -0700 (PDT)
In-Reply-To: <CALkWK0kv-5vAMsrtpPffBaSZrHfm98KNDL8Jw6_pSLsL=8=8iA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225708>

On Tue, May 28, 2013 at 9:28 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Ramkumar Ramachandra wrote:
>> %>(N) doesn't work properly with f-e-r, and I'm not sure why.  I'm not
>> talking about your last patch where you compute * -- that works fine;
>> it's just that %>(N) doesn't when N is a concrete number.
>
> Try this:
>
> %(refname:short)%>(30)%(upstream:short)
>
> (assuming that you have lots of branches).  I'm noticing random
> alignment problems.

It's because you don't pad enough spaces after %(refname:short) so the
starting point of %(upstream:short) on each line is already unaligned,
I think. Try this:

%<(*)%(refname:short)%>(30)%(upstream:short)

or if you prefer at specific column (e.g. align upstream close to the
60th column, regardless of refname's length):

%(refname:short)%>|(60)%(upstream:short)
--
Duy
