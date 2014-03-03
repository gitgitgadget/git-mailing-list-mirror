From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Place cache.h at the first place to match general rule
Date: Mon, 3 Mar 2014 02:44:09 -0500
Message-ID: <CAPig+cRPjf4vCsPzOSoe+exw4o5rN_W=N7N0k5=rj=J9xsYSeQ@mail.gmail.com>
References: <1393749101-14985-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:44:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNXr-0006lZ-A3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbaCCHoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:44:11 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33647 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaCCHoK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:44:10 -0500
Received: by mail-yh0-f49.google.com with SMTP id z6so3203424yhz.22
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 23:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5W79r9H1PDnB4wyGb9ey3E2YwVU0bcOenM1216WbXjM=;
        b=Bo9j+VdMDvBvHaW61RNc7/vNPrVMKGt0m8XIvoWT5VOSs6r56PFVQRL/hpgk1HNkfQ
         t3lklES5cL31+2o/ROmNQ6JFFSEMvJa6TPySja1TalUJsBSDdGaH0SLjGbNmPsX5Z5Ek
         WCsj5Q8CofMrCw4Ymg57owZtOwrx+uxu+0vTJsuPbGfd5JWcsay0sShVjejmvfj3NLBp
         vFj2XmUss/v2n2zcXfOgH1OMJAff+vNcmS916u1Akdvl1yMnjMnKF49Bd1AfKYpy1dOP
         UfoQLP7GMCbmOhy0QpA0YSLCRKVP5pv1deJ5YHcO7E6T0ezAZJllY4/VGSMyz4NrFREn
         7wyA==
X-Received: by 10.236.231.101 with SMTP id k95mr20155471yhq.34.1393832649374;
 Sun, 02 Mar 2014 23:44:09 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 23:44:09 -0800 (PST)
In-Reply-To: <1393749101-14985-1-git-send-email-sunheehnus@gmail.com>
X-Google-Sender-Auth: s7mkvTkDlTrpjBZ4whXxXE9tkOs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243193>

On Sun, Mar 2, 2014 at 3:31 AM, Sun He <sunheehnus@gmail.com> wrote:
>  The general rule is if cache.h or git-compat-util.h is included,
>  it is the first #include.
>  As builtin.h starts with git-compat-util.h, files that start with builtin.h
>  are not changed.

Minor: Odd one-space indentation on each line of commit message.

> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
>  "PATCH v3" fix the position of information I want to convey to readers,
>  with the directions of Eric Sunshine.
>
>  sigchain.c and test-sigchain.c are started with "sigchain.h"
>  I checked sigchain.h, and it didn't import any bug.
>  But to keep consistant with general rule, we should take this patch.
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
>
