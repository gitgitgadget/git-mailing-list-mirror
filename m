From: David Turner <dturner@twopensource.com>
Subject: Re: [BUG] t7063-status-untracked-cache flaky?
Date: Thu, 15 Oct 2015 15:44:04 -0400
Organization: Twitter
Message-ID: <1444938244.20887.6.camel@twopensource.com>
References: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, pclouds@gmail.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoRh-0003aU-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbJOToJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:44:09 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34993 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbJOToI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:44:08 -0400
Received: by qkap81 with SMTP id p81so44860282qka.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=rJblYZmzK7GntV8ubWb0IJxFW6wVJAzyYtPYtjvAW9M=;
        b=SA8/UAZPY8NS2yBgCsarCY8/GDrlq2RxxHjFBJHHHG99S+a0fE9BfP6UdHOwdTkEUn
         RklKAudHwZSBUUa21YGOywjwKU8+kSMrkY1kMxKqAXM/L18J7D+1eyA/TSILhwq17hv/
         v8tXYRGjEnsRkMopA8eEis/8/n9jEy58OCqEej3ZwHm6f5RCwgsLUFOj7PvQgER+EFzS
         fgD7tCATYsij9w5CPD//NHyQwYv1LUTWOfp/xk+y/RAYUVKAMsgVpyzHQ7Dovjha1Z2T
         BtM7mAHFLNV+f5lBr6pYySwj4ggz4ujT/VRaoVm2LxAdQ3hwrgA1k6pRXx6Vs1+2lZQr
         o+MQ==
X-Gm-Message-State: ALoCoQnQLWOEjIGUF6cfsPTXWrdPOEfN0bCsAWW36VU70DN6Shd7bt7Cmky4ShWKkMNuRusRH3Vy
X-Received: by 10.55.197.147 with SMTP id k19mr14272790qkl.11.1444938246270;
        Thu, 15 Oct 2015 12:44:06 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p88sm6099064qkl.34.2015.10.15.12.44.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2015 12:44:05 -0700 (PDT)
In-Reply-To: <326E1A8B-3612-4771-80B8-77346C0D762D@gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279679>

On Thu, 2015-10-15 at 09:52 +0200, Lars Schneider wrote:
> Hi,
> 
> I noticed that "t7063-status-untracked-cache.sh" occasionally fails with "not ok 24 - test sparse status with untracked cache".
> 
> E.g. on OS X compiled with gcc:
> https://travis-ci.org/larsxschneider/git/jobs/85432514
> 
> E.g. on Linux compiled with gcc:
> https://travis-ci.org/larsxschneider/git/jobs/84986975
> 
> The test was added with commit 7687252. I have not really investigated the problem yet but the "avoid_racy" method caught my attention. Is this test known to be flaky? Would an increased sleep time in "avoid_racy" help?

I've never seen this test be flaky before your report.  I just tested
it, locally, though, and I can reproduce.  After 53 successes, it
failed.  Will investigate further.
