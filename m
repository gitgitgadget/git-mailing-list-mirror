From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] git-gui: Make git-gui lib dir configurable at runtime
Date: Mon, 21 Jul 2014 17:57:44 -0400
Organization: Twitter
Message-ID: <1405979864.15933.4.camel@leckie>
References: <1405966809-30882-1-git-send-email-dturner@twitter.com>
	 <xmqqbnsiifq6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Lai-0002u5-I6
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 23:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbaGUV5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 17:57:48 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:44247 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaGUV5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 17:57:47 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so6080686qgd.13
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 14:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=raVAiv1hVytnfra5BpRi65wuw0+pypZ6G0MCCrnUlkA=;
        b=d6yKGq7aei/0xVTgYt/aWfJL+Axymg2zqk/krYkZ64wheX40Kts98SNYk0prOI5rhd
         XuMGlislkd6TIs12xTAuGmNcZDkJ92Ybs3RQ0zulFTVCIt8+3WGvNnZatIgEIpM/sXyQ
         1LqIeO7bHCOT2gPXmpwli0cNTtF+yFv/2c+0YVaQy79t35WG3nMSlP4qlleiZtdO/vvE
         VEg5YvU0T228om0jSI1pLgWDqWfl75zbBSEP8gzVVhHrZpAtF+hwwO8GrTpHMB6+ZmNE
         7V6Cc8iCfyft2Z2/ImhE3r4m9MYNUT1GJ+glB/AcQj1867otoA4q75HHiYx28dk7NoLS
         mJYA==
X-Gm-Message-State: ALoCoQmw5r8Os4iMNMhqAqF30felRKi9mDCmGxuwMCNJQveM5OFVOAIGBhrQvzkkqlZ0AioUBHGT
X-Received: by 10.140.81.51 with SMTP id e48mr41663881qgd.31.1405979866959;
        Mon, 21 Jul 2014 14:57:46 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id v7sm6017398qav.40.2014.07.21.14.57.45
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 14:57:46 -0700 (PDT)
In-Reply-To: <xmqqbnsiifq6.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253997>

On Mon, 2014-07-21 at 14:06 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Introduce the GIT_GUI_LIB_DIR environment variable, to tell git-gui
> > where to look for TCL libs.  This allows a git-gui which has been
> > built with a prefix of /foo to be run out of directory /bar.  This is
> > the equivalent of GIT_EXEC_PATH or GITPERLLIB but for git-gui's TCL
> > libraries.
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> > ---
> >  git-gui/Makefile   | 3 ++-
> >  git-gui/git-gui.sh | 6 +++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> Would a similar change to gitk necessary/beneficial to platforms
> that would benefit from this change?

Apparently not; it seems to work fine for me from an alternate location.
Convenient!

> git-gui directory in my tree comes from its upstream repository
> git://repo.or.cz/git-gui.git/, and it is maintained by Pat Thoyts
> (Cc'ed).

> Note that these two upstream projects do not have leading
> directories git-gui and gitk-git themselves (they are merged to my
> tree while their paths being renamed).  A patch that is appliable to
> them would touch paths without them (e.g. Makefile and git-gui.sh
> for an equivalent of the patch I am responding to).

Pat, do you want patches via the git mailing list, personal mail, or
some other way?  
