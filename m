From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --pretty accepts incomplete pre-defined formats
Date: Wed, 6 Apr 2016 14:07:01 -0700
Message-ID: <CAPc5daVQwP2ZxpK6+57q+_EZLTU=CuHmcVT_VHmFH-KxrSKMog@mail.gmail.com>
References: <5704A925.9030506@gmail.com> <xmqqinzuzs3d.fsf@gitster.mtv.corp.google.com>
 <20160406210339.GA18799@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 23:07:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anufs-0003Sf-F8
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 23:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbcDFVHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 17:07:24 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35470 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbcDFVHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 17:07:21 -0400
Received: by mail-yw0-f194.google.com with SMTP id k197so4251955ywe.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=4l7m7m09VHPiW3jnLb0uK+2QhrDjydj/hhWHUmTz16s=;
        b=DkHF1cdLU9qNzegNAQtqE98NV8daO8Y0YYTk6Nfgl35fpRcdST/UOf/5tTaV6io3mn
         wF8U+TOu5/2Tior/KATcAgfXx8eMyTRliQrXpfVRf8874c11Ntz978WgRVNhSgJekCAc
         u/jp45mpdwPTNPCvBfYKxGL7XzbxoIiCjCPRgiJCyUR0SufPlBiCuJcwtr2I9JOstp+b
         din7v6UCrQjjsKk8KOsBKwFzUUXRlXs4IWTyr/0S+PaJsDGTmrHj2ehzbR0VzswMhN6Z
         i9Rc5KND1EbhuMHU07ys4032qFzX8vLw/qRSKLpgN0JNCOezf8NebsNta67hf0xY4UbC
         y67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=4l7m7m09VHPiW3jnLb0uK+2QhrDjydj/hhWHUmTz16s=;
        b=Uk5z8j4ySjqfn61gHet3xEoJsv1VJnqX2gM/yXRC4PCfQ6rCNH1Hz5K1tiBw6XAhdR
         5Mk4EeHes/tBnl28+25dpC1zoFHhK9Ctsi+Wcr8nyXyeLRsul2LAgMA8A+tlCVa91N0R
         z0U8PeI4p5xVwgsbvuXGSWnGNvYWgHHVc8P8QSuLn9pIJ/KzwDhiuvCqJhY6Zg/+je+u
         hVFKpz1lVA8Xblw/5E5OzctpUl6P+eCepiFxSAyC0CFBJhB48MBqXS8t3Y+fh3wJh6c8
         A7ZlC8Pc8TcoFkGsjLOBWLtdR4YYszD/NjXN5RVGffSpFRtS9Cj8682kzopa1PJj3z6d
         e3JA==
X-Gm-Message-State: AD7BkJKSgHze4Umg1IjcwQ6RsyRWif2JxUfdo1Q/VdRa1gMbYNDxTqZM3BoeRDS549PeDV9mMkWLfJdtil2Mrw==
X-Received: by 10.37.31.87 with SMTP id f84mr25225121ybf.151.1459976840731;
 Wed, 06 Apr 2016 14:07:20 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Wed, 6 Apr 2016 14:07:01 -0700 (PDT)
In-Reply-To: <20160406210339.GA18799@dcvr.yhbt.net>
X-Google-Sender-Auth: J0I5Qx8FjLfrtMYWjW-4dGQ8Ceg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290869>

On Wed, Apr 6, 2016 at 2:03 PM, Eric Wong <normalperson@yhbt.net> wrote:
>> which was slightly tightend by aacd404e (Fix some
>> documentation typos and grammar, 2007-02-02).
>
> Huh?

Huh indeed.

b6936205 (Disallow invalid --pretty= abbreviations, 2007-02-02)

was what I meant to name.
