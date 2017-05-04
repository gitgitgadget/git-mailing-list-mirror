Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D290207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbdEDW5b (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:57:31 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36291 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdEDW5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:57:30 -0400
Received: by mail-pf0-f175.google.com with SMTP id q66so14115536pfi.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u07/P7G4vPlJHOt4/p9TAsdPUcjAo8OGlJyg3J7fLmA=;
        b=sct0dxUhyUGbGUO6X0T3UoCoaPP/U5Ms8b7nd5Lr6mUsjM/sS4ZYYJaDqo7axJd4iq
         zpU/3gBfM0srsd7+zHSH6/ZLZLJMdNI7nAlPS1lyJ1oXsiOTtS0WB6xROzMp4dJzZw6t
         4jawne84uqXCtOs0jE5Odjy+gAAjIHGTYHL2JsHUNuJd6ZfnpKe0vGbi9jCE0GeQnMrQ
         PV6shXfHQSlF/G+in1i4M5ZqijPkx2uXzfFXD93z6mtDylxsVC47rzYyldLc5sEQ5Tvg
         FXIG3SIWS6K/+4DnNPAJoxWbEhu0WeQm12iQoQ4x5XRGhhAvh+yONLDCNOM9tZVcCAuj
         /42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u07/P7G4vPlJHOt4/p9TAsdPUcjAo8OGlJyg3J7fLmA=;
        b=XCL/RAaNiudg9uZkoiWtdhRX4ZVLQQLT7DejHyhYNSFgniPSSf7WMFl9+YiIa7nPT9
         Gntkb9U8CWN9p/FsnxccQDbSl23kgHhov13/TXk5QWuuxMKvWxvHNvEpXgdQboRZyBJc
         1aYcE1d9QurY+uJsQgYP+X1N3zl5K9yJkj1E5WF8atsizDoSuk5LTJUIbKR13vBoxkcm
         fbRo2WqRbXVmKPFXlTnetjC7HznlPmfpZmgvTjGvynlA78FfYw1Wfps+wKko6Xs8Ct57
         GJ3vhGxIz86rot+iTC+maFmR1A2wmuRAhH0FMAGsbFXgGQ53vbecaCH3RYMmsNW2QZId
         tjGg==
X-Gm-Message-State: AN3rC/4+01JvivRtbwr0eJdvwuWYnBvxm//nJ1W8azQ7JGdTSNiKpiG8
        KSZwT1ezK89zj5NoSftNz8WE1sWH4QMJ
X-Received: by 10.98.213.194 with SMTP id d185mr13370558pfg.35.1493938649780;
 Thu, 04 May 2017 15:57:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 4 May 2017 15:57:29 -0700 (PDT)
In-Reply-To: <b8f1dab4-896f-c9ad-7a89-87aacb2c3e61@gmail.com>
References: <b8f1dab4-896f-c9ad-7a89-87aacb2c3e61@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 4 May 2017 15:57:29 -0700
Message-ID: <CAGZ79ka66czcGpNGWFEQ=2Qf7OJgH7A-O+R860P=usiFWV4RBA@mail.gmail.com>
Subject: Re: Delta compression hooks
To:     "Soni L." <fakedme+git@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 3:48 PM, Soni L. <fakedme+git@gmail.com> wrote:
> Can we get delta compression hooks? I'm working with voxel data as my source
> code (it's a long story...) and git doesn't handle changing lines of voxels
> very well.
>
> Example, I have something from position (0,0,0) to position (0,10,0) and I
> replace it with something else. Git doesn't handle this difference very well
> if the file is encoded in XYZ order (it'd handle it exceptionally well if
> the file was in YXZ or YZX order), and Z-order curves aren't much better.
> It's even worse if the file is compressed.

Maybe look into smudge filters to store the data in a different format
inside Git
than what is in the working tree.

https://git-scm.com/docs/gitattributes
