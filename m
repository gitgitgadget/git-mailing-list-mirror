Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEEDC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 23:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiDRXqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 19:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiDRXqY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 19:46:24 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BA1B78F
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 16:43:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y85so6293554iof.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 16:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ieq3nCRhzRaWN3HfTpeAv1rqgNd2O4rztjRiUTAnrEc=;
        b=gJHQnpOI8Lm5UwfFevuXhUGgCThl8TNsEo7LR74tt+z+kfYxSlHqYACIa2UNBzct00
         K9ZhamykR+FSbAJDzvvY/PXyj+nG0+2tQv8Q3i7i1fGQ2Qu+ZjeCyba3l9+Zhl0t85b3
         ACh1+MQsYHu9SIfqJ3Kc0hIo+YR1vWpQqfUnX+j2X02RFql7UBrtVdMepB3UDkUHeSet
         g9GuMDj8kwyOoNC+JRHvOqJLgKTGKi3+IzrZdpVZgrGECXgt3T2fOKA6kA5NA7kEw8zt
         CIID/vS1xU0xIiwfeQo9gVD5ltmkdibfyW768eUjluEbTjL+nesRTij4dUCjY9dSP8VD
         vThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ieq3nCRhzRaWN3HfTpeAv1rqgNd2O4rztjRiUTAnrEc=;
        b=i5K0NPJK8/OfWJ0fQVYQ7HbSXzprXwADc6gB4fKcK654ikAdMW/XzLrVps2P2eajWf
         l7TlkgyhAXEAHyACDQl+YtNTmhhDQNvC6qPBSpnkRjNePZYSTzAIXCqWgTyc8OdBJ4KL
         OKIsTiqNR3YkkAyziWkdPFde/akrdJnHtdLUcGa0oDjB0P7k/d+VkcbHsAhV1PIiim6+
         wii6cObIW/1ohRP1S6zPEMsS9wObKm9Rt367eSORhCZDBcf5mH2Cc0JcNejPBGL4uyeC
         EFI9XfhpC1b3yXxjDX2jrx8iwzuc8e0XOVokNU6IHDz/3JmoTQKURSMID9BvzUe57Jc3
         pY9g==
X-Gm-Message-State: AOAM533Y3EhwaE3vOWLeFD6dVmMDPkvVVZurMivFQz+yRTw56M3vAacL
        /0FGU0a3nJpzyO+wbe7hFqpYx7IRgA/TazxB
X-Google-Smtp-Source: ABdhPJzUM+c9o7mbm2hQoZ9H/5aBxgQpVRYnYdC1SbOi7lZmDk0lJHUYLLM3ybXOk+jcNlboyPVNVg==
X-Received: by 2002:a05:6602:3281:b0:648:d45d:22e with SMTP id d1-20020a056602328100b00648d45d022emr5405128ioz.7.1650325423517;
        Mon, 18 Apr 2022 16:43:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i3-20020a056602134300b0064620a85b6dsm9449534iov.12.2022.04.18.16.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 16:43:43 -0700 (PDT)
Date:   Mon, 18 Apr 2022 19:43:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Dan Moore <dan@fusionauth.io>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <Yl33rojJkG1arkSQ@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local>
 <Ykt6lPF0JC1Mg2Tx@nand.local>
 <YlRHcHBrdyUPAu4z@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlRHcHBrdyUPAu4z@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 11, 2022 at 11:21:20AM -0400, Taylor Blau wrote:
> Any last objections? If I don't hear anything soon-ish, I'll work with
> Dan and Conservancy to set up the logistics and transition our Heroku
> billing off of our project funds.

I didn't hear any objections in the meantime, so I'll work with Dan and
the fine folks at Conservancy offline to set up the remaining logistics.

Dan: thank you (again!) very much for your generous offer.

Thanks,
Taylor
