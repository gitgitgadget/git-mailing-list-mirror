From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 07 Oct 2010 17:07:30 +0200
Message-ID: <4CADE232.8030801@viscovery.net>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com> <20101007141015.GB8162@sigill.intra.peff.net> <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 17:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3s4Z-00040w-Cy
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 17:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094Ab0JGPHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 11:07:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46188 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932873Ab0JGPHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 11:07:34 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3s4A-0004Ab-RX; Thu, 07 Oct 2010 17:07:31 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 80FEC1660F;
	Thu,  7 Oct 2010 17:07:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158406>

Am 10/7/2010 16:35, schrieb Kirill Likhodedov:
> My bad, this happens only on Windows (at least not on Mac OS X).

With git rev-list, it also happens on Linux:

$ git log -1 --pretty=foo%x00bar HEAD | od -c
0000000   f   o   o  \0   b   a   r  \n
0000010
$ git rev-list -1 --pretty=foo%x00bar HEAD | od -c
0000000   c   o   m   m   i   t       8   7   f   a   f   1   0   9   0
0000020   5   d   1   f   8   a   b   1   e   9   a   c   2   4   c   c
0000040   3   e   f   e   d   8   1   f   a   7   e   2   9   6   7  \n
0000060   f   o   o  \n
0000064
$ git version
git version 1.7.3.67.gcc234

-- Hannes
