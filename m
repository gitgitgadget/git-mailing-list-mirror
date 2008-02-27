From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: [PATCH] Prompt to continue when editing during rebase --interactive
Date: Wed, 27 Feb 2008 12:50:22 +0000
Message-ID: <57518fd10802270450r27e7339cs7612eab733d4e94e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 13:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JULkT-0000NM-PI
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 13:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbYB0MuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 07:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYB0MuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 07:50:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:29390 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbYB0MuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 07:50:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1716778rvb.1
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=YqqHj6nFBDkSkOVphllicw9OWLBkIojQieoDCWDireM=;
        b=EVcrtVEyp+XrADmnj/tINeOKjs+XBZfSlHhl7B0zxlhA78To/unZXN2FVQpZyaKJMHSNX4kbqAxlDoDZ9O+2jzH5JeqXR+UtzKiO51OCHmr0SOnBfJ/vLxJOD7LA14ekojaWtUkcVP+MikWej4rlnXC758YbjwZQE3lJBEx2rVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Aono+xSOCQTztKxFOVnazbad/CkovFyRN8+6nq6sASv+YeIFvNIfauYlPjhlu+dHzo48NtcsNNTWr1LJFu8ID7htjYxplCJ6HTXI9+SZehZx2U6A13N5j+rUVoeTkusYU+0rqDmViB+lQHzqQ+3XHFehs9BWgg2vaxL8TYaEb8w=
Received: by 10.141.33.21 with SMTP id l21mr4450034rvj.140.1204116622752;
        Wed, 27 Feb 2008 04:50:22 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Wed, 27 Feb 2008 04:50:22 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: e9d7aedf3d67c63f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75226>

On hitting an edit point in an interactive rebase, git should prompt
the user to run "git rebase --continue"

Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
---

 git-rebase--interactive.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index fb12b03..c2bedd6 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -268,6 +268,10 @@ do_next () {
 		warn
 		warn "	git commit --amend"
 		warn
+		warn "Once you are satisfied with your changes, run"
+		warn
+		warn "	git rebase --continue"
+		warn
 		exit 0
 		;;
 	squash|s)
-- 
1.5.4.1.97.g40aab
