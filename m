From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Tue, 5 Apr 2016 12:44:03 -0400
Message-ID: <20160405164402.GB9507@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 18:44:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anU5V-0002uR-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 18:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbcDEQoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 12:44:08 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:36858 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428AbcDEQoG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 12:44:06 -0400
Received: by mail-qg0-f65.google.com with SMTP id f105so1716748qge.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzSpTf2svWNhO3LEFCLyPyuZEGBZMJsnKLyPvisQ18A=;
        b=SSLyE3WfZYnA3V5EzdkmQ1VgUXnK9sAd+lQeN/K4wloTqDXTL/CA/dmLiZKauitlK5
         LIG22+gMOkwbzLxb58rPXWolpxjdz6wJz0mOlNL1x9iTgX8WSdDlycrjVjmD9gTZgeDS
         bIvDimeUri4+OpfusE+3bZIosK/8CWpGg7Gc2CgaaINIP7uNzo6n+M38+/VVwa1dHmov
         D0JE+KqicQncSjJOfd+lf85h3M55SAKPFBzGLctZU6do2Q24CJLEpeBoun8/6ABgvRn0
         AJdx/I9PdsJsOw0bRIES9sFCcFyZMPPuOz+yZZaBnhZiiwp2lGzrbeOU9IosooJxNmrP
         Csqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzSpTf2svWNhO3LEFCLyPyuZEGBZMJsnKLyPvisQ18A=;
        b=buSXYU+DmTJksWquoI5QVz09l+NTOu0iV2qFCpC7jw68cx4WjgStVLhxEMhFVwD46M
         EbJIRv4HYrPP2Ltg1pE9vqlGI29EvcrqQMCbC8ce71Mg4CjHzWAn6H4RuA9qr2B71B0q
         pfvs5TQIpB8gDo11726fDF69sqx/9vT2oiySV3LNF/9/zgxuzwkBkizAEUbHuwEgVB3R
         lzoCA0t/bp3zn9D8xz7lGZ1eZJKZty1Xaz6xk3R7R5lpW/va6nODROAH2DoNIzFYaXTl
         GMruJkOxBTIZeyHLfjiHWMW0vFWB7U1ea5my7mnMkW0AODAgqJ4Q08URpwYmIEUB2Aqf
         ImjA==
X-Gm-Message-State: AD7BkJLkrKEd9jIUrz6zgKe12ahtXFg5lxGvoreKmZVdWiGVGqOs9igdX75a3nRDhMZuT91M
X-Received: by 10.140.23.139 with SMTP id 11mr18366337qgp.62.1459874645039;
        Tue, 05 Apr 2016 09:44:05 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-20.NATPOOL.NYU.EDU. [216.165.95.9])
        by smtp.gmail.com with ESMTPSA id w32sm7894643qge.12.2016.04.05.09.44.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2016 09:44:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290798>

Sorry, forgot to add, this is a follow on to [1].

Thanks,
-Santiago.

[1]:
http://git.661346.n2.nabble.com/PATCH-v4-0-6-tag-move-PGP-verification-code-to-tag-c-td7652451.html
On Tue, Apr 05, 2016 at 12:07:23PM -0400, santiago@nyu.edu wrote:
> From: Santiago Torres <santiago@nyu.edu>
> 
> v5 (this): 
> Added helpful feedback by Eric
> 
>  * Reordering of the patches, to avoid temporal inclusion of a regression
>  * Fix typos here and there.
>  * Review commit messages, as some weren't representative of what the patches
>    were doing anymore.
>  * Updated t7030 to include Peff's suggestion, and added a helped-by line here
>    as it was mostly Peff's code.
>  * Updated the error-handling/printing issues that were introduced when.
>    libifying the verify_tag function.
>    
> v4:
> 
> Thanks Eric, Jeff, and Hannes for the feedback.
> 
>  * I relocated the sigchain_push call so it comes after the error on
>    gpg-interface (thanks Hannnes for catching this).
>  * I updated the unit test to match the discussion on [3]. Now it generates
>    the expected output of the tag on the fly for comparison. (This is just
>    copy and paste from [3], but I verified that it works by breaking the
>    while)
>  * I split moving the code and renaming the variables into two patches so
>    these are easier to review.
>  * I used an adapter on builtin/tag.c instead of redefining all the fn*
>    declarations everywhere. This introduces an issue with the way git tag -v
>    resolves refnames though. I added a new commit to restore the previous
>    behavior of git-tag. I'm not sure if I should've split this into two commits
>    though.
> 
> v3:
> Thanks Eric, Jeff, for the feedback.
> 
>  * I separated the patch in multiple sub-patches.
>  * I compared the behavior of previous git tag -v and git verify-tag 
>    invocations to make sure the behavior is the same
>  * I dropped the multi-line comment, as suggested.
>  * I fixed the issue with the missing brackets in the while (this is 
>    now detected by the test).
> 
> v2:
> 
>  * I moved the pgp-verification code to tag.c 
>  * I added extra arguments so git tag -v and git verify-tag both work
>    with the same function
>  * Relocated the SIGPIPE handling code in verify-tag to gpg-interface
> 
> v1:
>  
> The verify tag function is just a thin wrapper around the verify-tag
> command. We can avoid one fork call by doing the verification inside
> the tag builtin instead.
> 
> 
> This applies on v2.8.0.
> 
> Thanks!
> -Santiago
> 
> 
> Santiago Torres (6):
>   builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
>   t7030-verify-tag: Adds validation for multiple tags
>   builtin/verify-tag: change variable name for readability
>   builtin/verify-tag: replace name argument with sha1
>   builtin/verify-tag: move verification code to tag.c
>   tag: use gpg_verify_function in tag -v call
> 
>  builtin/tag.c         |  8 +------
>  builtin/verify-tag.c  | 65 +++++++++------------------------------------------
>  gpg-interface.c       |  2 ++
>  t/t7030-verify-tag.sh | 12 ++++++++++
>  tag.c                 | 48 +++++++++++++++++++++++++++++++++++++
>  tag.h                 |  1 +
>  6 files changed, 75 insertions(+), 61 deletions(-)
> 
> -- 
> 2.8.0
> 
