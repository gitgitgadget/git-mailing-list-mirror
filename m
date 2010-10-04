From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git version of some common SVN hooks?
Date: Mon, 04 Oct 2010 13:58:24 -0700
Message-ID: <4CAA3FF0.2040404@gmail.com>
References: <AANLkTimPGtH9xCh8rLSMAa2KDNOEDUt49qFK7p==aZho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2s76-0003Z1-5Y
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223Ab0JDU6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:58:17 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48446 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168Ab0JDU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:58:17 -0400
Received: by pzk34 with SMTP id 34so1439791pzk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=y1v/q2aPNiZhyGogW7bZOjd72Zy2n+SG0wiq6rnTS6w=;
        b=r4N2trvWKwPstAqxmW0Ik/II1p6yBJXt+S7aGDUsgPbS771iEfHASs9l9Du1jgdggH
         gldx80besDekWIi/95jLG6WttE3+TuAYuoI4aIWk6LBYcqO8M8T4nN/0DvojUz4mAWQp
         0TUdx6QUZtKnyiRxaQB64tUf4Zo/ViozfqjhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=C3QV7fHjlINFHhhHEv+ktnqrBHYxRChFZwr2jKlSmFxVztJ5vq5YymD0f6KRqUJozd
         LzvwWqEnaFz7Ds1jgA5wkHxlV1VFrQFqPJ4tv4CLymwWPjzQlGeGpSRnWcRCC9BBTgl0
         RkXZdYbYbDGC7flg0vufSuE1mMcSvddjo0lyQ=
Received: by 10.114.121.18 with SMTP id t18mr12186304wac.136.1286225885794;
        Mon, 04 Oct 2010 13:58:05 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id r37sm10035817wak.23.2010.10.04.13.58.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:58:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTimPGtH9xCh8rLSMAa2KDNOEDUt49qFK7p==aZho@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158115>

On 04/10/10 12:43, Dun Peal wrote:
> Hi,
> 
> I'm porting a large and active repository from SVN to Git.
> 
> To provide the developers with the same features, I need the Git
> version of the following common hooks:
> 
> 1. svn2cl: the Subversion ChangeLog Generator. Basically a script that
> sends a readable email listing a range of commits, showing just a
> short summary for each commit: author name, timestamp, hash, paths
> modified, commit message.
> 2. Hook to reject any commit containing a path with non-ASCII characters.
> 3. Hook to reject any commit causing the repository to contain two or
> more paths that differ from each other only in letter case. For
> instance, a commit adding foo/bar.py would be rejected if foo/Bar.py
> was added as part of that same commit, or already existed in the repo.
> 4. Hook to trigger an action based on which path was committed to. For
> example, if a developer commits into REPO_ROOT/foo, send an email to
> address foo@somedomain, whereas a commit to REPO_ROOT/bar will send an
> email to bar@somedomain.
> 
> I'm hoping there are Git versions of these hooks already written, but
> if now any leads about implementing them would be appreciated.
> 
> Our full setup btw is a large repository hosted on a local instance of
> Gitorious. All our users use Git >= 1.7, although they work on all 3
> operating systems: Linux, OS X, Windows.
> 
> Thanks, D

I don't know if they suit all of your needs but there are a few default
hooks that ship with git. Have a look at .git/hooks/*.sample in any
init-ed git repository. You can also find them here
http://repo.or.cz/w/git.git/tree/HEAD:/templates

There are also some in http://repo.or.cz/w/git.git/tree/HEAD:/contrib/hooks

There are plenty of others but that's the extent of the googling I'm
going to do for you.

Pre-empting your next question. One point to note is that for security
reasons the hooks don't get included when you clone a repository. This
is OK for most people as you generally want these things on the server
containing the canonical repository anyway, what other people do with
their clones is up to them.

At $dayjob we have a few hooks enforcing coding/commit policy so we
wrote a simple script that can either wrap git clone or be run after git
clone to install the hooks for individual developers.
