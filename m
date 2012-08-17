From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 03/12] git p4: gracefully fail if some commits could not
 be applied
Date: Fri, 17 Aug 2012 08:21:46 +0100
Message-ID: <502DF10A.2040306@diamand.org>
References: <1345160114-27654-1-git-send-email-pw@padd.com> <1345160114-27654-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2GtW-0006HZ-IT
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 09:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932920Ab2HQHWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 03:22:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40002 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639Ab2HQHWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 03:22:48 -0400
Received: by wgbdr13 with SMTP id dr13so3091784wgb.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 00:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=IVKGtSxyj0A6WJcJvH0SfOOmud8tt6G3BgrM4O4p9Sw=;
        b=hZWvETz9nNIDpDTuZ0j7qOBJcrEsTT0uFESI+YqeDkML/KO5YT6JL4p2J18p2TeCo1
         h0ZjssCzXqzejWYZ4hWeGDId/lekn6F5xdA3d57RccKMxDiAPEKdz66PavJqcendvzDM
         +6mn5zD1r01t5zz+2N5tdGfCAoR7nu0hJ0fMCFnmhgBPPGKQnzDc+7fBObI6VLqd7ROT
         C2kUyi5nlzYJZg84SBv6vTTBCe1cp2OwOOCpT0wBx18midcd5ACpXC25FHbSDAnlAezN
         N9yjyN/A2Z2JbxXP/r+w7OfRtrGWQCm8gEGFw0Z5/1tM+84pCwER2kpBJpRssUkuCt6v
         fhBQ==
Received: by 10.180.95.193 with SMTP id dm1mr2641349wib.10.1345188167275;
        Fri, 17 Aug 2012 00:22:47 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id b7sm12364599wiz.9.2012.08.17.00.22.46
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 00:22:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1345160114-27654-4-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQn5JLzwJ6vwokNlLei+E1FXwhH46tWUoSPSVC5MZ4WaFNJjKd7xsl3CTwkLbYK5vv1n6nXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/12 00:35, Pete Wyckoff wrote:
> If a commit fails to apply cleanly to the p4 tree, an interactive
> prompt asks what to do next.  In all cases (skip, apply, write),
> the behavior after the prompt had a few problems.
>
> Change it so that it does not claim erroneously that all commits
> were applied.  Instead list the set of the patches under
> consideration, and mark with an asterisk those that were
> applied successfully.  Like this example:

I could be wrong about this, but this change doesn't seem to help out 
with "git p4 rebase", which for me at least, is where the conflicts 
usually get picked up first.

I modified a file in p4, and the same file in git, and then did 'git p4 
rebase' and it just failed in the rebase in the usual way with a big 'ol 
python backtrace.

If this patch series is intended to sort out conflict handling, then it 
needs a bit more work.

(Says Luke, trying not to sound too confrontational, as I'm rubbish at 
handling conflict....)

Thanks!
Luke
