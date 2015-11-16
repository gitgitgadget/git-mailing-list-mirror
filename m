From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 16 Nov 2015 10:15:24 -0800
Message-ID: <CAGZ79kacpWFFWiE-KjwEQZC+3PZw2MrpsgQWLJyS82X5LF+Lqw@mail.gmail.com>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 19:15:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyOJN-0004W7-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 19:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbbKPSPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 13:15:25 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34182 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbKPSPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 13:15:24 -0500
Received: by ykfs79 with SMTP id s79so254607866ykf.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ezFwGYa+b9+4ETspUoGhhs92Q2g05a9vjvsR1p3jlLU=;
        b=kuA5GsALxT6vx/zapLC2aSr2sqnMEjBdfmjBLM9Cgl/bvBmmFHdvjchxsfyV7LWM1M
         A3LOABULtnvlUO67Qw6yCH5NAVcSMjuvvNt1ZWvT78Qqw55NT11WE3fbTwvvWy85TdGG
         QoJvtJSfmHNSj+vJzWR/uQlSdzr7etdx02wOebxFi+cm3oLIxklOfWNBPNFlQupEg3XN
         R5NGSP4cZDxON1xo7hPhusoTfiaAtaFiz9R0g4bP1qBgUWLhljklxZhvS96/ffTmblKp
         yz1/5fLwxrcuEl4PB9sxL6y59Lf4Y8XOvwBhQOrPBQLCQiPi3mnE7iq6GRnbfjMpNIX9
         hLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ezFwGYa+b9+4ETspUoGhhs92Q2g05a9vjvsR1p3jlLU=;
        b=CvVLrqMMqmuL8TnjeJunxApvIzB/bDMP7mi9CY0z7i+yXrTdgw1EyBka2aDck0gJCd
         hDP3hMaRgN7vu/Y4/9UPd5E/xt0l5QBZGDSn4rAJtG7lv80DvSc3E62UxhSoXxmuypkS
         3rdzvyiSfjWC96IZXE6zB5rqzb0AxJn5u2beLRS5mB9Ua+McY1bMzKgeGrgDiTemLRaI
         QXDO76Xl2Ial7Y7uipNN752GAVHQViYNrXcWWoC2kwhlJXtSewInOkrv5zb8rOQeATcq
         wjblS86OF9SgEMDsWXh7z8zSnz9C5axTeRUGuEezD0KXYHqtktUCbo3I1YF2TD1yvHLf
         auNw==
X-Gm-Message-State: ALoCoQmGLy4TrjHcuo1Rg79EmNYbkscMPvRNl32F4xrx+yttopeWEWXn+ED2IQJkuEMmDmD5K8hs
X-Received: by 10.129.40.147 with SMTP id o141mr36775887ywo.199.1447697724247;
 Mon, 16 Nov 2015 10:15:24 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 16 Nov 2015 10:15:24 -0800 (PST)
In-Reply-To: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281349>

On Mon, Nov 16, 2015 at 5:24 AM, Mike Crowe <mac@mcrowe.com> wrote:
> The --recurse-submodules command line parameter has existed for some
> time but it has no config file equivalent.
>
> Following the style of the corresponding parameter for git fetch, let's
> invent push.recurseSubmodules to provide a default for this
> parameter. This also requires the addition of --recurse-submodules=no to
> allow the configuration to be overridden on the command line when
> required.
>
> The most straightforward way to implement this appears to be to make
> push use code in submodule-config in a similar way to fetch.
>
> Signed-off-by: Mike Crowe <mac@mcrowe.com>
> ---

The code itself looks good to me, one nit in the tests though.

> @@ -79,6 +87,119 @@ test_expect_success 'push succeeds after commit was pushed to remote' '
>         )
>  '
>
> +test_expect_success 'push succeeds if submodule commit not on remote but using on-demand on command line' '
> +       (
> +               cd work/gar/bage &&
> +               >recurse-on-demand-on-command-line &&
> +               git add recurse-on-demand-on-command-line &&
> +               git commit -m "Recurse on-demand on command line junk"
> +       ) &&
> +       (
> +               cd work &&
> +               git add gar/bage &&
> +               git commit -m "Recurse on-demand on command line for gar/bage" &&
> +               git push --recurse-submodules=on-demand ../pub.git master &&
> +               # Check that the supermodule commit got there
> +               git fetch ../pub.git &&
> +               git diff --quiet FETCH_HEAD master

Missing && chain here.

> +               # Check that the submodule commit got there too
> +               cd gar/bage &&
> +               git diff --quiet origin/master master
> +       )
> +'
> +
