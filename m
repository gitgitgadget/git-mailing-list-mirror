From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #05; Thu, 30)
Date: Thu, 30 Jun 2011 23:09:09 -0600
Message-ID: <BANLkTikeg+=QrxiRB7fxVByizDqy=qxNjQ@mail.gmail.com>
References: <7viprmq4sy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 07:17:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcW6F-00070v-2l
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 07:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab1GAFJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 01:09:12 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:35268 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab1GAFJL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2011 01:09:11 -0400
Received: by fxd18 with SMTP id 18so2912057fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 22:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=77x3RfNz7t0z9/OiyIgWjLpR6ISv72vATxY3FDDr06M=;
        b=nbksiPaThUIpRkl/7jm2b8ilMqhoUya3g++aw3e/s6jl5v5Jy5tI1zozbEvYnWU4FE
         BAbwafRBt8VRcYS6Mklm4fKVZjA9cu2TxRzisOlyOHvD/WI8fJQYmIRa4qCKZNNJAb+v
         qrfRr2bTHrqwUEsrz67xnSn82d1VEDgpU+yjY=
Received: by 10.223.100.197 with SMTP id z5mr4184632fan.46.1309496949678; Thu,
 30 Jun 2011 22:09:09 -0700 (PDT)
Received: by 10.223.105.131 with HTTP; Thu, 30 Jun 2011 22:09:09 -0700 (PDT)
In-Reply-To: <7viprmq4sy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176515>

Hi,

On Thu, Jun 30, 2011 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> * en/merge-recursive (2011-06-13) 49 commits
> =C2=A0- t3030: fix accidental success in symlink rename
> =C2=A0- merge-recursive: Fix working copy handling for rename/rename/=
add/add
> =C2=A0- merge-recursive: add handling for rename/rename/add-dest/add-=
dest
> =C2=A0- merge-recursive: Have conflict_rename_delete reuse modify/del=
ete code
> =C2=A0- merge-recursive: Make modify/delete handling code reusable
> =C2=A0- merge-recursive: Consider modifications in rename/rename(2to1=
) conflicts
> =C2=A0- merge-recursive: Create function for merging with branchname:=
file markers
> =C2=A0- merge-recursive: Record more data needed for merging with dua=
l renames
> =C2=A0- merge-recursive: Defer rename/rename(2to1) handling until pro=
cess_entry
> =C2=A0- merge-recursive: Small cleanups for conflict_rename_rename_1t=
o2
> =C2=A0- merge-recursive: Fix rename/rename(1to2) resolution for virtu=
al merge base
> =C2=A0- merge-recursive: Introduce a merge_file convenience function
> =C2=A0- merge-recursive: Fix modify/delete resolution in the recursiv=
e case
> =C2=A0- merge-recursive: Provide more info in conflict markers with f=
ile renames
> =C2=A0- merge-recursive: Cleanup and consolidation of rename_conflict=
_info
> =C2=A0- merge-recursive: Consolidate process_entry() and process_df_e=
ntry()
> =C2=A0- merge-recursive: Improve handling of rename target vs. direct=
ory addition
> =C2=A0- merge-recursive: Add comments about handling rename/add-sourc=
e cases
> =C2=A0- merge-recursive: Make dead code for rename/rename(2to1) confl=
icts undead
> =C2=A0- merge-recursive: Fix deletion of untracked file in rename/del=
ete conflicts
> =C2=A0- merge-recursive: When we detect we can skip an update, actual=
ly skip it
> =C2=A0- merge-recursive: Split update_stages_and_entry; only update s=
tages at end
> =C2=A0- merge-recursive: Consolidate different update_stages function=
s
> =C2=A0- merge-recursive: Allow make_room_for_path() to remove D/F ent=
ries
> =C2=A0- merge-recursive: Split was_tracked() out of would_lose_untrac=
ked()
> =C2=A0- merge-recursive: Save D/F conflict filenames instead of unlin=
king them
> =C2=A0- merge-recursive: Fix code checking for D/F conflicts still be=
ing present
> =C2=A0- merge-recursive: Fix sorting order and directory change assum=
ptions
> =C2=A0- merge-recursive: Fix recursive case with D/F conflict via add=
/add conflict
> =C2=A0- merge-recursive: Avoid working directory changes during recur=
sive case
> =C2=A0- merge-recursive: Remember to free generated unique path names
> =C2=A0- merge-recursive: Mark some diff_filespec struct arguments con=
st
> =C2=A0- merge-recursive: Correct a comment
> =C2=A0- merge-recursive: Make BUG message more legible by adding a ne=
wline
> =C2=A0- t6022: Add testcase for merging a renamed file with a simple =
change
> =C2=A0- t6022: New tests checking for unnecessary updates of files
> =C2=A0- t6022: Remove unnecessary untracked files to make test cleane=
r
> =C2=A0- t6036: criss-cross + rename/rename(1to2)/add-source + modify/=
modify
> =C2=A0- t6036: criss-cross w/ rename/rename(1to2)/modify+rename/renam=
e(2to1)/modify
> =C2=A0- t6036: tests for criss-cross merges with various directory/fi=
le conflicts
> =C2=A0- t6036: criss-cross with weird content can fool git into clean=
 merge
> =C2=A0- t6036: Add differently resolved modify/delete conflict in cri=
ss-cross test
> =C2=A0- t6042: Ensure rename/rename conflicts leave index and workdir=
 in sane state
> =C2=A0- t6042: Add failing testcases for rename/rename/add-{source,de=
st} conflicts
> =C2=A0- t6042: Add tests for content issues with modify/rename/direct=
ory conflicts
> =C2=A0- t6042: Add a testcase where undetected rename causes silent f=
ile deletion
> =C2=A0- t6042: Add a pair of cases where undetected renames cause iss=
ues
> =C2=A0- t6042: Add failing testcase for rename/modify/add-source conf=
lict
> =C2=A0- t6042: Add a testcase where git deletes an untracked file
>
> Haven't looked at the whole series yet.

That's understandable; it's a pretty long series.  I've got this
worry, though, that you're going to read it all soon and have lots of
questions and comments -- just after I leave on vacation for two weeks
and am unplugged from email.  Anyway, just thought I'd send a heads up
to avoid any problems in reviewing/advancing this series.  Let me know
if there's anything in particular you'd like me to do (either the few
days before I leave or when I get back).  If you'd prefer to just wait
a few weeks to look at it, or are okay with me not responding to
reviews for a couple weeks or whatever, that's fine.

Thanks
Elijah
