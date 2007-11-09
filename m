From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 14:41:05 -0500
Message-ID: <4fe79b4b0711091141i38044a5o1ef940d9c7afd58f@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
	 <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com>
	 <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org>
	 <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com>
	 <alpine.LFD.0.999.0711091050230.15101@woody.linux-foundation.org>
	 <20071109190707.GA17864@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org, ae@op5.se,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZjM-0001NU-Hl
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbXKITlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 14:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756744AbXKITlH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:41:07 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:40935 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbXKITlF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 14:41:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so716247wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 11:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=EV7V+03LG7Uy087RQ6RBCp1B1utx0Io8fuT2oN911bo=;
        b=Vaa7a+baFH1vgiQn1QYtQvi24wBVDxZylWCMpjRLRaZjS8igZ1v2nJGrSisVzvYLbaQQ8piRBDi48wlTAu7IVL6PSKl3Pm/Kngtc8EfZuY/6rSaoJUWdLZStbaAhddbpw3KoH6KTw0MdONb2ClMiJlVWYDobG6Pt4WvbXq+KEx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GLdwpHW7XcbTsRKTaH8qCJ3BPzNs6nLRmbWEu703f7l76oPi4j7lOg06HRbwAFiwmya5oCKlTK+E4T9hy/n3A9ef5hSC71S1GDurTy7GXsHhMFh6iGvsqhGW2WcIvffqZme03++HYx7URyqdcxPyc9pOuGytrP6TiF2ZGBWeG9o=
Received: by 10.115.59.4 with SMTP id m4mr27369wak.1194637265182;
        Fri, 09 Nov 2007 11:41:05 -0800 (PST)
Received: by 10.114.174.5 with HTTP; Fri, 9 Nov 2007 11:41:05 -0800 (PST)
In-Reply-To: <20071109190707.GA17864@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64255>

What I do notice is that this commit involve few files. most of the
file the commit generate the right next SHA1
only for one file its generate broken SHA1

>From the git show <commit> I can see that the file which end up
corrupted is actually being totaly remove from

diff --git a/SymmK/St.c b/SymmK/St.c
index 308806c..4b9458b 100755
--- a/SymmK/St.c
+++ b/SymmK/St.c
@@ -1,1535 +0,0 @@
-MODULE_ALIAS(m_st);
-
-#include <errno.h>
-#include <string.h>
-#include <stdarg.h>
-#include <sys/types.h>
-#include <sys/time.h>
-#include "ib_global_init.h"
....
.....
....


While I tried to delete the whole file and I did not get the right SHA1
Is this soud familiar to some one ?
maybe its releated to issue with some kind of white character I cant see.

Yossi
