From: Stefan Beller <sbeller@google.com>
Subject: Merge conflicts are reported relative to root not cwd
Date: Wed, 13 Apr 2016 14:37:31 -0700
Message-ID: <CAGZ79kbVfk=yAK3UB=H385_YfAtMHZe-gSE=EYVvvcS8jjy08A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 23:37:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSTk-0001Sf-LA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbcDMVhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:37:32 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35068 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbcDMVhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:37:32 -0400
Received: by mail-io0-f175.google.com with SMTP id g185so85413161ioa.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=6ISj97VHihNPkRxMnWBRSb9qkSATKbOtDL8PjqUEiZk=;
        b=IeIkKodMyuLxwZ2nleNU8XT+RsJ3THbWNRs015TSX+J02KjykYT3IaEzmBpmMgbjR5
         PbWfddS5gWhrRU5YVp4u6WxeDLR8tGyXSLZJcx8sXGfNxe2K9wJaCNHQexvHKrThpZtR
         qFmG7s+8nJhJgmKXnPqabASudX4qQhDczFrGuBmP3Fm/9cMN6YrKNgc5d0pmPXjKq4i+
         LmIgCS5AKqKbjSS+l5ucD4RMfOh1jG3chyJr9an7//f/nodBBS+uBN1Cj8UXtM50u8mJ
         ggPd9QFrBYtwf+qPzuNGKWX1NV2K2doGhVpcaYUfoRbXx0HJSYjTvM42iayVcQBxJ2yL
         77Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6ISj97VHihNPkRxMnWBRSb9qkSATKbOtDL8PjqUEiZk=;
        b=YNc8dk22ditfkWoSs9BMjH4l1RIOewlXqQxQZbnat/UyumxRDmctV/xgKwLZaMyALs
         i4vhxaxoWZLFzZ8fFtKRsfvwr+QLlLJjNDQLwWSCrr6dtTELlPWKuBBDfGTKHwXBbU89
         hj4za04WdD0CWWhg7R98lkQKHH3Leywb3sMCDof6Tz3gE0Db5xo7pn+U2dl41xjfT6SO
         wpNNrwGKRJiSrfIIlN5kqHnhi878nGL3DoAJZCh057HFlxz+AZBlmo/ABmsY68c6aIRT
         8qPpy65piFwjwMt2m5SES0cpsOJJo9I6GJGDgZuceJEf5DNdTqAK7JVC237enEAc28mf
         mbJg==
X-Gm-Message-State: AOPr4FXYWMZH6tM8IkIhZROrx1Y8tPyQJ2tp/qRLH61DRnB80T1sr/pqXPDb0wlt16Dtw/PfcQsd2UG5eiRM6+Ci
X-Received: by 10.107.18.227 with SMTP id 96mr12102950ios.174.1460583451092;
 Wed, 13 Apr 2016 14:37:31 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 13 Apr 2016 14:37:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291488>

$ cd t/
$ git merge ...
...
Auto-merging builtin/submodule--helper.c
Auto-merging builtin/fetch.c
CONFLICT (content): Merge conflict in builtin/fetch.c
Auto-merging builtin/clone.c
Auto-merging README.md
...

It should say ../builtin/fetch.c IMHO.
Any reason to keep the old behavior?

Thanks,
Stefan
