From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Thu, 21 Mar 2013 01:55:27 +0530
Message-ID: <CALkWK0mgX40oicqxnoa7M3NJP_k8jDrg7mVGyWrg5T+=iRtHQA@mail.gmail.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
 <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPaS-0006qy-04
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844Ab3CTUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:25:48 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:37552 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3CTUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:25:48 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so2383736iee.25
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tV4ejb8wEj66n+2qWWUx2gOHaMrJuoiOtKpHHOgup6Y=;
        b=vUgRXSVvn5RNHAJ7Dp/yk7gNPEPLrAM3AOpLI8u0lDJgjSIjuqtY4Odfun4mb+TCU6
         NQReLJSJReV0aXD/lg4vKVVqJ1mqEQc6cPg5daAHHvyYd5lH8DIZdk+MwKcX4UgwK7xz
         DzmzR2MRxQZOvOk7cBk3jvGEuNAwqp4kIHBIdiw8a76WabOkxqmOxj9xLJgxX/EREPSY
         8iJ9Fm7u2S93kEg9bLn2KhOxcA0laU6I9RTVwZ5XOZbbkrVXLC0s2mK7WMLoTw+mllrK
         HL663Ni0vdIkeAMg4Z/R0PB6AzaInMSNqNc3TgOTjVmuvdhKUtDHgH6lmJj/k+hQoWqk
         vTiA==
X-Received: by 10.50.17.201 with SMTP id q9mr209883igd.107.1363811147737; Wed,
 20 Mar 2013 13:25:47 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 13:25:27 -0700 (PDT)
In-Reply-To: <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218675>

Andrew Wong wrote:
> On 3/19/13, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>> I know that this is expected behavior, but is there an easy way to get
>> rid of this inconsistency?
>
> You can actually rely on "rebase" to run the appropriate command.

Didn't Junio explicitly mention that this is undesirable earlier (from
the point of view of `rebase -i` design)?  The printed advice too,
says that you should use `commit --amend` to finish the job before
invoking --continue.  Also IIRC, we don't allow --continue after
staging changes in the sequencer.
