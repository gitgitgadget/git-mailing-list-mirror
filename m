From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:20:09 +0100
Message-ID: <CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com>
	<1446800323-2914-5-git-send-email-larsxschneider@gmail.com>
	<CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com>
	<22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZugwL-0007pn-6t
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033343AbbKFNUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:20:14 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34728 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033190AbbKFNUK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 08:20:10 -0500
Received: by igpw7 with SMTP id w7so31923626igp.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=noYDQ/Dy4MXclAOAcwqhYmCPPuNGsABp+ak/H5Pk38Q=;
        b=OvENuiHh0GVyCUCU7e9G5pfmX114c6+hWA+7eMtAexj8iolQEngVv0HhjcODWqyV/A
         9nTxOuh70LXfnuYBuRXSxb4oeFsoFV1cCCS/thoTo/d0xFm+94E7KWIVq2g3yNJAfCqi
         H2aWMDPQUCTZPrtTBWoEjV3wi+JJkbHmldU7YL0iHSg7EbnnDZ2IQ9cvlr5WYK4XYsUN
         UlJjcLK3kHqZuY/ib1QmxZNQrQ+zTkCZ/ZIOdXEr+CJQknl5NND1aR/qkgBlLOfQJZL1
         cczxSrVZJRiRCl/sezR2/yigJ04CjJJSmnowvQOLAsx3S5H6kENe8epXZdVhq9wAvapz
         6lyw==
X-Received: by 10.50.66.69 with SMTP id d5mr8208277igt.30.1446816009872; Fri,
 06 Nov 2015 05:20:09 -0800 (PST)
Received: by 10.107.182.133 with HTTP; Fri, 6 Nov 2015 05:20:09 -0800 (PST)
In-Reply-To: <22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280977>

On Fri, Nov 6, 2015 at 2:11 PM, Lars Schneider <larsxschneider@gmail.com> wrote:

> Per platform/compiler (Linux&Mac/clang&gcc) we run two configurations. One
> normal configuration (see the lonely "-" right under "matrix:") and one
> configuration with all sorts of things are disabled ("NO...").
>
> You can see all 8 configurations ([linux, mac] * [clang, gcc] * [normal,
> NO_...]) here:
> https://travis-ci.org/larsxschneider/git/builds/89598194

Aren't these 8 configurations a bit too much? I see the total running
time is about 2 hours. For my taste, this is way to much to give
developers feedback about the status of their PR. It should be
something < 30 minutes.

IMO, the purpose of the Travis CI configuration mainly is to 1) save
developers work by not requiring to build manually, 2) build on other
platforms than the developer has access to. I doubt that the average
developer manually builds anything close to these 8 configurations
before we had this job, so I wouldn't make it a requirement for Travis
to do much more than a developer could / would to manually.

On the other hand, I see the point in letting a CI system test more
configurations than manually feasible. But that should be done as part
of a different job then. E.g. we could have a "fast" PR validation
job, and a "slow" nightly build job.

-- 
Sebastian Schuberth
