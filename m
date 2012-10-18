From: Thomas Ackermann <th.acker66@arcor.de>
Subject: Aw: Re: Aw: Re: [Patch v3 0/8] Create single PDF for all HTML files
Date: Thu, 18 Oct 2012 19:19:52 +0200 (CEST)
Message-ID: <634888125.421937.1350580792693.JavaMail.ngmail@webmail11.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, philipoakley@iee.org, peff@peff.net,
	git@drmicha.warpmail.net
To: gitster@pobox.com, th.acker66@arcor.de
X-From: git-owner@vger.kernel.org Thu Oct 18 19:20:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOtlN-0008Qa-Si
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 19:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531Ab2JRRTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 13:19:55 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:42055 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932119Ab2JRRTy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 13:19:54 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mx.arcor.de (Postfix) with ESMTP id B9F7B108431;
	Thu, 18 Oct 2012 19:19:52 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id B3FD42E60AA;
	Thu, 18 Oct 2012 19:19:52 +0200 (CEST)
Received: from webmail11.arcor-online.net (webmail11.arcor-online.net [151.189.8.83])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id ADFAB30766;
	Thu, 18 Oct 2012 19:19:52 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-02.arcor-online.net ADFAB30766
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1350580792; bh=9wzglAHa3A4+8jYIoJXeaDrw0RYUshSe43vaRSq3g3g=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=LUXQTxp7StWP5/EXMaMFkjEocm9gcrDmArwV89KqmSn/kkMelgcu6cw+2fbUEXO23
	 jlaOzjQUWiFElkhsNtN/Nmk+eUmB8MoclAig2DyBPGfnJkU8b/ZoSzcoND8PnIjU8E
	 OhnRBKCTxGthVVdaDFzwbv4PxFI3KP6Lea7KP6BI=
Received: from [188.105.105.12] by webmail11.arcor-online.net (151.189.8.83) with HTTP (Arcor Webmail); Thu, 18 Oct 2012 19:19:52 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.105.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208016>

 
>
> That means that for the patch [6/8], which adds content-type to the
> text files, to be complete, it needs to update Makefile to produce
> html files from them.
> 

IMHO also for the new files in ./technical html should be created because
now as we have asciidoc markup why not also use it.

>
> > BTW2: The 'pretty-print shell script in update-hook-example.txt'
> > part of my changes was left out from the merge to pu ...
> 
> Do you mean e2399e9 (Documentation/howto: convert plain text files
> to asciidoc, 2012-10-16), or something else?

Yes; in e2399e9 the following hunks where left out from the patch to update-hook-example.txt:

@@ -111,12 +114,12 @@ then
 
       info "Found matching head pattern: '$head_pattern'"
       for user_pattern in $user_patterns; do
-	info "Checking user: '$username' against pattern: '$user_pattern'"
-	matchlen=$(expr "$username" : "$user_pattern")
-	if test "$matchlen" = "${#username}"
-	then
-	  grant "Allowing user: '$username' with pattern: '$user_pattern'"
-	fi
+        info "Checking user: '$username' against pattern: '$user_pattern'"
+        matchlen=$(expr "$username" : "$user_pattern")
+        if test "$matchlen" = "${#username}"
+        then
+          grant "Allowing user: '$username' with pattern: '$user_pattern'"
+        fi
       done
       deny "The user is not in the access list for this branch"
     done
@@ -149,13 +152,13 @@ then
 
       info "Found matching head pattern: '$head_pattern'"
       for group_pattern in $group_patterns; do
-	for groupname in $groups; do
-	  info "Checking group: '$groupname' against pattern: '$group_pattern'"
-	  matchlen=$(expr "$groupname" : "$group_pattern")
-	  if test "$matchlen" = "${#groupname}"
-	  then
-	    grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
-	  fi
+        for groupname in $groups; do
+          info "Checking group: '$groupname' against pattern: '$group_pattern'"
+          matchlen=$(expr "$groupname" : "$group_pattern")
+          if test "$matchlen" = "${#groupname}"
+          then
+            grant "Allowing group: '$groupname' with pattern: '$group_pattern'"
+          fi
         done
       done
       deny "None of the user's groups are in the access list for this branch"



---
Thomas
