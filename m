From: David Glasser <glasser@davidglasser.net>
Subject: Keep original author with git merge --squash?
Date: Wed, 11 Feb 2015 09:21:04 -0800
Message-ID: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 18:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLayg-0004Jl-UL
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 18:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbBKRV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 12:21:26 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36092 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbBKRV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 12:21:26 -0500
Received: by mail-wg0-f48.google.com with SMTP id l18so1792755wgh.7
        for <git@vger.kernel.org>; Wed, 11 Feb 2015 09:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=QFpespvmNNiXe2irICRVoZ2OeLK11s3JmbLjv3sS+AE=;
        b=bE/3Fga1mFp+wlmqjvCjTayNmjhgSPTDVzpMi75VYOOxNOVwBo3urVnewgvu89Lw7i
         Kh9F/toKFbJZsmZUKQ3fWndpgXscyhWsaBhfeJAcO+QdMbOveLJIQwhWMC6oYBCWPFDn
         g/NoN9+TNo4szHf2i0wwsewHWawYxtxgBIqQQY6T/iGR78Eu/JPqazo9NOkHLElgFXpH
         2SKYgqLOJhacq39khItAv7c2k/AC/lZ0H1JkZZyEgG8pvVYrzbcJm3CS8FKF3duG/B4W
         jkSb4FinYwRpcvswogezglS+tqx5lgvH7JpAZSvpaVoVC2l0AdGAmNJHfDPGQw8foen6
         PBiA==
X-Received: by 10.194.3.40 with SMTP id 8mr61896777wjz.98.1423675285075; Wed,
 11 Feb 2015 09:21:25 -0800 (PST)
Received: by 10.194.16.196 with HTTP; Wed, 11 Feb 2015 09:21:04 -0800 (PST)
X-Google-Sender-Auth: O5mdJIP8Tl4lluadNauG-80LLow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263683>

I frequently find myself using `git merge --squash` to combine a
series of commits by the same author into one.

(For example, I fetch my project's GitHub PRs into my repo.
Frequently, a PR consists of the original PR (with a good description)
followed by a few follow-ups based on feedback from me.  While I'd
prefer that the submitter amended their original commit instead of
making it my job, this is rare.  And I don't feel that it's valuable
to my project's git history to contain all the intermediate stages of
code review --- it's usually just one commit.)

So `git merge --squash origin/pr/1234` is a really convenient command
here... except for one thing: it sets the author as me.  I always have
to manually find the author line and make sure to pass it to --author
(perhaps with --amend).

What would people think of a flag (or a config value) that means "if
all merged commits are by the same author, use that author for the
resulting commit instead of the default author"?

(I'm not sure if this should be a flag to --squash or to commit.
Maybe `git merge --squash`; `git commit --use-squashed-author`?  Seems
like it should be not too hard to implement; SQUASH_MSG is pretty
parseable.  Or just a config value.)

--dave

-- 
glasser@davidglasser.net | langtonlabs.org | flickr.com/photos/glasser/
