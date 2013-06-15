From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] Add missing calls to git_config()
Date: Sat, 15 Jun 2013 21:28:23 +0100
Message-ID: <51BCCE67.9010105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 22:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unx96-0007Ta-5S
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab3FOUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 16:32:06 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:36578 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754558Ab3FOUcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 16:32:00 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 87094384081;
	Sat, 15 Jun 2013 21:31:59 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id F3D92384080;
	Sat, 15 Jun 2013 21:31:58 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 15 Jun 2013 21:31:58 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227970>


Hi Junio,

I recently had need to use the '-c' option to git in order to
set some config variables from the command line; specifically
with 'git show-ref' and 'git pack-refs'. I haven't looked to
see if any other commands need similar attention, but:

    $ git grep 'cmd_.*(int argc' -- builtin | wc -l
    109
    $ git grep 'git_config(' -- builtin | wc -l
    80
    $

... maybe. ;-)

[I did think about separating the command line processing from
the config file processing; maybe some commands could accept
config settings from the command line, but do not need/want
the regular config file processing? *dunno*.]

ATB,
Ramsay Jones

Ramsay Jones (2):
  show-ref.c: Add missing call to git_config()
  pack-refs.c: Add missing call to git_config()

 builtin/pack-refs.c | 3 +++
 builtin/show-ref.c  | 2 ++
 2 files changed, 5 insertions(+)

-- 
1.8.3
