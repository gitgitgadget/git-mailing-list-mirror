From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 16:39:57 +0300
Message-ID: <4826F72D.2070205@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet> <4826EEDF.4010404@gmail.com> <20080511132752.GA22778@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 11 15:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvBnq-0007dl-Fz
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 15:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbYEKNkF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYEKNkF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 09:40:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:62761 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYEKNkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 09:40:04 -0400
Received: by ug-out-1314.google.com with SMTP id h2so515574ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=NEgPOtmsiuOD6XdNMHY3pwvqDq0JFDDOkv0E3Ln4yN4=;
        b=k/wNhPMoCZjrLHhWAcoabguMcN1ZkdTKXw5yA/H+fuk5z8x+V/yHsmAZqlPRm4qzxSQLbmwX2L/3JCxfISql1jz1rqTOurrN2FHA6Iy/ydXtmTFBUFKhBxNKu7a1jnsmSaPR+ey+DIq6laYFA9JJXc6D6zv199s9WWd/8tn7+NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rG0ZnFKk6+XDINygMRR8BFzHCYzbyF4mw96YOJGyR5DJJLNbhye3jMQ2mpLYSDioA4hkEx8eEwIqbLaxBv/mtBodmi2Wv5Fqur2s2ICvs2e/miDfKtCFI1tibcocU7O8ss2rSe/9rGAcug5YF97WfibUYqYKC/Dx6N9q2y1Pvtw=
Received: by 10.67.115.15 with SMTP id s15mr4098193ugm.63.1210513202429;
        Sun, 11 May 2008 06:40:02 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id f13sm13101208gvd.2.2008.05.11.06.40.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 06:40:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080511132752.GA22778@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81773>

Bj=F6rn Steinbrink wrote:
 > No. Uncommitted changes are, well, uncommitted. They don't belong to=
 any
> branch yet. A branch is not some structure that contains history in
> itself. A branch just points to a commit, and the commits, with their
> parent-child relations, form the actual history. The index and workin=
g
> tree are not part of a branch.
>=20
> Changing that would even break a workflow that is rather common for m=
e.
> I start working on something that is either just experimental or assu=
med
> to be a very small change. Then I realize that the change is worth
> keeping and/or too big and deserves its own branch. At that point, I =
can
> just do "git checkout -b new_branch", and pretend that I started work=
ing
> on that branch right from the start. With your proposed change, I wou=
ld
> need some extra command to transfer the work in progress from the old
> branch to the new branch.
>=20
> If I ever want to switch to another branch and not keep the changes i=
n
> my working tree and index, I stash them away or create a temporary
> commit, which I later amend. That's a use-case that comes up rather
> seldom though (for me at least).
>=20
> Bj=F6rn

My proposed change shouldn't necessarily break the described workflow. =
Git can keep the current behavior for new branches, but automatically '=
stash' the changes when checking-out an existing branch. At least havin=
g an optional parameter for "auto-stashing" will be nice.

What do you think of that?
