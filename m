From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [CGit] [PATCH 0/6] Communicate the repo name to the filter scripts
Date: Sat, 19 Feb 2011 09:46:15 +0100
Message-ID: <AANLkTimASPjeHor3R6c=i1xpjftxrg4NnFaLJfReuZ-X@mail.gmail.com>
References: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 09:46:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqiSM-0002xf-79
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 09:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998Ab1BSIqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 03:46:18 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:42482 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1BSIqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 03:46:16 -0500
Received: by wwi17 with SMTP id 17so1401613wwi.1
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 00:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B5/IwmhZP3R0cg72d2Rz2uDuE/V27XTgVNNPFkG0kaM=;
        b=td/3G/ZiGgPl7RYECG+JT3zkz7MztZAs9UBfKgMeVmdC24/xGNVzfxFWkj+3kvDNj0
         zCdGQFxd56wTZRdKXNJo/dwQmKlnYe0FFMPIRC/FrGyWAie248rWCOzKR84UDlgWxXgJ
         p4xVTH2ZDUGRvydzSBhJIOceYPYyeCA3Ju0qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DHfnfqsO1XTojSL+yNsr71dYcpu6KVddHVtV4i8+siOW/zaqJ26wkZgZZU8HhRb/Uz
         UBtLIE0/QFw1a2Aoz1TdqZv6HsnRTcmmJiyrYWSddM3EeMYjbrybbW3PjkSH0PBWPStZ
         glB8aBJJb1U0y3uAvKL5xjBFbhw8/ttkImXug=
Received: by 10.227.157.141 with SMTP id b13mr1495087wbx.96.1298105175450;
 Sat, 19 Feb 2011 00:46:15 -0800 (PST)
Received: by 10.227.72.198 with HTTP; Sat, 19 Feb 2011 00:46:15 -0800 (PST)
In-Reply-To: <1297977069-21884-1-git-send-email-mailings@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167259>

On Thu, Feb 17, 2011 at 22:11, Ferry Huberts <mailings@hupie.com> wrote:
> This patch series fixes two bugs and communicates the repo name
> to the filter scripts.

Thanks, but I think the current filter invocations with unnamed,
positional command arguments was a mistake. We should probably fix it
instead of extending it, taking care not to break backwards
compatibility.

The easiest fix would be to add some environment variables:
* GIT_DIR
* CGIT_REPO_NAME
* CGIT_REPO_REL_URL
* CGIT_REPO_ABS_URL
* CGIT_BRANCH_NAME
* CGIT_COMMIT_ID
* CGIT_PATH_FILTER

What do you think?

--
larsh
