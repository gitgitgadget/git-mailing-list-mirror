From: Adam Tkac <atkac@redhat.com>
Subject: Re: [PATCH] Fix bash completion when `egrep` is aliased to `egrep
 --color=always`
Date: Mon, 26 Nov 2012 12:23:53 +0100
Message-ID: <20121126112352.GA4481@redhat.com>
References: <20121122154120.GA16835@redhat.com>
 <CAFj1UpG6H3bpoa7xbqpH6Hyb6pwqE_CCgP6iT36D-ELvtVi4wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Cc: git@vger.kernel.org
To: Marc Khouzam <marc.khouzam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 12:24:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcwna-0001SE-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 12:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2KZLYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 06:24:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44916 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab2KZLXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 06:23:55 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qAQBNsg7004134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 26 Nov 2012 06:23:54 -0500
Received: from localhost (evileye.atkac.brq.redhat.com [10.34.4.30])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qAQBNrYh016789;
	Mon, 26 Nov 2012 06:23:54 -0500
Content-Disposition: inline
In-Reply-To: <CAFj1UpG6H3bpoa7xbqpH6Hyb6pwqE_CCgP6iT36D-ELvtVi4wA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210430>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 22, 2012 at 02:55:21PM -0500, Marc Khouzam wrote:
> On Thu, Nov 22, 2012 at 10:41 AM, Adam Tkac <atkac@redhat.com> wrote:
> > Hello all,
> >
> > attached patch fixes bash completion when `egrep` is aliased to `egrep --color=always`.
> 
> To avoid any aliases, it may be better to use
> \egrep

Good idea, thanks. Improved patch is attached.

Regards, Adam

> 
> This could be worthwhile for all utilities used by the script.
> 
> Just a thought.
> 
> Marc
> 
> 
> >
> > Comments are welcomed.
> >
> > Regards, Adam
> >
> > --
> > Adam Tkac, Red Hat, Inc.

-- 
Adam Tkac, Red Hat, Inc.

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-If-egrep-is-aliased-temporary-disable-it-in-bash.com.patch"

>From 255192296cd175fddcac2647447a66a0ca55b855 Mon Sep 17 00:00:00 2001
From: Adam Tkac <atkac@redhat.com>
Date: Thu, 22 Nov 2012 16:34:58 +0100
Subject: [PATCH] If `egrep` is aliased, temporary disable it in
 bash.completion

Originally reported as https://bugzilla.redhat.com/show_bug.cgi?id=863780

Signed-off-by: Adam Tkac <atkac@redhat.com>
Signed-off-by: Holger Arnold <holgerar@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0960acc..79073c2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -565,7 +565,7 @@ __git_complete_strategy ()
 __git_list_all_commands ()
 {
 	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
+	for i in $(git help -a| \egrep '^  [a-zA-Z0-9]')
 	do
 		case $i in
 		*--*)             : helper pattern;;
-- 
1.8.0


--Dxnq1zWXvFF0Q93v--
