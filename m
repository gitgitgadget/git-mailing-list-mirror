From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Mon, 10 Mar 2008 16:34:59 -0700 (PDT)
Message-ID: <m3d4q2ywyx.fsf@localhost.localdomain>
References: <47D5AFF3.90000@yahoo.it> <20080310225302.GE8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Filippo Zangheri <filippo.zangheri@yahoo.it>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:36:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYrXa-0008T2-0b
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 00:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756470AbYCJXfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 19:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbYCJXfG
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 19:35:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14687 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbYCJXfC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 19:35:02 -0400
Received: by ug-out-1314.google.com with SMTP id z38so5009594ugc.16
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=bMNuQB2lzSR+mYAQLl+idvU16yrnE+cTY/qp8FWHz0U=;
        b=awo23lBB8ts5olB4RNF35Kj1eq56cvONUoudfCAAsCyGyJH8I7IAEBlDVCMgiiwU1pDNO0OQGg7gm0qjYNREsDD6sRHkNDnO4/pIqXL5/vKYY7sIcV1qVAAah0JhHFGPPPmvKFGV3z2+y5vbcueT0w06anX1oBIwaCqAkyr8BaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=RyK+n0r5uZW0rBspjtoZvriQVLk95Iaxd4CvGYjCj+caabVeOeSOLWZ0KkYtn8OvzE8khHyza6/6sJqt1QGaNCPKMkWDsFSPvaWsAFaXTQt21Bxx4SBw265b7fJRoznymoQyDimYnv00AhNyoNS/gLnVKY+cE4QxDigVUNz7AK0=
Received: by 10.67.23.5 with SMTP id a5mr4263009ugj.8.1205192101258;
        Mon, 10 Mar 2008 16:35:01 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.230.40])
        by mx.google.com with ESMTPS id w40sm9562875ugc.45.2008.03.10.16.34.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 16:34:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2ANYoQZ032120;
	Tue, 11 Mar 2008 00:34:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2ANYlFr032117;
	Tue, 11 Mar 2008 00:34:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080310225302.GE8410@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76770>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
> >
> > Is it possible to git-fetch only a portion of the tree
> > of the specified repository, say, fetch only one directory or a
> > subset of files matching some regular expression? This is currently
> > - to my knowledge - only possible via wget iff the GIT repository
> > has gitweb enabled. But that's just a workaround.
> 
> No.
> 
> You can use a shallow clone to fetch only X commits back into
> history on any branch, and you can also manually configure the
> fetch specification in .git/config to only fetch specific branches,
> but you must fetch the entire tree to get any of the files in it.
> 
> If the repository is available by git:// protocol you may be able
> to use git-archive to obtain a tarfile for just the directory you
> want (service has to be enabled on the remote side) but that is
> just a raw UNIX tar; there is no Git repository and no ability to
> commit/fetch/push/diff/apply/log/etc.

Note that what you wanted is, I guess, something called partial
checkout or subtree checkout.  This feature appears now and then in
feature requests; lately Nguyen Thai Ngoc Duy (pclouds) offered to do
this in "on subtree checkout" thread:
  http://thread.gmane.org/gmane.comp.version-control.git/74915

The problem is twofold, as far as I understand it.  First, what to do
if there is merge conflicts outside checked out (selected) directory?
Second, how to make repository contain only relevant objects: git in
many places assumes full connectivity, and that if it has an object it
hass all objects depending on it.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
