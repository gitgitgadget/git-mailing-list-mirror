From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: git push rejected due being behind after git svn dcommit without
 any changes local/remote
Date: Wed, 21 May 2014 23:33:21 +0200
Message-ID: <CAEcj5uURgU0NfocwSxYDJiQvwdyvDgS3Gvo2kFEroz-dg=U5Tg@mail.gmail.com>
References: <CAB10+LtnAiCCiMdrULvioxc-UBQufKD4AzOphvE8bAdq7en04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Henning Sprang <henning.sprang@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnE8b-0005R2-N3
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaEUVdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:33:22 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:52055 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEUVdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:33:21 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so4203352qge.36
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fgFBnta9LqrHd8OaYT2jMMijTu9vvC5th2714FWmyLo=;
        b=dhxpCg5Y94EfbbNI58ZXzbxc4U8/hiksXt4Ge5w0TOWJSgMM38WOa8k0wGwDAqLlaj
         +QESzPp7NKRLqBWowrBzhDLb/Gsl5LKxs1odhy/MbhBrE9aDPOROm9ulXZd05tlyJjpx
         JdjA7NkQvvhTB+FdnhvPC5G1o9Rt7Ty+c7Byq0PJVccej7ZpmKmgLTgeKI1RT6iSrx2C
         xza9o6TCkdgaGdj9Vo3D4YdDRLeKi7fWRE/Z8bEs18p2dMfC50ihcWsbyZDAAj+yYdCn
         9SyMYOLI+0VvaXohP6isCqSeBge1RKtOLyrSRBk2QdPO5bY5CGBsSnAE9B+8CLF9Wq7Z
         UCdQ==
X-Received: by 10.140.21.101 with SMTP id 92mr71195599qgk.57.1400708001172;
 Wed, 21 May 2014 14:33:21 -0700 (PDT)
Received: by 10.140.27.19 with HTTP; Wed, 21 May 2014 14:33:21 -0700 (PDT)
In-Reply-To: <CAB10+LtnAiCCiMdrULvioxc-UBQufKD4AzOphvE8bAdq7en04g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249838>

On Wed, May 21, 2014 at 6:13 PM, Henning Sprang
<henning.sprang@gmail.com> wrote:
>
> You'd say, can happen, when some developers work against the remote
> git repo, others with svn. But I'm the only developer on the project,
> and no one ever commits to the remote svn nor the remote git repo. So,
> I'm clueless.
>
> How can I find out what happens and how to prevent that?
>

This is normal. Every time you update or sync against the SVN server,
your local history is rewritten if you have local commits: All your
local commits are rebased on top of the latest changes coming from
SVN.

If you want to avoid this, only push to your Git mirror when your
git-svn clone and the SVN repo are in sync. Doing so ruins the whole
point of your Git mirror, I assume.

So, I'm afraid you have to get used to just force-pushing to your Git
mirror. Even though this is not considered good practice, it should be
fine as long as you are the only one using this mirror.

Alternatively, you could consider some other mechanism for backup (rsync, etc).
