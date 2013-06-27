From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Thu, 27 Jun 2013 20:52:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306272030291.28957@s15462909.onlinehome-server.info>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, 
    msysGit Mailinglist <msysgit@googlegroups.com>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    Pat Thoyts <patthoyts@users.sourceforge.net>, 
    Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBU4TWKHAKGQEQUC7NRI@googlegroups.com Thu Jun 27 20:52:08 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBU4TWKHAKGQEQUC7NRI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f57.google.com ([209.85.216.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBU4TWKHAKGQEQUC7NRI@googlegroups.com>)
	id 1UsHIa-0003nU-Pf
	for gcvm-msysgit@m.gmane.org; Thu, 27 Jun 2013 20:52:05 +0200
Received: by mail-qa0-f57.google.com with SMTP id hu16sf4239qab.22
        for <gcvm-msysgit@m.gmane.org>; Thu, 27 Jun 2013 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=IS7GXxXYHiH3CCTz4jnswMPzCoONp6pAwOQLb92wZo8=;
        b=Z9vX2E6bnfvvqZnfRCKVPXFBkHJQTmbaF4XvdPNX46dptQwFqsHv8MzBhqumjmh1mR
         yqNnQgBhjZr284c8/boHgBIjwfJ7OQe0TVg47kd2qyCTgLut46SPbOMzQaLyX9OxBF91
         51lh8Usj9O7CV6zpzcNX9Q2+c2g5wTagrzGF+kS7z6wutDoxZhNo2aDQNmJuKh/JB/zR
         FKBUGonFYsw8rYsojkDqt/bQNkaHe5xc4iHrnGQZOZBAM2/CM2SaX/rEJg928hnt/Och
         a2mu+HLhqUhSucYQh854tkBX+aOylSh 
X-Received: by 10.182.241.41 with SMTP id wf9mr26334obc.11.1372359123886;
        Thu, 27 Jun 2013 11:52:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.153.104 with SMTP id vf8ls25032igb.41.canary; Thu, 27 Jun
 2013 11:52:02 -0700 (PDT)
X-Received: by 10.66.164.71 with SMTP id yo7mr4023268pab.12.1372359122771;
        Thu, 27 Jun 2013 11:52:02 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTP id bu9si712687pac.0.2013.06.27.11.52.02
        for <msysgit@googlegroups.com>;
        Thu, 27 Jun 2013 11:52:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from mailout-de.gmx.net ([10.1.76.29]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Mdp4t-1Uc8OC3Pw5-00PaOo for
 <msysgit@googlegroups.com>; Thu, 27 Jun 2013 20:52:01 +0200
Received: (qmail invoked by alias); 27 Jun 2013 18:52:01 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp029) with SMTP; 27 Jun 2013 20:52:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kqK9rpBTkfNv5HkwSrLJitvxb0n0xFgZ2/uJd0d
	BVoBkYxMgv6w1m
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229144>

Hi Sebastian,

On Thu, 27 Jun 2013, Sebastian Schuberth wrote:

> Call built-in commands via the main executable (non-dashed form) without
> relying on the aliases (dashed form) to be present. On some platforms,
> e.g. those that do not properly support file system links, it is
> inconvenient to ship the built-in aliases, so do not depend on their
> presence.

A laudable goal!

> diff --git a/git-am.sh b/git-am.sh
> index 9f44509..ad67194 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -16,8 +16,8 @@ s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
>  keep-non-patch  pass -b flag to git-mailinfo
> -keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
> -no-keep-cr      do not pass --keep-cr flag to git-mailsplit
> independent of am.keepcr

That looks to me as if an overly-long line in the diff (not your fault)
was wrapped in the mailer...

> +keep-cr         pass --keep-cr flag to git mailsplit for mbox format

At first, I wondered what changed in this line. But then I realized that
you separated "git-mailsplit" into "git mailsplit". This is purely
nitpicking and I am almost ashamed to do so, but I think it might be
*slightly* easier to read if the "git mailsplit" was quoted.

Having said that, I think it is an important change.

It is a different change, philosophically, though, from changes like this
one:

> @@ -174,7 +174,7 @@ It does not apply to blobs recorded in its index.")"
>      then
>  	    GIT_MERGE_VERBOSITY=0 && export GIT_MERGE_VERBOSITY
>      fi
> -    git-merge-recursive $orig_tree -- HEAD $his_tree || {
> +    git merge-recursive $orig_tree -- HEAD $his_tree || {

This change is code while the former change is documentation. It might be
prudent to split this commit into two, one for calls in scripts, one for
documentation. That way, we could carry the documentation change (which I
whole-heartedly agree with) in Git for Windows should upstream stop before
the fence.

> diff --git a/git-archimport.perl b/git-archimport.perl

This file's diff would be less long if the code was a bit more DRY. But
your changes are sound.

> diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
> index d13f02d..6718bad 100755
> --- a/git-cvsexportcommit.perl
> +++ b/git-cvsexportcommit.perl
> @@ -18,7 +18,7 @@ $opt_h && usage();
> 
>  die "Need at least one commit identifier!" unless @ARGV;
> 
> -# Get git-config settings
> +# Get git config settings

This is not as clear-cut as the changes above. I would tend to call it a
"documentation" change, though.

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a0d796e..53c136f 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -358,10 +358,10 @@ sub req_Root
> 
>      my @gitvars = `git config -l`;
>      if ($?) {
> -       print "E problems executing git-config on the server -- this
> is not a git repository or the PATH is not set correctly.\n";
> +        print "E problems executing git config on the server -- this
> is not a git repository or the PATH is not set correctly.\n";
>          print "E \n";
>          print "error 1 - problem executing git-config\n";
> -       return 0;
> +        return 0;

Please don't. I know, it is a whitespace error. But it makes reviewing
more tedious...

> @@ -3936,14 +3936,14 @@ sub update
> 
>          if ( defined ( $lastpicked ) )
>          {
> -            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
> '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call
> git-diff-tree : $!");
> +            my $filepipe = open(FILELIST, '-|', 'git', 'diff-tree',
> '-z', '-r', $lastpicked, $commit->{hash}) or die("Cannot call git
> diff-tree : $!");

Likewise, this would be a documentation change. It is funny that the
open() did not require a change: apparently, your intended code fixes were
already started at some point, but not finished.

> diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
> index 8643f74..ec1d65b 100755
> --- a/git-merge-octopus.sh
> +++ b/git-merge-octopus.sh
> @@ -97,7 +97,7 @@ do
>  	if test $? -ne 0
>  	then
>  		echo "Simple merge did not work, trying automatic merge."
> -		git-merge-index -o git-merge-one-file -a ||
> +		git merge-index -o git-merge-one-file -a ||

This is a problem. 'git-merge-one-file' cannot be split here AFAICT.

Of course, we could teach merge-index to read *two* parameters instead of
one when it encounters "git" as the <merge-program>. But that would be as
hacky as the whole dashed-form business to begin with.

> diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
> index c9da747..343fe7b 100755
> --- a/git-merge-resolve.sh
> +++ b/git-merge-resolve.sh
> @@ -45,7 +45,7 @@ then
>  	exit 0
>  else
>  	echo "Simple merge failed, trying Automatic merge."
> -	if git-merge-index -o git-merge-one-file -a
> +	if git merge-index -o git-merge-one-file -a

As above, with -octopus.

Apart from the split and the merge-one-file problem, absolutely no
objections from my side, but appraisals!

Ciao,
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
