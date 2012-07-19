From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 18:40:48 +0200
Message-ID: <CA80E335-AD87-4DFC-9569-A010D3E850C0@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Dan Johnson <computerdruid@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srtmf-0001LC-50
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 18:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab2GSQkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 12:40:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:47835 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab2GSQkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 12:40:52 -0400
Received: by wgbdr13 with SMTP id dr13so2673137wgb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 09:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=vRnxfRtAdykFMhxXv1zKsi29CSY9yg8SW6evVurJPZs=;
        b=JcT8/QK3YQ6hSB5IWNRBAlv/kRe+lTh75A5LxINQdKoxVfbn59vXVKq1zLKfGqWL2w
         1JUk4PJgwkqDcf6YJdD+P1tjbNeSJ4iuCVUxQHjYvAjLpx0CLqazyZrogVJwL3Fl2Eeg
         +x3FmpkJTcTc9dIv6FhuZ5LiqmGtDsWodrsR7O73WomIUO4jlJ9dqZsGTQVIbAcb7Rcp
         l2P4aUM/Bg8BA0Y20ndE/LES8Vt1Auml1k9RCRki0HRmLkXCQMgd1d1wmvuQigXWIQJA
         ivxEEmlHjfNsHkoVEt0bnrMOoPVYQ8uuEuuJzsmEJQbrNy/YVK7ctNqj/7Y34ndFGPpd
         K2bw==
Received: by 10.216.175.76 with SMTP id y54mr870141wel.56.1342716050794;
        Thu, 19 Jul 2012 09:40:50 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id j6sm7264878wiy.4.2012.07.19.09.40.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 09:40:50 -0700 (PDT)
In-Reply-To: <20120719115558.GC29774@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201739>

On 19 Jul 2012, at 13:55, Jeff King wrote:

> I agree it would be much less confusing. However, one downside is that
> we do not keep reflogs on deleted branches (and nor did the commits in
> remote branches necessarily make it into the HEAD reflog). That makes
> "git fetch" a potentially destructive operation (you irrevocably lose
> the notion of which remote branches pointed where before the fetch, and
> you open up new commits to immediate pruning by "gc --auto".

If i understand correctly, existence of a reflog entry will not stop "gc" from removing a commit, will it?
In this case, if a remote branch was rebased or reset, commits can be lost anyway, right?

Alexey.