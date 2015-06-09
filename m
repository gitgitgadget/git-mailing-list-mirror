From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 5/6] am --abort: support aborting to unborn branch
Date: Tue, 9 Jun 2015 17:18:14 +0800
Message-ID: <CACRoPnQft7p1QrVwYaKcBnyoAkZLm0uOaf84E+jrdDUb8myweg@mail.gmail.com>
References: <1433591172-27077-1-git-send-email-pyokagan@gmail.com>
	<1433591172-27077-6-git-send-email-pyokagan@gmail.com>
	<xmqq8ubu9d1a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 11:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Fg8-0000Qs-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 11:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbbFIJSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 05:18:22 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36726 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907AbbFIJSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 05:18:16 -0400
Received: by laar3 with SMTP id r3so7565148laa.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D91NX1FH6KAZml5/NNhtl7BUM/jZfbWKNKxHThhN1B0=;
        b=0LIEl8iil8kr4G9ZeKsIQSGG53XMiRHaA//ksL/BuYr7OMJUJCvf+cUzqvKoVbG3jz
         kHhG3y0CAEbCb38Eb9DxtteNYOQIWqG5gqmFNVh6rK/OkbNY9SvoSLvLiFRHNvGofM/F
         SZux/AfoO4rzFq5Dyb/bWyml5bnBa0bqW7dWLVRXCRvk5gwnBrIk4+tXJhRbd1/lJcOK
         De3vWkw+PiorN4KcF/GVq77s/8rs4Ipn0l/DyS5OKC3PMkS0CsPH1x1cXc7RWozzmeeC
         /CIyaAZqa/xK9LiJfifuXlQ/9jKjlt0BC+Pv2tKt2NIXudzZYyG0/F0Jv6ZlhHL4VYIK
         S/Rg==
X-Received: by 10.112.42.16 with SMTP id j16mr20988708lbl.98.1433841494958;
 Tue, 09 Jun 2015 02:18:14 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 9 Jun 2015 02:18:14 -0700 (PDT)
In-Reply-To: <xmqq8ubu9d1a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271156>

On Tue, Jun 9, 2015 at 4:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> When git-am is first run on an unborn branch, no ORIG_HEAD is created.
>> As such, any applied commits will remain even after a git am --abort.
>
> I think this answered my question on 4/6; that may indicate that
> these two are either done in a wrong order or perhaps should be a
> single change.

Ah right, patch 4/6 was too sneaky in that it tried to do the "support
unborn branch" thing as well, which should only be handled in this
patch.

I still think the patches should be separate though since they are
conceptually different. 4/6 modifies the "index clean up" function,
while 5/6 modifies the "reset HEAD" function.

Thanks,
Paul
