From: Andreas Ericsson <ae@op5.se>
Subject: Re: Should we support Perl 5.6?
Date: Mon, 20 Feb 2006 22:01:58 +0100
Message-ID: <43FA2E46.2000503@op5.se>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de> <20060220191011.GA18085@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 22:02:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBIAe-0007R1-Lu
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 22:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWBTVCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 16:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161184AbWBTVCJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 16:02:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5575 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1161182AbWBTVCA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 16:02:00 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 3FABB6BD08; Mon, 20 Feb 2006 22:01:59 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060220191011.GA18085@hand.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16500>

Eric Wong wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
>>Hi,
>>
>>I just had a failure when pulling, because since a few days (to be exact, 
>>since commit 1cb30387, git-fmt-merge-msg uses a syntax which is not 
>>understood by Perl 5.6.
>>
>>It is this:
>>
>>	open $fh, '-|', 'git-symbolic-ref', 'HEAD' or die "$!";
> 
> 
> This is just 5.8 shorthand for the following (which is 5.6-compatible,
> and probably for earlier versions, too):
> 
> 	my $pid = open my $fh, '-|';
> 	defined $pid or die "Unable to fork: $!\n";
> 	if ($pid == 0) {
> 		exec 'git-symbolic-ref', 'HEAD' or die "$!";
> 	}
> 	<continue with original code here>
> 
> All of the Perl code I've written uses this method.
> 
> 
>>I know that there was already some discussion on this list, but I don't 
>>remember if we decided on leaving 5.6 behind or not.
>>
>>Somebody remembers?
> 
> 
> IIRC, there was no clear decision.
> 

I think we agreed not to bother at all with Perl 5.4 and earlier, and 
not to bend over backwards to support 5.6. This seems like a simple fix 
though, so I'm sure Junio will accept a patch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
