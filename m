From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Segfault in git reflog
Date: Wed, 30 Dec 2015 12:17:28 +0100
Message-ID: <1451474248.9251.7.camel@kaarsemaker.net>
References: <20151230092400.GA9319@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 12:17:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEEl5-0001FT-Aq
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 12:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbL3LRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 06:17:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34393 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520AbbL3LRa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 06:17:30 -0500
Received: by mail-wm0-f42.google.com with SMTP id u188so36309505wmu.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=yiIiHVUTqSm2ryHDEc1CJvj7UggGHauFtSARcyoglnY=;
        b=rff6UuzAWwAk6/bIt2kx70iRDCQZbVGJ9CHIXeu26lTYK6VTXBBFe1f7crKOdAGL/A
         LCk7vKALqmwXdPlMpYqwO4q/MBpd6m4bDPrqtIGPEF46MPXSq6jA+crNxUSLATFuCq4Q
         NIoYhbGiDP3HD4k8dzJ6K8Admi1Z8ZmYKpmnzD0xj3HzKsox7zYoTAhyy+M7AvFIzGQl
         jRceaCsqH2ca5GQYZN//2jwICEj4hvD4uAacLj6Pr3+HzjE6bJ6jFlc33sTqvraJXFpe
         ztbI7ayT39obNIZt2DZJWrghWSog2/WFAw44giCsYHiwmE79jXyidh0TOfi1aesMK0eL
         faUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=yiIiHVUTqSm2ryHDEc1CJvj7UggGHauFtSARcyoglnY=;
        b=hWUKK1zQr6EIzwVp88B45aEcYF6rs0ak/2ZaI92Egc0sNw8fhJ5SRuklAj1awzPObI
         8rDZTiAR+xrU+xVg4WOz/gKRlRrkW+BVLpfrNJpOXcCv9PwpORbNnXS9wvK0ZwY3i4yR
         aAYCGbfv6ZBk4NumAZbJ9//hNHLyCN4QiA+HwoOVUn0Nt69hMTSx3Afm0NjIP5ZtM/Lj
         eLiA2lTsj+UsyS7HTWe44Bt1J2nSoNiwZF1jMov7kFMnm9GuJt3W3/8KuM3BaG4ovRl4
         yipRY7iMta92bKjIEo3iLSSsOwPRsSn21l2zHSLNHYtkWGkBqrTwTUyd+6tovHGDTK0o
         +OpQ==
X-Gm-Message-State: ALoCoQk3DbLcoaz/wAGslwdzoJU5dc3lB+rEwt4I9uctEUyxe9aGeA5fotrf2A9vvdpdesxkJltBjsJM7vAdW6ZLhJ+V4cdfbQ==
X-Received: by 10.28.54.159 with SMTP id y31mr58823015wmh.87.1451474249378;
        Wed, 30 Dec 2015 03:17:29 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id ko2sm14274336wjc.9.2015.12.30.03.17.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 03:17:28 -0800 (PST)
In-Reply-To: <20151230092400.GA9319@spirit>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283175>

On wo, 2015-12-30 at 10:24 +0100, Dennis Kaarsemaker wrote:
> spirit:~/code/git (master)$ cat .git/logs/HEAD
> 2635c2b8bfc9aec07b7f023d8e3b3d02df715344 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765642 +0100  
> 74c855f87d25a5b5c12d0485ec77c785a1c734c5 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master

74c855f87d25a5b5c12d0485ec77c785a1c734c5 is actually a tag, pointing to
3c3d3f629a6176b401ebec455c5dd59ed1b5f910. I'm not sure if that is
relevant.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
