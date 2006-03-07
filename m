From: "David Ho" <davidkwho@gmail.com>
Subject: Re: Pulling tags from git.git
Date: Tue, 7 Mar 2006 11:12:38 -0500
Message-ID: <4dd15d180603070812u16fbcf58m4afea92293dce370@mail.gmail.com>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>
	 <4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>
	 <440D5285.3050401@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 17:12:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGeno-0004mL-0w
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 17:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWCGQMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 11:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWCGQMp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 11:12:45 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:13231 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751220AbWCGQMo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 11:12:44 -0500
Received: by zproxy.gmail.com with SMTP id 18so1255699nzp
        for <git@vger.kernel.org>; Tue, 07 Mar 2006 08:12:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ADp/TqmNiScV6Jv98kn9LPNMCZ3vPjoHtBtuNaUksRf+4ewTYtcOD0K8hHDywbjYZBGedRFHCzIyOZQv80OH4JjYemJ2wq48AmHBzRJQIbk/0qTN0yAs7MKJeWz8ysatxgpHrolYJB5u8ASE6q0ToWRIW/s8hSk2ip5aGQISl2c=
Received: by 10.64.203.19 with SMTP id a19mr3323450qbg;
        Tue, 07 Mar 2006 08:12:38 -0800 (PST)
Received: by 10.65.22.11 with HTTP; Tue, 7 Mar 2006 08:12:38 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
In-Reply-To: <440D5285.3050401@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17340>

Andreas,

After get it working, I did an experiment where I hard-resetted my
local repo to v1.2.3, git-pruned and removed the v1.2.4 tag.  A git
pull with the git protocol does indeed pick up the tag.

Thanks for explaining what's going on under the hood.  Everything now
makes sense to me!

David

On 3/7/06, Andreas Ericsson <ae@op5.se> wrote:
> With the git or git+ssh protocol, tags will be autofollowed when you do
> a pull (only signed tags, I think). The auto-following is done by
> detecting tags that are fetched, so when you did a pull using rsync the
> tags weren't auto-followed but you got all the commits. Next, when you
> changed protocol to git:// you already had all the commit objects, so
> there was nothing to auto-detect tags on. Since you're using git:// now
> it should work as advertised in the future though.
