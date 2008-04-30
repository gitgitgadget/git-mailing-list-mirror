From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 16:31:43 -0400
Message-ID: <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:32:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrIyh-0001dy-Hb
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 22:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678AbYD3Ubr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbYD3Ubr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 16:31:47 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:59355 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbYD3Ubq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 16:31:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so470397fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ixc/CT11TzjrZBbMbMk4gIXcjdErA66aHq66MB6ChQ0=;
        b=UFoPelB/youV57g1rDKo7ZGIfTNYbTzf9ZES79/9EwWldLnkmpcajKpEcEqR83k0WzC8SNBTm5J7Inqa9dcLZ2Yab7rKjQlfgJtffV63XN790+qsI2DVe8DRiZldwygJkeGu4b2qsIbYTra4fYIyf0tAaenB3rRnTxeqzpfFSnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J+7Z+HUuUui+QlcxmA8SLt/rTY2AEaERXWYOsz3xfL3b5oWRsfbFXx7ieuuH5KKTafiC1dtMBTZnXJzttCnMvNX6oilzPbD18lepgm/fSJbAO03QZ2mbqK3sQ2rxXHDvkdWOQFWakdROqXlXFDnWpuCu9rmPzPUQH9DMRm2E8gQ=
Received: by 10.82.153.12 with SMTP id a12mr182375bue.2.1209587503334;
        Wed, 30 Apr 2008 13:31:43 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 13:31:43 -0700 (PDT)
In-Reply-To: <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80870>

On 4/30/08, Tim Harper <timcharper@gmail.com> wrote:
> > The problem, of course, is that you can easily have valuable, but
> > not-tracked, files in there.  Deleting the submodule is therefore no
> > option.
>
>  Submodules are not deleted.  They are moved out of the working copy into a
> folder in .git.  Therefore, upon changing back to the branch with the
> submodule, they are restored, without nay a hair on their head lost.

<drool>

Yes!  I'm a little sad that I didn't think of that, because it sounds
like *exactly* what I want.

What about the following case:
- submodule matches the super module checkin
- make changes to submodule but to *not* commit them
- switch supermodule branches, which should checkout a different submodule
- submodule checkout causes a conflict with uncommitted files

What will/should happen here?  It seems like either the supermodule's
submodule pointer won't be set properly (ie. git-submodule-update will
fail, but the supermodule won't be marked as conflicted, thus
git-commit in the supermodule will commit the wrong submodule
revision) or else submodule files might have to be lost or something.

Also, someone earlier asked for a link to your work.  I'd like to see
it too, as I don't know what a "textmate git bundle" is.  I gather
textmate is a MacOS X program, but I don't know what that has to do
with git-submodule :)

Thanks,

Avery
