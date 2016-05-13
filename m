From: =?UTF-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
Subject: bug report
Date: Fri, 13 May 2016 13:04:24 +0800
Message-ID: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 07:04:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b15HM-0001ox-KP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbcEMFE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 01:04:26 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34524 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcEMFEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 01:04:25 -0400
Received: by mail-oi0-f54.google.com with SMTP id k142so154199996oib.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 22:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=OzyXi42bm2B+DwEFQN/SNGvWeDwY8lG0yf07+ugOc8w=;
        b=YyN0WuVfFRO51xlM+IQ9SVxrpz7J3Q5VBdTximXWofwiQuNRQez6d3BSXlHAXbcqL6
         z+U+UXBtULYtZ24icfoIc6KoqDmVShDAAwROz2xQZ8ABY/4aHALJQ39PIa21mNgkSOha
         AxOxfnHjEZWIneJQb8xISwiS0Wjj9+RJVTtDjETPr/PC1flnnnd5ieDj/f0N0eg+bOaO
         13FrCJnObbLOZ5BMAuY90A52tIHkikcQdGF0Dsw1csAJIxUUPR1tkCDoBcqD8LIushrA
         /DrwakQEuWPjz7V/6JBsnDxmeXPL6GIio5Tw7QXUMdNDrW+gu/THqGKB720w5RSmLdig
         WMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OzyXi42bm2B+DwEFQN/SNGvWeDwY8lG0yf07+ugOc8w=;
        b=iWnk8RhP889e8qKXcS7jrk+ScD7pYMNZU2HOzsegbx9yIVA+UBWxELELcZjkJr+XnJ
         diMMrayko+xIWd3Z+YMeM4ngE3s0G4ySZZKH8TOydbN1beg6t95Cj6nbsGWdfMfN8thG
         29+s0R5pHifKIlpjJxHCC5q784IwZy+6JoaNWAB5Vz5Tq64ypzi0V8eopjPwcv5MmBSI
         rxxtscb9s7HUTISHmdKlBBYDtAU9RsHDBCShjEzOsGSO7VgmipdxTRCVZyyr6I39iEXN
         6QIBpjvidW1Loa/yw0Yk7K4d5lhkaQurQBbCQieOraRlmrg6L5cnKdUjvbjYHgVo7tG0
         KKxA==
X-Gm-Message-State: AOPr4FVbvT3XrMd7yCLM9v2X+8ODeig/SbHNHHyu7kvKiCuvG6+GwMX2MXcqbFRfDpwvR0jHCRThjVdgMqNRcw==
X-Received: by 10.202.173.209 with SMTP id w200mr8061643oie.67.1463115864934;
 Thu, 12 May 2016 22:04:24 -0700 (PDT)
Received: by 10.202.46.8 with HTTP; Thu, 12 May 2016 22:04:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294500>

Hi all,

      Yestoday when I worked using Git, I found a bug. It's about
rebase. Or I don't know if it is a bug, maybe that is Git. Below is my
problem:

      There is a master branch, and we develop in our own branch.
Let's simplify this: there are two branches created at the same commit
point at master. Then branch A add a function X. Branch B add funciton
X too (yes, they are very same). Then branch B modify function X to
function Y.
      Branch A finishes it's job first and merged to master
successfully and happily without any conflicts. When branch B wants to
merge to master, he finds that master has updated. So branch B must
rebase to the current master. Then problem happends: git rebase
successfully without any conflicts. But branch B cannot see function X
from master (or branch A), only its own function Y.
      I think that's because Git is based on file instead of patch.
But I think Git can report it in this situation.
      How do you think ? Thank you anyway for maintaining this amazing software.

-- 

Benchao Li
School of Electronics Engineering and Computer Science, Peking University
Tel:+86-15650713730
Email: libenchao@gmail.com; libenchao@pku.edu.cn
