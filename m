From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Git for redundant mail servers
Date: Sat, 23 Apr 2005 18:24:33 +1000
Message-ID: <2cfc403205042301243841fe0c@mail.gmail.com>
References: <1114238562.3419.29.camel@localhost.localdomain>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 10:20:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPFrr-0002Ml-Ad
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 10:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVDWIYl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 04:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVDWIYl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 04:24:41 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:13108 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261469AbVDWIYh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 04:24:37 -0400
Received: by rproxy.gmail.com with SMTP id j1so940056rnf
        for <git@vger.kernel.org>; Sat, 23 Apr 2005 01:24:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmLr99Q5RFxWdhdSCaFrJnY6MtifVURsS5YD8bZ95cONnOijd4URX0pxQ2Wjjp2/5NMse7pKvsdV1wLNncxIxfgHprUXMOQOwaTSyRnXmV3zeM5SzwHmVvCCoNYlqG0vZrweY8EkR25h+fcQInlyXeKslm5VnMtJH5HG9ZHtEFo=
Received: by 10.39.3.79 with SMTP id f79mr1439612rni;
        Sat, 23 Apr 2005 01:24:34 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Sat, 23 Apr 2005 01:24:33 -0700 (PDT)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114238562.3419.29.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/23/05, David Woodhouse <dwmw2@infradead.org> wrote:
> Random alternative use for git... we could use it to provide a cluster
> of redundant mail delivery/storage servers.
> 
> The principle is simple; you use something like a set of Maildir
> folders, stored in a git repository. Any action on the mail storage is
> done as a commit -- that includes delivery of new mail, or user actions
> from the IMAP server such as changing flags, deleting or moving mail.
> These actions are actually fairly efficient when Maildir folders are
> stored in a git repository -- the IMAP model is that mails are
> immutable, and flag changes are done as renames.
> 
> In the normal case where all the servers are online, each commit is
> immediately pushed to each remote server. When a server is offline or
> separated somehow from the rest of the group, it's going to have to do a
> merge when it reconnects -- we'd implement a Maildir-specific merge
> algorithm, which really isn't that hard to do.
> 

This is a cool idea. When the concept is rendered this way, it sounds
a lot like some of the core principles in the architecture of the
Lotus Notes replication engine. I've always thought it would be cool
to have an open engine that provided similar functionality to the
Lotus Notes replication engine without the naff programming
environment that sits on top. I can see how the git concepts and code
could provide the basis of such a solution. Very cool.

jon.
