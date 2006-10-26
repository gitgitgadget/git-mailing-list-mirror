X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Fri, 27 Oct 2006 01:50:39 +0200
Message-ID: <200610270150.40100.jnareb@gmail.com>
References: <20061026233439.37073.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 23:50:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uVQFjVqwsPn4lasbOZMGDVt+OX81meS36Gz6RgGFg6DyYt/5MlW71wCKZw3s26poml2XvBG1zrhEFDA4sZzODCxppPG6F8pdWWyaiZXF3h1BlzwVhwisJjLSEHv6SkoKJD5/tr5K4YUQVrehgtY1ljFElYU2kMCCwFPSzci84C0=
User-Agent: KMail/1.9.3
In-Reply-To: <20061026233439.37073.qmail@web31811.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30267>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdEzF-00031M-6n for gcvg-git@gmane.org; Fri, 27 Oct
 2006 01:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946030AbWJZXuH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 19:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946032AbWJZXuH
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 19:50:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8073 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946030AbWJZXuF
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 19:50:05 -0400
Received: by ug-out-1314.google.com with SMTP id 36so470403ugg for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 16:50:04 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr3871457ugh; Thu, 26 Oct 2006
 16:50:03 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id l40sm1028504ugc.2006.10.26.16.50.03; Thu, 26 Oct
 2006 16:50:03 -0700 (PDT)
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> Can you please explain what both patches actually do?
> 
> "slight visual improvements to commitdiff view" leaves
> much, _much_ to be desired and is hardly a commit message
> suitable to live in git.git.
> 
> Please describe what you found objectionable, why, how
> you decided to fix it and why you decided to fix it that way.

Adding difftree/whatchanged output to commitdiff view was somewhat
hasty, without taking care of details like separator between message 
body and difftree, and separator between difftree and patchset.

First, I have removed creating empty divs. The div with number of 
changed files in git_difftree_body is added only if the message about 
number of changed files is displayed (above 10).

Second, I have moved commit message body in commitdiff outside 
"page_body" div, to be together with "author_date" div with authorship 
info. The name of class was changed from "log" to more informative 
"commitdiff_log". This required some changes and additions to CSS. Now 
"commitdiff_log" div is responsible for displaying line separatring it 
from "page_body".

I have added not full line above "patchset" div (between patchet and 
difftree). It is added by "patchset" div and separated by 8px padding.


Those changes might wait for proper refactoring of gitweb CSS (having 
for example 8px padding in one place only).
-- 
Jakub Narebski
