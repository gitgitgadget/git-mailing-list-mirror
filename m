From: Chris Packham <judge.packham@gmail.com>
Subject: Re: gitk bug: write commit to file takes commit message from previous commit
Date: Wed, 3 Sep 2014 17:47:39 +1200
Message-ID: <CAFOYHZDtaLEcdOSGA8h99rDTUzsn9z7JytgFLi-WGzZ525QkvQ@mail.gmail.com>
References: <CAFOYHZAWnaQNcCDbS3-2zxacYaD=egwhCT7qAc1DorRZ3_Pe_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Sep 03 07:47:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XP3Q0-0003As-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 07:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbaICFrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 01:47:41 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:54315 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbaICFrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 01:47:40 -0400
Received: by mail-pd0-f179.google.com with SMTP id z10so10264678pdj.24
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YQpP0TOVnnbMXPn4U0y58jJEAHLLFwb1g4kfYLdY3q0=;
        b=IyCXkvfh7zOBZbvPRwA+SAT+S6pxYuqRgeoUdqjdZjk7iHTG/o3VlOM+wVYsxrxwOY
         1qJUU4atrsOIJMS1GI41GlW/k3Ud++cCJBeFpihHZ8vnsBI/c9Io9/ohPYO8SkeSgupQ
         W8KVQCnknIWWqCk1luYKNEMaD/BzU2P4trEAjvGupJtzfoQC3qrrqC05BnBQz9op9Ztw
         X9Z22Zpg5xN7MXwfNG8K1gKOOOA/reZE8vPn0xv8FkqdxK9uqp0hXTo8UjiLbo23Cq/6
         18vkDykFS5+vq1xzpSuT2JqhnQ8SGUPKt88nS+TKR9BsX2ALdXKja9ZN2VZn7trrGDzN
         vGmg==
X-Received: by 10.70.96.233 with SMTP id dv9mr11356972pdb.146.1409723259992;
 Tue, 02 Sep 2014 22:47:39 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Tue, 2 Sep 2014 22:47:39 -0700 (PDT)
In-Reply-To: <CAFOYHZAWnaQNcCDbS3-2zxacYaD=egwhCT7qAc1DorRZ3_Pe_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256379>

On Wed, Sep 3, 2014 at 5:22 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi Paul,
>
> Just noticed something in the version of gitk included in git 2.0.3.
>
> When I right click on a commit and select "write commit to file" the
> resulting file has the diff from the selected commit but the commit
> message from the previous commit.
>
> Attached is an example from running gitk on gitk
> (git://ozlabs.org/~paulus/gitk). As you can see the author, sha1 and
> diff are from 09898e7 but the message is from d4ec30b2.
>
> I haven't tried bleeding edge gitk or bisecting yet. I'll let you know
> if I can track this down to a specific change.

Actually I don't think it's a gitk problem. If I run

  git diff-tree --stdin -p --pretty << EOF | less
  09898e7c3b040086e8addd4ef226548c9dce1460
  EOF

I get the wrong commit message. Looking at the release notes this has
already been fixed in 2.0.4. Sorry for the noise.
