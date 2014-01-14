From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Diagnosing stray/stale .keep files -- explore what is in a pack?
Date: Tue, 14 Jan 2014 14:42:09 -0500
Message-ID: <CACPiFCLxiCOqv=wLeq9LxisWn5T62hk8xDYwXmeFRNT05HY0iQ@mail.gmail.com>
References: <CACPiFCLa3X-Xt5GwrHHA-PFj-Bi9_sW+=y2xidZ7tDbFfM26rA@mail.gmail.com>
 <CACPiFCJVx0dkkPQ=LosbAAKq7CvK6_yQL5QDHMYr5oJAS6wb6Q@mail.gmail.com> <201401141236.44393.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 20:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W39sh-0006ec-Mr
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 20:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbaANTmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 14:42:32 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38861 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbaANTmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 14:42:31 -0500
Received: by mail-wi0-f178.google.com with SMTP id cc10so1224286wib.5
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9h9e+AKPS5gZ/cxjCdS70P7RFoRTM+sYXc39zV69uF8=;
        b=GLRTTRUIeh6X3xZ+EeKdxMW2pRjiK2Ic3d/IL9K1WG4iQmam1kEy7muuFB3yAWc3ju
         +WLLSP/+0HAgrL7VH0bvjoaN4COzZiXnb4NkyzsikxeVXm5iuPFXdWewE6kqem6quF66
         bC/foY48hGeIyF+HIaOpbM6eSYFGHApc1stGXU13eDw1nemJKkdl7lVgAqg1yyTvfFoE
         8Bf9RrjoLklXGUXbnh6m1WkJHbOVCc4QbYNO6evwaEwBrfFchrApwK1+hPqjGePYZSH8
         CZGBs8xcBMJLXotcGkGU2qyo+iipdXKp7hVEk0yHl7GV8OayYNn1cfvUK3FNqrYONRDM
         DyvA==
X-Received: by 10.194.85.75 with SMTP id f11mr74348wjz.47.1389728550073; Tue,
 14 Jan 2014 11:42:30 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Tue, 14 Jan 2014 11:42:09 -0800 (PST)
In-Reply-To: <201401141236.44393.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240410>

 On Tue, Jan 14, 2014 at 2:36 PM, Martin Fick <mfick@codeaurora.org> wrote:
> Perhaps the receiving process is dying hard and leaving
> stuff behind?  Out-of-memory, out of disk space?

Yes, that's my guess as well. This server had gc misconfigured, so it
hit ENOSPC a few weeks ago.

It is likely that the .lock files were left behind back then, and
since then the clients pushing to these refs were transferring their
whole history and still failing to update the ref, leading to rapid
repo growth.

So my situation is diagnosed and solved; I am still unhappy that it
took so much work and expertise; mainly because git isn't logging
anywhere. See my "Error logging for git over ssh?" message...

thanks,




m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
