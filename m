From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [REQUEST 1/1] docs: update http.<url>.* options documentation
Date: Fri, 26 Jul 2013 20:04:53 -0700
Message-ID: <C0FA1DEA-A725-40B4-AE9D-5F49B61C94BC@gmail.com>
References: <4b44f95a1b574b5d92a15254e4e8523@f74d39fa044aa309eaea14b9f57fe79> <ec5ecd4fe44af87e83778ce8e297afe@f74d39fa044aa309eaea14b9f57fe79> <20130726043748.GA20286@sigill.intra.peff.net> <0A68F4A5-22B0-4629-8693-73258566E218@gmail.com> <20130726222732.GA3444@sigill.intra.peff.net> <251106F7-56FA-4503-A4C9-267A5EF04A2C@gmail.com> <20130727024353.GA19853@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 27 05:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2uoX-0001rl-Le
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 05:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab3G0DE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 23:04:58 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:64038 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab3G0DE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 23:04:57 -0400
Received: by mail-pd0-f173.google.com with SMTP id bv13so3516784pdb.18
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=vWdyVBJUKPGZybMClrzJRjRnklL6r7QICDINzbZWMpg=;
        b=glT2iZMSVybjerqDrj0OJeF8xYPftmfqMmtfqUrVJyrZC8AlW6QdYbNaR5OAHsQVwv
         ibiinvzpFPGQd9oWvrBiqs8LKOfkjVUMPhtFm3+fko4UibMMMXNDuvylB+RHex14Ynj2
         EXgaeN1tuvJV57k+weEos7p9mo5YvDwff932SNWfx7QdfaIRx+j5kIpgVzhLIssDDf9j
         e5ZxnyaxeY2c/nRQGQNdgzWi1f1BDA6MRGWkC773NGAdAnMm01Id820hMveo7g8QXe9w
         DlhQV25GGoyHkWEpIC5+7tqeqOCkroW28vpPTat4i44Y7pwQNukBwS75VYeXa0eeuRGx
         kAwA==
X-Received: by 10.66.254.135 with SMTP id ai7mr58231642pad.185.1374894296517;
        Fri, 26 Jul 2013 20:04:56 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id w8sm6761669paj.4.2013.07.26.20.04.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 20:04:55 -0700 (PDT)
In-Reply-To: <20130727024353.GA19853@sigill.intra.peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231224>

On Jul 26, 2013, at 19:43, Jeff King wrote:
> On Fri, Jul 26, 2013 at 07:15:07PM -0700, Kyle J. McKay wrote:
>
>> So there's a version of this in next as cea9928 and I think that
>> version is fine.  If the documentation gets updated in the future, or
>> perhaps moved to a separate urls-matching.txt for some reason at some
>> point (git config --url, git config --url-parse), I'll make a point
>> of inserting the ", but at lower precedence than a config key with a
>> user name" text.
>
> Unless you are planning to do that immediately, we are very likely to
> forget. Either it is worth adding or not, and if it is, we should not
> let having to add one more commit stop us.
>
> Here it is in patch form, so the amount of effort does not influence  
> our
> decision. :)
>
> I'd lean towards including it, but don't feel strongly.
>
> -- >8 --
> Subject: [PATCH] docs: mention precedence of empty username matching  
> in URLs
>
> The documentation makes it clear that a URL with a username
> will match a config entry with or without a username, but is
> not clear that in the presence of both, the one with
> username would be preferred.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Documentation/config.txt | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0dd5566..f2ed9ef 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1568,7 +1568,8 @@ http.<url>.*::
> . User name (e.g., `user` in `https://user@example.com/repo.git`). If
>   the config key has a user name it must match the user name in the
>   URL exactly. If the config key does not have a user name, that
> -  config key will match a URL with any user name (including none).
> +  config key will match a URL with any user name (including none),
> +  but at a lower precedence than a config key with a user name.
> --
> +
> The list above is ordered by decreasing precedence; a URL that matches
> -- 
> 1.8.3.rc1.30.gff0fb75
>

I like it.  :)

+1 for adding it as an incremental patch to next.
