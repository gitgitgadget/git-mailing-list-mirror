From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 16:02:31 +0700
Message-ID: <CACsJy8AAQJhX+b1UUhVxC_vV_4r=XjDSbtDDd5MLkgwKri8dEg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:03:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aucQL-0007L6-3L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 11:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbcDYJDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 05:03:06 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36840 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbcDYJDC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 05:03:02 -0400
Received: by mail-lf0-f43.google.com with SMTP id u64so12443704lff.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2oZJhHUjVXu3ew+S+prwKyCoR2X5f5vozp7yyt5gJ4=;
        b=b3xXr2S4lLnB495zOYIt+Kyb7MCun7oqYSLIjbqjE9bYY8EHaGv1e8FPkcuxh9ZAkd
         hB7BoFMweLYU24z9z0bdkyqvasxIDeORCetmiv/7PxfTmqUIr9irGHEuzC2cESjcrBCh
         nwyNdEAxXyGMctuffO3DF7rByztir78c9qXy9mY5qud0Z0rVtRY97/3cfRZGRUohDl7t
         AKEoZLSzEyZ2DhF6kK7PNncqqC7uJ9gfBqet0eh+HTLYg61t0opSUWQnYeVx43i4mE5E
         2vFweKvZrk+7gzNFjC2uVDMrwtakOcaK/RdjMa9YbIqIqGjvKmDPX/ZindaLTlzpipll
         z8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2oZJhHUjVXu3ew+S+prwKyCoR2X5f5vozp7yyt5gJ4=;
        b=l5SfZrB+1QyUOwtqnIxhSWXuy6iflAjRg99hf3lgB4rfkmekhWpRVD8N0JuM6g9xDi
         UdLJ/O8B5hOyZjrtNVcHsbSZW3hPS1wDmUdM3ZB+BGUKHL6Oi8QHh1sEm+UO7OdljtNi
         cAa4I/WXaZnX9Wr33EIC3Zad8WOCdBpLsDMmSw41JuH7Bb1W3a/CJcJwRHq9WbnovVCQ
         2GCga+4aMrGWXyMlCrSA0kI1MK4mc3TJN51XO5KiLTnFc2HqLAUfdHuOfhvhat3XuoPg
         BH4Hv7OGMYNizGJfytOxHyYicvyOoXAuRf+OW1iHCMTTDyOUyCoYh/fqGzEqtj9HPCbu
         AdtQ==
X-Gm-Message-State: AOPr4FWIaaJb0uWkcxw+J0rUIRqScP2frL9zuAEFA9KHxABCFwuYQyDNenf0sMn7VCZj2Y/A7NCdQBy5yXRM7w==
X-Received: by 10.25.23.155 with SMTP id 27mr9210295lfx.3.1461574981190; Mon,
 25 Apr 2016 02:03:01 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 02:02:31 -0700 (PDT)
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292460>

On Sun, Apr 24, 2016 at 8:33 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Sorry if this patch series is a bit long. I can split it into two or
> more series if it is prefered.

I suspect you deliberately made the series long just to show off how
good new git-rebase is ;-)

> Performance numbers:
>
>   - A few days ago =C3=86var did a huge many-hundred commit rebase on=
 the
>     kernel with untracked cache.
>
> command: git rebase --onto 1993b17 52bef0c 29dde7c
>
> Vanilla "next" without split index:                1m54.953s
> Vanilla "next" with split index:                   1m22.476s
> This series on top of "next" without split index:  1m12.034s
> This series on top of "next" with split index:     0m15.678s

I was a bit puzzled why split-index helped so much. It shouldn't have
in my opinion unless you paired it with index-helper, to cut down both
read and write time. So I ran some tests. Long story short, I think we
can achieve this gain (and a little more) even without split-index.

I ran my measurement patch [1] with and without your series used this
series as rebase material. Without the series, the picture is not so
surprising. We run git-apply 80+ times, each consists of this sequence

read index
write index (cache tree updates only)
read index again
optionally initialize name hash (when new entries are added, I guess)
read packed-refs
write index

With this series, we run a single git-apply which does

read index (and sharedindex too if in split-index mode)
initialize name hash
write index 80+ times

This explains why I guessed it wrong: when you write only, not read
back, of course index-helper is not required. And with split-index you
only write as many entries as you touch (which is usually a small
number compared to worktree's size), so writing 80+ times with
split-index is a lot faster than write 80+ times with whole index.

But why write so many times when nobody reads it? We only need to
write before git-apply exits, either after successfully applying the
whole series, or after it stops at conflicts, and maybe even at die()
and SIGINT. Yes if git-apply segfaults, then the index update is lost,
but in such a case, it's usually a good idea to restart fresh anyway.
When you only write index once (or twice) it won't matter if
split-index is used.

[1] http://article.gmane.org/gmane.comp.version-control.git/292001
--=20
Duy
