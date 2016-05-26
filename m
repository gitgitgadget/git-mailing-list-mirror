From: Sebastian Staudt <koraktor@gmail.com>
Subject: Re: [feature request] find git commit log before rebase
Date: Thu, 26 May 2016 22:37:37 +0200
Message-ID: <CA+xP2SZgYYcQOVcWQsEY2YccW3cwONOhXOvViCfH2ONvm5-G8g@mail.gmail.com>
References: <CAKkAvax5Yf2=qLhVkn8EgkNEgHL97Doxr3JWR10aqxksYVsYXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: ryenus <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 22:38:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b622z-0001gU-6J
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 22:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbcEZUiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 16:38:19 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36797 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbcEZUiS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 16:38:18 -0400
Received: by mail-lb0-f195.google.com with SMTP id r5so4986723lbj.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VyTmy29IudZwi2f/vUpf4Ntr3N+fuvucqEwj84Sv+AY=;
        b=gTqsADBD2FLpiGgzyHL7uX2AT8A2m/hGSc6Vrdj+fispBU/SbR2vBz2BRhz1QvoK9e
         2yULrPr8XiYN79ktYYKeQvVsAm2GbNuKSuuCzoCgRa8p+MiohLTJQdkCg7dlcu5LjM8I
         uz/uwM6GFeCb40w5O+l0qSPGXaTKkE4XgK+VoOLCgAuNmTgAg/9coI3401BOspi8KrmJ
         AkIuoGUpnM9F6PvKZN7kGoc6f0UQhoHRAJxsAqHXPjBZZXN+bd2GVSfrSYJjZd+5lOMx
         IdQ/Np2tlX1sMQM8yMceOAha7wA59gtKf+4qgtj2jqv4hyzpKjC+0sCUQDlki1h3FzZ5
         876g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VyTmy29IudZwi2f/vUpf4Ntr3N+fuvucqEwj84Sv+AY=;
        b=GCyJdDj8V4PiDOTbNMUZKmoa5xwiaEVD02YZ2VOw7hdWIEIdMXuboDSduQ4gNKYICJ
         UmxHr7wuf4ycXLz2w1P/Idw3wD1ZMpxOWi39GPd7+QY/+ST55w3dFf127QmK9/MCA1BV
         xN5E8sDksj0XO03i0rwh+4rQXZEQs6pStO0BK5fx5VB+QQ/9CuoOUaj8XepsLJEDRhlt
         8qqPMRoJmZ/EBPeOBs3dkWhvCEIr3VIVGFSoU40Cua4EfHqa7UlS/x6FGKzTF9JxPqOQ
         ZhqDwOal1XEvxQ8neMM1djKwzMQI5/jHV/gDEuC6+IhzjToV20kNZCrfw41lPqX1ZZ7/
         uSug==
X-Gm-Message-State: ALyK8tJtdKV/JbQvzcRtDFbtP3pkW0dn1IXhKjy2475UGYbSMoSYVoW+zoH38josrLozc/KxmK/ahO5g7Z6tSQ==
X-Received: by 10.112.6.231 with SMTP id e7mr3439551lba.45.1464295096886; Thu,
 26 May 2016 13:38:16 -0700 (PDT)
Received: by 10.25.32.142 with HTTP; Thu, 26 May 2016 13:37:37 -0700 (PDT)
In-Reply-To: <CAKkAvax5Yf2=qLhVkn8EgkNEgHL97Doxr3JWR10aqxksYVsYXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295689>

Hi.

I think what you want is `git reflog` (http://git-scm.com/man/reflog).

git reflog b

Will tell you the commits b pointed to in the past.

Best regards,
    Sebastian

2016-05-26 18:55 GMT+02:00 ryenus <ryenus@gmail.com>:
> Assuming I have branches master (m), and a side branch (b), with a
> history tree like below:
>
> m0 --- m1 -- m2 -- m3 -- m4 --- master (m)
>         \          /      \
>         b1 ------ b2       b3 -- b4 -- branch (b) (HEAD)
>                   |
>       (tag:POINT_BEFORE_REBASE)
>
> The history of branch b is can be described as:
>
> 1. branch b is forked at point of m1
> 2. branch b is merged to master into m3,
> 3. branch b then is rebased (fast-forward) from b2 to m4
> 4. then branch b started its new life as b3 b4 after rebase
>
> With the following command: I can find b3 and b4 since last fork-point
>
>     git log --oneline $(git merge-base --fork-point master)..b
>
> But how to find out commits b1 b2, given the fact that b2 is the point
> before rebase?
>
> I understand it can be achieved via:
>
>     git log --oneline m2..b2
>
> That's because I know b2 is the point before rebase,
> and m2 is another child of the subsequent merge commit m3
>
> I wonder how to do this with an simple (enough) command without me
> looking through the history and find b2 and m2 manually?
>
> Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
