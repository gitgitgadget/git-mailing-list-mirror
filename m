From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: git-gui is still using old-style git-merge invocation
Date: Thu, 29 Oct 2015 18:56:35 +0100
Message-ID: <1446141395.3199.2.camel@kaarsemaker.net>
References: <56325C58.1060007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:56:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrrRL-0004Fk-EN
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbbJ2R4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:56:39 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33914 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbJ2R4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:56:38 -0400
Received: by wikq8 with SMTP id q8so292109839wik.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=0WWKd4IAWTSxyYkCKRcq+N2dMbD2V1n/i0X94q4Zmgs=;
        b=poDj17yqHbWbxcCETPvE146Hrwpn3IGvdCse4Y/x73Jbe0JaVC/08X0a720NA+26D/
         xS47tQy7nqM+/eqO14ccm/T65wQaCKfypJI/uzsVn9hYXAPxxGlvkAFOrjG5WpbB7gmB
         nix0cU9FOcO6sageo0V3YCKglvC0HtQZzzYIiZkGnsNCBLcaYQog+tND99lKfx9ij1cT
         M6xgmdHedVO92OP/BgagF2jIA0Hc71XjfzliDVOZTKahU7n3DPmKFrgMCqTYIKqZ7YSN
         tpNxyQuK8euzep/pNUekHtODekQlrI54RO0Qa3AwJ/TKRD9MV4HEVjrmQ3i6QDQPKFMP
         ozsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=0WWKd4IAWTSxyYkCKRcq+N2dMbD2V1n/i0X94q4Zmgs=;
        b=Ng5mmFGw7WDxrmLpeFYSbaj11Zm+XL1hJ+SZXHRmIc5nONER5PvIoaFutEXdgCivvM
         tgLSEiQ332VIVnRRx/7D2ySrhPpUayR8Gil58IGrNyDB0HR/vHPBGsBwZaNNGDc6CEgs
         QSH3HKgYsZyK5Bg4v+6yq81ZsAQJTlpD+429UIAtUneWlKyQDYGilf64nzXeD2w+blsi
         upCq3ejnlO4oE/GJTvIe2Q3YxRQGA9iiqYw4AvUMIvbGZ9rq3/hW61qbRqSXVymEtK3w
         halFsOB8cQq4d/tiEKJ5Uu1aT/IAbbJZouK2k8xKoKPdn1A/TBrjVpw6yKoGR3O74mnN
         bPKQ==
X-Gm-Message-State: ALoCoQmO8SGGLy3QxD8PQoMEJObmVmGCuJVCy0gBsOR4nWlkufQ8jv2V7DMQreVhXb9UqrdKptZR
X-Received: by 10.194.2.144 with SMTP id 16mr3812552wju.90.1446141396971;
        Thu, 29 Oct 2015 10:56:36 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id at4sm2943475wjc.9.2015.10.29.10.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 10:56:36 -0700 (PDT)
In-Reply-To: <56325C58.1060007@kdbg.org>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280451>

On do, 2015-10-29 at 18:50 +0100, Johannes Sixt wrote:
> Performing a merge with git gui presents the following message in the
> merge result window:
> 
> warning: old-style 'git merge <msg> HEAD <commit>' is deprecated.
> Merge made by the 'recursive' strategy.
>   a | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 a
> 
> But I am unable to find where the invocation happens. Can somebody
> help?

git-gui/lib/merge.tcl, method _start

The command is constructed on lines 115-120 (master as of today,
 37023ba3)
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
