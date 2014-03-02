From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Place cache.h at the first place to match general rule
Date: Sat, 1 Mar 2014 23:34:28 -0500
Message-ID: <CAPig+cRAni1m2xReUvFkx1muvzTLGo1PF8iTuQdXUzLn3yXNkg@mail.gmail.com>
References: <1393726697-2816-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	psclouds@gmail.com
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 05:34:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJy6n-0007AS-NW
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 05:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbaCBEea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 23:34:30 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:58048 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaCBEe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 23:34:29 -0500
Received: by mail-yh0-f54.google.com with SMTP id c41so2450614yho.13
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 20:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=15Vl24XNZwoq29RNgpx2dTKtTBggxqyloHH6CnFxztE=;
        b=yKaLjO1hHpFGNhfdjM8qMbU079dQWDSOOvV3FNN3KUJMJdY7J74pqZ1/9EaRRai4ov
         GgBs/+GlSv5xfSPU79koD92pr4TQlTFtU1M90LGvh5HjxR/CtSSKTDpAe9TPvsNjVAKh
         xFXEdYoOJw23L02UpZ6VNRuwY+0ZUfoDG+TkLt4Bo3nsS45+Tzv+5/atVLQ9wQhGio2Y
         MvXrPdi9k6TL1KiG/B2vtlDODeCIxXDHKq7V+myE/fj4YGOsktht+DQk7ZqlGW680fCb
         EqcdYGqDDmwWHOJFXB4B6Of5n5rpVH+h51Q9VhP8iUlUI7Y2vPqOXhyTroCiTUZNnh+P
         yQng==
X-Received: by 10.236.136.231 with SMTP id w67mr12232861yhi.53.1393734868635;
 Sat, 01 Mar 2014 20:34:28 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 20:34:28 -0800 (PST)
In-Reply-To: <1393726697-2816-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: b1qh2CiY5Vw0Sg9LxkDjd9dP_kI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243130>

On Sat, Mar 1, 2014 at 9:18 PM, Sun He <sunheehnus@gmail.com> wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>

Footers should follow a temporal order. For instance:

1. Duy helped you.
2. You revised your patch based upon his input.
3. You signed off before submitting the patch.

Hence, your Signed-off-by: should follow Helped-by:.

> ---
>  "PATCH v2" Fix the spelling bug of general in subject as is suggested
>  by brain m.calson <sandals@crustytoothpaste.net>

There are two type of information you want to convey to readers:

1. Explanation and justification of the change itself. This is
recorded for all time in the project history as the commit message. It
is placed above the "---" line.

2. Commentary related to this version / submission of the patch which
is not likely to be helpful or meaningful to people reading the
"official" project history via the commit messages. It is placed below
the "---" line.

Explaining what you changed since the previous version of the patch,
as you do above, is a good thing. It's not meaningful once the patch
is officially accepted into the project; it's only meaningful to
people following the progression of the patch on the mailing list, so
it definitely belongs below the "---" line, as you did here.

However...

>  The general rule is if cache.h or git-compat-util.h is included,
>  it is the first #include.

This information explains the patch's purpose, thus it is relevant to
the project history. It belongs above the "---" line.

>  I parsed all the source files, and find many files start with builtin.h.
>  And git-compat-util.h is the first in it. So they don't need any change.

This could go either way. It tells how you arrived at this version of
the patch (relevant below "---"), but also explains why the patch does
not have to touch additional files (relevant above "---"). It's
probably okay to leave it below "---".

>  sigchain.c and test-sigchain.c are started with "sigchain.h"
>  I checked sigchain.h, and it didn't import any bug.
>  But to keep consistant with general rule, we should take this patch.

Commentary suitable for below "---".

>  Thanks.
>
>  sigchain.c      | 2 +-
>  test-sigchain.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sigchain.c b/sigchain.c
> index 1118b99..faa375d 100644
> --- a/sigchain.c
> +++ b/sigchain.c
> @@ -1,5 +1,5 @@
> -#include "sigchain.h"
>  #include "cache.h"
> +#include "sigchain.h"
>
>  #define SIGCHAIN_MAX_SIGNALS 32
>
> diff --git a/test-sigchain.c b/test-sigchain.c
> index 42db234..e499fce 100644
> --- a/test-sigchain.c
> +++ b/test-sigchain.c
> @@ -1,5 +1,5 @@
> -#include "sigchain.h"
>  #include "cache.h"
> +#include "sigchain.h"
>
>  #define X(f) \
>  static void f(int sig) { \
> --
> 1.9.0.138.g2de3478.dirty
