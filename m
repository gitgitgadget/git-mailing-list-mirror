From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GPG signing for git commit?
Date: Thu, 7 May 2009 15:30:51 +1000
Message-ID: <fcaeb9bf0905062230h7ba9526fg6b79ddade72c072a@mail.gmail.com>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> 
	<49D99BB2.2090906@vilain.net> <20090415185554.GG23644@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 07 07:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wCb-00009T-GR
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 07:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbZEGFbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbZEGFbP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 01:31:15 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:36582 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbZEGFbO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 01:31:14 -0400
Received: by yx-out-2324.google.com with SMTP id 3so347125yxj.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 22:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=cw8O/w9QGDkd6/UpGkjKP1v4mw0g7FzAF1KLEQgExFY=;
        b=jLov0xcCocg4fXqcZUCiDn3bHTq5GlXejoq8GYZSyqOTicYeNi0foizO7aXVM+15oP
         j+RmlD6iuS7aht7FF5MtE3aBWle69co/JIRTFmZJXzLnAbJyhI0QqlPZ4a894jH+J3fz
         tT8bk90tCrzrPOXCgPoqXnLCGx3bdRiBwv/IE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CFmyzuWRq+HWxmAjdzxUVH6adZOyNMjormi2QAiDnU1RyKI7v+7HlhDidqzmFiZlVt
         ut5LeVIPA+0Yftx/HNHOOaDnDGlzymttt0WvJuRiXo8KutKGYum0rBir3+RSJb9vVra3
         /aVIJk1kwWCRWSOisgoIZ8l9xj6i9e0A3tycA=
Received: by 10.100.153.6 with SMTP id a6mr3795727ane.89.1241674271280; Wed, 
	06 May 2009 22:31:11 -0700 (PDT)
In-Reply-To: <20090415185554.GG23644@curie-int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118425>

On Thu, Apr 16, 2009 at 4:55 AM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> One of the spots that we're looking for in this, is a model something
> like what follows. Firstly, a "proxy maintainer" (PM) is a developer
> with commit rights to the central repo, that's willing to proxy commits
> by an outside source for some specific package. Think of them as the
> kernel subsystem maintainer, but many more of them. The PM is still
> expected to verify the work before passing it on the central repo.
>
> So we have a commit with author+committer being the outside source, and
> now we want to record (in an easily reviewable fashion) that a specific
> changeset was introduced to the central tree by the PM.
>
> Not sure of the best route to trace this data. Signing the SHA1 makes
> the most sense, but need to be able to do that without polluting the tag
> namespace.
>
> If the changeset does not have an associated signature, we'd like to
> reject it at the central repo.

How about signing the tree SHA-1 and putting the signature in commit
message? It's like gpg way of saying Signed-off-by. If the committer
wants to sign again before pushing out, he could amend the commit,
append his signature there; or make a no-change commit to contain his
signature (probably from git-commit-tree because iirc git-commit won't
let you make no-change commit)
-- 
Duy
