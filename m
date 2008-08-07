From: "Tony Stubbs" <antony.stubbs@gmail.com>
Subject: Re: git svn rebase - could not detach HEAD
Date: Thu, 7 Aug 2008 19:33:36 +1200
Message-ID: <f7d8f60b0808070033g7a322ee4w9147dd51e41850c6@mail.gmail.com>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
	 <7vd4kljnpn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 09:34:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR01B-0004zE-Ia
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbYHGHdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 03:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbYHGHdi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:33:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:59836 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbYHGHdh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:33:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so341197rvb.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2008 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ByjF9SL89+yqMrJdu9ELUNKmj90mySN1SFSIyvZ9CyM=;
        b=BFQuY+uUUPT6Rlx6S2D9VDKsoOn7TXZiEJczX+yAG7CF7EZOaqvA/LaJzxQCpjIDIV
         4PqR1cC3myQK8OvJu1SElo3/W5+27Ny3GGN6DcLZA+AH27vET2aEfRy1q3awhx0/QcNt
         wQqyK2oWspIMhxjrNJPhPhii4BTmD1B5EBSFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=StrarIVPgngqEwdmMjCjoSV2/Yjaxyz0KXTCoP/qMsAqiO++UV5dkrlHum2ZNiETK3
         +b4DaBaXs4m/hlIvyFco02mTVeVFMwE0keuNgyhl6iyXgGLdODou41n26Q4LxA93LtIh
         hFh5DgoZj0G7HcU+hd8xQrfnzGTtDYXFhvPlI=
Received: by 10.115.74.1 with SMTP id b1mr1144079wal.169.1218094416203;
        Thu, 07 Aug 2008 00:33:36 -0700 (PDT)
Received: by 10.114.157.2 with HTTP; Thu, 7 Aug 2008 00:33:36 -0700 (PDT)
In-Reply-To: <7vd4kljnpn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91564>

Ok, woah. that's really weird... note the strange behaviour of
git-clean (i had my ide open, then clossed it. but it still acted
strange)

that seems to have got it. so are you going to apply that patch to git proper?

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git --version
git version 1.5.6.4

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git svn rebase --dry-run
Remote Branch: refs/remotes/git-svn
SVN URL: http://10.107.6.150/repos/portal/oasis/branches/oasis-cr

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase git-svn
First, rewinding head to replay your work on top of it...
error: Untracked working tree file
'webnonline-db-access/target/hanson-db-access-1.0.jar' would be
overwritten by merge.
could not detach HEAD

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git clean -df
Removing .temp/
Removing Libraries/release/
Removing SiebelJavaInterface/release/
Removing SiebelJavaInterface/src/generated/
Removing SiebelJavaInterface/tmp/
Removing Utilities/.apt_src/
Removing Utilities/build/
Removing VFSecurityProviders/build/
Removing VFSecurityProviders/vfSecurityProviders.jar
Removing VFSecurityProviders/vfSecurityProviders_r1_00_01.jar

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase git-svn
First, rewinding head to replay your work on top of it...
error: Untracked working tree file
'webnonline-db-access/target/hanson-db-access-1.0.jar' would be
overwritten by merge.
could not detach HEAD

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git clean -df
Removing Utilities/.apt_src/
Removing Utilities/build/

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git clean -df
Removing Utilities/.apt_src/
Removing Utilities/build/

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git clean -df

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase git-svn
First, rewinding head to replay your work on top of it...
error: Untracked working tree file
'webnonline-db-access/target/hanson-db-access-1.0.jar' would be
overwritten by merge.
could not detach HEAD

<manually deleted "untracked file" here>

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git rebase git-svn
First, rewinding head to replay your work on top of it...
Applying removed generated files
Applying Changed maven call method
Applying Switched dependency to project from jar
Applying Added dependency build
Applying Updated notification service build target

2008/8/7 Junio C Hamano <gitster@pobox.com>:
> "Tony Stubbs" <antony.stubbs@gmail.com> writes:
>
>> $ git svn rebase
>> First, rewinding head to replay your work on top of it...
>> could not detach HEAD
>> rebase refs/remotes/git-svn: command returned error: 1
>
> It is somewhat unfortunate that git-svn does not say anything about what
> ref it is trying to rebase onto here.  I do not use git-svn nor know much
> about the code myself, but here are some ideas.
>
>  * Try "rebase --dry-run" and see what you see from this part of the code:
>
>        sub cmd_rebase {
>                ...
>                if ($_dry_run) {
>                        print "Remote Branch: " . $gs->refname . "\n";
>                        print "SVN URL: " . $url . "\n";
>                        return;
>                }
>
>   Most interesting is what $gs->refname is;
>
>  * If you are using recent enough git (I think 1.5.2 is Ok), update your
>   copy of git-rebase like this, so that you would at least see *why* you
>   cannot detach HEAD.  It is possible that git-svn is giving a nonsense
>   ref to detach to.
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index e2d85ee..7825f88 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -376,9 +376,7 @@ fi
>
>  # Detach HEAD and reset the tree
>  echo "First, rewinding head to replay your work on top of it..."
> -git checkout "$onto^0" >/dev/null 2>&1 ||
> -       die "could not detach HEAD"
> -# git reset --hard "$onto^0"
> +git checkout -q "$onto^0" || die "could not detach HEAD"
>
>  # If the $onto is a proper descendant of the tip of the branch, then
>  # we just fast forwarded.
>



-- 
___________________________
http://stubbisms.wordpress.com/
