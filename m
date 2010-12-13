From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 13 Dec 2010 17:36:22 -0500
Message-ID: <20101213223621.GD13447@onerussian.com>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
 <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
 <20080718182010.6117@nanako3.lavabit.com>
 <20080718094404.GB32184@machine.or.cz>
 <7vtzen7bul.fsf@gitster.siamese.dyndns.org>
 <loom.20101213T194818-377@post.gmane.org>
 <7vbp4pz9hf.fsf@alter.siamese.dyndns.org>
 <20101213214628.GA13447@onerussian.com>
 <7vlj3txqsz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 23:36:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSH0R-0005hs-FD
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 23:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612Ab0LMWgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 17:36:24 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:52784 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab0LMWgX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 17:36:23 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSH0I-0003gV-8w; Mon, 13 Dec 2010 17:36:22 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PSH0I-0003gS-39; Mon, 13 Dec 2010 17:36:22 -0500
Content-Disposition: inline
In-Reply-To: <7vlj3txqsz.fsf@alter.siamese.dyndns.org>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163602>


On Mon, 13 Dec 2010, Junio C Hamano wrote:
> > hm -- read-tree sounded like yet another unknown to me feature of GIT I
> > was trying desperately to discover ;)  unfortunately it doesn't produce a merge
> > for me

> Didn't I already say it makes sense only with --no-commit?  IOW to shape
> the tree.

rright -- in my case --no-commit so I could remove the content before
committing.

> And in your use case I do not think you would even want to have a merge.
> Even if you run "git rm" to remove non-free stuff from the merge result,
> if you merged the history of 0.2 that contains non-free stuff you are not
> allowed to distribute (forbidden either by upstream or self-imposed dfsg,
> the reason does not matter), people who gets the merge commit can follow
> its second parent to grab the non-free stuff, no?

I see your point better now -- so it is yet another dimension of
"the feature".

as for non-free -- I probably should have been more precise --
non-DFSG (debian free software guidelines)-free ;) i.e.:

*  free compiled,rendered materials, often binary blobs, without
   sources (e.g. .dll's, pdfs etc)

*  material under free but not DFSG-free licenses, etc

* if upstream repository already provides that 'non-free' material it
  would not be much of my misdemeanor to keep them as well buried in the
  repository history.  What I care is to have a cleaned branch from
  which I could git archive, and also which I could inspect in regards to
  changes between releases without visually filtering all changes in
  non-sources (e.g. those binary blobs) or irrelevant content.

  if ever legal situation causes upstream to rewrite history to remove
  them -- I will have to do that as well anyways :-/

Having an actual merge would be useful for making the explicit "bridge"
from upstream branch, thus '--no-commit -s theirs' with consecutive
cleaning before commit looks the way to go IMHO.  But I see now
that I could possibly use read-tree at times if a real necessity comes
to prune non-distributable content, and then obviously I do not want to
drag upstream's illegal stuff along.

-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
