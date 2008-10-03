From: "Robin Burchell" <w00t@inspircd.org>
Subject: git rebase -- a suggestion
Date: Fri, 3 Oct 2008 01:10:17 +0100
Message-ID: <b19eae4e0810021710v14a3901an1f793de00c439ba1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 02:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlYGc-0000wG-GE
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 02:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbYJCAKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYJCAKU
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 20:10:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:22038 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYJCAKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 20:10:18 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1376025wfd.4
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=l5we2wDD/myVt+6uavAz9Ix52/fjYk/oY3egx03nbMw=;
        b=E5fuJdGxhOIklNiiqHfraznYHkf7Ue+ulju+B7OiHwxtRYeQDhgqPRRpViuvDEAFGz
         uMuPCQzpChpiAIbDPSXRXceb9IQNjT+EMiDeQgo55iGNi+p7Uizf5Gqq5pUZga2Ue2B5
         jw4OgcjPBAWhTRPdkEZ6D/R6NIxbYN9CqKPPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=RuIGns00aGVW8RrzWrLUu//+k7u+oGG2AteTjUBlF8AwxdMRZqk3aOu0RB8x+VlyIY
         OJ+faThbceKR2bIbK0J3roJblKsxW7aDeIhjXUkhdTCTyEufw1i/H4Ser5Vl1gP4cJRl
         w1NPvfS0xx2vNiHN95AyLsx0ArOFeGVv7gOwM=
Received: by 10.142.171.6 with SMTP id t6mr94875wfe.209.1222992617372;
        Thu, 02 Oct 2008 17:10:17 -0700 (PDT)
Received: by 10.142.237.16 with HTTP; Thu, 2 Oct 2008 17:10:17 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 120ed22d7f9144ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97383>

Hi,

This is my first mail to this list, so I hope I'm not breaking any
form of ettiquette, etc. If I do step on any toes, feel free to bop me
on the head with a rubber mallet, or steer me in the right direction.

That over, I have a suggestion for `git rebase', from the perspective
of a newcomer.

I've been using git instead of svn (and various other VCS) now for
about a month, and am finding it quite a refreshing change.

I have also recently started a collaborative project exclusively with
git (well, pulling changes from a git-svn repo I don't control) which
has been a valuable ..learning experience.

With this in mind, I'd like to mention exactly what I did.

Upstream had issued a new commit, so I, not knowing the possible
dangers used git-svn rebase to pull in the new changes to our tree.

This "appeared" to work fine, but alarm bells were already going off
in my head before I typed the command (I didn't know at the time I
could merge svn trees like I could normal git branches) as I knew that
rebase rewrote history, and I saw it do this to about 300 commits.

It promptly made merging absolute hell with the other few members of
my team, as it would.

Granted - this is a mistake on my part, and probably a common newbie
one, but something that came to mind when thinking about it later:
would it perhaps be an idea to have a way to mark a tree 'public', and
disallow rebase *unless* --force was passed, or it was a public tree?

(Then again, the alternative might be more 'intelligent' for new
users: start off with branches defaulting to private, and marking them
public, disallowing use of rebase, etc).

Thoughts, feedback, etc are welcome.

-- 
Robin Burchell
