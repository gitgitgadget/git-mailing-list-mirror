From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git Bug report
Date: Wed, 05 Oct 2011 08:11:37 +0200
Message-ID: <4E8BF519.8090509@viscovery.net>
References: <1317763443.17036.15.camel@skyplex>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Federico Lucifredi <federico@canonical.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 08:11:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBKho-0002bf-0M
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 08:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101Ab1JEGLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 02:11:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50404 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933898Ab1JEGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 02:11:41 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RBKhd-000375-N0; Wed, 05 Oct 2011 08:11:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5C8971660F;
	Wed,  5 Oct 2011 08:11:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1317763443.17036.15.camel@skyplex>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182826>

Am 10/4/2011 23:24, schrieb Federico Lucifredi:
> Hello Git list,
>  Found a minor bug in git today - the error message reported is not
> correct when trying to access a repo that is not accessible
> permission-wise:
> 
>> federico@skyplex:/etc$ git log
>> fatal: Not a git repository (or any of the parent directories): .git
> 
> with correct access permissions, everything works as expected.

And the correct error message is...?

>> drwx------   8 root root      4096 2011-10-03 16:53 .git

Assuming that you expected something like this:

fatal: .git: permission denied

it is hard to argue that a directory that happens to be named .git, but
was sealed by its owner should be assumed to be a git repository, albeit
one that we do not have access to. "Not a git repository" is an equally
justifyable error message, IMHO.

-- Hannes
