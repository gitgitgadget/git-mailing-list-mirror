From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] remote: add get-url subcommand
Date: Wed, 05 Aug 2015 13:34:18 -0700
Message-ID: <xmqqio8t325x.fsf@gitster.dls.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<1438700198-4942-1-git-send-email-mathstuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:34:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5OO-0006rI-6B
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 22:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbbHEUeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 16:34:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33243 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbbHEUeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 16:34:21 -0400
Received: by pabyb7 with SMTP id yb7so12312612pab.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=p4w9REhcSFfHLNK9uvNrdlP9BNKPWG9QiGAq+EB33YE=;
        b=z23Ed5uxLLorFAIuNlqtsTFbcYSveR9+7wExlPs4LttQMivr9BFanqGES2HPOHsqoF
         0wbu0CqcerNJH5/QfkNw6+aRLqFKzCsaaPtUXx18VMVo7E9LPR1jM1mbZdjWFgMR6y41
         kdBm0u+bY/Du2ku7SYPPkcHb0aaKU+gqsry099ereOgpPdlzcIXAfFZKLk3HTD6TYwXG
         5Gy3eEBIBXLxSN7MF2sA0IebhX4dAH7G5naCqzutM/pmW5I25J0ZALJs2XEKF67AayJo
         LEGngXmSBSv9IZyJ5Unw+4RIdE7Ea/fXUR6Vk9xT/SemjhwgXEVISLa0W6D7JpvMt4Yh
         nHWQ==
X-Received: by 10.68.134.129 with SMTP id pk1mr23204733pbb.65.1438806860556;
        Wed, 05 Aug 2015 13:34:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id jd3sm3851717pbd.96.2015.08.05.13.34.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 13:34:19 -0700 (PDT)
In-Reply-To: <1438700198-4942-1-git-send-email-mathstuf@gmail.com> (Ben
	Boeckel's message of "Tue, 4 Aug 2015 10:56:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275393>

Ben Boeckel <mathstuf@gmail.com> writes:

> Expanding `insteadOf` is a part of ls-remote --url and there is no way
> to expand `pushInsteadOf` as well. Add a get-url subcommand to be able
> to query both as well as a way to get all configured urls.
>
> Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
> ---
>  Documentation/git-remote.txt | 10 ++++++++
>  builtin/remote.c             | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Changes to these two files look reasonable.

Don't you want to protect this feature from future breakage by
others by adding a couple of tests, though, to t/t5505?

Thanks.
