From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 11:25:35 +0700
Message-ID: <CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Diego Lago <diego.lago.gonzalez@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 06:26:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WY6ZH-0006Lh-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 06:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934551AbaDJE0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 00:26:07 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:46547 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaDJE0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 00:26:05 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so3349672qge.16
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 21:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=X8fCaWZgUhgeKi3MpaZt3By9T9i6/gg1uZ8daLnur/Q=;
        b=EMjml9oV4FkShEIoUw1MLkSlIE6vfKxazehIi/H10/IXVApGwwu5s84UTozAOnFHET
         qxbQrlr26nimsN6WKx+JJ6E4sgP14LKOcBeiJy0L5R/euquXbwbXLBfWNXIa+uZu72Ws
         TEwHMxe7AhFwsvweOCDyNvEKjkdTr47pzla9i8HL65N3vozjlX+r3ly3mVJj05hFSAA6
         GbHuh5XXdFdOABAv48Aefj7nv9WagQ6itTfQxGpT0JFQ3DWXSO3k8AwhLXeuxBEn5O8a
         1qD+EN+KbwFXKMCU+nAx+uRQRHhzc6BTf7JHiWxeduwtULdDTx5SRHZ8fogijyyZhijU
         V5Qw==
X-Received: by 10.224.114.76 with SMTP id d12mr17586132qaq.84.1397103965298;
 Wed, 09 Apr 2014 21:26:05 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Wed, 9 Apr 2014 21:25:35 -0700 (PDT)
In-Reply-To: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246007>

On Thu, Apr 10, 2014 at 2:38 AM, Diego Lago
<diego.lago.gonzalez@gmail.com> wrote:
> Commit attributes are custom commit extra headers the user can
> add to the commit object.
>
> The motivation for this patch is that in my company we have a custom
> continuous integration software that uses a custom formatted commit
> message (currently in YALM format) to show several information into
> our CI server front-end.
>
> But this YALM-based commit message pollutes the commit object not being
> human readable, so a good form of achieve the YALM's behaviour (without
> using YALM nor any other structured language) is to add custom attributes
> to the commit object itself.
>
> For example, in our CI server we show the risk of the change (that can
> be low, medium or high); we, as said before, add this information by putting
> YALM code inside the commit message, but the problem is that this message
> is not human readable.

If the problem is polluting human eyes, wouldn't it be better to make
git-log to filter it out? For example, we could tell git that all
fields (in the message body) that start with X- are "rubbish", so
instead of showing "X-something: base64 stuff...", it shows
"X-something: <filtered out>" instead? At least people will see that
this commit carries human-unreadable stuff.
-- 
Duy
