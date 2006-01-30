From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git vs git
Date: Tue, 31 Jan 2006 09:16:34 +1300
Message-ID: <46a038f90601301216n793f0eb5k34a2b5a7c4e7491e@mail.gmail.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@dgreaves.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 21:17:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3fS3-0004R6-5h
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 21:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWA3UQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWA3UQg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 15:16:36 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:6812 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964936AbWA3UQf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 15:16:35 -0500
Received: by wproxy.gmail.com with SMTP id 57so1129454wri
        for <git@vger.kernel.org>; Mon, 30 Jan 2006 12:16:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WzyocQiBC6bHhZV3sYM7ZVvVBzgIjrLIERB27SgIp2t2M1jnYewrBxN6o4XVvgK72WYICpo2FU1iDcwLS0KvdOR82Z8veP65svh93YbjfYRaDhpxmfg4w/UiBMgS5Aok1TqkwlVzmdzD6aaTBv8c4mK0+86FBhTFZx4W7GS4nyU=
Received: by 10.54.111.19 with SMTP id j19mr1637716wrc;
        Mon, 30 Jan 2006 12:16:34 -0800 (PST)
Received: by 10.54.70.12 with HTTP; Mon, 30 Jan 2006 12:16:34 -0800 (PST)
To: Hendrik Visage <hvjunk@gmail.com>
In-Reply-To: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15295>

On 1/31/06, Hendrik Visage <hvjunk@gmail.com> wrote:
> git isn't
> working because the wrong git is in the right place :(

Well, I just hit this yesterday on a colleage's machine who was trying
to get going with git.His first try was to `apt-get install git` and
as that didn't lead anywhere he fetched the git (scm) sources and
built them.

Apparently GNU GIT's git binary was earlier in the path than GIT SCM's
and so stuff broke very creatively. As soon as I did `git --version` I
understood what was happening and a swift `apt-get remove git` fixed
it. But it can sure mess the day for any user trying to install git
naively.

Not sure how to deal with this. Packages already record (or can
record) it as a conflict, but source built stuff is different. Perhaps
during `make install` we should try and exec git --version towards the
end and print a big fat warning?

cheers,


m
