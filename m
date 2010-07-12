From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: git-svn: both merged commits and original commits are showing up 
	in branches after migration
Date: Mon, 12 Jul 2010 14:31:44 -0400
Message-ID: <AANLkTikTDv5NI_7oEdfdp4ZHY6No4JKTJU28Sat9wQhk@mail.gmail.com>
References: <AANLkTikwyFwO2G1E6rozSxrI4g51wyA8CFV5jl30qRo-@mail.gmail.com>
	<AANLkTin3TYuC-y2U-o4NEgXH7N4M59vqWxXsa6J2Ae74@mail.gmail.com>
	<20100712182421.GA8644@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 20:31:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYNnD-0003xF-8h
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 20:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab0GLSbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jul 2010 14:31:45 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56680 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0GLSbp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 14:31:45 -0400
Received: by qyk38 with SMTP id 38so4503040qyk.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 11:31:44 -0700 (PDT)
Received: by 10.224.93.203 with SMTP id w11mr7964219qam.75.1278959504235; Mon, 
	12 Jul 2010 11:31:44 -0700 (PDT)
Received: by 10.229.38.133 with HTTP; Mon, 12 Jul 2010 11:31:44 -0700 (PDT)
In-Reply-To: <20100712182421.GA8644@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150837>

Thanks!

Seemed weird at first that I would see both the original commit and
the merge. I'm realizing now that this is the way Git handles merges,
however, so I guess it's just trying to apply the same logic during
the svn 2 git migration by utilizing the svn:merge-info to "re-create"
the branch history.

I noticed that this did not happen in branches created before we
upgraded to the SVN version that supported merge tracking.

On Mon, Jul 12, 2010 at 2:24 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Bradley,
>
> Bradley Wagner wrote:
>> On Thu, Jul 8, 2010 at 10:58 PM, Bradley Wagner wrote:
>
>>> I've done a migration using "git-svn init" and "git-svn fetch". Aft=
er
>>> the migration, I did a "git log refs/remotes/svn/6.7" and found tha=
t
>>> it listed both the commits that I merged into the 6.7 branch and th=
e
>>> original commits to the trunk/master even though the SVN history
>>> obviously only has what was merged into that branch.
>
> Yes, this is intentional. =A0If you try =91gitk --all=92, you can see
> the history of all branches, where they branched from, and so on.
>
> As far as I know the svn:mergeinfo is not actually used until
> a merge. =A0Instead, git-svn uses subversion=92s file copy tracking
> information to follow history past a branch point; see the
> find_parent_branch function in the git-svn script for details.
>
> Hope that helps,
> Jonathan
>
