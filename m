From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 09:27:15 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4AA9FBD3.5040404@atlas-elektronik.com>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com> <4AA9F0A2.6050105@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 09:27:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm0XZ-0000tJ-Mn
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 09:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbZIKH1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 03:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZIKH1U
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 03:27:20 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:43747 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbZIKH1U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 03:27:20 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 1A912138A5
	for <git@vger.kernel.org>; Fri, 11 Sep 2009 09:27:21 +0200 (CEST)
X-AuditID: 0ac86512-00001df4000005b8-a9-4aa9fbd90751
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Sep 2009 09:27:21 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 46D9A27184
	for <git@vger.kernel.org>; Fri, 11 Sep 2009 09:27:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 39C8727182
	for <git@vger.kernel.org>; Fri, 11 Sep 2009 09:27:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4AA9F0A2.6050105@atlas-elektronik.com>
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128181>

On 9/11/2009 8:39 AM, Stefan Naewe wrote:
> On 9/11/2009 12:33 AM, Aloisio wrote:
>> Hi all,
>>
>> I faced a problem when trying to clone git://gitorious.org/qt/qt.git
>>
>> this works:
>> git clone -n git://gitorious.org/qt/qt.git repo
>>
>> this doesn't:
>> git clone -n git://gitorious.org/qt/qt.git repo >log
>> fatal: The remote end hung up unexpectedly
>> fatal: early EOF
>> fatal: index-pack failed
>>
>> I reproduced the error in the following versions:
>> git version 1.6.0.4
>> git version 1.6.4.2
>> git version 1.5.4.7
>>
>> Any clues?
>> Thanks
> 
> I'd say:
> 
> Take a look at /proc/<pid-of-git>/fd
> 
> fd 0 (stdout) is linked through a pipe to 'git index-pack'.
> Redirecting this link breaks everything.

stdout is of course fd 1 ;-)

Regards,
Stefan
-- 
/dev/random says: Never trust a computer you can't lift. - Stan Masor
