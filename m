From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to do a fast-forward merge without a checkout?
Date: Mon, 18 Jul 2011 17:08:37 +0200
Message-ID: <4E244C75.6060407@viscovery.net>
References: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 17:08:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QipRB-0006Kq-CB
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 17:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab1GRPIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 11:08:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50867 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1GRPIn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 11:08:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QipR0-0004OG-7n; Mon, 18 Jul 2011 17:08:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BCC691660F;
	Mon, 18 Jul 2011 17:08:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CAF_dkJCvtVqoDmRXMy23ZnZL6iUAVX0nNA9Ev6e4zvBp9mfTpg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177375>

Am 7/18/2011 16:18, schrieb Patrick Doyle:
> $ git push
...
> To somehost:path/to/repo
>    e1004df..bad8767  wpd -> wpd
>  ! [rejected]        master -> master (non-fast-forward)

[Context: Patrick works on the topic branch, but can't push it anymore
because the unrelated branch master was moved forward by someone else.]

After the obligatory 'git fetch', there are at least two ways to do this:

(1) The quick and unsafe way:

    $ git branch -f master origin/master

(2) The safer way:

    $ git push . origin/master:master

The second command is safer because it checks that origin/master is indeed
a direct descendent of master.

-- Hannes
