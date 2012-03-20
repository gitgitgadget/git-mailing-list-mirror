From: Antony Male <antony.male@gmail.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 02:27:43 +0000
Message-ID: <4F67EB1F.30205@gmail.com>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 03:27:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9onf-0000FE-FW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 03:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2CTC1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 22:27:46 -0400
Received: from honeysuckle.london.02.net ([87.194.255.144]:54498 "EHLO
	honeysuckle.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab2CTC1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 22:27:46 -0400
Received: from [127.0.0.1] (87.194.161.58) by honeysuckle.london.02.net (8.5.140)
        id 4F58EC1A004E2634; Tue, 20 Mar 2012 02:27:44 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
X-Antivirus: avast! (VPS 120319-1, 19/03/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193479>

This is my 2 cents from helping out on #git.  I don't consider workflows 
at all, only how to minimise confusion for new users when they're trying 
to understand how git works.

We occasionally get users who are having trouble understanding why the 
argument-less form of 'git pull' is failing, due to lack of tracking 
configuration.  We explain that the tracking config is git's way of 
"connecting" local and remote branches, and how to use 'git push -u' and 
'git branch --set-upstream' appropriately.

This is all well and good -- they've discovered that local and remote 
branches are separate, that they aren't "magically" joined, that there's 
a bit of configuration data which "connects" the two, and how to 
manipulate it.

Users then assume that argument-less form of 'git push' uses the same 
mechanism.  To then discover that it (by default) uses a different way 
of "connecting" local and remote branches is often confusing [1].  In 
addition, it can't be manipulated in the same way as the tracking config 
they learnt about before.

For this reason, I am in favour of push.default = upstream. Although it 
requires knowledge about setting up tracking config (in the cases where 
tracking config isn't set automatically), this knowledge has to be 
gained anyway for the argument-less form of 'git pull' to work.


[1]: Indeed, a lot of users only find out about this difference when it 
has bitten them in some way.

Thanks,
Antony
