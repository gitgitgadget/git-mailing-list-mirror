From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: "warning: no common commits" triggered due to change of remote's 
	IP address?
Date: Mon, 2 Mar 2009 08:43:24 -0800
Message-ID: <e38bce640903020843p4d7e20f8lbdfe980b34661bce@mail.gmail.com>
References: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com>
	 <e38bce640903011501t2c7a134dp887f5a96db3db0f4@mail.gmail.com>
	 <200903020940.24813.trast@student.ethz.ch>
	 <200903020956.45975.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 02 17:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeBGB-0002pN-Bm
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 17:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZCBQn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 11:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754389AbZCBQn1
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 11:43:27 -0500
Received: from el-out-1112.google.com ([209.85.162.183]:38714 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbZCBQn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 11:43:26 -0500
Received: by el-out-1112.google.com with SMTP id b25so1798958elf.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 08:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N5GbfO7zcRhgwvAiY7Q4HdUNpF/Wr8Ag2bE3iJweC9Y=;
        b=g6WRv2e7UMv5OP8b6i9D8ZRvgeRHY18eYJU4AZsY+yhLG1VHWBoJUKY5/Exoz+7DJW
         1sWZ9lNI6aJk8MpZl6vrWmBya1Aku2Mxxn18g9d+wqp5FfhDqvoxnnZrATHHpcIsgadE
         Ga4tksmvGYQu9qNZSU6HmVQI/gvuGFYjX9BwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uT1rXJMupl74HcDsinbAy+aqmJfPG6YW2RfHcePPl2CEcVGgSu4FtalM9Mj1W/aJt/
         uAtewWuJ5wbxZ9Rh+wiPymLp2jhJ+LmfaO/IRofE5Z3et8+BLXdepD0sPjktqY78Ojm5
         xmiUP1WOYXUlJzdrFaRXoQuMiZ+J3TMz8ov3I=
Received: by 10.90.94.2 with SMTP id r2mr1122912agb.52.1236012204285; Mon, 02 
	Mar 2009 08:43:24 -0800 (PST)
In-Reply-To: <200903020956.45975.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111948>

On Mon, Mar 2, 2009 at 12:56 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Actually this should name the remote's idea of the ref, i.e.,
>
>  git fetch-pack -v $url refs/heads/home 2>&1 \
>  | git name-rev --stdin

Sorry, but I had since done a git fetch from home using the local IP
address before I realized that you would want to try more
experiments on it. But that "local" git-fetch did not emit the
"warning: no common commits" message and was fast. Maybe the majority
of the fetch I had started at the Internet cafe but terminated had
done a lion share of the work already, and the speedy local fetch
finished up the leftovers.

But for completeness sake, I did as you said on the now (mostly) up to
date repo:

  git fetch-pack -v <remote_ip_address>:git.repos/environ.git
refs/heads/home 2>&1 \
   | git name-rev --stdin
  Server supports multi_ack
  Server supports side-band-64k
  Marking 67cb0521a93778a9d9c4d8f4608f2c6c796a7558 (home) as complete
  already have 67cb0521a93778a9d9c4d8f4608f2c6c796a7558 (home) (refs/heads/home)
  67cb0521a93778a9d9c4d8f4608f2c6c796a7558 (home) refs/heads/home

where <remote_ip_address> is the remote IP address, and not the usual
local IP address that is referenced in .git/config.

What does "Marking ... as complete" mean?

Is the git-fetch-pack method shown above the only way to get a report
of what git finds out of date? Seems that git-fetch-pack actually
downloads objects, instead of just reporting what it would do without
actually doing it.

Brent
