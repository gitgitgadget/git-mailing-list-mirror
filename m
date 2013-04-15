From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase-am: fix regression with new cover-letter config
Date: Sun, 14 Apr 2013 22:57:05 -0400
Message-ID: <CAPig+cQXaZ_pdOn1RtANdQnYrOaRvpbS2kpCYDq1Gej1w5j=jQ@mail.gmail.com>
References: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
	<7vhaj84l8m.fsf@alter.siamese.dyndns.org>
	<CAMP44s0GbocoBrONYdiN6f=qd58xbX0Y4neGSVRmCiLRr_f8Jw@mail.gmail.com>
	<7v1uac4icp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:57:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZbV-0000vG-Do
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584Ab3DOC5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:57:08 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:46515 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145Ab3DOC5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:57:06 -0400
Received: by mail-la0-f46.google.com with SMTP id ea20so3899455lab.5
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Tlc30Nzh0XYhul/5YdGbyesnLZuoHMHHr6XXo8QfPLM=;
        b=XLyAU0P5U9pEfp0JDRz5uS2M7o/xQOTpM9Z7818ydw7KShnUwXAgLY/joN3af+8vCo
         zZCWmHoEQzxugQqPKKeSTceKTEK+G5A+eFpvUShIgQKdXI4LB4bSjeVo4iaxG76oTU7r
         /tBNLhxGvf+/pG8aIhZOulCCFmiI9niFiarB8/RAb26MqxvvhF6vYXaCZeR0KboVkC9c
         +8XQiqrHh9vum/lJGzkDSaSwEb31xQYMKIMlkkJoXNjMiguWM9XzHs9Pq6VZO2/cyFOZ
         AVNgRq4ZyH6ZJB3+oem0pcMFtc9VsPguoBe7qA9Xf5aOwzhpoYtRjRrCb1yHO0m/AU3l
         jbrA==
X-Received: by 10.112.155.131 with SMTP id vw3mr9440313lbb.64.1365994625433;
 Sun, 14 Apr 2013 19:57:05 -0700 (PDT)
Received: by 10.114.99.67 with HTTP; Sun, 14 Apr 2013 19:57:05 -0700 (PDT)
In-Reply-To: <7v1uac4icp.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qrkfcFCOR7CBeUFsD6JEJyWtaSc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221189>

On Sun, Apr 14, 2013 at 10:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here is what I tentatively queued.
>
>     rebase-am: explicitly disable cover-letter
>
>     If the user has a cover-letter configuration set to anything
>     other than 'false', 'git format-patch' may generate a cover
>     letter, which has no place in "format-patch | am" pipeline.
>
>     The internal invocatoin of format-patch must explicitly override

s/invocatoin/invocation/

>     the configuration from the command line, just like --src-prefix
>     and other options already do.
>
>     Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
