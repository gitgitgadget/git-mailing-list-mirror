From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"
Date: Thu, 25 Jun 2015 21:15:34 -0700
Message-ID: <CAPc5daUXw-ZUHrM+7Ff8-KOPFiPXLEKGZ3O4sPeZ0KCKbgrUig@mail.gmail.com>
References: <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net> <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
 <20150610192734.GA23715@peff.net> <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
 <20150615182721.GA4041@peff.net> <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com>
 <f06e573d-02e3-47e9-85d8-3bb6551d72f5.maildroid@localhost>
 <20150626002706.GA6367@peff.net> <558CA717.2040400@quantopian.com> <20150626040325.GA8559@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Kamens <jkamens@quantopian.com>,
	=?UTF-8?B?YsOkcg==?= <crashcookie@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 06:16:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8L3Y-0005gY-20
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 06:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbFZEPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 00:15:55 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36461 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbbFZEPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 00:15:54 -0400
Received: by oigb199 with SMTP id b199so67367356oig.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XQgV554UUiT5NxqYxNDC2R9mRmgOsHXqHgEofDT8PBI=;
        b=CpL1LGmBzRZfqTzEiUvKN2QxAO9H14UoWlc4Au9Cum2hmalbEoZoQeSHeK5UjcqixH
         qbJ5o+CpFIbOaAKP3rq3+qgNTjrz/XEonZTz2sLQcbPvWNcwoMyf4uveYa2oyeapKALs
         hqTRogAwMdpCp20g8DuwuLwAtx1XtRw/zDMmcGpq8NonDU+PMLSG9X3OcyFLTyR60Ni9
         FpuKx1wVrTTn7gEJ/yjhZNoKebAyG9bk0sfKTlfw7TOUyLaysqXizOJb1/JUSte0yZCQ
         NhAaMLrKdWogeG5ilqpHh1bChjxTe8i83pIxxcNXNh8qS+DUufCRLBFhFn5CzUkJVkx8
         7z0Q==
X-Received: by 10.60.79.97 with SMTP id i1mr42845415oex.44.1435292153584; Thu,
 25 Jun 2015 21:15:53 -0700 (PDT)
Received: by 10.202.202.129 with HTTP; Thu, 25 Jun 2015 21:15:34 -0700 (PDT)
In-Reply-To: <20150626040325.GA8559@peff.net>
X-Google-Sender-Auth: Hca07Wgr8wCFddD-WPhcOTTOdAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272760>

On Thu, Jun 25, 2015 at 9:03 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 25, 2015 at 09:12:55PM -0400, Jonathan Kamens wrote:
>
>> I encountered this issue in git 2.4.3 on Fedora 22.
>
> Ah, sorry, you're right. I must have fed the wrong sha1 to "git tag
> --contains" earlier.
>
> I agree it can probably go onto the v2.4.x maintenance track. It is
> already in v2.5.0-rc0.

Yeah, thanks for clarifying while I was away. As with any other changes,
a revert also follows the "master first and then maintenance tracks later"
pattern. Perhaps in 2.4.6 which I expect we would do during the 2.5-rc
period.
