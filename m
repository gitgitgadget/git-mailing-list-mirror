From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 17:36:35 -0400
Message-ID: <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <47EECF1F.60908@vilain.net>
	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
	 <47EFD253.6020105@vilain.net>
	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
	 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
	 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgRh1-0002HG-9P
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 23:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757717AbYCaVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757538AbYCaVgi
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 17:36:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:61985 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757409AbYCaVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 17:36:37 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1859123wxd.4
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eSVQY+yJv0UYkPx1cPsgDxKWndNHfUmdzKSNUoEJf8M=;
        b=e32fM1QSPIcA8q6WmsC2VZAoP9FrzYULsBqjXhjWi9DuB5+djVXiF5kwMO2Luo20SEMpbi9Z1kk+dQjnfgy8kI6XPK8YJw9SzH08A4sW8Iog9SWAEBYmBn66Uv6Nmm1gS0QqLC6icO7lGaSDp3gFMyJBoQmowgtcdb84tJZBMQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CbbDTgdm5t5fFWAz+KC2aPxObT7tDDjOv4n9KiUkdV7IG2p++x1i6Bsu+WLyPg1Dkbe3WMaFwXjHyJk+EsnXuF5WPMxXGRVA8nQdP40v93Qup7tyhk6ByD37TTVv7kiToQY2pSQhIh1X0MZ6BwQwPrYq5KIC35/Yh6c0BFa2sF4=
Received: by 10.100.214.19 with SMTP id m19mr16939781ang.50.1206999396042;
        Mon, 31 Mar 2008 14:36:36 -0700 (PDT)
Received: by 10.100.91.16 with HTTP; Mon, 31 Mar 2008 14:36:35 -0700 (PDT)
In-Reply-To: <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78606>

On Mon, Mar 31, 2008 at 5:29 AM, Eyvind Bernhardsen
<eyvind-git@orakel.ntnu.no> wrote:
> On 31. mars. 2008, at 01.03, Avery Pennarun wrote:
>  As I tried to explain, all the automatic push solutions I could come
>  up with were flawed, so I decided not to use submodules at all and
>  just have the build tool check out every module (that's what we
>  currently do with CVS, so it's the easy way out anyway).

I even *use* git-submodule and had to modify my build scripts because
"git submodule init" and "git submodule update" don't seem to kick in
automatically for some reason.  The ideal situation would be to have
git just manage the version control without having to babysit it, of
course.  That's hard to do in the general case, but should be quite
possible in the limited situation that I'm proposing in this thread.

>  If I understand you correctly, you want to be forced to create a
>  branch and push to that?  I don't think that works well with many
>  developers pushing to a shared repository (my situation),

Hmm, this is curious.  If you're *not* using submodules, then I don't
think you can push successfully without being on a branch, can you?
So the suggestion merely extends this behaviour to submodules.

(To be more precise, 'git push' seems only to be able to push branch
heads.  When you're not using git-submodule, commits are by default
attached to branch heads, so this doesn't cause a problem.  If you
disconnect your HEAD, trying to push will silently do nothing, because
it'll push some other branch head that hasn't changed, or maybe no
branch at all.  But with git-submodule, the *default* is a
disconnected HEAD, which is too dangerous.  I propose to simply have
it fail out in this case.)

If you 'git checkout -b branchname' inside a submodule, then 'git
push' will do the right thing, so I'm not sure what you'd want to be
more automagical than that.

>  If you have local changes committed in a submodule that is updated by
>  a pull in the main module, "submodule update" will silently overwrite
>  them.  I was wrong, though, because you can fix that just by making
>  "submodule update" error out when a submodule doesn't have its HEAD
>  where the main module thinks it should be.

Shouldn't "git merge" get a merge conflict if you've made a checkin
that changed the submodule pointer, then try to pull someone else's
checking that changes the submodules pointer to something else?  It
would seem there's no better option than that.

While we're here, it's inconvenient to have to call "git submodule
update" at all when there *isn't* a conflict.  It should always be
safe for git checkout or git merge to do that for you, no?

Thanks,

Avery
