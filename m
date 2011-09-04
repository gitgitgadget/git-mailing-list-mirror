From: knittl <knittl89@googlemail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 16:30:26 +0200
Message-ID: <CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "John S. Urban" <urbanjost@comcast.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 16:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Dio-0003gv-Vy
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 16:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab1IDOas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 10:30:48 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63438 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab1IDOar (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 10:30:47 -0400
Received: by vxi9 with SMTP id 9so3250438vxi.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qDaj/YCc012nlpJHvSv5hzmSPnyLfrrbcEzY6AQ8DjU=;
        b=oPp+GXftJifRRrCJZJhNwwegwGXYp7gdmIDITOYIUzEHgUplAp5uYwqquf7fpkLCol
         Aq1rjj7xfFOpNNDApWT59zLu9xzRaYmLnERNRzLCB24QCZDSKq13vApueyAgfjUo13yD
         QMpVUCT+KqwUCCrVt2RfthaNQW8h0QTSuALDU=
Received: by 10.52.172.226 with SMTP id bf2mr570776vdc.147.1315146646128; Sun,
 04 Sep 2011 07:30:46 -0700 (PDT)
Received: by 10.52.188.38 with HTTP; Sun, 4 Sep 2011 07:30:26 -0700 (PDT)
In-Reply-To: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180683>

On Sun, Sep 4, 2011 at 3:32 AM, John S. Urban <urbanjost@comcast.net> wrote:
> With my first use of git(1) I  created a small project with about 200
> "commits".  When this was complete, I needed to label each commit with
> information pointing it to a section of a document. I used tags for this.

Use git notes[1] to attach additional info to existing commits. Git
notes will by default be copied when using git rebase or git commit
--amend (cf. notes.rewrite.<command> config)

> So far, everything was fine. I was then asked to merge two commits
> into one. I then did a "rebase" (for the first time). I then appear to have
> lost all association between the tags and the effected commits; as all
> commits after
> the ones I modified no longer see "their" tags. Was there a way to have kept
> the tags associated with the original commits as they were "rebased"?

"Rebase" takes commits and creates new commits from those. The new
commits are not the same as the old, although they might have
associated the same tree or changeset.

> Also, I have some commits with multiple tags pointing to them. It has come
> to my attention that might not be an intentional feature. I could find
> nothing in the documentation explicitly stating multiple tags were allowed
> to point to a commit; but the tags seem to be unique "objects" so I
> see no reason this should not be an expected feature?

Tags can point to any git object (commits, trees, blobs, notes, even
to other annotated tags).  There's nothing wrong with that.

[1]: http://www.kernel.org/pub/software/scm/git/docs/git-notes.html

--
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
