From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Configuring git to for forget removed files
Date: Sat, 20 Feb 2010 13:50:25 -0500
Message-ID: <32541b131002201050l35c095a0i1b525e8be7812e59@mail.gmail.com>
References: <4B7FBB73.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andrew Benton <b3nton@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 20:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiuPj-0003xX-Vw
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 19:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0BTSur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 13:50:47 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:40722 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0BTSuq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 13:50:46 -0500
Received: by yxe38 with SMTP id 38so1195785yxe.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 10:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=DGwl1GopRfto6kiQrW59Uv81+CfiIi/bPAkTtfZwdC0=;
        b=xrDmGV3Tg4nqwwNK8BwuxUrzc8eEyOatI1SCgX7L5sai3jTHumUTkBICoBy47sYazf
         k2juPvuLDhi6KW4MYt1qD/ig2nauWTibQiiLxHh15j6AIPuQZHLEQ2byDJ9owS/xPJjM
         D+5g38uwrmyOlpqQEM/5QuDagdJMlHyFkHU8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CWw839TfUibMFD2ogyBufYNYMq/ZVUANUERZ2ZYZSkSt3HZLPDJBixG3+aHj3bLy0u
         ahgl0+SAjXDlpBERRfTyLeGLTnOcMHchnnz2rELv+QfoOtqxrUQvS8m9XtZ7iuT2QKr7
         8+aA4ISx4jTerj2LObqHVPEOEysNaTY0gMluE=
Received: by 10.151.88.17 with SMTP id q17mr4263911ybl.193.1266691845137; Sat, 
	20 Feb 2010 10:50:45 -0800 (PST)
In-Reply-To: <4B7FBB73.70004@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140543>

On Sat, Feb 20, 2010 at 5:37 AM, Andrew Benton <b3nton@gmail.com> wrote:
> I have a project that I store in a git repository. It's a bunch of source
> tarballs and
> some bash scripts to compile it all. Git makes it easy to distribute any
> changes I make
> across the computers I run. The problem I have is that over time the
> repository gets ever
> larger. When I update to a newer version of something I git rm the old
> tarball but git
> still keeps a copy and the folder grows ever larger.

You can use 'git filter-branch', as Tim already mentioned, or use a
git 'shallow clone' to only get the most recent versions of things.

Alternatively, have you thought about storing *uncompressed* tarballs
in git instead of compressed ones?  Then when you update to a newer
version, git can compute an xdelta from one to the other and store
only the changes.  That means you can have full history *and* not
waste too much disk space.  Git compresses the objects anyway when it
stores them in the repository.

Have fun,

Avery
