From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 16 May 2013 04:15:03 -0500
Message-ID: <CAMP44s1G=SFJ-5J8UR=mnoO_JXmuY+CC1FaaY7yJNQGuCi0Naw@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
	<CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
	<7v38tv7n5y.fsf@alter.siamese.dyndns.org>
	<CAMP44s1d_9iT7nqtu3gTy=kX-Kapnf0AUZJ-Z-MpLkBuWxBgSw@mail.gmail.com>
	<7vobcj65wp.fsf@alter.siamese.dyndns.org>
	<7vk3n763is.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:15:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuHH-0003cd-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab3EPJPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:15:08 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:52825 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3EPJPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:15:05 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so821199lab.38
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Nh2av8iGPM59Hk0+H+yR8DzPwdgpqgjDpW8J8NEIhaM=;
        b=ZhZ8q+wU7KWgUX4Cj3z33x6AIN3MoYmtJk+OVjY7kukNPYin0E5XgB8AogNESD7ebY
         U/D6ZMg7RFLmaVTNtGljS/pqfIf+nCWXnM0EjzEU2Hey4ajIXQiu8rfogO0SkOkopcOs
         qnxcm5sK2tdnMPv763rCK4RS0TWg49XihXP8OKzKasIzMzUwKLf1JlTWBjD0rooUkV76
         PSkBFDZT1d5oeITmjubEZo0lAH2hUtKZMOzPQtpwhSlnmIuMXI8ZMMtZsCIYBvUXIoih
         h+p5qJIqEJAMN/QguXMDYvj6a2piEdNdmJi9SQeeFKaIfriwACqVmZdDmqUU5S9Mkl9O
         WaMA==
X-Received: by 10.152.3.103 with SMTP id b7mr10445508lab.8.1368695703592; Thu,
 16 May 2013 02:15:03 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:15:03 -0700 (PDT)
In-Reply-To: <7vk3n763is.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224517>

On Thu, May 9, 2013 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:

>    It is a very powerful concept that we can generate data once,
>    cast it in stone, and delay the decision on _how_ it is used
>    until the last minute, much better than mapping at export time.
>    So bundle does not need a similar refspec mechanism to map what
>    it exports.  I haven't thought things through to see if the same
>    logic applies to fast-export output (if so, it would mean it is
>    better to allow the consumer of the stream take the refspec
>    parameter and map the tips it finds in its input), though.

It's possible to delay the renaming of refspecs to leave that duty to
the remote-helper, however, each and every remote-helper would need
advertise a new capability, and then implement the renaming. I think
it makes much more sense to implement something that just works for
free in all remote-helpers.

But I wasn't even that interested in this patch, I implemented it
because while I was helping the emacs folks I had to explain to them
that old:new didn't work, and I thought it would be trivial to make it
work.

I'm dropping this series. Somebody should at least make it so a proper
error is displayed so that the users are not left in the dark
wondering what the hell is going on.

-- 
Felipe Contreras
