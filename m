From: Pol Online <info@pol-online.net>
Subject: Re: git status / git diff -C not detecting file copy
Date: Tue, 2 Dec 2014 06:15:10 -0800
Message-ID: <CAJxwDJxyOgH=NLAbPU8LvK5Wo5XR1t76kL3dPbwv_g5A-==gvQ@mail.gmail.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
	<CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
	<20141202065550.GB1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 15:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvoEZ-0004Ag-NW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 15:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603AbaLBOPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 09:15:12 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:63456 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbaLBOPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 09:15:11 -0500
Received: by mail-qg0-f54.google.com with SMTP id q107so9106443qgd.41
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 06:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pol-online.net; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6rEh9BFk22mPxBUJW21Kp2y4eYXmvc/5k5O4KPsZPRs=;
        b=aJQOBFhaaRIfnNWM00NVwSIJ/h7woFIGaEH7lgUCm62UvqTkIDCXUbeMWEm33gkQbo
         p02ZSwFIZm3F1RUqOf7b0GEo8J4Q53aCRWXHvekDFFTHXAbZf4Sa6UF/JdR12Ki8AsLK
         u0LfgmKweRQ0I4SVGF7Js1VkyIUCzyoEJHBpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6rEh9BFk22mPxBUJW21Kp2y4eYXmvc/5k5O4KPsZPRs=;
        b=CQQ/0/zYI/DqQZqBOu8R376mm88jNHYkaMiz4Ycuo82Fwc/JCjG2XM9dnfsYKudzAs
         AECBLC21JWgANfmULZxIEgN7Ayxuo8Up+NFboqZhJvATPaaVvhdMlMaBwtexaAqghMLL
         t97ZAH+R0rmQHI18LlDftPClvGXDK7oioVa1ufrnZjEpAhjxNwvQDFZUtaDoR7jmwik8
         OfwwvKblJPuK+aN4DYNMse4xq1QLIvnLhZniC+RqGdpU/TTXVhuluGhFEDu5VCwGxm5R
         dU6CaA8yJOr4Bjksr8HHpUyEA50vSGVsAAOr9ljb6GoUCrM29ZCveWpioAXRfd9Rf5Y/
         RpVA==
X-Gm-Message-State: ALoCoQmgwNXgn8QTYNZSkOGMFVe41V+dObG1Sf4NxEvG60TdRJ1zkq1lxav2eiuqtMrZiqCAiG9U
X-Received: by 10.224.51.131 with SMTP id d3mr75348579qag.94.1417529710759;
 Tue, 02 Dec 2014 06:15:10 -0800 (PST)
Received: by 10.140.97.5 with HTTP; Tue, 2 Dec 2014 06:15:10 -0800 (PST)
X-Originating-IP: [50.152.168.224]
In-Reply-To: <20141202065550.GB1948@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260570>

Jeff,

Thanks much for the detailed answer and analysis.

> Does either of you want to try your hand at a patch? Just enabling
> copies should be a one-liner. Making it configurable is more involved,
> but should also be pretty straightforward.

I'll have to pass on this. I'm absolutely not familiar with the Git
source code nor with the contributing guidelines and process at this
time. I'm currently working on libgit2 and trying to clone the git
status behavior and that's how I discovered this file copy detection
issue.

In the meantime, shouldn't we patch the docs? That should be trivial for sure.

- Pol
