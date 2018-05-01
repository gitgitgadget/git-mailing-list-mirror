Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA971FADF
	for <e@80x24.org>; Tue,  1 May 2018 21:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeEAVnC (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 17:43:02 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45031 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEAVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 17:43:02 -0400
Received: by mail-qk0-f195.google.com with SMTP id z8so9791451qki.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0d0A+TUSrv4hosbZDcdXBVZn/87hhXd124cG/OkA7BQ=;
        b=Azy+VsmH1Yn8UzloHYGKHPPcZHvYHQUPiFQEB0G/cvk1rEb+Qs14FVC5z6/PAaWGBk
         EIHp4teGxGlQs+tcwY1D/INsJDFhqgVdsUYG2uJQyDmDg9cMGZ1Ys6SNpLimOsu3Yodf
         HoyW0WVHh83uFLkdRdKe1gS9BB3DHf52FFIlH3zxubCQu/gwc3t9UQZGwU+K02WLfVt7
         /HB6uwxKjnZxewma5o/lft18/WI2QyhDP9lEaD4bl/lkcVVggDJMtyIcmT0yKfHV4Vnk
         i9svCv6Cubj+PbNrlEVC9/mvwh6dK5TFWZje3m6sTpE2J84WeOJpnIGpmYo1zfd3oBXz
         b5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0d0A+TUSrv4hosbZDcdXBVZn/87hhXd124cG/OkA7BQ=;
        b=RzjCAXFWz5U0XMv9wgInmzfdTnyI8x34WKjPGW4dyIwVmxM8Vmy3URdrGiVJxVFVfo
         Gy2oT82oiwrcZ+LznVeO45ZJoIEgt4VIZK09RtVfTSW/PjDjFc8uQGPpWfR5voqf1AoD
         I3ForGksul8c8m0ZMQ5OquHV4sTnm61nQh5i/AvcgVk5veo00ZNzQiXaDfDwYl+hhByA
         nvTWqy8gX6o8uHi8Tk2fETI4j/Tu4A64jHJHRfGxIe+osRAzOmOqTOumFjSvlM5Pnyzy
         GJDLZm1v0xHLzHdfk7+R30THzb99LY1cF0TSXv/aF2RYJY1M9sYjiHxm/ie2JyIhBZL8
         MDcw==
X-Gm-Message-State: ALQs6tAVycVVHts3NLRLX9QGb0M0Ae9I6ckxmK7zNtDZAv1sBNTIReb4
        w0Ao3mPcbi3b1VcYE8sodN8w8/vZ8Zx/fwonKYU=
X-Google-Smtp-Source: AB8JxZrbRZsnTjknAKOJFI5Sxnde5enUwBhUJEJRRZkVCRlHnxxiPpRX5U5PWN2DVjKZOiml1+zFSoLlk+xdiybjkv8=
X-Received: by 10.55.190.134 with SMTP id o128mr12970670qkf.141.1525210981344;
 Tue, 01 May 2018 14:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Tue, 1 May 2018 14:43:00 -0700 (PDT)
In-Reply-To: <20180501213403.14643-3-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-3-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 1 May 2018 17:43:00 -0400
X-Google-Sender-Auth: X6w-8Bl-Lg_X1eO-K6C2z4Bf3X0
Message-ID: <CAPig+cSYxib5NEGM+J9RZ=v6GbaMf_0R2nWpfQWybrcn7bPOaw@mail.gmail.com>
Subject: Re: [PATCH 02/13] object: add repository argument to create_object
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 5:33 PM, Stefan Beller <sbeller@google.com> wrote:
> Add a repository argument to allow the callers of create_object
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.

This is only patch 2, and patch 1 did not use a macro trick to catch
callers passing the wrong argument.

> Add the cocci patch that converted the callers.

No cocci patch anywhere in sight.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
