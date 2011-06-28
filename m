From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 1/6] rebase -i: Add the "ref" command
Date: Tue, 28 Jun 2011 07:15:53 -0400
Message-ID: <20110628111553.GU5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <186680ca6febeb231e9a4fb44cee1e6aff58db6c.1309133817.git.greg@quora.com> <7vd3hzxgbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWKx-0001OH-Gf
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab1F1LQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 07:16:57 -0400
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:60883 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755987Ab1F1LPz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 07:15:55 -0400
X-AuditID: 1209190d-b7bdeae0000004f8-dc-4e09b796f260
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 17.BE.01272.697B90E4; Tue, 28 Jun 2011 07:14:30 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p5SBFsba001930;
	Tue, 28 Jun 2011 07:15:54 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SBFr4k016606;
	Tue, 28 Jun 2011 07:15:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd3hzxgbn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsUixCmqrTttO6efQf8xK4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj6uyZrAXzBSq2vVvE0sD4gbuLkZNDQsBE4kT7
	PyYIW0ziwr31bF2MXBxCAvsYJTr/7GeHcDYwSrxo/cUE4XxhlLgx8RwzSAuLgKrE1u8vWEBs
	NgEFiR/z14HFRQTUJCa2HQKLMwuIS6ybe54dxBYWsJRY/WcPI4jNK2AssWt5FwvE0CWMEo/6
	7rBAJAQlTs58AtWsJXHj30ugzRxAtrTE8n8cICangJnE7G3lIKaogIrEqqWZExgFZyHpnYWk
	dxZC7wJG5lWMsim5Vbq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxjBgSvJu4Px3UGlQ4wC
	HIxKPLxMKzn8hFgTy4orcw8xSnIwKYnydm7j9BPiS8pPqcxILM6ILyrNSS0+xCjBwawkwjvV
	CCjHm5JYWZValA+TkuZgURLnVfP+7yskkJ5YkpqdmlqQWgSTleHgUJLgtQVGqJBgUWp6akVa
	Zk4JQpqJgxNkOA/Q8BaQxbzFBYm5xZnpEPlTjIpS4rzOIM0CIImM0jy4XlhiecUoDvSKMK8R
	SBUPMCnBdb8CGswENLisFmxwSSJCSqqBsfzsS7Za9bVNNeFbVzMxp+t26Duvmnlutfvzx5sO
	zj41ny/i06F5u9fMWHXw0rOHX51aclybLr4uLOycGHxZryPmIofzXVUfy1vnVntMLWmv6LUJ
	MGZc172A4WjzCqXlznwB6usDRB/yzN20YVHnFOPvZWyrHi8qunDC7nRtffwn8Udc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176392>

Thanks for the review.

On Mon, Jun 27, 2011 at 11:46:52AM -0700, Junio C Hamano wrote:
> Greg Price <price@MIT.EDU> writes:
> 
> > ...
> > +		if ! grep -Fq " $refname" "$state_dir"/oldrefs 2>/dev/null
> > +		then
> > +			echo "$sha1 $refname" >> "$state_dir"/oldrefs
> 
> (Style) Extra SP between ">>" and "$state_dir/oldrefs"

Hmm -- it looks like the prevalent style in the codebase is actually
to include the space:

greg@gouda:~/w/git$ git grep -c '>>[^ ]' v1.7.6 git-*.sh
v1.7.6:git-bisect.sh:3
v1.7.6:git-instaweb.sh:2
v1.7.6:git-rebase--interactive.sh:2
v1.7.6:git-stash.sh:1
greg@gouda:~/w/git$ git grep -c '>> ' v1.7.6 git-*.sh
v1.7.6:git-am.sh:1
v1.7.6:git-filter-branch.sh:1
v1.7.6:git-instaweb.sh:8
v1.7.6:git-rebase--interactive.sh:10
v1.7.6:git-rebase--merge.sh:1

and in particular in git-rebase--interactive.sh.  But I could do it
either way.



> > @@ -332,6 +334,15 @@ skip)
> >  abort)
> >  	git rerere clear
> >  	read_basic_state
> > +	[ -n "$oldrefs" ] && echo "$oldrefs" | while read sha1 ref
> 
> (Style) I think almost everybody else spells out "test".  Also please
> break line before the while, like this:
> 
> 	test -n "$oldrefs" &&
> 	echo "$oldrefs" |
> 	while read sha1 ref
>         do
>         	...

Sure, done.



> > +	do
> > +		if test "(null)" = $sha1
> 
> Who is giving you "(null)"???

I am, myself -- it's what the 'ref' implementation in
git-rebase--interactive.sh uses to indicate that a ref had not existed
and should be deleted on abort.

+       ref)
+               mark_action_done
+               refname=$sha1
+               sha1=$(git rev-parse --quiet --verify "$refname" \
+                       || echo "(null)")
+               if ! grep -Fq " $refname" "$state_dir"/oldrefs 2>/dev/null
+               then
+                       echo "$sha1 $refname" >> "$state_dir"/oldrefs
+               fi

I could change it to something like "-".  It needs to be something
that the 'read' builtin, as used at the top of the loop, treats as a
word.

Greg
