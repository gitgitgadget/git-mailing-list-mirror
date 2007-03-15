From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: error with symlinks on OSX
Date: Thu, 15 Mar 2007 15:19:43 -0700
Message-ID: <m2wt1i6tfk.fsf@ziti.local>
References: <m2r6rqbfcy.fsf@ziti.local> <20070315194410.GC29547@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:24:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRyMg-0007TD-BR
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 23:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933887AbXCOWU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 18:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbXCOWUM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 18:20:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:37147 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933846AbXCOWTm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 18:19:42 -0400
Received: by wr-out-0506.google.com with SMTP id 41so337458wry
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 15:19:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=BeFvsXtKBHbFbbqEtvKnblwI6lRIQOcoB8mfPNfmF2BkwILoSQrb/7RltDB9eK/ywuV0R9x4QU/KsYse6jO9Xrd297mddIqM21gLEeiyJJUbT2BXF52a7tJy7P4d0VwiF6TQG93yJUQqg5oRyF0eRNwLWcKVznVzYbXdwZDHVys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=CImfxsTkbEIHtb95yOBSH95o5yxMLciNOeXmXmXn2iUW1uPEsIScT9Nkvtd51U3eFt6ztSi19FmsOKAjtLuw9ndhCMB1qMTqRFflbxZtChqG4C+dZBowb26vIf3ep7kO+vcMo7ZMlC+KHlYL63dgcsDQHtAYSkPbrFVWth4QS5o=
Received: by 10.114.197.1 with SMTP id u1mr459511waf.1173997181710;
        Thu, 15 Mar 2007 15:19:41 -0700 (PDT)
Received: from ziti.local ( [140.107.156.111])
        by mx.google.com with ESMTP id y11sm3089582pod.2007.03.15.15.19.40;
        Thu, 15 Mar 2007 15:19:40 -0700 (PDT)
In-Reply-To: <20070315194410.GC29547@spearce.org> (Shawn O. Pearce's message of "Thu, 15 Mar 2007 15:44:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42302>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Seth Falcon <sethfalcon@gmail.com> wrote:
>> error: git-checkout-index: unable to create symlink Category/Makefile (Invalid argument)
>> 
>> Now while my file system isn't smart enough to tell the difference
>> between t and T, it does support symlinks AFAIK.
>
> Yes, it does support symlinks.  Is it possible that the name Category
> already existed, but as a file?  Hmm.

I think in the revision before the update, there was a file
Category/Makefile and that it was replaced by a symlink.

So Category is/was a dir.  Category/Makefile was a file and became a
symlink.  Note that I am using git-svn to track an svn repository and
so the problem could be there.

However, I'm not sure where to look or what experiment to try next.

If I checkout an old revision prior to the file becoming a symlink and
then checkout master, I get:

git checkout -b foobar 74227bbd35a77b8
Switched to a new branch "foobar"
git checkout master
D       Category/Makefile
[...snip...]
D       vsn/Makefile
Switched to branch "master"

git reset --hard HEAD
error: git-checkout-index: unable to create symlink Category/Makefile (Invalid argument)
[...snip...]
error: git-checkout-index: unable to create symlink vsn/Makefile (Invalid argument)
HEAD is now at 30bd65d... the commit msg here


-- 
Seth
