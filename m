From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Tue, 28 May 2013 19:54:02 +0530
Message-ID: <CALkWK0nFDdfGKeRqKKTTMSm4zqHDOt_iGc1aA7LgD9=y2DJO5A@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
 <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com> <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 16:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhKpU-0008Gd-6u
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 16:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934271Ab3E1OYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 10:24:44 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64649 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934123Ab3E1OYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 10:24:43 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so1815630iea.4
        for <git@vger.kernel.org>; Tue, 28 May 2013 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jasrKjEM+RJUyc2XuU6JyMKTvemta7nwMJLyCefRMAY=;
        b=doC3bVSOEAixKedHFP9iev7iUTGucSIWvxLolma8FeGSNSMnyNfWHIxV9In3S8fw8f
         W8fYVba0sG+zk0ke4wbBMvaz/fF+yu5RswvEzvRjPhoncR13xBSSUUit1vVgDeaex7GI
         +mXugFxk8xCs/ihOy1siaz4O3F4SZLj5jgQkmKeFFL2z7juLW57fYi9Hz1ZKFzFMlMMm
         0bWGVeuR2QJCUmHv+hxpDFqOfQ+mdCrhYtfz6GGdLGxHFDCw8pHlmt//wSfejHmLQsig
         ZcCYeipP3X94SIUJNA/uOb13+5tR4+lcOrcChEjjvlT/TUby5202Ox5XRT+BLMeuUpvP
         dPpw==
X-Received: by 10.50.141.230 with SMTP id rr6mr7046336igb.89.1369751083075;
 Tue, 28 May 2013 07:24:43 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Tue, 28 May 2013 07:24:02 -0700 (PDT)
In-Reply-To: <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225655>

Oh, and by the way:

We're pretty close we are to replacing branch -v and branch -vv.

brv = for-each-ref --format='%(HEAD)
%C(green)%<(*)%(refname:short)%C(reset) %<(*)%(objectname:short)
%(subject)' refs/heads

brvv = for-each-ref --format='%(HEAD)
%C(green)%<(*)%(refname:short)%C(reset) %<(*)%(objectname:short)
%C(blue)%(upstream:short)%C(reset) %(subject)' refs/heads

There are small differences:

1. In branch -v, the green-color of the branch name is dependent on
%(HEAD).  Not worth ironing out, in my opinion.

2. In branch -vv, there are dependent square braces that come on when
%(refname:short) is set.  We might want to introduce an undocumented
%(refname:branchvv) for internal use by branch -vv, for backward
compatibility.

What do you think?
