From: =?UTF-8?B?YsOkcg==?= <crashcookie@gmail.com>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Wed, 10 Jun 2015 15:19:41 -0300
Message-ID: <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
References: <5570F094.10007@quantopian.com> <20150607124001.GA11042@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Kamens <jkamens@quantopian.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 20:20:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2kbl-0005lS-S0
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 20:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933521AbbFJSUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 14:20:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33806 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbbFJSUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 14:20:03 -0400
Received: by oiax69 with SMTP id x69so3903789oia.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iiqYSbvUQ4RSv80Bs4aKHzh/A06LH2CEZ+7c6ZODHnc=;
        b=Bn/PsoLhhgqVzWPsT1thb9hfgxmcgKB/uy2l/HUJEneWNFaId7lvpHU4vraNHnnjve
         Q6ULDE8Kx146YyZpw47PTcAAZDyRrdGzhgvAGjedfAEFfT2bt9cnqp0gT7J5qOLDD6Ug
         VSM38rdwl8kpxDS0bO2T+vFaW39KvdgahZ01hiMBxkFN5T3Kxm+Ffq4NdXB7j4dy6/ZZ
         BGQNxwBUdu2FmiLD5xdygb9hWYOePi+ky0Twv6PAlStG8OG9+gBS4b9M9uTUKp5GVgZd
         1hTpUK2tYbmMAEiFSNrlw6ive5k8VVxnfcxzpq1IRaw2gLlSFXynrQAVgmumIO15663N
         KgkQ==
X-Received: by 10.60.74.34 with SMTP id q2mr4022696oev.68.1433960402435; Wed,
 10 Jun 2015 11:20:02 -0700 (PDT)
Received: by 10.60.157.202 with HTTP; Wed, 10 Jun 2015 11:19:41 -0700 (PDT)
In-Reply-To: <20150607124001.GA11042@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271337>

On Sun, Jun 7, 2015 at 9:40 AM, Jeff King <peff@peff.net> wrote:
> Hrm. The new protection in v2.4.2 is meant to prevent you from losing
> your index state during step 4 when we run into a conflict. But here you
> know something that git doesn't: that we just created the stash based on
> this same state, so it should apply cleanly.


It is strange that `git stash --keep-index && git stash pop` while
having something in the index, fails with a "Cannot apply stash: Your
index contains uncommitted changes." error, even if we have a
`--force` param it find it awkward that one needs to force
applying/pop'ing even though the stash was created from the same
snapshot where the stash is being merged with.

I understand the original issue, but at least it was expected, when
you stash save/pop/apply, you should know what you are doing anyways.

-- 
Ber Clausen
