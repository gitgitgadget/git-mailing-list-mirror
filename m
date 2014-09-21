From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Bug/request: the empty string should be a valid git note
Date: Sun, 21 Sep 2014 16:32:51 -0700
Message-ID: <1A2394C0-50A4-40F4-B0B9-B2EC38109083@gmail.com>
References: <F9750CC0-3FAC-4B50-AB6A-BFD6A7D0BE97@trifork.com> <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "James H. Fisher" <jhf@trifork.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Sep 22 01:33:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVqcn-0006TB-Bg
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 01:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbaIUXc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 19:32:56 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56450 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbaIUXcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 19:32:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id ey11so3801455pad.28
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=0Zebf9+J3F3mU98fDjKZ68qJVkWPxGKy5F/4uQ0dv04=;
        b=n/SN6q6ayq+dAZdZp/BMkDR1IehHVHC06zEjbJopqGhuni8CE1i33wHhn0cxyegoJm
         Ug+9DSMcZbPA17fF0iWsigbUPzjG173yPae+TAvqaBy8q+VMAKPDSr/EKSFFNGa6lDRW
         EUs34oG6qYEHf3coL/etjjtb/cYiQFacnygXkkUGi0HDfSwIO6JkQCLFDu9zn1SgVAI/
         qUDfnwxqPyOoWhHi4NrsOgC/SwtfB76z/MTBg1ys2vMtznw3CxiDsDMrzATHWd4DKzBF
         9bVXMOZ0R0GGFoaM4O6VAIBD8WdzofBQZzHsUVVwC1rPkepD84fS6l7bev1OL4faQx+Z
         FiBQ==
X-Received: by 10.68.69.38 with SMTP id b6mr18107441pbu.70.1411342374567;
        Sun, 21 Sep 2014 16:32:54 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id n3sm7613393pdl.5.2014.09.21.16.32.53
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Sep 2014 16:32:53 -0700 (PDT)
In-Reply-To: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257359>

On Sep 20, 2014, at 18:44, Johan Herland wrote:

> At least, we should fix
>
>    git notes add -C e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
>
> Whether we should also change
>
>    git notes add -m ''
>
> to create an empty note, or leave it as-is, (i.e. similar in spirit to
> "git commit -m ''"), I'll leave up to further discussion.

The help for git commit has this:

   --allow-empty-message
     Like --allow-empty this command is primarily for use by
     foreign SCM interface scripts. It allows you to create
     a commit with an empty commit message without using
     plumbing commands like git-commit-tree(1).

Why not add the same/similar option to git notes add?

So this:

   git notes add --allow-empty-message -m ''

creates an empty note.  (Perhaps --allow-empty-note should
be an alias?)

With your patch to allow -C e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
there's already support for it, it just needs the option
parsing added.  :)

--Kyle
