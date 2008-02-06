From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 06 Feb 2008 12:33:37 +0100
Message-ID: <47A99B11.8080506@viscovery.net>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <47A98092.2070509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>,
	Scott R Parish <sRp@srparish.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 12:34:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMiXh-00012H-Rd
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 12:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbYBFLdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 06:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755653AbYBFLdr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 06:33:47 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51564 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbYBFLdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 06:33:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JMiWo-0004I7-J1; Wed, 06 Feb 2008 12:33:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C738D6B7; Wed,  6 Feb 2008 12:33:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47A98092.2070509@viscovery.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72802>

Johannes Sixt schrieb:
> Wincent Colaiuta schrieb:
>> Drop the --inetd option and it works with no errors:
>>
>>   # /usr/local/bin/git-daemon --base-path=/blah -- /blah
> 
> When I run git-daemon with a reduced path similar to this:
> 
>    PATH=/bin:/usr/bin /usr/local/bin/git-daemon ...
> 
> i.e. git is installed in /usr/local/bin, but it is not in PATH, then I
> also get "hung up unexpectedly" from a client that connects to this server.
> 
> Which makes me think that you xinetd doesn't pass a PATH to git-daemon
> that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:
> 
>     env = PATH=/bin:/usr/bin:/usr/local/bin
> 
> (not tested).

And if I run it this way:

    PATH=/bin:/usr/bin /usr/local/bin/git daemon ...

(notice the dash-less form) it works, too. Although I don't know if this
somehow would interfere with --inetd mode.

-- Hannes
