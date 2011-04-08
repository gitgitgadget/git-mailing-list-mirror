From: Vincent van Ravesteijn <V.F.vanRavesteijn@tudelft.nl>
Subject: Serious inflate inconsistency on windows
Date: Fri, 08 Apr 2011 10:39:50 +0200
Message-ID: <4D9EC9D6.2090100@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 11:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q87ZP-0000xH-0F
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 11:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab1DHJB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 05:01:29 -0400
Received: from mailservice.tudelft.nl ([130.161.131.5]:53641 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab1DHJB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 05:01:28 -0400
X-Greylist: delayed 1300 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2011 05:01:28 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavis (Postfix) with ESMTP id 80A1A2B8010
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 10:39:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at tudelft.nl
X-Spam-Flag: NO
X-Spam-Score: -21.89
X-Spam-Level: 
X-Spam-Status: No, score=-21.89 tagged_above=-99 required=5
	tests=[BAYES_00=-1.9, PROLO_LEO3=0.01, TUD_REL01=-20] autolearn=ham
Received: from mailservice.tudelft.nl ([130.161.131.73])
	by localhost (tudelft.nl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mINXjjmunsNi for <git@vger.kernel.org>;
	Fri,  8 Apr 2011 10:39:46 +0200 (CEST)
Received: from smtp-a.tudelft.nl (smtp-a.tudelft.nl [130.161.180.7])
	by mx2.tudelft.nl (Postfix) with ESMTP id E21702B8011
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 10:39:46 +0200 (CEST)
Received: from [192.168.40.219] (221-44.206-83.static-ip.oleane.fr [83.206.44.221])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-a.tudelft.nl (Postfix) with ESMTP id 92538B3A62
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 10:39:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171117>

Hi All,

I'm not sure how important this is, but I had the following this morning 
while fetching the git repo:

 >git fetch
remote: Counting objects: 567, done.
remote: Compressing objects: 100% (149/149), done.
remote: Total 317 (delta 238), reused 216 (delta 167)
Receiving objects: 100% (317/317), 134.38 KiB | 24 KiB/s, done.
error: inflate: data stream error (incorrect header check)
fatal: serious inflate inconsistency
fatal: index-pack failed

 >git --version
git version 1.7.4.MSVC
(self-compiled on windows 28-3-2011)

This was reproducable. Now trying a precompiled git version:

 >"c:\Program Files\Git\bin\git.exe" fetch
remote: Counting objects: 567, done.
remote: Compressing objects: 100% (149/149), done.
remote: Total 317 (delta 238), reused 216 (delta 167)
Receiving objects: 100% (317/317), 134.38 KiB | 20 KiB/s, done.
Resolving deltas: 100% (238/238), completed with 65 local objects.
 From git://git.kernel.org/pub/scm/git/git
    5cd1518..ee3adc3  html       -> origin/html
    d424a47..5fb41b8  maint      -> origin/maint
    9b12242..635319e  man        -> origin/man
    fa38cfc..6be0559  master     -> origin/master
    0244ef9..4a6bb82  next       -> origin/next
  + 5d84cab...1e58d31 pu         -> origin/pu  (forced update)
    f0ee024..9b460ad  todo       -> origin/todo
  * [new tag]         v1.7.4.4   -> v1.7.4.4
  * [new tag]         v1.7.5-rc1 -> v1.7.5-rc1

 >"c:\Program Files\Git\bin\git.exe" --version
git version 1.7.3.1.msysgit.0

I don't know how to rewind my git clone to represent exactly the state 
it was in this morning, so it's difficult to explore further.

Vincent
