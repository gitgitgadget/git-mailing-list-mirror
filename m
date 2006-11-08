X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: New improved patchset view
Date: Wed, 8 Nov 2006 17:58:57 +0100
Message-ID: <200611081758.57597.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <200611081150.07469.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 17:00:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=H/BZ3q1hRafb6l4iy945avEzvgC8bdQ2cvgxHxgXouH2daL17WYdFudAUznZiJXjynWch/hLvyCN1CB5Q8ur3i43IKTGIVw+Z/TIfUvobBEdPsbJsXPxaMMWuzYabLh1fCvsXbhTYxdKCjiO1izdB87VDh/gDQjqNLZdwKyrBQ8=
User-Agent: KMail/1.9.3
In-Reply-To: <200611081150.07469.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31145>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhqmI-00087z-0z for gcvg-git@gmane.org; Wed, 08 Nov
 2006 17:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161293AbWKHQ7u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 11:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161347AbWKHQ7u
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 11:59:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21145 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161293AbWKHQ7u
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 11:59:50 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1576702ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 08:59:48 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr11266128ugm.1163005188201; Wed, 08
 Nov 2006 08:59:48 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e1sm8082261ugf.2006.11.08.08.59.47; Wed, 08 Nov
 2006 08:59:47 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This series of patches is based on previous "[PATCH 0/2] Better unquoting
of git quoted filenames; esc_path to escape pathnames for display" series;
actually previous series was send because it is prerequisite of this series.

This series introduces new "feature", namely new commitdiff and blobdiff
view (new patchset view in short) BUT without this feature the accepted
"gitweb: Output also empty patches in "commitdiff" view" is of dubious value,
as it has not much sense without new patchset view.

Without "new improved patchset view" the empty patches are just that:
totally empty. It is new header and especially outputting extended header
information which makes outputting "empty" patches (with no diff)
in "commitdiff" view usefull. By "empty" patches I mean pure type change,
pure rename, pure copy, and type change with rename.


Shortlog:
 [PATCH 1/2] gitweb: New improved patchset view
 [PATCH 2/2] gitweb: New improved formatting of chunk header in diff

Diffstat:
 gitweb/gitweb.css  |   79 +++++++++++++++++---
 gitweb/gitweb.perl |  201 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 203 insertions(+), 77 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
