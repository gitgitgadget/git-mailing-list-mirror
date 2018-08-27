Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BDD31F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeH0Ve4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:34:56 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34265 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH0Vez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:34:55 -0400
Received: by mail-ed1-f44.google.com with SMTP id h1-v6so11075314eds.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2G3h/s9A4Ksmdhg2xZ5NGnqqpiXtLW2pqCot9aq15Dw=;
        b=mmsQyrAm2bJpESEZg9JDUfEl0ybQjJ5IWh8Jxfs5ojPSR14pz0GetV6tPl184UsHsc
         4VKZlkFOiVztUiJgwXZrTQXYsoa0oc+L5N6XTyLINzOjvkaXgd2hk1BQB6bCaszsHQCR
         mYmbXZOdgYALkPFNsesNaPJuN204hLcd8GU4UN/ADTAvXgRL+UxJbUkHw9hjU3KKCH/k
         /qlzl7dj095eEgFxo8F6nYBBs64ivRMVgyzFO3ScQas/o+NueEP6iCEAyiYXzfsC289G
         MCxeq5JTeJic5vcxm/hTQVoKhyA2JfddcajRoioDSq0OkZ/UAi3g2XpJZn+vOeV4Vs5H
         VXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2G3h/s9A4Ksmdhg2xZ5NGnqqpiXtLW2pqCot9aq15Dw=;
        b=aAGH7dZfeLOnbbV46kMqjBaakkv+24b2/6ehXRdApK9xVkj971XjAMLSI/tviAcrBm
         6V3egFpOcWqkcKxyplveyzOC1iQY36raHbnAyjrGE4lkCBJn8dq1Sdh6TFhK+rHag9x6
         dR76DhTqBIEGTaZjyXDfRqHlbiqvXAL0jZpaGqxF5zApflV/YtGdGxbUC18RIjTFEO4E
         87zrGz6XXVRFAzkrSuIRP22cqupVGnHEDPmZW3CHdiP9RkIAeZEzAOGydm4W6w2kzOQO
         Oc3wV2DoV1ThRL4BhMZz1Wtm5TNYra/+Qck/z2m1E5XlAE7ST5D7IcLsPjd0CNR/8AZq
         kx+A==
X-Gm-Message-State: APzg51BkxrA+6Csgbp6XGb6t9fV8tjfFhgwPjKm8ysvHrT89lzR6ap7v
        G5QbqwK1Gf9PhvOafGn2iCJ+aEKPlkbfX+FbBlL8zw==
X-Google-Smtp-Source: ANB0VdZMqXu0Fk1iqWdb8OYH+u+fDUsfj1i1ur3Sw5nvZzHh+ZEWmn6lAnMTgpElguHyTEfEud3Td2wMdy4pWhb6uOA=
X-Received: by 2002:a50:d083:: with SMTP id v3-v6mr17889817edd.243.1535392040742;
 Mon, 27 Aug 2018 10:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
In-Reply-To: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 27 Aug 2018 10:47:09 -0700
Message-ID: <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
Subject: Re: Possible bug: identical lines added/removed in git diff
To:     gthepiper@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 26, 2018 at 6:54 PM Gabriel Holodak <gthepiper@gmail.com> wrote:
>
> I think I'm running into a bug with git diff on v2.18.0.

I cannot reproduce with the two files attached.

I suspected you might have a different diff algorithm configured,
so I tested
    git diff --no-index old new
    git diff --patience --no-index old new
    git diff --histogram --no-index old new

all of which do not reproduce the issue.

Are there any encoding issues locally (Which platform
are you on?) or in transit (Could you re-download the files
from [1] and confirm it still produces this bug?)

[1] https://public-inbox.org/git/CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com/


> where the "DWIDTH 8 0" and "BITMAP" lines are removed and added,
> despite being identical. It only seems to be happening around this
> section of the file, for the U+00F0 character. This also seems close
> to a minimal reproduction of the issue.

Could you cut down to a real minimal reproduction, i.e. just these 20
lines or so?

>  If I git add --patch and stage
> a few hunks, then the duplicated lines seem to disappear.

Do you have any smudge filters or configuration regarding
line endings?

Are the lines really different or the same ? (Can you inspect with a
hex editor, maybe there are different kinds of invisible white spaces?)

> Steps to reproduce:
> git diff --no-index unitera_bold_italic.bdf.old unitera_bold_italic.bdf.new
> (It also happens inside a repo, this just seemed the easiest way to
> demonstrate.)

Thanks,
Stefan
