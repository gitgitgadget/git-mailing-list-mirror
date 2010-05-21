From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 16:58:22 +0100
Message-ID: <AANLkTimIxtmaUNxp-LNy_ui5__BEBetcjTYE17ygIXD2@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	 <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	 <u5tzkzt73us.fsf@beatles.e.vtech>
	 <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
	 <AANLkTimYCxzT16aI96dztmcKYuVrvKikSkrkRHT-Ckcd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:58:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUcH-0008H0-WB
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758312Ab0EUP6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 11:58:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59022 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab0EUP6Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 11:58:24 -0400
Received: by fxm5 with SMTP id 5so991414fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=umcs4s4Pus53fv4K5n2dJbBObkPhdmwCpZuF4zCuepU=;
        b=bJB4xo7y7VDlEwb1yk3vEhLuBCTFd2vsakN1qfQllRkAuKzEilA2lhsvihji9lFUW1
         oTI0k3RaMB16BNcDOGw8kT/M+WceCztzqFH9djvyhndeE0R08xzGBacAE0VBhfQbUelY
         zYsDvFOBpO2hI9pgsHB9RSW9MPeDE4o3wLfmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XwT0mCsnHSFk4Awqulu3z88OzEKFKPuE6WtOEOGFEjoDkjCfImwKdxongFtkJpSRX3
         3tNHhfb/A6GI/cglWsGiQeLzh8X1qEt1/CR9oSH2GJWTGskqR6USUTBirHU1+eZFwnJm
         iYLsMkcWyog5FQDx0iK3OdLDGlehruvw8tay4=
Received: by 10.223.24.133 with SMTP id v5mr1652490fab.46.1274457502709; Fri, 
	21 May 2010 08:58:22 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Fri, 21 May 2010 08:58:22 -0700 (PDT)
In-Reply-To: <AANLkTimYCxzT16aI96dztmcKYuVrvKikSkrkRHT-Ckcd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147473>

On 21 May 2010 16:32, Gustav H=E5llberg <gustav@gmail.com> wrote:
>> On 21 May 2010 14:59, David K=E5gedal <davidk@lysator.liu.se> wrote:
>>> The idea is that Gustav wants to allow the editing of a file as it
>>> appears in an earlier version. Lets say you have patches A, B, C an=
d
>>> D. You realize that one of the changes in to foo.c in C shuold real=
ly be
>>> done in A. So you open the "A version of foo.c" in your editor, do =
the
>>> change, and then save it. The save operation needs to update A to b=
e
>>> the new tree that contains the updated foo.c, and the remaining pat=
ches
>>> will keep their tree. The effect is that the moved change now appea=
rs as
>>> a diff in A, but not in C (nor B or D).
>
> David's example does not exactly describe the situation I have in
> mind. I was only envisaging the possibility to move a change from one
> patch to one of its neighbours. This is enforced by keeping all other
> trees intact.

Yes, that's something commonly needed.

> On Fri, May 21, 2010 at 5:16 PM, Catalin Marinas
> <catalin.marinas@gmail.com> wro> This is currently achieved by "pop B
> C D", edit file, "refresh", "push
>> --set-tree B C D".
>>
>> Can "edit --set-tree <sha1>" make this simpler? Which <sha1> value
>> would be used with "edit --set-tree" (unless that's done by Emacs mo=
de
>> behind the scene and it generates the tree that gets passed to edit)=
=2E
>
> This is indeed my assumption. Without a "smart" user interface to hid=
e
> the intricacies this operation becomes too complicated. At least
> unless you work exclusively with the index. My prototype for the Emac=
s
> mode approximately does 'read-tree <old patch sha1>', 'update-index
> --cache-info <new blob>', 'stg edit --set-tree $(write-tree)'.

OK. As I said, I don't have  a problem with the patch. Maybe you could
mention in the help that it's usually meant for tools like Emacs,
otherwise people would wonder how to use it from the command line but
as it is, the patch looks fine.

> I actually think it is the use of the Emacs user interface that reall=
y
> enabled us (me and my colleagues) to see the stack as a living set of
> changes that are very easy to edit. This lead to the conclusion that
> one wants to make it much easier, light-weight and faster to move
> individual changes between (for a start, neighbouring) patches.

I try to reduce the patch editing as much as possible since I need to
have some public branches that have an immutable history (hence the
stg publish command).

BTW, since you are a group of people using stgit, have you found a
useful way to share patches/series easily?

=46or example, one colleague works on a set of patches and I'd like his
included in my series but I don't want me to maintain those, so
periodically I would have to re-import his patches. There is a way to
use a combination of export and sync but it's not always easy to
follow.

StGit has the patches (diffs) in the a *.stgit branch but solving
conflicts in diff is problematic, so not sure how to use that for easy
synchronisation.

--=20
Catalin
