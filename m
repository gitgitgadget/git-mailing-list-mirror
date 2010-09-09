From: ods15@ods15.dyndns.org
Subject: Re: [PATCH] Add --src/dst-prefix to git-formt-patch in
 git-rebase.sh
Date: Thu, 9 Sep 2010 21:49:20 +0300
Message-ID: <20100909184920.GG4610@crate15.ODS15-HOME>
References: <1283954045-8326-1-git-send-email-ods15@ods15.dyndns.org>
 <1284019625-14096-1-git-send-email-ods15@ods15.dyndns.org>
 <7vbp86n4t4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 20:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmBp-00059N-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 20:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab0IISt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 14:49:26 -0400
Received: from bzq-79-177-53-38.red.bezeqint.net ([79.177.53.38]:36673 "EHLO
	ods15.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0IIStY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 14:49:24 -0400
Received: from ods15 by ods15.dyndns.org with local (Exim 4.71)
	(envelope-from <ods15@ods15.dyndns.org>)
	id 1OtmBU-00047C-V9; Thu, 09 Sep 2010 21:49:20 +0300
Content-Disposition: inline
In-Reply-To: <7vbp86n4t4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155874>

On Thu, Sep 09, 2010 at 11:35:19AM -0700, Junio C Hamano wrote:
> Oded Shimon <ods15@ods15.dyndns.org> writes:
> 
> > For the case of "diff.noprefix" in git-config, git-format-patch should
> > still output diff with standard prefixes for git-am
> >
> > Signed-off-by: Oded Shimon <ods15@ods15.dyndns.org>
> 
> Hmm.

Anything wrong?

> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 7508463..e83a0cf 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -565,7 +565,7 @@ fi
> >  
> >  if test -z "$do_merge"
> >  then
> > -	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
> > +	git format-patch -k --stdout --full-index --ignore-if-in-upstream --src-prefix=a/ --dst-prefix=b/ \
> >  		--no-renames $root_flag "$revisions" |
> >  	git am $git_am_opt --rebasing --resolvemsg="$RESOLVEMSG" &&
> 
> As the format-patch invocation is already multi-line, you probably would
> want to use a continuation line with "\" to keep the line length shorter.

Will do.

> We need to protect ourselves from crazy people, so regrettably something
> like this patch is unavoidable, albeit unsightly.

I am one of those crazy people (hence noticing the bug). I constantly copy 
paste the filenames from diffs in order to write them in command line, 
with mouse double-click which grabs the entire path/filename...

- ods15
