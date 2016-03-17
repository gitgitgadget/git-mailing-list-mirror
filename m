From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] index-helper: add Windows support
Date: Thu, 17 Mar 2016 19:59:10 +0700
Message-ID: <CACsJy8BimGG6nVV2kMPG5vJqVTt2mXEtoKv_nKB4LRsVvdF1NA@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-10-git-send-email-dturner@twopensource.com>
 <CACsJy8DSORe6chXkufJB8ZYxi0kG6dUUbW_Spb=60bcxETasLQ@mail.gmail.com> <alpine.DEB.2.20.1603171309301.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 13:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXWl-00048a-5X
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 13:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935877AbcCQM7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 08:59:43 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33009 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935577AbcCQM7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 08:59:42 -0400
Received: by mail-lb0-f176.google.com with SMTP id oe12so68071725lbc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pjbhy7wE7wBFECwM5kzMRZgKcSo54+O+5yVScTEr5wo=;
        b=lNNC5Np1WY2MCUxEkdKhaWYCU5hc7eGF1felyeMFbVJSLXau9PSXzgT5zih/2sLBKS
         DeoS5lIfuksCskpVTyF1jzWZHY+XWfYrFNQvn0sST64exPN9egZtmWNhMZksO/rxKcmT
         nSj/GlB7Bg6q2itNxF9FhRwCdChXpHwrl0SqhnVpYEjrWgRBBIjkTHqugM62L+gwLEJA
         Mlm9wORWkc62WaLK/enw9da1Zr9B5Ui3PIRNmPZdyWFzV0rwDlvuB1nnT4WyRbYYlelW
         b95cGakoSMsnuAHg48rqa7s1YA4amIesWBccPkBEVAw5C1VoNQreoNpE6vAftE3CaMCq
         rKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pjbhy7wE7wBFECwM5kzMRZgKcSo54+O+5yVScTEr5wo=;
        b=Arg8guMfoKaDaUa2FxzfmyH9NY75m6WlVpbiI6ZGwS88U1foi0zTcRWw3A4tJXsWWD
         Y2EZodVmHbhYExelaLHaCoQIG6QRWnZGJIHV/M9t10VT/DWgHvYC7Le64Fpc2WbuKTfi
         TL/eSuLhdkXKtPATEY9zTUCHq6DqmhtX6USQpad1roeTpxv+0bG0Nu2z5A3u4Fh2UMrG
         vZf6qt40Y4Z2kEP3sSOF4V7p0E3M5OuEDpJNCJJCRjGzHdkMHB0rQA0C9VdXBFDpM666
         G1M4UqK5BWuDvCm0L/x03JN5fyHW638d41MIFndagyswSUZP0cnf5TgWnFQxt9tR8/na
         /aSQ==
X-Gm-Message-State: AD7BkJL+dBuOUN1FhnuHz61+meXtCbNnWlSFx3Uw8bUGz5PJBqAYXYHQ6urrc8EG8PSJ7tCU60zpmycshOIr3w==
X-Received: by 10.112.209.99 with SMTP id ml3mr3500862lbc.26.1458219580409;
 Thu, 17 Mar 2016 05:59:40 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 05:59:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171309301.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289106>

On Thu, Mar 17, 2016 at 7:18 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Please note that there is one very important difference between Windows vs
> Linux when it comes to shared memory: on Windows, the memory is released
> as soon as the last user goes away.

I assume that can be taken care of without changing anything else
fundamentally, or you need to tell us now. I guess that by making
index-helper hold the shared memory all the time, we can avoid that.
You may also want to check if my solution for the lack of ftruncate on
Windows shm is correct.
-- 
Duy
