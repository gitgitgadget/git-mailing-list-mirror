From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat, 1 Mar 2008 18:28:14 +0800
Message-ID: <46dff0320803010228g2d4672c3qd0548133d43b11a@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803010201q72a72et951e0a3f090684e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 11:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVOxZ-00049c-3F
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 11:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbYCAK2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 05:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbYCAK2Q
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 05:28:16 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:58422 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbYCAK2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 05:28:15 -0500
Received: by an-out-0708.google.com with SMTP id d31so1001937and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 02:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b/SqunES9UOM0Gfcl3rCC+TsmyVSZqhlOdCY+j8MYq8=;
        b=CmAUQv3Q1MVdJ6sx18yJzXjLtLFYv8asRSWfg9GI2n3/sCxFLkA4dNU99Cv8LDD/q/V986gX38fum/OkjkYC4eT8KkDr83Oxx5rql4Cq85xTwelHr7p3WW7aVFnzYozn7Wntm+QgYoOW4cEZIQqptNsMuwFGH1TW9NcSbuXcxRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X30Tg8binix+tr6QO5EJEQE9+tuEW4r1JikgtO1n+0dK/xvRicbqLHSfy4CN949GDPh6WkelPOupHIxOZwpDSxPYrdteUrRebVxCpHQADnhJ/gt4vk4hI7XlaUrLPKna7+iorkE6bIO3cP8TrkG7o79Ta6CnX+zX0mnhDybqzgc=
Received: by 10.100.3.4 with SMTP id 4mr22316352anc.67.1204367294159;
        Sat, 01 Mar 2008 02:28:14 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 02:28:14 -0800 (PST)
In-Reply-To: <46dff0320803010201q72a72et951e0a3f090684e4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75650>

On Sat, Mar 1, 2008 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
 >
 > Ping Yin <pkufranky@gmail.com> writes:


> > .Example: a super project with modified/deleted/typechanged submodules sm1 to sm5.
 >
 > Overlong lines.  What's the dot before "Example"?

 '.' is an asciitext syntax. Maybe i should not use it in a commit message.


 > >
 > > sm3 and sm4 are submodules with typechanging (blob<->submodule).
 >
 > Are they?  I think you meant 4 and 5.
 >

 oh, it's a typo


 >
 > > This patch just gives the framework. It just finds the submodules to be
 > > shown as follows.
 > >
 > > --------------------------------------------
 > >  $ git submodule summary
 > >  # Submodules modifiled: sm1 sm2 sm3 sm4 sm5
 > >  #
 > > --------------------------------------------
 >
 > Probably it would be a better organization to show only this in the commit
 > log message for [1/3] and describe how the output is enhanced in the log
 > message of the commit as the code builds more .
 >

 Nice suggestion. Should i move most text into man page instead of in
 commit message?



 >
 > > +# @ = [head counting commits from (default 'HEAD'),] requested
paths (default to all)
 > > +#
 >
 > What's "@ =" convention?
 typo again, should be $@


 >
 > > +cmd_summary()
 > > +{
 >
 > We seem to have '{' on the same line for shell functions in our scripts.
 >
 ok

 >
 > > +     # parse $args after "submodule ... summary".

> > +     while test $# -ne 0
 > > +     do
 > > +             case "$1" in
 > > +             --cached)
 > > +                     cached=1
 > > +                     ;;
 >
 > If you do this "cached="$1" instead here, then you do not need to do ...
 >
 > > +     cache_option=${cached:+--cached}
 >
 > ... this.
 >
 --cached may be passed before 'summary' subcommand. So in the outer
 option parsing should i replace cached=1 to cached=$1 just in this
 patch or in another patch?

 >
 > > +
 > > +     if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)

> > +     then
 > > +             head=$rev
 > > +             shift
 > > +     else
 > > +             head=HEAD
 > > +     fi
 >
 > Hmph, is showing diff with anything other than HEAD useful?  What happens
 > if the user says "git submodules status HAED" by mistake?
 >
 s/status/summary ?
 This patch has nothing to do with git submodule status.
 'git submodule summary' and 'git submodule summary HEAD' is equivalent

 Except HEAD, HEAD^ is neccessary. Since my target is to call 'git
 submodule summary' in wt-status.c and teach git-status and git-commit
 show this summary. So when 'git commit --amend', 'git submodule
 summary HEAD^' should be used.
 >
 > > +
 > > +     cwd=$(pwd)

> > +     cd_to_toplevel
 > > +
 > > +     # Get modified modules cared by user
 > > +     modules=$(git diff $cache_option --raw $head -- "$@" |
 >
 > When scripting, please do not use "git diff" unless absolutely necessary.
 > Its output is not meant for script consumption and can be made more "user
 > friendly" as user request comes in.  Instead, use "git diff-index" here.

 ok


 >
 > > +     test -n "$modules" &&

> > +     echo "# Submodules modified: "$modules &&
 > > +     echo "#"
 > > +     cd "$cwd"
 >
 > Hmph, is there any point to try coming back there?  You could have even
 > done the cd-to-toplevel inside of $( ... ) construct which is run inside a
 > subshell, so...
 >
 Hmm,  just to avoid side effect of this function.  I'll put 'cd' into
 the subshell



 --
 Ping Yin
