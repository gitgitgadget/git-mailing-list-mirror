From: Andrew Eikum <aeikum@codeweavers.com>
Subject: Re: Copy branch into master
Date: Mon, 28 Nov 2011 12:36:16 -0600
Message-ID: <20111128183616.GB29503@foghorn.codeweavers.com>
References: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ron Eggler <ron.eggler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 19:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV641-0005sH-4Z
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 19:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846Ab1K1SgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 13:36:19 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58745 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab1K1SgS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 13:36:18 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130])
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <aeikum@codeweavers.com>)
	id 1RV63u-0003Ys-1c; Mon, 28 Nov 2011 12:36:18 -0600
Content-Disposition: inline
In-Reply-To: <CAHxBh_T-f7O4r0zn=NtLTYtdbNqd3qSo2tW84aYRJp7ugDSMpw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186025>

On Mon, Nov 28, 2011 at 10:25:33AM -0800, Ron Eggler wrote:
> Some time ago I created a DVT branch in my project and I have almost been
> exclusively working in it. Now the time for some test deployment came and I
> didn't have time to merge it all back into the master thus I gave out the
> DVT branch version. Now I would like to copy exactly what I have in that
> branch back into my master to have an exact copy in my master of what got
> deployed with out any changes.
> How can I do this?

Couple options, depending on what you want:

Rename DVT to master (similar to 'mv DVT master', including
losing the contents of 'master'):
$ git checkout --detach HEAD
$ git branch -M DVT master
$ git checkout master

Retain old master (like 'mv master old_master; mv DVT master'):
$ git checkout --detach HEAD
$ git branch -m master old_master
$ git branch -m DVT master
$ git checkout master

The "checkout --detach" is just so Git doesn't complain about
moving/deleting the currently checked out branch.

If you haven't yet, be sure to read ProGit, which should make
questions like this trivial for you to answer yourself in the future:
<http://progit.org/book/>

Hope this helps,
Andrew
