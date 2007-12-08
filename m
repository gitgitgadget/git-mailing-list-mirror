From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Where has "git ls-remote" reference pattern matching gone?
Date: Sat, 8 Dec 2007 23:05:14 +0100
Message-ID: <4E5E5B1E-A303-45C9-9944-57D54FD50F80@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 23:39:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J18KN-0000vH-CD
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 23:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbXLHWi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 17:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbXLHWi5
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 17:38:57 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:60522 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbXLHWi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 17:38:57 -0500
X-Greylist: delayed 2020 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2007 17:38:56 EST
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id BB0C862E788
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 23:05:14 +0100 (CET)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67575>

git-ls-remote(1) says that ls-remote supports filtering by reference  
name:


> SYNOPSIS
>        git-ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack  
> <exec>]
>                      <repository> <refs>...
>
> [...]
>
>        <refs>...
>               When unspecified, all references, after filtering done  
> with
>               --heads and --tags, are shown. When <refs>... are  
> specified,
>               only references matching the given patterns are  
> displayed.
>
> [...]
>
>        $ git ls-remote --tags public v\*
>        d6602ec5194c87b0fc87103ca4d67251c76f233a        refs/tags/v0.99
>        f25a265a342aed6041ab0cc484224d9ca54b6f41        refs/tags/ 
> v0.99.1
>        c5db5456ae3b0873fc659c19fafdde22313cc441        refs/tags/ 
> v0.99.2
>        7ceca275d047c90c0c7d5afb13ab97efdf51bd6e        refs/tags/ 
> v0.99.3

But when I try to use the <refs> argument on a current build of git  
(git version v1.5.3.7-1112-g9758ecd), I just get its usage message,  
which doesn't mention that argument:

> vredefort:[backup]% git ls-remote origin foob
> usage: git-ls-remote [--upload-pack=<git-upload-pack>]  
> [<host>:]<directory>


ls-remote was recently made a builtin; was reference filtering  
deliberately removed, or was it just lost in translation from the  
shell script?

Eyvind Bernhardsen
