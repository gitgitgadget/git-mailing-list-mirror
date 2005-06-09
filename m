From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [ANNOUNCE] Cogito-0.11.3
Date: Thu, 09 Jun 2005 15:07:24 +0200
Message-ID: <42A83F0C.5020809@gmail.com>
References: <20050609091909.GF29665@pasky.ji.cz> <42A81584.90605@antselovich.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Konstantin Antselovich <konstantin@antselovich.com>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 15:39:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgNAq-0000cr-Sz
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 15:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVFINi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 09:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVFINi0
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 09:38:26 -0400
Received: from main.gmane.org ([80.91.229.2]:60802 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262379AbVFINiY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 09:38:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DgMvg-0006sG-VD
	for git@vger.kernel.org; Thu, 09 Jun 2005 15:18:41 +0200
Received: from c80-217-52-214.cm-upc.chello.se ([80.217.52.214])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 15:18:40 +0200
Received: from holmsand by c80-217-52-214.cm-upc.chello.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Jun 2005 15:18:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c80-217-52-214.cm-upc.chello.se
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <42A81584.90605@antselovich.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Konstantin Antselovich wrote:
> I have updated to Cogito-0.11.3, it compiles and runs
> but make test returns multiple error messages (see below)

There's a typo in rev-list.c. This fixes the tests for me:

diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -218,7 +218,7 @@ int main(int argc, char **argv)
                         list = limit_list(list);
                 show_commit_list(list);
         } else {
-#ifdef NO_OPENSSL
+#ifndef NO_OPENSSL
                 if (sort_list_in_merge_order(list, &process_commit)) {
                           die("merge order sort failed\n");
                 }

