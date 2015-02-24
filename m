From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Mon, 23 Feb 2015 21:40:43 -0800
Message-ID: <CAGZ79kYhUyRyvf6ou1QWM1j1L1X2YwCbZaNuVp6jJMyUcpwb+A@mail.gmail.com>
References: <1424747562-5446-1-git-send-email-sbeller@google.com>
	<CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 06:40:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ8Eo-0001Ai-G4
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 06:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbbBXFkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 00:40:45 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:59179 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbbBXFko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 00:40:44 -0500
Received: by mail-ig0-f174.google.com with SMTP id b16so24213236igk.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 21:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FF+Y0oy5lFe0LkW/1Kv6y17Z+Nv1bSny1THbDx5c2BU=;
        b=PMQF67SQsJzN82W4XqPhf1CBOJXfp0irETurTaAWPRytAUSAM94kaIvChbdXujyZ94
         xkD3gIDcm5/7kZxD54FSIK4hIlrQWR1yJVaT23Y8AwoZXdnZNluoRay8jBAlxAzR/5XE
         bZP1ZLJdAOmv5E5sQJiuLsQZjHkxMp7GYzqKRO2uMPZnXJctbuOKOKD18YdzRw81wtHR
         MrsMUIpXGjf+5s4HRUga/oMKqLQGJZygZ/Im/lmC+DeyBUYMP/jIFHjS34AtrqZZ8bd2
         tjxRw6HM9KhI5tWGcAURLvuxrhwmUOhW0sTrC1zi+3sf0UfzbBROle226YCGjMo2AodP
         CF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FF+Y0oy5lFe0LkW/1Kv6y17Z+Nv1bSny1THbDx5c2BU=;
        b=PcgdtE6kOXmNDOCKuh+fiO3QnDA/yrEqMxquMSV24xVF1MRCcuipY8yESggks/ZhsI
         KV6vPEkTGEgGR5gDnkX44C3Wd6Q9cGPuSoLJWi9wNMnrTTAyp0219Uss7BWunKDVbKSj
         Y3O1E09qgcRcOjfHkP0AT+jUSHGVtBOFC9gvWN+H6NLq+kS9v60e9YHASTRK2IBKO0bx
         ku1Yk+dJL0pS1qSwGb7t1laJvUiCgOJFQdfUOc0A0zosY8jwUltC3UqpbsVuDbY7lSwS
         Ul/cFUGFyinwJDXXWjUWWaF5Vj/PYvimlUfdDYHC8OZs7cCf+H1nMJ8OasNd5JHAEBvd
         LOhw==
X-Gm-Message-State: ALoCoQlRjLS20r8gGbOi3vO7jKRDW+sSZ4Fgek8WW3r+CxJA1cw3OfxsQ8T8k2J0UtEKaKSDBki7
X-Received: by 10.43.100.67 with SMTP id cv3mr15805486icc.92.1424756443585;
 Mon, 23 Feb 2015 21:40:43 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Mon, 23 Feb 2015 21:40:43 -0800 (PST)
In-Reply-To: <CACsJy8BSf2h_xD-Q1tudAg_xCzffRQM+7xzUgprONxD7vM5RYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264310>

On Mon, Feb 23, 2015 at 8:02 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 24, 2015 at 10:12 AM, Stefan Beller <sbeller@google.com> wrote:
>> One of the biggest problems of a new protocol would be deployment
>> as the users probably would not care too deeply. It should just
>> work in the sense that the user should not even sense that the
>> protocol changed.
>
> Agreed.
>
>> To do so we need to make sure the protocol
>> is backwards compatible and works if an old client talks to
>> a new server as well as the other way round.
>
> It's very hard to keep backward compatibility if you want to stop the
> initial ref adverstisement, costly when there are lots of refs. But we
> can let both protocols run in parallel, with the old one advertise the
> presence of the new one.

That's what I actually meant, to have different versions out there,
but maybe having the version as of now as the least common denominator
such that it always works (albeit inefficient for many refs).

> Then the client could switch to new protocol
> gradually. This way new protocol could forget about backward
> compatibility. See
>
> http://thread.gmane.org/gmane.comp.version-control.git/215054/focus=244325
> --
> Duy

> I would add that upload-pack also advertises about the availability of
> upload-pack2 and the client may set the remote.*.useUploadPack2 to
> either yes or auto so next time upload-pack2 will be used.

I had a similar thought, though I would not just restrict it to v2
this time, but
I'd aim to make it possible to plug whatever protocol you want to.
(Comparable to the SSL or ssh, it will always work, but as a proficient user
you can spend lot's of time tweaking what you actually want, looking
at tradeoffs
of efficiency, security, convenience).
