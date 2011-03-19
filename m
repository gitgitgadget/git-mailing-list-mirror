From: Ilyes Gouta <ilyes.gouta@gmail.com>
Subject: Re: Question: How to rebase my changes on a new base (ref)?
Date: Sat, 19 Mar 2011 09:54:18 +0100
Message-ID: <AANLkTi=8hbaMZDhrdC1pppk5OBejTuaMSpG4BCr_TpGs@mail.gmail.com>
References: <AANLkTinnGw-u-snLwTUzry2PRmTUD7oDGjedJLhkJGoh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 09:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0rvo-0003oP-5M
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 09:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab1CSIyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 04:54:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40164 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab1CSIyj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 04:54:39 -0400
Received: by vws1 with SMTP id 1so4242547vws.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=Lh65PlcIwbaTo3B/5/ajdnjdCUwsJStEp6q8+sL8cJ8=;
        b=Q9b8PqCfD70FZA0SwmrON5Yp8X5IAXP9NGm4SlctNpMjm1TUn+oe6Qjw7DdN+crP3o
         DYPQS3mm0g80TyJaZZwaKyGSZdeSvdcRnmKIrmUbbq64XFtp2Uixn2rqfpVNXbr6BK3A
         dCBCCZjU+uQ6glGdh/7Bwazb4RQFzps7emmLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=So9FizqmDh7zgvOssEOtTBwagwfVKnRfzfKMBJrX8qZniLhV/RxwnVRQ+Wx/JeG6OK
         bTM5zasxhK5buAO5/no5HLb/2KxxL+HuJqvNQWE1Ui6dN8PQn0p0xT9hAVbi9X/cp65B
         HeLYqwpAb83aARWxHSRbVBXeTNvqzGEQuOhZw=
Received: by 10.52.65.52 with SMTP id u20mr2695756vds.309.1300524878212; Sat,
 19 Mar 2011 01:54:38 -0700 (PDT)
Received: by 10.52.169.163 with HTTP; Sat, 19 Mar 2011 01:54:18 -0700 (PDT)
In-Reply-To: <AANLkTinnGw-u-snLwTUzry2PRmTUD7oDGjedJLhkJGoh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169417>

Please CC me in the reply. I'm not registered to the mailing-list. Than=
ks!

-Ilyes

On Sat, Mar 19, 2011 at 9:50 AM, Ilyes Gouta <ilyes.gouta@gmail.com> wr=
ote:
> Hi,
>
> I've been tracking a project, via the master branch, customizing
> certain aspects and applying my changes into a separate local branch
> B. In the mean time, there is this new remote branch
> origin/release_2.1, that was created for releasing a certain version.
> It happened that I merge entirely that master branch into my local
> branch, periodically, in order to get the latest change sets. It also
> happens in that projects, that commits from branch C get merged into
> the project's origin/master.
>
> I'd like to do the following: Take all the those changes I made
> against origin/master, checkout a local branch based on
> origin/release_2.1 and apply them on it. This way I can get my
> customizations re-based against that particular branch (stream)
> instead of origin/master being the parent/upstream.
>
> Is it possible to achieve that? does it involves a kind of git
> rebasing (--onto ?). So far, I used exclusively a merge flow to
> maintain my private branch B in sync with origin/master and that righ=
t
> now that code base is more recent than origin/release_2.1.
>
> Here is the structure, in ASCII, of the project: (best viewed with a
> proportional font)
>
> origin/master
> |
> |
> | =A0| =A0|
> | =A0| =A0|
> | =A0| =A0|
> +--|--\ (sometimes commits in origin/release_2.1 go into origin/maste=
r)
> | =A0| =A0|
> | =A0| =A0|
> | =A0| =A0|
> | =A0| =A0|
> | =A0| =A0|
> | =A0+ =A0| (git merge origin/master into my_private_branch)
> | /| =A0|
> + =A0| =A0|
> | =A0| =A0|
> | =A0| =A0|
> | =A0+ =A0| (git merge origin/master into my_private_branch)
> | /| =A0|
> + =A0| =A0|
> | =A0| =A0| origin/release_2.1
> | =A0| =A0/
> +--|-/
> | =A0|
> | =A0| my_private_branch (git checkout -b)
> | =A0/
> +/
> |
> |
>
> Regards,
>
> -Ilyes
>
