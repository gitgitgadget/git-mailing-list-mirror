From: Quy Tonthat <qtonthat@gmail.com>
Subject: Re: [PATCH] git-send-email: default value for "From:" field.
Date: Fri, 19 Jan 2007 12:14:42 +1100
Message-ID: <45B01B82.9050707@gmail.com>
References: <200612271343.kBRDhKfA009927@laptop13.inf.utfsm.cl> <45928035.6000605@gmail.com> <45AFDAEA.607@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 02:15:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7iLV-00060c-Jl
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 02:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834AbXASBPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 20:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932835AbXASBPA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 20:15:00 -0500
Received: from pecan-mail.exetel.com.au ([220.233.0.8]:57961 "EHLO
	pecan.exetel.com.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932834AbXASBO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 20:14:59 -0500
Received: from [220.233.69.95] (helo=[192.168.64.35])
	by pecan.exetel.com.au with esmtp (Exim 4.63)
	(envelope-from <qtonthat@gmail.com>)
	id 1H7iLE-0007R2-La; Fri, 19 Jan 2007 12:14:53 +1100
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <45AFDAEA.607@freescale.com>
X-Enigmail-Version: 0.94.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37145>

Timur Tabi wrote:
> Quy Tonthat wrote:
>> If user hits enter at the prompt for
>> "Who should the emails appear to be from?",
>> the value for "From:" field was emptied instead of GIT_COMMITER_IDENT.
>>
>> Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
>> ---
>> It seems the original code assumes readline to accept
>> an extra argument for default value. I don't remember I ever encountered
>> that feature from readline. Is there anything like that out there ?
> 
> I was thinking the same thing.  Almost every call to readline() in
> git-send-email is like that, so could your patch below could be expanded
> to include the other instances?
> 
>         $_ = $term->readline("Who should the emails be sent to? ",
>                         "");
> 
>         $_ = $term->readline("What subject should the emails start with? ",
>                 $initial_subject);
> 
>         $_= $term->readline("Message-ID to be used as In-Reply-To for
> the first email? ",
>                 $initial_reply_to);
> 
It is correct to expand the fix to other instances, but that won't practically
change anything at run time (All those "defaults" are empty when passed to readline).
I don't normally change somebody else's codes just for the sake of correctness or styles.
Quy
