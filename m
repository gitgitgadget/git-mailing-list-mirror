From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 18:26:09 +0530
Message-ID: <20101001125604.GA20713@kytes>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
 <20101001045713.GE20098@kytes>
 <20101001053721.GB6184@burratino>
 <20101001072149.GA24171@kytes>
 <20101001074039.GC6184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 14:57:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1fB2-0001Sl-Sn
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 14:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab0JAM5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 08:57:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58760 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932457Ab0JAM5V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 08:57:21 -0400
Received: by pvg2 with SMTP id 2so740669pvg.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IDyKrXQFJddCjO89YGggw/76cOH5bellRpsr2bA8V2A=;
        b=JJk1EZIhx0yo1JRVnBn+XHaYxze3oclY4j/Qkiq74CdjAlHOgT5OAXWzPmqi//faUO
         uVYDbPq4rwMuoxdk6/zcRdMFQSnnzhvykCdyhb6tl8Ry9LEZADDR0Lf4UK7GAOJXRQY4
         c6ArKOKvInzhu44JnHhdfZYryMuco88Hfj3rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ny+h5Zl8kX2U+2tPJOTMpaR+LBZY7pW1CYAmTr/NRMYENX2bib5icsGmMlQuJGhBNw
         5aw/dUnLs2NWFGmzkQ8CyVGR+CKR+9ckhoSbrQPHwWaTT6edFIO7V8ljhcownxDZ9tDi
         cBTO1x6mjQGycjJO85C8mXm5IJtM+ByuyKQxI=
Received: by 10.114.46.14 with SMTP id t14mr6208914wat.67.1285937840958;
        Fri, 01 Oct 2010 05:57:20 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm1830941wad.18.2010.10.01.05.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 05:57:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101001074039.GC6184@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157751>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Are all these tags useful?
> 
> Probably not. :)
[...]

How about this then?

Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- 8< --
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ece3c77..72741eb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -264,12 +264,21 @@ the change to its true author (see (2) above).
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
 
-Some people also put extra tags at the end.
-
-"Acked-by:" says that the patch was reviewed by the person who
-is more familiar with the issues and the area the patch attempts
-to modify.  "Tested-by:" says the patch was tested by the person
-and found to have the desired effect.
+If you like, you can put extra tags at the end:
+
+1. "Reported-by:" is used to to credit someone who found the bug that
+   the patch attempts to fix.
+2. "Acked-by:" says that the person who is more familiar with the area
+   the patch attempts to modify liked the patch.
+3. "Reviewed-by:", unlike the other tags, can only be offered by the
+   reviewer and means that she is completely satisfied that the patch
+   is ready for application.  It is usually offered only after a
+   detailed review.
+4. "Tested-by:" is used to indicate that the person applied the patch
+   and found it to have the desired effect.
+
+You can also create your own tag or use one that's in common usage
+such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
 ------------------------------------------------
 An ideal patch flow
