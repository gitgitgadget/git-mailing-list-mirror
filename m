From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/8] Speed up cache loading time
Date: Tue, 13 May 2014 21:35:47 +0700
Message-ID: <CACsJy8C9caJam4ZO5GNMym-LRxSkss_06KHq-Ob3Qxz5xYqjxA@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <CALbm-EZEeFv=CX-TJJ3ZAUOxdBrqWfcJ_W-to20XAaB5=oZ0Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 16:36:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkDoc-0003VL-UH
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 16:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760526AbaEMOgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 10:36:19 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:48355 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759892AbaEMOgS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 10:36:18 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so500630qcy.36
        for <git@vger.kernel.org>; Tue, 13 May 2014 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lCS5ljrWB1b6iczgKxozSkSxPR2Ykk6E9IxE4ekwbkc=;
        b=R1XWU7+BMcNxPM1FXEq+SoFry3ENjXvoS6zG3qBm6n2gfTwwkYshi+CslZC2EgdJnl
         HBoMVmy1/+9ShHiyzEef4aCBUQ6gY0cSqp94LHyAAQ9h6z5DTG43SlYeBdB/gQKUDMQ9
         KNQhzeAUvh55PR5mKGVYcbKYI/7Izih3LqLQFuunaoVSCxKM09YP3O4FRo4q/yv01tBd
         FX5yvJp/rv3JC55umCjGpsu4CLS478MQkvf9w2Y1d1KTkp5JTKDns3L6GQ2rA6EzKzKd
         BEp0VpvzYRyU9hvfEa783QVh0qg7dVCZBfDVIqGNgYnO7hnzWjHFyk7niQKhiyLGyRKw
         5H3g==
X-Received: by 10.140.107.198 with SMTP id h64mr44879476qgf.30.1399991777660;
 Tue, 13 May 2014 07:36:17 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 13 May 2014 07:35:47 -0700 (PDT)
In-Reply-To: <CALbm-EZEeFv=CX-TJJ3ZAUOxdBrqWfcJ_W-to20XAaB5=oZ0Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248789>

On Tue, May 13, 2014 at 9:24 PM, Stefan Beller <stefanbeller@gmail.com> wrote:
>> That is clocked at 800 MHz. A repository at this size deserves a
>> better CPU. At 2.5 GHz we spend 183.228ms on loading the index. A
>> reasonable number to me. If we scale other parts of git-status as well
>> as this, we should be able to make "git status" within 1 or 2 seconds.
>>
>
> Which harddrive do you use? Traditional or SSDs?

Traditional

> Does have harddrive loading time significant impact here? (just a
> guess/question)

In the hot cache case, I assume the index stays in OS cache anyway so
hard drive should not impact much (the other parts of git-status like
index refresh or untracked file listing is a different story and some
may fall out of cache). My laptop has 4G ram, with my repeated tests,
I guess the index (even 200mb) stayed in the cache (but did not really
verify it).
-- 
Duy
