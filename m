From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: SVN to Git: trunk moved during repository history
Date: Tue, 27 Apr 2010 15:55:15 -0400
Message-ID: <v2l2f0f6ced1004271255m6d4a7f70o87be795c87fb66e5@mail.gmail.com>
References: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com>
	 <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 21:55:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6qsP-0004xF-I2
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab0D0TzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Apr 2010 15:55:16 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:40615 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756Ab0D0TzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 15:55:15 -0400
Received: by pzk42 with SMTP id 42so9246113pzk.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 12:55:15 -0700 (PDT)
Received: by 10.143.24.6 with SMTP id b6mr3494362wfj.98.1272398115125; Tue, 27 
	Apr 2010 12:55:15 -0700 (PDT)
Received: by 10.231.85.141 with HTTP; Tue, 27 Apr 2010 12:55:15 -0700 (PDT)
In-Reply-To: <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145940>

So, I tried to clone the repository with this command:

git svn clone -T trunk -t tags/6.x -b branches/6.x <svn_url>/<proj_name=
>

After it completed, I went it to the .git/config file and added a few
more branches/tags from other locations:

[svn-remote "svn"]
        url =3D https://<svn_url>/<proj_name>
        fetch =3D <proj_name>/trunk:refs/remotes/trunk
        branches =3D <proj_name>/branches/{6.x,5.x}/*:refs/remotes/*
        branches =3D <proj_name>/branches/*:refs/remotes/*
        tags =3D <proj_name>/tags/{3.7.x,4.x,5.x,6.x,old-releases}/*:re=
fs/remotes/tags/*

Is my syntax even correct? Can I have more than one "branches"
property? How do I tell git-svn to re-sync with the latest branch/tag
locations?

Thanks!

On Mon, Apr 19, 2010 at 5:18 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> I'm trying to port an SVN project to Git. We have gone through
> multiple layouts for our SVN repository. It started off with just a
> mainline branch in the root folder. Then we went to the standard
> layout (branches, trunk, tags).
>
> The problem is that when I do a "git svn clone --stdlayout"=A0of the
> repository, it's not picking up any of the revisions from when the
> trunk previously resided in the root directory.
> Is there any way to specify that the trunk had multiple paths the way
> you can specify multiple branch folders with -b flag? What would be
> the best course of action for reporting an SVN repo who's layout had
> changed during its history?
>
> Thanks,
> Bradley
>
