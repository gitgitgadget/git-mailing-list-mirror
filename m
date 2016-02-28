From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Sat, 27 Feb 2016 20:26:31 -0800
Message-ID: <CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com>
	<1455919074-5683-1-git-send-email-aidecoe@aidecoe.name>
	<xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com>
	<87fuwnd4u7.fsf@freja.aidecoe.name>
	<xmqqbn7aa522.fsf@gitster.mtv.corp.google.com>
	<877fhwd1g0.fsf@freja.aidecoe.name>
	<xmqqegc33oal.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com>
	<871t83cfi7.fsf@freja.aidecoe.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: =?UTF-8?B?QW1hZGV1c3ogxbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
X-From: git-owner@vger.kernel.org Sun Feb 28 05:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZswH-0000xy-3x
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 05:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992806AbcB1E0d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 23:26:33 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35776 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992798AbcB1E0c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Feb 2016 23:26:32 -0500
Received: by mail-ob0-f175.google.com with SMTP id dm2so108524278obb.2
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 20:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=PiFqSx0qS/dac1Q4PODwJVLRkeqqBWycfZH5srjvC9U=;
        b=OMn15k1JJKk0p02ixDwFBJyRmbHjfmTu6+ZipcJ3t57xQWwYzuSo0xmujVgMXIiFS7
         hLhbp992uYkt2D0sjnyqnz3IyXexaWqp4ugJXZlU1nvZQpWTPeugoDjtOs/wf2cQarBO
         MyRtDNVSzqsEl/P8+Il4VTp7X8OaFKmmiLpIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=PiFqSx0qS/dac1Q4PODwJVLRkeqqBWycfZH5srjvC9U=;
        b=DiMw/L9pp4g7/aXt2LYin2II/fYJXwROzUoZz5YFtNUu9Zt+/eV8q7iC1VPZW+QeJo
         6L+odpDdkbmij7mLvk4wV+zFUpGtwSEci1zoT4AqdMFN/9sOyPuH5MpHqa7RsCH3dvvX
         79WPCFP9ZKHP/CllPWJW9VB3IseZHUAOnP0aFkZ6DmXFYiicK37m5ae/ln+PZ0lx71MS
         vspk5bG3FASRn5NXC4mH6rfYR/b0sCZJKX0Xn2+hU2AHBMTgC7Z1X63nihbMKWd6Vjy8
         1VL5W9piNOBEiA45hC/yQs+W9gO/Kq2TTwDt/1kgHyD3w5tryUS/vKn/G3ebCyTJdvPt
         qIFw==
X-Gm-Message-State: AD7BkJIJaPKm1Pv5R9wSiF8a+PCjfYRD9WZpgvIlbUkPUzM8Dr9kiFFvavA/GfC+5kAWPQLwxLix6nPJ7mbE4Q==
X-Received: by 10.182.114.232 with SMTP id jj8mr6918485obb.19.1456633591437;
 Sat, 27 Feb 2016 20:26:31 -0800 (PST)
Received: by 10.202.172.132 with HTTP; Sat, 27 Feb 2016 20:26:31 -0800 (PST)
In-Reply-To: <871t83cfi7.fsf@freja.aidecoe.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287739>

On 23 February 2016 at 20:56, Amadeusz =C5=BBo=C5=82nowski <aidecoe@aid=
ecoe.name> wrote:
>
> To simplify things, why not just update ref during submit from bare
> repository? As you have pointed out, if user invokes submit in this
> context he/she actually wants to submit from bare repo and probably
> knows what he/she is doing - especially if he/she reads man page. (-:

Will it do something sensible if anything goes wrong?

I'm thinking about what happens if you submit and one of the commits
fails to go to P4 due to a merge conflict.

But I guess just doing an update-ref could be an OK thing to do.
Without actually trying it out for real though I can't be sure. It
might make sense to get some practical experience of how this works
out.

Luke
