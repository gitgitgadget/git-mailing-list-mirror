From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] "git-tag -s" should create a signed annotated tag
Date: Mon, 26 Nov 2007 05:51:47 +0100
Message-ID: <1b46aba20711252051x5ec7398er6806f21e179583d4@mail.gmail.com>
References: <7vprxxj4hl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:52:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwVx3-0002JY-JO
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 05:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbXKZEvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 23:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756044AbXKZEvt
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 23:51:49 -0500
Received: from rn-out-0910.google.com ([64.233.170.189]:4870 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752090AbXKZEvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 23:51:49 -0500
Received: by rn-out-0102.google.com with SMTP id s46so164464rnb
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 20:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=N9uWFMVnCT2wSnJrKxUGMTAR3R37txRUUwH6wYpNTlk=;
        b=F3qDQZ2okQy9RI9itnUiPlu5x0n4Tv6zelcD1Sts28YecOrPuJf8w63ZWTPExkU6TpAqe215gFvm3G/SIs9FTqRzFyecDSnqQkudSNgsVF1X/muXe0eUYlnih+uoVoeJGTeWXc1vSFRTMqdGUkVGimNbDCIhs8rCB0F5r+Q2FM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sWnnqa9NbsVeAtDPR7UKiXQ5ykKuJzM0HSYPDKnZ2uZBJwIJ9CboFK+1cGVFjnRkGCCVayRNxoQsBryTRgcNkanMFkO3BaD1YPYDpJKjmh5MvyJiv3d839eU8WDCh1Ak+EaIPEbMmPqkQciYOZu8YptXODPPB8WA85C4ozi/GYE=
Received: by 10.142.230.11 with SMTP id c11mr187494wfh.1196052707196;
        Sun, 25 Nov 2007 20:51:47 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Sun, 25 Nov 2007 20:51:47 -0800 (PST)
In-Reply-To: <7vprxxj4hl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66045>

On Nov 26, 2007 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The earlier patch 396865859918e9c7bf8ce74aae137c57da134610 (Make
> builtin-tag.c use parse_options.) broke "git-tag -s".
>
>  * It's _very_ disturbing that the testsuite did not catch this
>    breakage, even though I though we had a very detailed coverage for
>    "git tag" when it was rewritten in C.

Yes, you're right, "-s" without -m or -F is creating lightweight tags
in my proposal.

I think it is due to the absence of tests checking the "editor" option, that is,
calls without -m or -F options to provide the message, since the tests are using
only those and they are enabling automatically the creation of annotated tags.

I need to think in adding tests replacing the editor with a custom command
to check also the correct behaviour of git-tag when the EDITOR and/or
the other variables are set.

At the end, I've learned that it's better to test a little of every feature than
test completely only a few of them.

Thank you.
