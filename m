From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Problem creating commits/trees with commit-tree/mktree
Date: Mon, 11 Jan 2010 13:38:02 -0500
Message-ID: <32541b131001111038m3dacaf72sc12f24aba8c60e@mail.gmail.com>
References: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Gavin Beatty <gavinbeatty@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:43:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPEi-00025I-HL
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 19:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab0AKSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 13:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075Ab0AKSn1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 13:43:27 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63066 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0AKSn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 13:43:27 -0500
Received: by yxe17 with SMTP id 17so20544989yxe.33
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 10:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=wdPkDL13EsTWneJYaVt7FxjEB6p2k/NkGHjD8mfmtrE=;
        b=Xi8RAubucDW+lxH56O575gyO1eSAo66dj+Qesyl7PkpDOgGC7E6NKZRe9WtVQZcZpG
         PGE7XhOsWN+WOepJ9BxlT0LMeGx3Zzrfn5e6HEN4Fu1DWMj+3QhKC36HDwTyLGtLYHVo
         1e7y1uM+7oF5e3cCLIk/KtSbFzeHDyVaFDpmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sjd1YH6Gr5k3ERfhbbmGyMumiamLqGmyo/W+5Z8xOU5MbcMbLmcqUsZhz83AEr5mLb
         04ED4iF6QKCdMF0Pnr0E/SzjmgdEa2fyjZcDeTzb6fmxabvx5zD19GO9QF6MzQnCOpgx
         QR3jZfhQEP9qwpaWpFT0QOwLOdIjf5SMFgBBA=
Received: by 10.151.88.42 with SMTP id q42mr10798399ybl.75.1263235102138; Mon, 
	11 Jan 2010 10:38:22 -0800 (PST)
In-Reply-To: <f6d77fed1001111014g73a06923na05cd14d37968b04@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136651>

On Mon, Jan 11, 2010 at 1:14 PM, Gavin Beatty <gavinbeatty@gmail.com> wrote:
> I can create new blobs and trees but can't figure out how to commit a
> new tree/blob _with_ the old tree.
[...]
> I get a commit with treefileisin/file.txt. I haven't included the
> other trees/files so they are gone in this commit. How do I include
> them? Is commit-tree the wrong tool?

When I'm doing similar things, I often prefer just using a temporary
git index file to keep track of my intermediate trees.  Just set
GIT_INDEX_FILE to point at a temporary file; then you can use
git-read-tree to read in an old tree, and git-update-index
(particularly with the --stdin flag) to update it.  Then you can use
git-write-tree to convert the temporary index into a real tree object.

Have fun,

Avery
