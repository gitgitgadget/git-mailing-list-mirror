From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] pack-refs: remove newly empty directories
Date: Tue, 06 Jul 2010 08:10:51 +0200
Message-ID: <4C32C8EB.1090104@viscovery.net>
References: <1278368848-7037-1-git-send-email-price@ksplice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 08:11:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW1N0-0005L8-0y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 08:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab0GFGKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 02:10:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44365 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab0GFGKz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 02:10:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OW1Mp-0006g8-Ky; Tue, 06 Jul 2010 08:10:51 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 587001660F;
	Tue,  6 Jul 2010 08:10:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1278368848-7037-1-git-send-email-price@ksplice.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150323>

Am 7/6/2010 0:27, schrieb Greg Price:
> In a large repository which uses directories to organize many refs,
> "git pack-refs --all --prune" does not improve performance so much
> as it should, unless we remove all the now-empty directories as well.

Before your patch, when you create a ref refs/heads/foo/bar, then pack
refs, then it is impossible to create a ref refs/heads/foo because
refs/heads/foo still exists as directory. And this is a good thing.

With your patch, is there any mechanism that inhibits that refs/heads/foo
is created when directory refs/heads/foo does not exist, but a packed ref
refs/heads/foo/bar is present?

-- Hannes
