From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 08:39:30 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4AA9F0A2.6050105@atlas-elektronik.com>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Aloisio <aloisiojr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 09:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm0Id-00059E-Kv
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 09:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbZIKHLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 03:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZIKHLy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 03:11:54 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:54069 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263AbZIKHLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 03:11:53 -0400
X-Greylist: delayed 1940 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2009 03:11:53 EDT
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id DC5C5138A5
	for <git@vger.kernel.org>; Fri, 11 Sep 2009 08:39:35 +0200 (CEST)
X-AuditID: 0ac86512-00001680000005b8-3b-4aa9f0a778e7
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Sep 2009 08:39:35 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id D8D6627180;
	Fri, 11 Sep 2009 08:39:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id CD7812717F;
	Fri, 11 Sep 2009 08:39:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128179>

On 9/11/2009 12:33 AM, Aloisio wrote:
> Hi all,
> 
> I faced a problem when trying to clone git://gitorious.org/qt/qt.git
> 
> this works:
> git clone -n git://gitorious.org/qt/qt.git repo
> 
> this doesn't:
> git clone -n git://gitorious.org/qt/qt.git repo >log
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
> 
> I reproduced the error in the following versions:
> git version 1.6.0.4
> git version 1.6.4.2
> git version 1.5.4.7
> 
> Any clues?
> Thanks

I'd say:

Take a look at /proc/<pid-of-git>/fd

fd 0 (stdout) is linked through a pipe to 'git index-pack'.
Redirecting this link breaks everything.

Regards,
Stefan
