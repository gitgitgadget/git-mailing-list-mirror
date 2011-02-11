From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: Fix error message crash in P4Sync.commit.
Date: Fri, 11 Feb 2011 05:44:43 -0800
Message-ID: <20110211134443.GA11773@honk.padd.com>
References: <1297167610-1795-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 14:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PntSP-0001UY-OV
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 14:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab1BKNyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 08:54:40 -0500
Received: from honk.padd.com ([74.3.171.149]:55184 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756361Ab1BKNyk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 08:54:40 -0500
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Feb 2011 08:54:39 EST
Received: by honk.padd.com (Postfix, from userid 7770)
	id 4B59829D6; Fri, 11 Feb 2011 05:44:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297167610-1795-1-git-send-email-torarvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166557>

torarvid@gmail.com wrote on Tue, 08 Feb 2011 13:20 +0100:
> There is an error message that crashes the script because of an invalid ref
> to the non-existing "path" variable. It is almost never printed, which
> would explain why nobody encountered this problem before... But anyway,
> this oneliner fixes it.

Needs signoff.

Acked-by: Pete Wyckoff <pw@padd.com>

> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index ca3cea0..29b9e32 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -1086,7 +1086,7 @@ class P4Sync(Command):
>              if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
>                  new_files.append (f)
>              else:
> -                sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
> +                sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
>  
>          self.gitStream.write("commit %s\n" % branch)
>  #        gitStream.write("mark :%s\n" % details["change"])
> -- 
> 1.7.3.1.68.g06779.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
