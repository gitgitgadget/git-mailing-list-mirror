From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: What is missing from Git v2.0
Date: Sun, 20 Apr 2014 17:41:05 -0500
Message-ID: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 00:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc0QF-00041U-VD
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 00:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbaDTWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 18:41:08 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:34360 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaDTWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 18:41:07 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so2726768lab.35
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XOgY6sTClEdLbQX5lejWi/gF+mZWKZUUTEJz8VCovK0=;
        b=PfNcbESZYg3f2hhCyQpb2Ih2A0l74Zf4eBgta0lY6P+uO1gZBpiSZQ7ViYtiproTKY
         E611+uipg4wZXseybTwlpTNHh312E1pl3UcYZGkwHirqD6IkDZ7akckkPKjj0jWE390D
         HPcPYOzwT0cbLKDHj9vrLhXdT3Bnmw8T0nWGqBsSfk+WaMQA4+R+YuYoflXzsWSDRvIA
         RJpyAWLZOyooHWEYbKiVVDHY4N6E+o62mIecLVNqH4mOk44unXpWOJOi0kpEfrDI5+Vu
         5sWd+AatQ8FbgNX4sAP8WRCRkkv8EXP209eQhqu056PktIOX1QKL7vSKUVMhjY532v0U
         yIcg==
X-Received: by 10.153.8.135 with SMTP id dk7mr24572353lad.18.1398033665159;
 Sun, 20 Apr 2014 15:41:05 -0700 (PDT)
Received: by 10.114.194.6 with HTTP; Sun, 20 Apr 2014 15:41:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246598>

Hi,

I had already given up on merging important features to Git upstream,
and then one of the features I've had in git-fc (my fork) for quite
some time suddenly got attention (the @{publish} branch), but
everybody forgot I already did the work. So maybe there's other
features in a similar situation.

= The publish tracking branch =

Git's triangular workflow support is definitely lacking, and although
there are many ideas and workarounds, the simplest and most
user-friendly way to fix the issues is by introducing the concept of a
publish tracking branch, similar to the upstream tracking branch.

Fortunately this might actually get into v2.0.

[1][2]

= Reject non-fast-forward pulls by default =

Many new-comers end up making merges by mistake when they pull because
they don't understand what is a non-fast-forward and what they should
actually be doing. Most people, even Linus Torvalds, agreed that by
default `git pull` should fail and guide the user, instead of silently
making a merge which might not be what the user wants (even though he
doesn't know it), and messing up the project's history, which affects
other people.

The patches were sent, the issues were addressed, people agreed, and
yet nothing happened.

[3][4]

= Use "stage" instead of "index" =

Everybody, and by everybody I literally mean everyone except Junio,
have agreed that "index" is a horrible name of the high-level concept
(not the actual index file) of the pace where the user drafts a
commit. Different actions were proposed to move towards a saner name,
and the simplest sensible one seems to be to start renaming the
confusing --cached and --index options to --stage and --no-work, and
also to add a new `git stage` command.

Nothing happened.

[5][6][7][8]

= Default aliases =

Every single version control tool out there has default aliases (e.g.
co = checkout) except Git.

Every argument against default aliases was basically refuted, yet my
patches went nowhere. And the users still expect these aliases.

[9]

[1] http://thread.gmane.org/gmane.comp.version-control.git/235981
[2] http://thread.gmane.org/gmane.comp.version-control.git/240030
[3] http://thread.gmane.org/gmane.comp.version-control.git/240030
[4] http://thread.gmane.org/gmane.comp.version-control.git/235981
[5] http://thread.gmane.org/gmane.comp.version-control.git/233295
[6] http://thread.gmane.org/gmane.comp.version-control.git/197111
[7] http://thread.gmane.org/gmane.comp.version-control.git/166675
[8] http://thread.gmane.org/gmane.comp.version-control.git/115666
[9] http://thread.gmane.org/gmane.comp.version-control.git/235145

-- 
Felipe Contreras
