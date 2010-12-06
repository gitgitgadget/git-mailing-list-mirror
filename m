From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH jn/svn-fe] vcs-svn: Allow change nodes for root of tree
 (/)
Date: Mon, 6 Dec 2010 17:12:43 -0600
Message-ID: <20101206231242.GA16804@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005334.GL17445@burratino>
 <20101206221931.GA13401@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkF5-0000LW-4u
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0LFXM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:59 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51931 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0LFXM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:58 -0500
Received: by vws16 with SMTP id 16so3002845vws.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h7fAxgzDYbUdTdWK4NHHlR91s+pb+rTFAGZdexsASU0=;
        b=Dwa+mwWhHO9Ic/9HOU8reqGeyQWTt934Vto0xabrHIJdKzhX1//FAn3riIAJnaszsT
         7oNThpEkeoOsMz3ij5qjDs4oJF07zn5kMOjJLshIQ37d3uYBe6thqoMlVnvk8hhYU5DQ
         1ClAVkEZbCMCxT/x+Di3VjdbmMCueI9yQuC/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pRF9oLeFHzYRq/VmWz1MlUrapOA5xOhheWxA4A3tLxMdRkWp87K3VBSNWFCP1701tG
         TllfuVR9E4WRb9YNox3Mr+PteH8qTT0YCUv1dBvMvLpkINykVONdB3YOExrL60pICM3f
         1Sm6w/pIDNapxoskRaZaCLUPJ8Oro1l8DaW/Q=
Received: by 10.220.81.21 with SMTP id v21mr631424vck.264.1291677177552;
        Mon, 06 Dec 2010 15:12:57 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id e18sm1981905vbm.5.2010.12.06.15.12.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101206221931.GA13401@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163047>

Jonathan Nieder wrote:

> ---
>  t/t9010-svn-fe.sh |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  vcs-svn/svndump.c |    5 +++-
>  2 files changed, 77 insertions(+), 1 deletions(-)

Hmph, some extra (but harmless) text snuck into the test. :/

-- 8< --
Subject: fixup! vcs-svn: Allow change nodes for root of tree (/)

Some pointless, unrelated code stowed away while resolving conflicts
during a cherry-pick.  Remove it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9010-svn-fe.sh |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index 04ce97d..8794507 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -625,24 +625,6 @@ test_expect_success 'properties on /' '
 
 	PROPS-END
 	EOF
-	echo Revision-number: 2 &&
-	echo Prop-content-length: $(wc -c <revprops) &&
-	echo Content-length: $(wc -c <revprops) &&
-	echo &&
-	cat revprops &&
-	echo &&
-	cat <<-\EOF
-	Node-path: script.sh
-	Node-kind: file
-	Node-action: change
-	Prop-delta: true
-	Prop-content-length: 30
-	Content-length: 30
-
-	D 14
-	svn:executable
-	PROPS-END
-	EOF
 	test-svn-fe changeroot.dump >stream &&
 	git fast-import <stream &&
 	{
-- 
1.7.2.4
