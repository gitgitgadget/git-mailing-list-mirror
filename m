From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 03:48:57 -0500
Message-ID: <CAMP44s3P02yFoi64j5aROQm69O4NGzvzxONyEjkpvLzW-GTenA@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<vpqehdzkoix.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 25 10:49:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVHrY-0003QC-Ga
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 10:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664Ab3DYItB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 04:49:01 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38121 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3DYIs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 04:48:59 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so2494012lbi.23
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WoS51b5eV/s+GGncpROmE4rjXag+k7FeRqGyuU4LhAE=;
        b=lB/s8VfJbrvhm0cwPxTkZy04X1isrUPFI5RkyTkPrURNjC1RLz05mWjqNoOE4ilclV
         yo2NU/K3oLs+8lXSLmWiOaBGcJObnXQAS9wy5JnXD60ZjlDmI4e1O47+Fd4XlxQzyjm4
         fmD79ILm5/4baGs+SElvdOFvoRXPiKXY8Au51tNHWj8z/psSHeGZx+51C03W9F3DkcKI
         w78QRnkxMNoJAQWZqF00JS6CZyeugP7ikLF4j2PlOv2dOj4AeweLJxNzQwQgO2EmjfLw
         uYeuXOITRBTQofH59SA8bPbSZb+ZrJwF8d7Cu7LdtHrx//cG8iJ4xc4jSEUF6+IIKJcd
         HlvA==
X-Received: by 10.112.146.133 with SMTP id tc5mr19242442lbb.88.1366879738084;
 Thu, 25 Apr 2013 01:48:58 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 01:48:57 -0700 (PDT)
In-Reply-To: <vpqehdzkoix.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222356>

On Thu, Apr 25, 2013 at 3:22 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Hi,
>>
>> So, I have three serious itches that would be nice to address:
>>
>> 1. git reset --hard HEAD~1/ git show HEAD~1 is a very common idiom
>> that's unnecessarily cumbersome to type out.  We can make the <rev>
>> part of <rev>~<n> optional without being ambiguous: you might argue
>> that ~<n> normally refers to a /home/<n>, but who uses numbers in
>> place of usernames?  Even if they do, how can that path possibly be
>> inside our repository?
>
> It's a bit more complex than that: the ~<username> is expanded by the
> shell, before Git has any opportunity to guess anything.
>
> ~1 would be unusable for zsh users and tcsh users at least by default:
>
> zsh% echo ~1
> zsh: not enough directory stack entries.
>
> tcsh% echo ~1
> Unknown user: 1.
>
> (An obvious workaround is to shell-quote it, but as the goal is to have
> something easy to type, \~1 or '~1' do not give so much benefit over
> HEAD~1)
>
> That said, it seems to work fine for bash (even if the number is a PID,
> it's not expanded), so it may be a good idea to add it as a shortcut,
> with a warning in the doc about shell expansion.

Yeah, probably fine, but I would also like H~1.

-- 
Felipe Contreras
