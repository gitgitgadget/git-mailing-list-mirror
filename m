From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 23:03:13 +0700
Message-ID: <CACsJy8BBvgJauL4a9MxWAXGN-_qiAKprt15hizyBp0O9knwKrg@mail.gmail.com>
References: <loom.20110815T162144-798@post.gmane.org> <CACsJy8AL5D938HA-sQkFkn_d9xuT2Vw8BKfD-h+V=iEkNrS1eA@mail.gmail.com>
 <loom.20110815T172423-956@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Marko Vukovic <amasniko@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 18:03:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qszdo-0007YU-Bz
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 18:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab1HOQDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 12:03:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1HOQDp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 12:03:45 -0400
Received: by bke11 with SMTP id 11so3088870bke.19
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=so9V4tLhecM1PMghyaaO2ujp2yAgwTlbKvrYpr9pTRw=;
        b=e/oM1y992HJx+rWlZmZr0d/iLKvlbC+mhA/wTaLdKDOkEPdYrAOsgn+msLa4aZFL7E
         kXlPpFezvNG51I2onYmdC6TXFFcgEIVARc4FDpL909Lry5gcWRV87ylRu1A6JxfV4Wbs
         6w4Y6y4Z+PiyXWy+QOwYHuByMuyTM26kVwSK8=
Received: by 10.205.34.130 with SMTP id ss2mr994779bkb.175.1313424223291; Mon,
 15 Aug 2011 09:03:43 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Mon, 15 Aug 2011 09:03:13 -0700 (PDT)
In-Reply-To: <loom.20110815T172423-956@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179378>

On Mon, Aug 15, 2011 at 10:48 PM, Marko Vukovic <amasniko@yahoo.com> wrote:
> Pardon my ignorance, but what does "git reset" do? I have got some uncommitted
> changes in the staging area. What will happen to them?

I should have written "git reset --soft 1b9a976133", which resets HEAD
ref back to (assuming) good commit. See [1] for more information. I
think for some reason, eGit put a tag object to HEAD, while it should
be a commit object. By resetting it back to the commit that the tag
points to, you may be able to commit again.

No history would be lost. Also if you use --soft, index should be
untouched. As always, back up your repository (copy the whole
directory, including .git) before doing anything.

[1] http://www.kernel.org/pub/software/scm/git/docs/git-reset.html
-- 
Duy
