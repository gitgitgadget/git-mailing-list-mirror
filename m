From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:36:59 +0100
Message-ID: <CAHGBnuO9aVGYLd+3F3wp7QwazQvWZAS-NeNba3SwsuVkcVkCWg@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
	<CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
	<22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com>
	<CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com>
	<D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:37:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuhCX-0004AR-8v
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033355AbbKFNhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:37:03 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35217 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033190AbbKFNhA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:37:00 -0500
Received: by igpw7 with SMTP id w7so35752890igp.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jFJ+JN3laDb7w0xaBqCm2xmWGx6cFcM44wJ2YTwOz58=;
        b=BA/yFt6vk8ClJc80djV+WktX07FzTygGtfU7VjHmw0tyCzpvm3kLPF4a0eDBdaGCpJ
         GKn89hJpyMWdon/eE/xSKTNMvMcolSgRDUAuwLxteG5E4crk/E+FEbF0vdetPNT2GtP7
         eKPHYZyBUoLxdgjF/TT1teQsRic/LCDOg6nSLzcx/dAUg7JmJuPmBdwb3Hy6Gch8SnR5
         x+lDfzMyh5tV1iX+Oumwd+YHsaJe3ewYqsodXfVlCbvaQVBqfNmHcU7S7xG5BiuIOm45
         7tMGhCxVlcaaJXw+2m94/0/CINLPLJHvsHtFHHcBixjSTTgmTOSDq0bLrV2kKBVg++bw
         9HUg==
X-Received: by 10.50.45.8 with SMTP id i8mr9173379igm.47.1446817019793; Fri,
 06 Nov 2015 05:36:59 -0800 (PST)
Received: by 10.107.182.133 with HTTP; Fri, 6 Nov 2015 05:36:59 -0800 (PST)
In-Reply-To: <D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280981>

On Fri, Nov 6, 2015 at 2:28 PM, Lars Schneider <larsxschneider@gmail.com> wrote:

> Well, I partly agree. Right now the running time is ~20 min (that means less than your 30min target!). After ~10min you even have all Linux results, Mac takes a bit longer. Travis shows you 2h because that is the time that would be required if all builds where run one after another (we run builds in parallel).

Are you sure about than? I mean, what sense does it make to show how
long it *would* have taken *if* the builds were running serially? I
can see that the longest of the jobs took 21 minutes, which is ok. But
that does not mean that all jobs completed in within 21 minutes. It
could be that not all jobs started at (about) the same time due to a
lack of resources, and that the last job did not compete before the 2
hours were over because it only started to run 1 hours and 40 minutes
befor ethe first job was started.

> That being said, I see your point of to avoiding to burn Travis CI resources meaningless. If I am not mistaken then you can configure Travis in a way that it runs different configurations for different branches. E.g. I would like to run all 8 configurations on maint, master, next and maybe pu. All other branches on peoples own forks should be fine with the default Linux build (~10min).
>
> What do you think?

I think running different configuration per branch makes sense, yes.

-- 
Sebastian Schuberth
