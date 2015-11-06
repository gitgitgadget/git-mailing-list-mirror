From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 4/4] Add Travis CI support
Date: Fri, 6 Nov 2015 14:28:37 +0100
Message-ID: <D71ED634-382A-4835-AF65-D16FEFF17270@gmail.com>
References: <1446800323-2914-1-git-send-email-larsxschneider@gmail.com> <1446800323-2914-5-git-send-email-larsxschneider@gmail.com> <CAPig+cSc+BBgd3-UeVE79D9GWXfaQqbLCQdKo6FbhnPMsK_eFA@mail.gmail.com> <22B2C2B1-9260-4EC0-A4C5-C7F7DDD388BA@gmail.com> <CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Nov 06 14:28:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zuh4P-0006Fr-22
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 14:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033318AbbKFN2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 08:28:41 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36951 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1033190AbbKFN2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 08:28:40 -0500
Received: by wmll128 with SMTP id l128so40820079wml.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 05:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UHPSy6t/7Vr/+FlnC+2j+BLGgUguer9hS8oSZswbxaI=;
        b=SnHcq7oA/zYRHYMQaZG/xZvTHcEQ6RG+GHXvk9v8B79tkQaZcjoRjW5MwMVFt6L/Xn
         dSDWdPPhsC6qzEiS67pH1/B9kDsRL+u1JIf1Z3AGKDW3UBjl422h0RpLO0uE7J0dVVOf
         9X9laZhBgePbxxxzW9aSNzyIhe+vfRr5K1DQQ4KrYOK4n7FCBT23a4zRgBwaOAV3laT9
         ZVhX5HNjtnq+l0iGPyo0DvYtAAKsvK05mfiZCrlFqfgUc5qFsDeaeyj+WRjtsjl5bkdw
         h1xXMT9pM84VtpZoEeUPst3L2O6BUiwAfLfF5de+w/563d5u7vB4gC9hL/0gaYCUytoy
         O0Iw==
X-Received: by 10.28.12.140 with SMTP id 134mr10657990wmm.9.1446816518604;
        Fri, 06 Nov 2015 05:28:38 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w73sm3066847wme.12.2015.11.06.05.28.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Nov 2015 05:28:38 -0800 (PST)
In-Reply-To: <CAHGBnuNwzGNjfh57zFOtwr6qU1PCsc7rgOniY8-Mz5Jgnv2QTg@mail.gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280979>


> On 06 Nov 2015, at 14:20, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> 
> On Fri, Nov 6, 2015 at 2:11 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
>> Per platform/compiler (Linux&Mac/clang&gcc) we run two configurations. One
>> normal configuration (see the lonely "-" right under "matrix:") and one
>> configuration with all sorts of things are disabled ("NO...").
>> 
>> You can see all 8 configurations ([linux, mac] * [clang, gcc] * [normal,
>> NO_...]) here:
>> https://travis-ci.org/larsxschneider/git/builds/89598194
> 
> Aren't these 8 configurations a bit too much? I see the total running
> time is about 2 hours. For my taste, this is way to much to give
> developers feedback about the status of their PR. It should be
> something < 30 minutes.
> 
> IMO, the purpose of the Travis CI configuration mainly is to 1) save
> developers work by not requiring to build manually, 2) build on other
> platforms than the developer has access to. I doubt that the average
> developer manually builds anything close to these 8 configurations
> before we had this job, so I wouldn't make it a requirement for Travis
> to do much more than a developer could / would to manually.
> 
> On the other hand, I see the point in letting a CI system test more
> configurations than manually feasible. But that should be done as part
> of a different job then. E.g. we could have a "fast" PR validation
> job, and a "slow" nightly build job.
> 

Well, I partly agree. Right now the running time is ~20 min (that means less than your 30min target!). After ~10min you even have all Linux results, Mac takes a bit longer. Travis shows you 2h because that is the time that would be required if all builds where run one after another (we run builds in parallel).

That being said, I see your point of to avoiding to burn Travis CI resources meaningless. If I am not mistaken then you can configure Travis in a way that it runs different configurations for different branches. E.g. I would like to run all 8 configurations on maint, master, next and maybe pu. All other branches on peoples own forks should be fine with the default Linux build (~10min).

What do you think?

Thanks,
Lars