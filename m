From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 09:52:44 +0200
Message-ID: <48CF65CC.6080509@viscovery.net>
References: <loom.20080915T222909-709@post.gmane.org> <48CF5B90.5050800@viscovery.net> <48CF630F.4090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 09:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfVQ9-0008WG-LN
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 09:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYIPHwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 03:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYIPHwu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 03:52:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57754 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYIPHwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 03:52:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfVMa-0000m0-Lr; Tue, 16 Sep 2008 09:52:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 715F26EF; Tue, 16 Sep 2008 09:52:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48CF630F.4090808@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95987>

Sergio Callegari schrieb:
> Johannes Sixt wrote:
>>
>> You don't need a temporay zip filename in filter mode:
>>
>>   unzip $UNZIP_OPTS /dev/stdin  # works for me, but not 100% portable
>>   zip $ZIP_OPTS - .             # writes to stdout
>>
>>   
> The unzip documentation says "Archives read from standard input are not
> yet supported", so I was a bit worried about using the /dev/stdin
> thing.  Might it be that there are subtle cases where unzip needs to
> seek or rewind?

I didn't test thoroughly nor did I read the documentation. So if the
documentation says stdin is a no-go, you better do what it says. ;)

> In any case - but this is just my feeling - it is much more disturbing
> the delay that the clean filter introduces in operations like add or
> status or commit, than the one introduced by the (slower) smudge filter
> in checkout.

My feeling is that the temporary tree that is written slows it down. If
rezip were a true filter it could be faster.

-- Hannes
