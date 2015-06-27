From: Karthik Nayak <karthik.188@gmail.com>
Subject: [GSOC] Update 3: Unification of tag -l, branch -l and for-each-ref
Date: Sun, 28 Jun 2015 00:02:43 +0530
Message-ID: <CAOLa=ZTb7Y_aRmBMucKyY-G9uEBL9uvHoh2f-7ny9jXrNB_yow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:33:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8uur-0001qL-K0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 20:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbbF0SdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 14:33:15 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34701 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbF0SdN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 14:33:13 -0400
Received: by obbkm3 with SMTP id km3so84156821obb.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2015 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=n8mWSxuMMnnyxiD8JpMfl7XS3bIdg2wniTm0bIPBmUE=;
        b=jaFt9cnZu8cvzGa7PGVvUf39K2lJ9W/vkDnMCrRQf3FS86mm0Pbulyf//bFBcKgzuB
         ox8GvnlSpNFwP9i91dWUgqdlnqgCToq0u3CePQm+GsKPZbE4ko2QUcufiAOq1BTgWz2B
         d5C6hrxzUd1V9l8qxTZ6tq++JSoQm6nIgsY+7jmHwh+ISo8TgYxJ+2LmDi8OQuy0cZ4V
         AgED9LeUQvKLgYvhk8mbxSBjEvfNrX7ylmcUATKLpnkcvGSP2hscSMO69A6NcPfZhds/
         7+esi9q2nDTSGkIbbEnpV9Ql6vAhtEP5yrQ0kPSdXpiFfiSAr94Z58QcyD9wsCHD8Gu2
         CUTg==
X-Received: by 10.60.58.136 with SMTP id r8mr6759954oeq.30.1435429993196; Sat,
 27 Jun 2015 11:33:13 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Sat, 27 Jun 2015 11:32:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272858>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'. Sorry for the lack of update since Jun 14, was a
little busy with an exam I had. Now thats over, I will be working more
on the project.

Current Progress:

1. Building ref-filter.{c,h} from for-each-ref.
This is the process of creating an initial library for the unification
by moving most of the code from for-each-ref to ref-filter.{c,h}.
thread.gmane.org/gmane.comp.version-control.git/271563v2 This was the
last edition (v8) and should be merged into next eventually.

2. Add options to ref-filter.
This includes the porting of --points-at, --contains, --merged,
--no-merged options from builtin/branch.c and builtin/tag.c, Also the
implementation of these options into for-each-ref.
The last version (v6) is posted here:
http:/thread.gmane.org/gmane.comp.version-control.git/272641
Currently waiting for comments.

3. Port builtin/tag.c to use ref-filter.
Here we port tag.c to use ref-filter and also port the --format,
--sort and --merged and --no-merged options to builtin/tag.c.
The "RFC" version is posted and I'm waiting for comments from the list:
thread.gmane.org/gmane.comp.version-control.git/272654

Next Plans:
I'm currently working on porting over builtin/branch.c to use
ref-filter.{c,h} the only problem with branch.c is that it implements
different colors for different branches while printing. Hence we need
to think about how we could use the code from ref-filter to print the
filtered branches.
As usual all intermediate code will be pushed to my Github repository
https://github.com/KarthikNayak/git

-- 
Regards,
Karthik Nayak
