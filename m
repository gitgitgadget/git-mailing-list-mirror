From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Strange behaviour of git diff branch1 ... branch2
Date: Sat, 27 Oct 2012 20:32:46 +0700
Message-ID: <CACsJy8BkKRxp9AQW0M0vDSL8Mb16VGSrZ1OnQpwCrERWKVLSyA@mail.gmail.com>
References: <20121026212650.GB2612@pug.qqx.org> <CACsJy8CX4Wbf3Bqez2kcQ7NGYMkqXC8MK+=hrH4iaev+0ZrQ8Q@mail.gmail.com>
 <4ecbe65e-4b56-4a49-96c3-1ea8b3f0c473@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 15:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS6W2-0001Hp-Fs
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 15:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab2J0NdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 09:33:18 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64896 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab2J0NdR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 09:33:17 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3461401oag.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=agAvkFejxTWuzMc0U03Lq4xmDYIlVboAJPvFduxktsA=;
        b=y/2ezGnfbUEdxgJqCNazOlH3ji///ksf2aPaQBX6ki27w14bAxHadv8h2pFFpdxDii
         7VHcTw24Xmhgp+pPypoyFpIfgr9pSm6an5npAQjI4ijlAXYobswjW7hSs9EglOcXsw+L
         UzRAKceQ1h9avYPhnRRFQq0xQ483xpFZ0Z5TnUQ4TuXll2raTzNZZD7XSsa9u0/PVj56
         ++k4l0bPqjIqwB3T8U5mu4RvfXMw9EOdK3AXlsz789KK6uqmHRt0pHE+UN4wJJrmiJpN
         /KyDJaaVpkatZSBUlrWgG0dJld4CbgSDwpR/hVyMQ3biqZUYDI4xituyKf7dFRiGoU+A
         W/rg==
Received: by 10.60.169.137 with SMTP id ae9mr21929318oec.91.1351344796354;
 Sat, 27 Oct 2012 06:33:16 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Sat, 27 Oct 2012 06:32:46 -0700 (PDT)
In-Reply-To: <4ecbe65e-4b56-4a49-96c3-1ea8b3f0c473@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208508>

On Sat, Oct 27, 2012 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>>Notice the --cc in the first line, which is combined diff. Usually
>>combined-diff is between two points and one parent. Though somehow git
>>passes 4 parents down combined-diff.c:show_combined_header, as you can
>>see in the "index" line. I think we should fix rev parsing code as it
>>does not make sense to pass 4 identical parents this way.
>
> The two heads home from HEAD...HEAD the user has on the command line.
>
> The user is getting exactly what she asked; there is nothing to fix.

Is there any use case where HEAD...HEAD (or "..." alone) is actually useful?

I have re-read the git-diff man page and I don't think it explains
"git diff foo ... bar" syntax (from a user's point of view, not a git
guru's). We could improve the documentation if "git diff foo ... bar"
is useful, or reject it with an error to avoid confusion.
-- 
Duy
