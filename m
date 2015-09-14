From: Filip Gospodinov <filip.gospodinov@monetas.net>
Subject: Re: git submodule ignores --git-dir
Date: Mon, 14 Sep 2015 15:25:46 +0200
Message-ID: <55F6CADA.9000100@monetas.net>
References: <55F1E2AB.3020507@monetas.net> <55F2F028.7070505@web.de>
 <20150911152807.GA17201@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Filip Gospodinov <filip.gospodinov@monetas.net>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 14 15:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTnQ-0003R0-Ab
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755009AbbINN1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:27:35 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38151 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbbINN1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:27:34 -0400
Received: by wiclk2 with SMTP id lk2so133072879wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aSCIycBwDGb4HYKMFpEkHCo2E+dAFkuheh616ra8VP4=;
        b=Cqw6nYe1RKMAPKnfcPY/Vdn9tx/vWaQXrRW82KF+yVPUyXbOGd+qF8KdLykiuRi98I
         KdmwQwJOhFQN9HSOWlp+3kHZBvEgXHTWb0Fm8ncmwFXnFDvVS6k6dNmT9APB3smxdPFT
         rqbkpDmvIz7s/VDLaQB8+z3MpSoDDpFOjYdz+ZHyc3CeXsuCkFnDVW4Gw3PMlPpwUYwg
         4DRuI+xbeCPN0pugpbMhvqpdWTEIXKpxU5jsnPYHsBxy+/7tpbSsWd/PWyChOenGlIi+
         XctxvB3Rt4tF/KKOSIi/BbFWovCLDSi1QDwjEh0rlgQVbtQPpB84zNG1Eua3MRsHQX+g
         nKcA==
X-Gm-Message-State: ALoCoQldTMxmIKCBO7e5mzwD1Ywq2f83laZKu3AgEZCojldFhs2NtzX0Zb3/jR9ACZeMzehOVmPh
X-Received: by 10.180.91.194 with SMTP id cg2mr27017576wib.72.1442237253340;
        Mon, 14 Sep 2015 06:27:33 -0700 (PDT)
Received: from ?IPv6:2a02:120b:2c12:2d80:8286:f2ff:fe50:43e4? ([2a02:120b:2c12:2d80:8286:f2ff:fe50:43e4])
        by smtp.googlemail.com with ESMTPSA id kb5sm15584252wjc.17.2015.09.14.06.27.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2015 06:27:32 -0700 (PDT)
X-Google-Original-From: Filip Gospodinov <filip@monetas.net>
X-Enigmail-Draft-Status: N0010
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150911152807.GA17201@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277825>

On 11.09.2015 17:15, Jens Lehmann wrote:
> Unfortunately trying to show git the right work tree:
>
> $ git --git-dir=$PWD/repo2/.git --work-tree=$PWD/repo2 submodule update --init
>
> Didn't work as I expected it to either:
>
> fatal: /home/Sledge/libexec/git-core/git-submodule cannot be used without a
> working tree.

Yes, that's confusing. I'm not sure how other commands use the --work-tree flag
and if having the git-submodule script `cd` into the work tree would be
acceptable. What do you think?

On 11.09.2015 17:28, John Keeping wrote:
> There's also "git -C /path/to/repo" which avoids the need for a separate
> "cd".
> 

Thank you, that works!
