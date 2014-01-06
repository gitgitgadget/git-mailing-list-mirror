From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 03:29:39 +0530
Message-ID: <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com> <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:00:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IDh-0004fM-4R
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbaAFWAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:00:21 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:62997 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaAFWAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:00:20 -0500
Received: by mail-ig0-f171.google.com with SMTP id c10so8434519igq.4
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 14:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rCCIbadNIhZ8Gn/9NDtfXS5vW51rRA5SdwkpcmzJbDU=;
        b=hakkeFgd7xgovAXB0zezODslXUgmWD5//+er0gI/mIjZJ3u15EyvisgVomWjhLYG2v
         uVzQvJxMTzekx/hXXdvs4ePNqbBaw9KM+DgipDclWCYaV+Gsa/HL7TCEEM8177YpCpTc
         crHsdzekF+gIRiZplKCNqYg3/5pL/1cz9vMH7LgSwDGjAeNxLUgnI+VQAN7I+g/Bphfy
         h4vGStOqiQ3rcGcFE7zclZn0hhwBNLxkfwp/cU5pnc5k3pQKa9vIisukoigjQxn+XyC8
         Wi1CmusNNr1o9ejKKCTzTBeBww3uZETA9UEXKdQz6NIhL/z5UMACVuxLecNWBcQNi6PW
         Abqw==
X-Received: by 10.50.150.174 with SMTP id uj14mr22327830igb.16.1389045620073;
 Mon, 06 Jan 2014 14:00:20 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 13:59:39 -0800 (PST)
In-Reply-To: <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240071>

Junio C Hamano wrote:
> I meant "a single branch" as opposed to "depending on what branch
> you are sending out, you may have to use a different upstream
> starting point", and a single "format.defaultTo" that does not read
> what your HEAD currently points at may not be enough.
>
> Unless you set @{u} to this new configuration, in which case the
> choice becomes dynamic depending on the current branch, but
>
>  - if that is the only sane choice based on the current branch, why
>    not use that as the default without having to set the
>    configuration?
>
>  - Or if that is still insufficient, don't we need branch.*.forkedFrom
>    that is different from branch.*.merge, so that different branches
>    you want to show "format-patch" output can have different
>    reference points?

Ah, I was going for an equivalent of merge.defaultToUpstream, but I
guess branch.*.forkedFrom is a good way to go.
