From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 12:17:27 +0100
Message-ID: <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 12:17:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psvg1-0000WC-Pl
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 12:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab1BYLRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 06:17:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab1BYLRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 06:17:32 -0500
Received: by fxm17 with SMTP id 17so1503681fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 03:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fL8xoPdUHyxA7W9s7fqQVsZMLFy8loM978pD31kfSJs=;
        b=rp7nnRLgAYpTAKFpDvvlTe8MNPZT2+O9IO2ZSe2+tbjZ2XNI3dKGY6ZBjr41afDbvF
         v6ldKT6e/hEMaAoFGuP56Sw5k+g+voHhPM3t5S1t8ZKqpGMYA2cLZJzqSkn6Qw2D79Ne
         K0cpUlc4MYenBDrfRLuzNpj9urUTv4SvwPZH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nwuFdALe/g/uB3lyJe/TvDlJHLKkQHPi0NcUnOPzv3k0IxrhncdttpW0qGVhKJLa7n
         1BAlUOaub+lSkkASBSVZkHg/J5NpnM/+BxSGX8HQVViul5lhpAGwyKY7x0OGFkKQhfEy
         KiQkmMCpXWEMXO9Pepf32GD7PXBe//qhAqG+E=
Received: by 10.223.71.9 with SMTP id f9mr2487574faj.64.1298632647235; Fri, 25
 Feb 2011 03:17:27 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 03:17:27 -0800 (PST)
In-Reply-To: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167900>

On Fri, Feb 25, 2011 at 11:34, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> I tried asking the same question on the "newbie" list some time ago:
>
> http://groups.google.com/group/git-users/browse_thread/thread/d562b4eeac016711
>
> Basically, when I go
>> git revert <commit> <path>
>
> .. my expectation was that a new commit would be made reverting the
> changes from the old commit, but only for specified path/file.
>
> Maybe it's a bit of a corner-case, but still would be nice to have
> once in a while. What do you think?

It would. What you can do in the meantime is:

    git revert <commit>
    git reset
    git add <path>
    git commit ...
    git reset --hard # making sure you didn't have uncommited changes earlier
