Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF4AC433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 14:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiCMOBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 10:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiCMOBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 10:01:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D10784EF7
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:00:25 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z7so15400016iom.1
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NLJV3ck3wDeK0HGZLU2azGRP98nAzmFXL/5678c6d5I=;
        b=iBaQKdtKvBXxmuLjoJHrAY8fpMdPEWUlkQViwu8Sm5tbTpegvRmlfrtmw0YKPXl0jI
         FXLo1X431Fy2cFVnNbT6U0mYTFdriE4rRzA6rEdlUTLrMqPZEvVqRA4i3viJMyceIpbp
         yZYl5iks0MC/MLHewMX8JCx6g3SVJkeseLCflGiO55wIUBOlhtrFmFGxV0ATCw+YvGND
         yjqdgRn2tz6jQKJ5mFYPSf2SeBVCQt1wMlvI+bsvxbwrtlN9eVPmsJmVKxwQKYVHAkNu
         hQ1JJb/5dNWJ4KsrCP+8swSdbQjtHHnKVQof+XK2c/HvKSY4zsCNxCcGGxqNSIp7qBAi
         6EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NLJV3ck3wDeK0HGZLU2azGRP98nAzmFXL/5678c6d5I=;
        b=Lspcw+RyNqZxUMu+HKHtRs24CSBOmbY71IOQTYORLL4pDUhQ7zdFdY5o7HU5Kfexui
         2/v+KQjYe7VEka/HPRzB3XwvuEgDttsf2g6bxV0qnQFOXZSUxZU3II0IZqdK4ldLEzvx
         FN/zaE72jRW/ISq/k7TsbqdS+YNX6OIgnahdghixUDRwAdZ/kutaxT8Y6SSvTVe5a03a
         RhYVIOK8MbjzS9sh0d+F88XBwFAIUmWr7gABilA1Mbm1+3wzifpIdxNVIdV4WeDUoYqD
         Duue69k4ZA4MbaIsF1kIkUXv44ronA7HXLkBnEBPVTxyt1vRdsz1ZNlUAYKi0aWPkQNl
         KhiQ==
X-Gm-Message-State: AOAM532BLaf7SW9ECnC6i7thtZ12bo+tQjn/CuHCAre39UjXq/DAPTNN
        GyHEU2sracndwvkpu50+zYIHSJrw+uE=
X-Google-Smtp-Source: ABdhPJxqZTcko1W1Kf7cts1P8NROer1L9QszhHlWQ1d15gmAZBfvc1fmv7AxrvkbkRCoA6L5/3rJVw==
X-Received: by 2002:a05:6602:1491:b0:648:cd01:9ba9 with SMTP id a17-20020a056602149100b00648cd019ba9mr8745507iow.195.1647180024616;
        Sun, 13 Mar 2022 07:00:24 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id y11-20020a056e02174b00b002c70ba6426dsm5642707ill.66.2022.03.13.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 07:00:24 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com>
 <27b5bf20-2eb5-7873-4fdd-875aa699862c@iee.email>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 08:35:00 -0500
In-reply-to: <27b5bf20-2eb5-7873-4fdd-875aa699862c@iee.email>
Message-ID: <874k42ar61.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley <philipoakley@iee.email> writes:
> Do you already have a map of those personal name and email name changes
> that are causing conflicts, or are you hoping for a way of detecting
> such changes? If you already know which names produce conflicts you are
> more than half way there.
>
> If you do know of the name conflicts, (e.g. when `John Doe` changed to
> `Jane Doe2`, then acquired `Jane Doe`, before being put back to `Jane
> Doe2`), do you have dates for the change over to map into the commit
> dates (assuming no slop or author/committer date slip). At least with
> the change-over dates you can apply mapping during the history transfer.

Whether or not we have maintained such a list in real-time remains to be
seen, but we have been able to put together such a list using both SVN
history and a variety of other internal data sources.  It's worth noting
that, if we do have to use this generated mapping, a mapping of over 10k
entries is surely to have the odd mistake every now and then.  So it's
not *totally* trustworthy (and never could be).

> An alternate option is to simply stick with the fact that history is
> messy, and use internal corporate knowledge for the few case that cause
> the major issues. It some point it always gets to be a G=C3=B6del Grammar
> (needing another rule).

This is definitely on the table, though it seems a shame to not attempt
to use the information we've been able to compile.

--
Sean Allred
