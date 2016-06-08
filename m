From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/4] dir: introduce file_size() to check the size of file
Date: Wed, 8 Jun 2016 12:03:26 +0200
Message-ID: <CAP8UFD0PBDnn0MV0+vUJkS-Smazi6x0cfq4EJot8fDpG4RqH1g@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160607205454.22576-3-pranit.bauva@gmail.com> <CAPig+cTgnp3tm_S7ybDBiGfesw9mh3J4_OtEV7timnsgL0AGjA@mail.gmail.com>
 <CAFZEwPPWMdOahMP4f0=Lm_n+ZmEtGHg=zHaZAyQjSf9oL8X2ew@mail.gmail.com> <CAPig+cR8+ekOv3xuj1Nn9ftA5smHG78wdFp1Xnfz_qyrstKRqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAaKm-0000W2-QX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 12:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424409AbcFHKDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 06:03:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33472 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423826AbcFHKD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 06:03:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id r5so1662051wmr.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=62ttXxi3m/VZATwy6x0YVr8nfTvKuhmccKCKa2ckkhw=;
        b=C/Ry8g35HY/Se4x5HIrSWFy6lBDXt+7uVAPtBGOSp0FIWGSF8EDSmWsFerEhbv3wDw
         h51RQpR9IbVpVicAEOsag5EKUCPAie25IlbyUqxplDR2U3MiK+aBejDdYh+O3T4UArez
         3TnRcIrislEV4/JRebOgYy6rWSimCSTQg6/CKeS5c7XG2LZcvmK02Js3/91ig19n44dR
         lSGtXH12XVUVmD3KDdaRqkQos1DA+TW0NaebA8w82rStG4WN95tMPeY/OHUIW6WnAVzH
         1DJ/ar9Igdmb9GVKqZDczpBnnkxyN4DnKF5wE/e5RxyBctbD8fhAl0JM70HJsDxYngqo
         SiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=62ttXxi3m/VZATwy6x0YVr8nfTvKuhmccKCKa2ckkhw=;
        b=Pyt6plT4KE1xyrmITAnEZegAyVqJ9qZ4jzMKD7XEZlIBWxAKKUweMyKcrx4cbMFSEa
         R0EMwaqkupVuyPQM/9xOiTiImVp2EZo0fKrtfsw5B8LUkT/P3HxHujUd4BHyI0MtO/o4
         5C2eNOzc8gJDCB2vcisY3fzBaQVufYJGWYcJL2gWj1qmG9It4XaXUUkNYLcKKjt+oRtw
         g1lZB/9m39plnxE8Tcj0nOFsFhaGTRtO6zNKIlU/XiRl4tbg7uo434dJiDiB99uiDSLN
         Pq0FRJjh8+wKafrtmfUC9ZZAedVkmo6Zi2eCKzjBkhUc3Q04bwVfS3nG7+er8KQxAPcY
         hY0g==
X-Gm-Message-State: ALyK8tKegMRraeNKqjhJLLT1XfpWjaxhrOSYiCmzL2hD7DApyVJstjeYz3VLh0uCm2Zt/q5keAwK1C+1mymWTA==
X-Received: by 10.194.109.4 with SMTP id ho4mr3616416wjb.78.1465380207338;
 Wed, 08 Jun 2016 03:03:27 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 03:03:26 -0700 (PDT)
In-Reply-To: <CAPig+cR8+ekOv3xuj1Nn9ftA5smHG78wdFp1Xnfz_qyrstKRqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296780>

On Wed, Jun 8, 2016 at 10:13 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> I think this would be clearer if you instead added a function to
> bisect--helper.c which operates at a semantically higher level than
> what you have here (and drop this file_size() function). Specifically,
> add a function which tells you precisely what you want to know:
> whether the file exists and has non-zero size. For instance, in
> bisect--helper.c:
>
>     static int file_empty_or_missing(const char *path)
>     {
>         struct stat st;
>         return stat(...) < 0 || st.st_size == 0;
>     }
>
> Or, if you have more cases where you want to know that it exists with
> non-zero size, then name it file_non_empty() and reverse the sense of
> the return value.

After a quick grep it seemed to me that there are a few places were we
stat a file just to get its size, so I suggested the file_size()
because it could help refactor other parts of the code.
