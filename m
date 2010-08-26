From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Storing notes refs outside of refs/
Date: Thu, 26 Aug 2010 13:20:48 -0600
Message-ID: <4C76BE90.6040902@workspacewhiz.com>
References: <4C7681F1.3070205@workspacewhiz.com> <7vy6btl2yo.fsf@alter.siamese.dyndns.org> <4C76B186.5080809@workspacewhiz.com> <7vlj7tkxvn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 21:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooi0g-0005uC-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 21:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab0HZTUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 15:20:53 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54624 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0HZTUv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 15:20:51 -0400
Received: (qmail 13064 invoked by uid 399); 26 Aug 2010 13:20:49 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.39.54)
  by hsmail.qwknetllc.com with ESMTPAM; 26 Aug 2010 13:20:49 -0600
X-Originating-IP: 75.220.39.54
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <7vlj7tkxvn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154558>

  ----- Original Message -----
From: Junio C Hamano
Date: 8/26/2010 12:54 PM
> Joshua Jensen<jjensen@workspacewhiz.com>  writes
>> gitk --all --not --glob=refs/notes/*
>>
>> does not work.
> I don't think --not there is a good idea because "--not" in rev-list
> parameter means "not reachable from the following commits".
Okay.  I've not used it before.
> It may be useful if you made "--all --glob=!refs/notes/*" to work,
> though.  I could picture myself buying such a change.
>
> Or just use "--branches --tags" instead, perhaps?
gitk --branches --remotes --tags is long to type.  (Let's ignore git 
aliases for the moment.)

The deal is, refs/notes/ showing in git log --all serves no purpose, in 
my opinion.  If it does for somebody else, I'd love to hear.

What if there was a configuration setting applied to 'git log --all' as 
a filter for refs I never want to see in the --all view?

git config --add core.logfilter refs/notes/*
git config --add core.logfilter refs/game-p4/*

I also like the negated --glob syntax you showed above.

Another possibly useful idea is an extra 'git log' parameter --brt (for 
--branches, --remotes, --tags).

Thoughts?  I'll see if I can find some time to work on something once I 
have a bit of direction.

Josh
