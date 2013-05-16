From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 13:59:46 +0530
Message-ID: <CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com> <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:30:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucta4-0002L5-6n
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab3EPIa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:30:28 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60002 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab3EPIa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:30:26 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so5975551iet.28
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WdXNxqFOrgckbuETxQLDmgJV1G/WxvSpvU7hGegP7pY=;
        b=ykZPuwXfOXQcUqsslAliYpJ6w1GFl0R8gzRDrSuhtXvtG5Cl/xXI3TtbECeA8Kz2oA
         ap8GDNCTdOpRqEr2XIiTA3ly90kNr++XCe8NzmXkP67z+oDS783ZKjDYnfKpWa3aUED/
         L0zsYEl8z4laH6UsOnHnoQJOcQQqyPllR8HvgfaTtGvCZTNCqYxF/8o12SbeGRzXvCxM
         Sq9fcC5bXMo0VnAKFu7npy+cFuUi+9OGLhM1mwD6qEtg/f+bJKMJL0fBhT+rQavy43Yc
         lkA6ygRndT1LqDWbzr1ZudlQjvTK0qnITwdwsVOleHjlhECaCLGx5ePTl0kyQxv4aUbv
         zUWA==
X-Received: by 10.50.147.71 with SMTP id ti7mr8489088igb.49.1368693026368;
 Thu, 16 May 2013 01:30:26 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 01:29:46 -0700 (PDT)
In-Reply-To: <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224500>

Felipe Contreras wrote:
>  git-pull.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

This one obviously looks good.  I'm not sure why you sent it along
with the other two patches though.

On a related note, I'm interested in fixing pull.  What I have on paper so far:

- pull.condition = clean-worktree | ff-update | no-local-changes |
always | never
- pull.action = merge | rebase* | reset
- pull.resetType = soft | hard | merge | keep
- pull.autostash = true | false

(ff-update is satisfied when FETCH_HEAD is directly ahead of
refs/remotes/<branch>, while no-local-changes is satisfied when
FETCH_HEAD is directly ahead of refs/heads/<branch>)

Any clue how to design branch-specific pull configuration?
