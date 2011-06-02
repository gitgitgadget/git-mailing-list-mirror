From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Can't get git rebase --onto to work
Date: Thu, 2 Jun 2011 11:17:41 +0100
Message-ID: <BANLkTikF7p_XsU6YJ81bq10S3nL6tBsApg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 12:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS4yR-0004Lq-FK
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 12:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402Ab1FBKRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 06:17:44 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:52817 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096Ab1FBKRm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 06:17:42 -0400
Received: by yia27 with SMTP id 27so270797yia.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=H/GlY94A9j1gs7JtwqwIVe7AGxNx+BCpFeMkPz415DE=;
        b=rwHYhpFXfDjrfwUm4bgDeNsWk3seIbl1H5atcVVfmD7G0wID3e9dNHB2AleXhOYbms
         c63q+t0JGLQ2T9KUZ5g7hVGJUhea+HnOmqY0lny4FqolILNDEncGCbOyQWxsJUz0yoBH
         PXc6xjG0mxC/8654zUQ0q6ouN1iuWJmj06TD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=MkqABnGx1iLglxIsQbv8d+KGOT31C5gCqnoR5UjELGhvGh4ZNLihi18IQaXpwny+jl
         iSBB+NJchcdeXRq2LmNi7KgS/ujeMub+sx4VxLNZKacN3kWi7e03zvGXE2D52p8tHPy8
         Wkrj/tVyeKbMZJAWWX0F8OJCu9FvrLnNSNBDs=
Received: by 10.91.203.37 with SMTP id f37mr504348agq.57.1307009861590; Thu,
 02 Jun 2011 03:17:41 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Thu, 2 Jun 2011 03:17:41 -0700 (PDT)
X-Google-Sender-Auth: WheVLAbDsct2IpP3G-CfXWc5scc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174934>

Trying to explain this as concisely as possible.

I started with the following branches (names changed to protect the guilty)...

* clientA
* clientB

both have a common ancestry....

I then checked out clientB created a new branch clientB_patch and did
a load of work and commits.

However, I actually wanted all those commits to apply to clientA
branch instead so....

git checkout clientA
git checkout -b clientA_patch     (to ensure I didn't wreck original branch)
git rebase --onto clientA_patch clientB clientB_patch

It says "rewinding" head and then applies the commits I would have expected.

However, I have now been switched to the 'clientB_patch' branch and it
says that it differs from its tracked remote branch by hundreds of
commits.

clientA_patch is unchanged. It seems to have mangled clientB_patch and
done nothing to clientA_patch. Where did I go wrong?

TIA
