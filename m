From: Michal Hocko <mhocko@kernel.org>
Subject: Re: CC in git cover letter vs patches (was Re: [PATCH 0/19] get rid
 of superfluous __GFP_REPORT)
Date: Wed, 13 Apr 2016 15:33:47 +0200
Message-ID: <20160413133347.GJ14351@dhcp22.suse.cz>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <570E2BC1.8050809@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lkml <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, git@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
X-From: owner-linux-mm@kvack.org Wed Apr 13 15:33:52 2016
Return-path: <owner-linux-mm@kvack.org>
Envelope-to: glkm-linux-mm-2@m.gmane.org
Received: from kanga.kvack.org ([205.233.56.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <owner-linux-mm@kvack.org>)
	id 1aqKvX-0006WN-Pu
	for glkm-linux-mm-2@m.gmane.org; Wed, 13 Apr 2016 15:33:52 +0200
Received: by kanga.kvack.org (Postfix)
	id AB416828E1; Wed, 13 Apr 2016 09:33:50 -0400 (EDT)
Delivered-To: linux-mm-outgoing@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 40)
	id A64D7828DF; Wed, 13 Apr 2016 09:33:50 -0400 (EDT)
X-Original-To: int-list-linux-mm@kvack.org
X-Delivered-To: int-list-linux-mm@kvack.org
Received: by kanga.kvack.org (Postfix, from userid 63042)
	id 97A2D828E1; Wed, 13 Apr 2016 09:33:50 -0400 (EDT)
X-Original-To: linux-mm@kvack.org
X-Delivered-To: linux-mm@kvack.org
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by kanga.kvack.org (Postfix) with ESMTP id 5959C828DF
	for <linux-mm@kvack.org>; Wed, 13 Apr 2016 09:33:50 -0400 (EDT)
Received: by mail-wm0-f53.google.com with SMTP id u206so78335167wme.1
        for <linux-mm@kvack.org>; Wed, 13 Apr 2016 06:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-original-authentication-results:x-gm-message-state:date:from:to
         :cc:subject:message-id:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ls0sQWAVb01b9Ur+yM2PkIvojzT6UxROVm1RBaHdwzM=;
        b=RqGIr72xkar2GgWJCUbHbVtSsDynAtKMDEYTdRajtA/TRM/HemKcsrdK00pdtB5CmJ
         3YZy9emWBFucYYAi8ZkJcgP0v+vTk9aBVbVl1dSRyLzzI4Qwz4NYvlO1JGNqQVvK/dPu
         r0VxtNadFhDeyI9XIiyPbyx3upVJAgAw/xrwR5zLxIakbDi9ugm4OzdCEaXm9pDJgoRe
         AOic2cVnNBIp1IcZT0NwogUnbAtH2gRUP2fWqSzVVvPuuXCl6Zybel24NdTl0kExzHgZ
         aeHT0uaezPkQY4sqsOgbIR0YYvklUHp6tH7EuvW8AUwFqEraGktRob6EEC0P90kyzHQp
         ZH3w==
X-Original-Authentication-Results: mx.google.com;       spf=pass (google.com: domain of mstsxfx@gmail.com designates 74.125.82.68 as permitted sender) smtp.mailfrom=mstsxfx@gmail.com
X-Gm-Message-State: AOPr4FWxnzG8EXjoD/yZfHPzyuzHuKSEIMeWpCi4jAcl+/vrl6VdVx/wezwlEaoVLOccaWXzseueOtpGm6XFvEqXgihfT4qSw/yQ0HsV35AB/yjnXzSmu5EYBW87hXDJuN2XLI8ClsCxaD7YCASdLZ3uLb3sou6HGw+GrvqnCM+OeYfJ+hlr2xXj9cBGjaolNSjQXR9ExL5dXrlNR72sNYRF/95FhHmwD3hqhQgu8Fgxl44qJ+BCH1ccJD17ubatC6v5WotfSbAAbJY+RIQwVdFiD8xMT47OXLolaXLvZfaiAt0=
X-Received: by 10.194.134.170 with SMTP id pl10mr9454279wjb.88.1460554429786;
        Wed, 13 Apr 2016 06:33:49 -0700 (PDT)
X-Received: by 10.194.134.170 with SMTP id pl10mr9454240wjb.88.1460554429207;
        Wed, 13 Apr 2016 06:33:49 -0700 (PDT)
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com. [74.125.82.68])
        by mx.google.com with ESMTPS id s1si1281319wme.105.2016.04.13.06.33.48
        for <linux-mm@kvack.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:33:49 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstsxfx@gmail.com designates 74.125.82.68 as permitted sender) client-ip=74.125.82.68;
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mstsxfx@gmail.com designates 74.125.82.68 as permitted sender) smtp.mailfrom=mstsxfx@gmail.com
Received: by mail-wm0-f68.google.com with SMTP id a140so14043326wma.2
        for <linux-mm@kvack.org>; Wed, 13 Apr 2016 06:33:48 -0700 (PDT)
X-Received: by 10.28.130.6 with SMTP id e6mr11129159wmd.94.1460554428704;
        Wed, 13 Apr 2016 06:33:48 -0700 (PDT)
Received: from localhost (nat1.scz.suse.com. [213.151.88.250])
        by smtp.gmail.com with ESMTPSA id a1sm38572844wje.43.2016.04.13.06.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:33:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <570E2BC1.8050809@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000002, version=1.2.4
Sender: owner-linux-mm@kvack.org
Precedence: bulk
X-Loop: owner-majordomo@kvack.org
List-ID: <linux-mm.kvack.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291450>

On Wed 13-04-16 16:51:37, Vineet Gupta wrote:
> Trimming CC list + CC git folks
> 
> Hi Michal,
> 
> On Monday 11 April 2016 04:37 PM, Michal Hocko wrote:
> > Hi,
> > this is the second version of the patchset previously sent [1]
> 
> I have a git question if you didn't mind w.r.t. this series. Maybe there's an
> obvious answer... I'm using git 2.5.0
> 
> I was wondering how you manage to union the individual patch CC in just the cover
> letter w/o bombarding everyone with everything.

I am using the following flow:

$ rm *.patch
$ for format-patch range
$ git send-email [--to resp. --cc for all patches] --cc-cmd ./cc-cmd-only-cover.sh --compose *.patch

$ cat ./cc-cmd-only-cover.sh 
#!/bin/bash

# --compose with generate *gitsendemail.msg file
# --cover-letter expects *cover-letter* file
if [[ $1 == *gitsendemail.msg* || $1 == *cover-letter* ]]; then
        grep '<.*@.*>' -h *.patch | sed 's/^.*: //' | sort | uniq
fi

it is a little bit coarse and it would be great if git had a default
option for that but this seems to be working just fine for patch-bombs
where the recipients only have to care about their parts and the cover
for the overal idea of the change.

HTH
-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
