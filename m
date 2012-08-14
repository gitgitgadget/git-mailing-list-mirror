From: Bernd Jendrissek <bernd.jendrissek@gmail.com>
Subject: Re: git diff vs git diff-files
Date: Tue, 14 Aug 2012 11:15:26 +0200
Message-ID: <CAF7PVPq0Wjck+53G4=Ofz0drMdx9NtpfgzMFR4j=32N-ez2xBg@mail.gmail.com>
References: <CAF7PVPrex6sJMU+uvxQOSpB12qSTp2barTycow_-LZ8Ngbv7uQ@mail.gmail.com>
	<87fw7qhm31.fsf@thomas.inf.ethz.ch>
	<CAF7PVPqyaZQtca0KfWHirBY2Dvdtn2RT-_mxR8x5uUNsfbHmdQ@mail.gmail.com>
	<87vcgl999v.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 14 11:15:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1DDt-0006Eb-VL
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 11:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab2HNJP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 05:15:29 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43006 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab2HNJP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 05:15:27 -0400
Received: by obbuo13 with SMTP id uo13so261279obb.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 02:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jehRL50EJ8/pUi4OaQ0fojC/izFthUc3QQXdVrV9GVY=;
        b=D/V78DW0VDo2vtq+mS/METUEEYP6xQK1X4tViRiwVni8h9fkHf42DKTtCU/k1aARgM
         HG265lOJlCsDyFvxE6AUjt+BiKO2BhUu+riO6FQUiKHQpcWuEWncsJv0xD3XjhfaObwq
         Hqu4eCtu39TYon4UAZ0qj3PJUE2sEcC2ToyFJHVYNN7pRaxV3qFw4O1dz4mmaLXXn5rF
         DefJVpgJKTxQ+qzw1YDSWb0WwtN4ytUK/ojxkv2TfK+wT/t34O1tmpGb/sDR8rEhHCu8
         xIn0uJfzHepWKpUZwvKVy8V6Zn6QZJMM4HtcjGjD+kybqjDch3GmoQOhZdvZ+jh0VLgG
         vBKQ==
Received: by 10.60.169.75 with SMTP id ac11mr23667159oec.12.1344935726717;
 Tue, 14 Aug 2012 02:15:26 -0700 (PDT)
Received: by 10.182.46.165 with HTTP; Tue, 14 Aug 2012 02:15:26 -0700 (PDT)
In-Reply-To: <87vcgl999v.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203394>

On Tue, Aug 14, 2012 at 10:18 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> That sounds like an issue with stat() data, and then it doesn't.  cp -a
> would change all the inode numbers, triggering a full refresh of the
> index in 'git diff'.  But I'm not sure exactly how this can lead to
> disagreement, since both commands read *both* index and worktree version
> of the file.  Very confusing.
>
> Can you try the following:
>
>   git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>   cp .git/index .git/index.orig
>   touch gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>   # note, it is important that you run diff first
>   git diff gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>   git diff-files -p gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net
>   git ls-files --debug gnetlist/tests/common/outputs/osmond/TwoStageAmp-output.net

I'm can't tell what this was supposed to prove, but I think it's
proven that I'm in the wrong mailing list, and that I should be taking
this up with gnome-terminal. The Q1 part deletion line seems to be
appearing (in the terminal) only after I've copy&pasted it into
another terminal.

Running the same commands in xterm (correctly) shows the Q1 part
deletion line without having to copy & paste.

At this point I doubt there's much value in publishing the output, but
just in case (and it may be relevant when i take it to
gnome-terminal), it's here:

http://www.bpj-code.co.za/downloads.php/bugs/git-output-87vcgl999v.fsf?text

Note that line 104 of that output appears in the same terminal from
which I copy&paste it only after I switch back to it, after having
pasted the output. Oi vey.

>> http://www.bpj-code.co.za/downloads.php/bugs/TwoStageAmp-output.net?text
>> contains the output from git show a5ee1e7. Leave off the ?text for an
>> application/octet-stream download.
>
> Umm, that's only one side of the diff, isn't it?  The hunk header claims
> that the hunk goes up to line 47, so there must be more changes beyond
> what you showed.

You're right - the hunk isn't even self-consistent!
http://www.bpj-code.co.za/downloads.php/bugs/git-add--p-TwoStageAmp-output.net?text
is the "bad" diff, and I count only 46 lines of (context + deletions),
while the hunk header claims the (correct) 47 lines corresponding to
the whole file covered in the hunk.

Thanks for your time; I'm fairly convinced now that git is just an
innocent accessory to another program's bug.
