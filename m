From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: stg refresh/conflict resolution helptext/reality inconsistency
Date: Mon, 13 Feb 2006 09:20:09 +0000
Message-ID: <b0943d9e0602130120p542c2b0ex@mail.gmail.com>
References: <Pine.OSX.4.64.0602131305420.19080@piva.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 10:20:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8ZsX-0005DL-Av
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 10:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWBMJUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 04:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWBMJUL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 04:20:11 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:59020 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751252AbWBMJUK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 04:20:10 -0500
Received: by xproxy.gmail.com with SMTP id s9so620284wxc
        for <git@vger.kernel.org>; Mon, 13 Feb 2006 01:20:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDk0hOiZupPEmFTHI1va8/OaAz7uPjAyncOhgW4KHRMBtr0m/5RW78mJ7mpb4CRjfRKjCESugkwINgu3cf2MTXnf48/v/EnUo27j0BhgzzCs3N/BnR6JlIpNz+Q/QrFV6HfnRT52vehCCvFsRwxJfDN8B63Vo5ZWsoYHvp6BxAI=
Received: by 10.70.67.5 with SMTP id p5mr2282481wxa;
        Mon, 13 Feb 2006 01:20:09 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Mon, 13 Feb 2006 01:20:09 -0800 (PST)
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.OSX.4.64.0602131305420.19080@piva.hawaga.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16056>

On 13/02/06, Ben Clifford <benc@hawaga.org.uk> wrote:
> The following happens to me. The help text about using "refresh" doesn't
> seem to match up what I actually did. Am I doing something wrong?

Indeed, the 'refresh' help doesn't say anything about this. Dealing
with conflicts can be found in the tutorial.

> $ stg push
> Pushing patch "strcmp-ordering"...Error: three-way merge tool failed for
> file "imap/src/osdep/unix/maildir.c"
> The merge failed during "push". Use "refresh" after fixing the conflicts
> stg push: git-merge-index failed (possible conflicts)
>
> [edit file to get rid of the <<< === >>> stuff]
>
> $ stg refresh
> stg refresh: Unsolved conflicts. Please resolve them first

'stg status -c' would show the conflict files.

> $ rm .git/conflicts

'stg resolved --all' does the same thing. I'd recommend that you use
it instead since it also clears the index if the merge conflict wasn't
handled by gitmergeonefile.py.

If you don't like doing this, you can set 'autoresolved: yes' in your
configuration file (/etc/stgitrc, ~/.stgitrc or .git/stgitrc) which
would mark all the conficts as resolved before refreshing. I
personally prefer to mark each individual conflict as resolved.

Setting 'keeporig: no' would also prevent StGIT from generating the
original versions of the file being merged.

--
Catalin
