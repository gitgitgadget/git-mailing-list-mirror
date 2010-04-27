From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Global .git directory
Date: Tue, 27 Apr 2010 13:37:29 -0700
Message-ID: <l2w8c9a061004271337v62c71145jec782712618e4655@mail.gmail.com>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern> 
	<201004271159.34071.trast@student.ethz.ch> <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 22:38:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rXb-0000e1-5H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755996Ab0D0Uhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:37:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35706 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0D0Uhu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:37:50 -0400
Received: by vws13 with SMTP id 13so1250372vws.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=xQ6OfkOvaLPm9v06C1I96kAfAv45MysBXR0pSqF04kE=;
        b=vbt/zchuyHExSJBH5YyKxWGJjJExbRyJ9zWibpw1/weNfW0Dr42qEixoycK5PHzfmJ
         qZMgHXFjd4zQbGHmw3EDcv0vDK0H4c9Sa1wbzVtxBhtgM44gSwjoecdVl05UhBV4AQ92
         5332JdwoYH3BE1SK8U6wE4XzZrz0Z6X2cGnIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HKNDEOSczKn4NShMGlAV6HjgsedYW7VeGmSQ/EWwk1nfo/8cKPYQvfjDzpPMyq8qZy
         bFc8azT1iO4VBKh/mvldEGrPFDeLuoDfh7sDY5QMtMiay0kmQVkpLp1ZeAqSlhR+eW1X
         cKJdFF5wKjfTvSzN4pdAssPs70MOwboAizY+o=
Received: by 10.229.238.72 with SMTP id kr8mr3172170qcb.76.1272400669145; Tue, 
	27 Apr 2010 13:37:49 -0700 (PDT)
Received: by 10.229.50.72 with HTTP; Tue, 27 Apr 2010 13:37:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145949>

On Tue, Apr 27, 2010 at 13:06, Gerhard Wiesinger <lists@wiesinger.com> wrote:
> I don't like metadata of the repository in MY file structure (e.g. .git in
> top directory, .svn in every directory in subversion, .hg in top directory)
> for several reasons:
> 1.) Searching might arise false results, longer output and takes longer
> (e.g. grep -ir string .)

Using ack, instead of grep is very handy here.  It'll automatically
skip common revision control directories, and (by default) only
searches known text file formats.  There is also "git grep".

> 2.) Making tarballs, diffs, etc.: One has to make ugly --exclude or some
> other workarounds when directories are traversed.

Making tarballs: Is there a reason not to just use git-archive?  You
don't need to make any ugly --exclude rules there, unless you're
trying to exclude things that you track in revision control.

Diffs: Is "git diff" not sufficient here?  If it's not, why isn't it?

> 3.) From an archtectural point of view: It is not technically necessary to
> mix up user data with repository data.
>
