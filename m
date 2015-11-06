From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:55:44 +0100
Message-ID: <BE90093A-90AA-4E63-9664-C5ABCDE6B410@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-5-git-send-email-larsxschneider@gmail.com> <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com> <22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com> <CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com> <D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com> <CAHGBnuO9aVGYLd+3F3wp7QwazQvWZAS-NeNba3SwsuVkcVkCWg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jean-Noel Avila <avila.jn@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	David Turner <dturner@twopensource.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 14:55:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuhUd-0001jN-EO
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbbKFNzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:55:47 -0500
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34452 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbKFNzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:55:46 -0500
Received: by wikq8 with SMTP id q8so30731326wik.1
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XChpzayHCFQU5hHoShXnikA56uSCph6Kso6Vpuyg2Qw=;
        b=wEBPFc9jERne5tHdTIY+Y79cmCM6zKsxoDi0f1Xc6qqfj+LhWdl+9J+09pMbaH1JIu
         6grOtlXgTg40l/mI8vNGyouqb49GqzHe6QLlF9z9lMmk6rc5T48EKEPkhM3/FhjvObRV
         M6MnU/UrGOK4ytdHQ5PnF9uiLDi/TfsYJ7oha5DIPVp/zwlnuhRvGgbkbBdvB/GdPPM2
         8KaqyFjZM7mdDcDLzF7/PRGtJL61+QD086kdZtcI6A/KzUJ7E0zW3iGxtSaKJB71qnAU
         4lWv3MJ+2Lk3M1sH3asmeC7CYCED+i/BNtbwhM5FltEvYI9TOuUVo77z9fZOsp0Wtqmv
         0g7w==
X-Received: by 10.194.92.170 with SMTP id cn10mr16386439wjb.12.1446818145635;
        Fri, 06 Nov 2015 05:55:45 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p10sm243482wjx.36.2015.11.06.05.55.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 05:55:44 -0800 (PST)
In-Reply-To: <CAHGBnuO9aVGYLd+3F3wp7QwazQvWZAS-NeNba3SwsuVkcVkCWg@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280983>


> On 06 Nov 2015, at 14:36, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> 
> On Fri, Nov 6, 2015 at 2:28 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
>> Well, I partly agree. Right now the running time is ~20 min (that means less than your 30min target!). After ~10min you even have all Linux results, Mac takes a bit longer. Travis shows you 2h because that is the time that would be required if all builds where run one after another (we run builds in parallel).
> 
> Are you sure about than? I mean, what sense does it make to show how
> long it *would* have taken *if* the builds were running serially? I
> can see that the longest of the jobs took 21 minutes, which is ok. But
> that does not mean that all jobs completed in within 21 minutes. It
> could be that not all jobs started at (about) the same time due to a
> lack of resources, and that the last job did not compete before the 2
> hours were over because it only started to run 1 hours and 40 minutes
> befor ethe first job was started.
I am fairly certain about this. 

See, here is the first configuration and the first test case of a job:
https://travis-ci.org/larsxschneider/git/jobs/89598195
[08:21:06] t0002-gitfile.sh 

Here is the last configuration and the last test case of the same job:
[08:51:22] t9903-bash-prompt.sh

~30 min for all 8 configurations. You can enable Travis CI for you GitHub account and try it easily yourself :-)

> 
>> That being said, I see your point of to avoiding to burn Travis CI resources meaningless. If I am not mistaken then you can configure Travis in a way that it runs different configurations for different branches. E.g. I would like to run all 8 configurations on maint, master, next and maybe pu. All other branches on peoples own forks should be fine with the default Linux build (~10min).
>> 
>> What do you think?
> 
> I think running different configuration per branch makes sense, yes.
If the list decides to accept this patch. Do you think that would be a necessary requirement for the first iteration?

Thanks,
Lars