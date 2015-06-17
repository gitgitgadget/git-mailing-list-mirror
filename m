From: Duy Nguyen <pclouds@gmail.com>
Subject: Fwd: New Defects reported by Coverity Scan for git
Date: Wed, 17 Jun 2015 20:54:56 +0700
Message-ID: <CACsJy8D5_n3+yQ=7fRFMv6XU=s3vf0hoi4-7yDyYZSByK0zKsA@mail.gmail.com>
References: <558151df465a5_4fafe3b3182568a@scan.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:55:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5DoT-0002Aj-S9
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 15:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbbFQNz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 09:55:29 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35002 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990AbbFQNz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 09:55:27 -0400
Received: by iesa3 with SMTP id a3so34211972ies.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LubwvjOyBb74zTE6cKuUvlnAJWy0ph6RO3wvyYahwlE=;
        b=aPuQEXB4HxCa5wUvOcSIddnTGCKwbyM1AnZ5bLOgf7i9w4Fg9P031w2OCHaEiop92M
         msSN9eokqaj/h/k8GsxKX8D/CexJ8wRnbn1zx7BFODXgWNRs7AWj+Lq9+drSS5mi177x
         of48S/50iBhGZig6y8itJ7RZ1iJqwwaD9I5VeFX1lbhuy0GQ1w2lxiGgDCumwclmfsR4
         HZvBekpti4VGUx6ZEM9Htc0zhl795zFd0skbhvXbwpGJOGxRftXcarYfNIE1m6NzE4yg
         sORoprRp1NSq8c5e7dOQSRXYb0wKCnJkFfvpKYjakYiYUhLfYpvpmWY9nK9Ar0XrDmnh
         jdXQ==
X-Received: by 10.107.47.224 with SMTP id v93mr8241254iov.86.1434549326978;
 Wed, 17 Jun 2015 06:55:26 -0700 (PDT)
Received: by 10.107.6.226 with HTTP; Wed, 17 Jun 2015 06:54:56 -0700 (PDT)
In-Reply-To: <558151df465a5_4fafe3b3182568a@scan.mail>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271838>

I think Coverity caught this correctly.

** CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
/builtin/pull.c: 287 in config_get_rebase()


________________________________________________________________________________________________________
*** CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
/builtin/pull.c: 287 in config_get_rebase()
281
282             if (curr_branch) {
283                     char *key = xstrfmt("branch.%s.rebase",
curr_branch->name);
284
285                     if (!git_config_get_value(key, &value)) {
286                             free(key);
>>>     CID 1306846:  Memory - illegal accesses  (USE_AFTER_FREE)
>>>     Passing freed pointer "key" as an argument to "parse_config_rebase".
287                             return parse_config_rebase(key, value, 1);
288                     }
289
290                     free(key);
291             }
292
-- 
Duy
