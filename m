From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 2/2] SubmittingPatches: Complete rewrite of section
 0
Date: Sun, 18 Apr 2010 19:21:13 -0500
Message-ID: <20100419002113.GA14202@progeny.tock>
References: <1271620467-sup-7590@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 02:21:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ejw-0001te-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 02:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab0DSAVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 20:21:11 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:58906 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0DSAVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 20:21:09 -0400
Received: by ywh32 with SMTP id 32so2418399ywh.33
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eNR8EJNJwBip6uh5AUcDiF/EDrq/qAYdFkj5oXoVsjM=;
        b=mQe5hlSesJ5viK2mRdaaiUKu4aP+6r80X1Et/79dKajRHjtvFykbYiHObTp5dysZNq
         AyhWVhlxJbgTdyJFQJpgnyZ6AWD65a7SWccWolg3L4EI+QkaPsGQ26Du8YjfZ3sriQMO
         /3Dmxqlt6dN+thQgu5ajG7o6/667H1AoRIi3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BIASTDHk4Ti7jjwAoVS6ztimdsyfvwVbHT6vdyy6LNUo6zw4PkasOGlmR8RCl5Dts7
         WbhypI5TePdtQeJ1XptxQUCyrLEBQhxW3LK2dSQv7VQfV6xRDq8JFqOKk94Sd4PBnl1p
         hfKJCurAPNLaq3SlVPPloiaf8sWIVFjtAsk7Y=
Received: by 10.150.243.4 with SMTP id q4mr5370166ybh.119.1271636468976;
        Sun, 18 Apr 2010 17:21:08 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm21429iwn.9.2010.04.18.17.21.08
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Apr 2010 17:21:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271620467-sup-7590@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145259>

Ramkumar Ramachandra wrote:

> This rewrite makes section 0 less verbose and more readable. It is
> intended to be squashed into the previous commit.

Nice.

> +To find the tip of a topic branch, run "git log --first-parent
> +master..pu" and look for the merge commit. The grandparent of this
> +commit is the tip of the topic branch.

The reader is not looking for the second-generation grand-parent foo~2
but the second parent foo^2, using terminology from git-rev-parse.1.

I guess the =E2=80=9Csecond parent=E2=80=9D term always involves this p=
otential
confusion.  Luckily, the uninitiated reader can infer from the context
that foo~2 is not the intended commit, so there is no need to resort
to awkward phrases like =E2=80=9Cthe second first-generation parent=E2=80=
=9D.

Jonathan

diff --git a/Documentation/SubmittingPatches b/Documentation/Submitting=
Patches
index 0b62b62..8db22ef 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -79,7 +79,7 @@ change is relevant to.
    rebase your work.
=20
 To find the tip of a topic branch, run "git log --first-parent
-master..pu" and look for the merge commit. The grandparent of this
+master..pu" and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
=20
 (1) Make separate commits for logically separate changes.
