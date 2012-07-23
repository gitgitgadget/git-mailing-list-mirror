From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC remote-svn
Date: Mon, 23 Jul 2012 06:59:03 -0500
Message-ID: <20120723115902.GD14294@burratino>
References: <4514544.Xip1OCQ7Uj@flomedio>
 <vpqr4s2nc0j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 23 13:59:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StHIC-0006gc-2L
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 13:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2GWL7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 07:59:10 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:63301 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594Ab2GWL7J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 07:59:09 -0400
Received: by gglu4 with SMTP id u4so5324132ggl.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=21SqI43+f5ZxsldrNrqI4QstVBGxK8VdlvUO5kpCEMk=;
        b=ayqJzyDIlEaZQZtOSDOJcM8NMZsBl9SBpph02a8tcKQ5jyNpgrVW8iMU5L7PtSt+P4
         qT0rCwHkLjTfP35f+7KEus+a+7w8wL8XMYiRHnvXF5WVbgoYpuIWfBoyzwrXzm/gor4z
         0ARTUasI+QLbOvNoLpJoenpHNzFxTflGGHSjHQo1pSG8/ochBUa5Ix8xCASPG42piBOT
         1bxiMQYEte3ji31u07EWBFipOXHsZnFFk9wX6BriDSYw4Hn3dstHWjU57lVwsVF4mN/M
         F57MaUWJCdjeuzsvC9KSeTLQr1EC9X089BliAh9WMflWORu3kEAH9/bGQuzmqHGC8980
         a3pA==
Received: by 10.50.34.195 with SMTP id b3mr14117977igj.47.1343044748180;
        Mon, 23 Jul 2012 04:59:08 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k6sm5849466igz.9.2012.07.23.04.59.07
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 04:59:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqr4s2nc0j.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201929>

Matthieu Moy wrote:

> The man page for git-remote-helpers says:
>
> refspec <refspec>
>     [...] It is recommended that all importers providing the import
>     capability use this.
>
> I'm not sure I fully understand the rationale, but one difference
> between refs/<remote name>/* and refs/remotes/<remote name> is that
> refs/remotes/ is automatically updated by Git on push, while the private
> namespace isn't (it only receives updates when importing).

It's mostly to allow "git fetch" to avoid non fast-forward updates
unless -f was used or the refspec starts with +.

I always liked the idea of tweaking the fast-import stream format to
allow the import to happen on no branch at all since it would avoid
all these questions.  Maybe another day.

Thanks,
Jonathan
