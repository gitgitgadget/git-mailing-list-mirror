From: Felipe Sateler <fsateler@debian.org>
Subject: Re: Bug: stash save -u removes (some) ignored files
Date: Wed, 4 Nov 2015 09:27:24 -0300
Message-ID: <CAAfdZj_t86AuhU7dgx81-MXFp7Fe=TCZ0uzRu37+FUp80mvy5Q@mail.gmail.com>
References: <CAAfdZj8=pqWDB9U3=bPeKXGzsZvzns2xX8WxEzQAy08wgSm=ZQ@mail.gmail.com>
 <CA+izobsNJ+Aj6JwFTtZVD_+8m9uXV-iiM7Z2aYWNCnWXFd82Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Atousa Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 13:28:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtxAh-0001xx-G9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 13:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbbKDM2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 07:28:06 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33499 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbbKDM2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 07:28:04 -0500
Received: by iodd200 with SMTP id d200so51552445iod.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rhQFmEGYpVE6w4LsWcVDPMletdcNymW3FHAPOyppBtI=;
        b=KgmNCfjwVItB31CFvpOg4AKpcUZy0NMn+7f+R1bSzEcfoKx0nQ2yLgfZ5TeWR8wu88
         wN5HVx1+dF8AMwSpe6ytfzNlj6HqHtXzrbNsSoN+2jUKOTG947pLqBVeNIssn++2vmrP
         NxFEwJm6qq0ykwwNrOIbD3sbooMyfTpmVxMvv4ZVlcNgg1Q2mcB8z5VwwzaQoYepm+ap
         4I+GNq1NKIotpjJQ3DtcRFEnfeLfm3zLR2HphgDZ+GNNgphpE4hstQTX8+yhXM5xsO9q
         vaA+bE8kYe+i5zSYRv2LbjcqAIAjQwTc0M9TbVU8YjdnS2uJg77/W/AfR7CZjAr4DLR9
         DB6A==
X-Received: by 10.107.6.195 with SMTP id f64mr2455749ioi.46.1446640083860;
 Wed, 04 Nov 2015 04:28:03 -0800 (PST)
Received: by 10.107.131.101 with HTTP; Wed, 4 Nov 2015 04:27:24 -0800 (PST)
In-Reply-To: <CA+izobsNJ+Aj6JwFTtZVD_+8m9uXV-iiM7Z2aYWNCnWXFd82Dg@mail.gmail.com>
X-Google-Sender-Auth: FWB7ZCrvLOXyt6VAWn9zF-KHDis
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280858>

On 4 November 2015 at 03:23, Atousa Duprat <atousa.p@gmail.com> wrote:
>> felipe@felipe:testgit% git stash save -u
>
> This does the following:
> $ GIT_TRACE=1 git stash save -u
> [...]
> 21:59:10.606094 git.c:348               trace: built-in: git 'clean'
> '--force' '--quiet' '-d'
>
> git-clean -d removes untracked directories in addition to untracked files.
> Should 'git stash save -u' issue a 'git clean -d' or simply a 'git clean'?

It appears to be intentionally done[1]. Maybe the problem is that
git-clean -d should not remove untracked directories that contain
ignored files?


[1] http://article.gmane.org/gmane.comp.version-control.git/180214

-- 

Saludos,
Felipe Sateler
