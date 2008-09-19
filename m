From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from
 git-gui.
Date: Fri, 19 Sep 2008 14:10:16 +0200
Message-ID: <48D396A8.4050607@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <1221685659-476-2-git-send-email-angavrilov@gmail.com> <1221685659-476-3-git-send-email-angavrilov@gmail.com> <1221685659-476-4-git-send-email-angavrilov@gmail.com> <1221685659-476-5-git-send-email-angavrilov@gmail.com> <1221685659-476-6-git-send-email-angavrilov@gmail.com> <1221685659-476-7-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 14:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgepf-0001xw-4p
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 14:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYISMKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 08:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbYISMKV
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 08:10:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38725 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbYISMKU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 08:10:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgeoS-0005Pg-TS; Fri, 19 Sep 2008 14:10:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5B58454D; Fri, 19 Sep 2008 14:10:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1221685659-476-7-git-send-email-angavrilov@gmail.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96278>

Alexander Gavrilov schrieb:
> Add functions that implement the same logic for file
> contents encoding as git-gui uses:
> 
> - Defaults to the system encoding.
> - Overridden by setting the gui.encoding option.
> - Further overridden on per-file basis by gitattributes.
> 
> Also extends the range of supported encoding names.

If I run

  $ LANG=C gitk 146ed90

with this series on the git-gui repository, then I hoped to see the text
in the patches in the right encoding. But I understand that I expected too
much - the patch text is just a stream of bytes that comes from different
files, and the best you can do is to apply the system encoding.

But if the view is switched to the tree view, and file contents are
inspected, then this patch should help. But it doesn't. If you look at
po/ja.po, it is appearent that the file was not read as UTF-8, which is
dictated by .gitattributes.

-- Hannes
