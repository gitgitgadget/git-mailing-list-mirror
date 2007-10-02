From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git clone questions relating to cpio
Date: Tue, 02 Oct 2007 08:11:24 +0200
Message-ID: <4701E10C.7050405@viscovery.net>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>	<Pine.LNX.4.64.0710020022470.28395@racer.site> <7vwsu6pg0v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 08:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icaym-0000zL-LA
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 08:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXJBGL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 02:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbXJBGL3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 02:11:29 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16682 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbXJBGL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 02:11:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IcayZ-00024d-QI; Tue, 02 Oct 2007 08:11:24 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9A9A354D; Tue,  2 Oct 2007 08:11:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vwsu6pg0v.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59662>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Mon, 1 Oct 2007, Reece Dunn wrote:
>>
>>> I am running a Linux From Scratch 6.2 system that does not have cpio
>>> installed on it. This means that I can't clone a local repository
>>> unless I install cpio.
>> You might be interested in the workaround Hannes did in mingw.git; he made 
>> a wrapper script called 'cpio' using 'tar'.
> 
> I think that may be good enough as workaround, but I do not
> think you would get the space saving from hardlinks that way.

FWIW, I'm thinking about changing the cpio -p (passthrough) part to use
'cp -l --parents --target-directory=...' instead of tar; this gives us hard 
links, even on NTFS. But it needs GNU's cp, of course.

-- Hannes
