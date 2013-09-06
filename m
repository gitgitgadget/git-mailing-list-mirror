From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] git-gui: Modify push dialog to support Gerrit review
Date: Fri, 6 Sep 2013 17:49:51 -0400
Message-ID: <CABURp0qL6CSmt87OnTpRjS4VFikfA3O+w7-HgfB9d6Kip46EpA@mail.gmail.com>
References: <20130906105022.0718C12156D@jed-dev-01.labnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, patthoyts@gmail.com
To: Joergen Edelbo <jed@napatech.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:50:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3v2-0004cA-C5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab3IFVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:50:16 -0400
Received: from mail-vb0-f54.google.com ([209.85.212.54]:50445 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3IFVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:50:12 -0400
Received: by mail-vb0-f54.google.com with SMTP id q14so2663055vbe.27
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tB+U9kVfi6O1tT1og59jG4qjGc/K6XZIg83BHw7pYGw=;
        b=nGB180ShPhv9Rq6Nnm2Pc+p5Rh/GWY5IPorZMqrUtn5m5RA2G1docW9qduHhpyBrF/
         AWY/FXBEsDRWqlA9uHDqlTw8MjWW/SA9b1LlKwqh1azFoft4qi+82ifk0/sknSQ+eOHm
         yU9sivPZIln7ZrYOZIg6Qxa5I/tN2uYtpnf+47H8/LBgwhorEsfk5AQNY8N4YRrlKsBm
         2uR5kkvnz6klDzou1z5zuFq439sbpKfwII/Ye2w7YenskFI2G+u8+eQK0UA6JqJ/Rq+g
         fZThSxQC3Hat3H0f+hA0Anzg6eIpOSm/l0kUehv3mizWKHniG034Awre/rUHhwAOfIAn
         r98w==
X-Received: by 10.58.100.234 with SMTP id fb10mr4398769veb.5.1378504211843;
 Fri, 06 Sep 2013 14:50:11 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Fri, 6 Sep 2013 14:49:51 -0700 (PDT)
In-Reply-To: <20130906105022.0718C12156D@jed-dev-01.labnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234102>

On Fri, Sep 6, 2013 at 6:30 AM, Joergen Edelbo <jed@napatech.com> wrote:
> Problem: It is not possible to push for Gerrit review as you will
> always try to push to "refs/heads/..." on the remote.
>
> Changes done:
>
> Add an option to select "Gerrit review" and a corresponding entry
> for a branch name. If this option is selected, push the changes to
> "refs/for/<gerrit-branch>/<local branch>". In this way the local branch
> names will be used as topic branches on Gerrit.


In my gerrit repos, I have this configuration

  $  git config remote.origin.push HEAD:refs/for/master

And so I can simply 'git push' and git does what I mean.

My main complaint with git-gui's push is that it ignores my
configuration. Can you teach git-gui to honor this setting, instead?

I would like for this remote."name".push option to be smarter and figure
out which $branch I mean when I am not on master, but that is a different
discussion. Having said that, I see that your change to git-gui attempts to
make that automatic.  Kudos for that, but I don't think this will work for
me as I am often on a detached branch and so "refs/heads/$b" is meaningless.

Can you think of a sane way to separate the "from" and the "to" branches in
the GUI?  I mean, I would like to push "HEAD" and I would like it to
go to "refs/for/frotz-2.0".

Phil
