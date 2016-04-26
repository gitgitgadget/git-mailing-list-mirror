From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Tue, 26 Apr 2016 10:21:25 -0700
Message-ID: <CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:21:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6fz-0002Mj-Av
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbcDZRV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:21:27 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34348 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbcDZRV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:21:26 -0400
Received: by mail-io0-f181.google.com with SMTP id 190so16835279iow.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gwp6cfaxBWNx2OG47zQ9jzayKxPr8Nwzaj59OWEDJec=;
        b=QDp9m7XRfSaOCR/euAyZb70iDXo+USyEoM78nnL9iEymrmIW1L2KlPi1h3o3hLMuhf
         muvDrQ1n8PlEbukAPxPvDpsQwheUZjR6m4srxt4MIP8cepE91YlX/xy3oE6RzxFxhhim
         hARXZUn66h/+waqt15uZAhaWWPWtxSbtyqOUYbp7g4SjHD+gav5mb5R3RmYmq87USdRG
         kpj+RAdU0R7lckdku+k6QbApBtJxtfhYSmRra7XaRozYp2B3+AsKVGcwAKD6hsgsR0fZ
         GtThSVUFkot8ehauQId3yMO9sYmoktpHbp5MJWEF/wKz2aXg5RJrWrNa3A1zm5aNJM6h
         24qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gwp6cfaxBWNx2OG47zQ9jzayKxPr8Nwzaj59OWEDJec=;
        b=kj50H+Ftlp7GSQFbFEYxRbin3EBUMbsFRf2150PARJIHGBRitm2YsVl6AYKHfsgPx8
         betCXUGLmqeb5QJVdWEUtQshs8dq7ZTfJRC/OejNOU4rECE+xqLkthCYm1e+CnDUbXSb
         2TRl78a9UOWfgtSk2Tmw48xcPruvWu6g6KCG2vW/RS7puNyjGw93X7U2hWJqIKZvR1xZ
         3XoFhW0geVPrHFn9bfWY746Px8/3PUIVG2+uQK1FcgEJD+ybxwmZrDTbkL6Nu7UFIW6f
         9krb2qaPwgcaWwHeui+jeYFfeA+Km28HzzUZHTwq+TfgBPKJI0kmU6stDxZ2m5J7RkW1
         xJwg==
X-Gm-Message-State: AOPr4FVc5CSo5FAT/ZT8QfxfVQT6LNWWB5bSSqHVS/uExw0/znKHp/qx58wJdnPII52CoIPf6yAxLVLnw7Pk04Dz
X-Received: by 10.107.53.200 with SMTP id k69mr4810579ioo.174.1461691285451;
 Tue, 26 Apr 2016 10:21:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 10:21:25 -0700 (PDT)
In-Reply-To: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292622>

On Tue, Apr 26, 2016 at 12:51 AM, Xiaolong Ye <xiaolong.ye@intel.com> wrote:
> Thanks for Junio's reviews and suggestions.
>
> This version contains the following changes since v5:
>
>  - Fix a decl-after-statement in patch 3/4.
>
>  - Improve testcases to cover more scenarios and make them more portable and
>    readable.
>
> Thanks,
> Xiaolong
>

Thanks for this feature!

I am playing around with this series, and here comes a feature request:
I have a local branch with no upstream set. My usual workflow is like this

    git checkout origin/master
    # toy around, do stuff
    git checkout -b new-shiny-feature
    git format-patch origin-master..

Now I have set the format.useautobase option and then the `git format-patch`
fails with

    fatal: Failed to get upstream, if you want to record base commit
automatically,
    please use git branch --set-upstream-to to track a remote branch.
    Or you could specify base commit by --base=<base-commit-id> manually.

but as I indicated I want patches from origin/master onwards,
Could we make use of that information? To record the base in my workflow
currently I need to do:

    git format-patch origin/master.. --base=origin/master

which seems redundant to me.
(I may be holding it wrong though? Should I try to set upstream
branches for my local branches? This seems weird to me as I cannot
push/change the upstream branches directly, as Junio owns the branches)

Thanks,
Stefan
