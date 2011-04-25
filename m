From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: Folder Git
Date: Mon, 25 Apr 2011 18:52:59 +1000
Message-ID: <BANLkTimnyv_+NCc3yOSswJeqHo_zsGwCDA@mail.gmail.com>
References: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEHXY-0006HV-0k
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 10:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab1DYIxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 04:53:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59287 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083Ab1DYIxB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 04:53:01 -0400
Received: by ewy4 with SMTP id 4so649000ewy.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T5EsL79yN0qlOy3ExtMgQ3SRHUNghF00+QYRHo9r5jY=;
        b=BarxebmpzVx2i+/X3Wqs27SikVQthjKxEHEs89+BNrSsFzrRsYb943xnTzFMgYp00q
         idur+DhJ57973z7OzK3+wdAuDaa/zYjFJjw97QqMw3jKqEa+aaL2x/RXBVip/9HSE2dc
         YFBNvDXUllFpxSJPl2vdSD+ek6/6ornIiklq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=plwo5BvoNNt1ADJ/12OS+6cESZ67QFcQ08VNMDN8RUlcVp3c33NQIu97+04e2548Ib
         NNIZp7fzQUlxWNOYsVL4EuZT6uCxEBOn98KT2KzsaMvJQ4QfNXZzlDLu+uts7z5jXY86
         CgzSVC9ws12lCuFtTFEMgh/qyC/7rlROUbT3U=
Received: by 10.14.123.9 with SMTP id u9mr1283292eeh.53.1303721579762; Mon, 25
 Apr 2011 01:52:59 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Mon, 25 Apr 2011 01:52:59 -0700 (PDT)
In-Reply-To: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172018>

On Mon, Apr 25, 2011 at 6:32 PM, Victor Engmark
<victor.engmark@gmail.com> wrote:
continue to other repositories.
>
> Issues:
> * Don't know if anyone else has used it. Probably not, so there's
> bound to be issues (especially since it's been changed quite a bit the
> last couple days for this RFC).
>

Victor,

Certainly seems like a common need. I had a similar solution which I
used for a while.

In the end, however, I found that creating a super-module in the top
directory that contains
the other git directories as git submodules allowed me to use a
standard feature of git to achieve the same effect.

So:

    git submodule foreach git gc --aggressive

I know this won't suit every use case, but it does work in an
environment where the set of repos you are operating on have a degree
of coherence and it makes sense to set up a submodule for them.  In
this particular case this is the only reason why I use submodules - I
don't use them for configuration management, for example, simply as a
handy way to exploit git submodule foreach.

Have you considered using git submodules in this way?

jon.
