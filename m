From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] git-send-email: default value for "From:" field.
Date: Thu, 18 Jan 2007 14:39:06 -0600
Organization: Freescale
Message-ID: <45AFDAEA.607@freescale.com>
References: <200612271343.kBRDhKfA009927@laptop13.inf.utfsm.cl> <45928035.6000605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 21:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7e3I-0008Sy-LA
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 21:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbXARUkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbXARUkA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 15:40:00 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:41252 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbXARUkA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 15:40:00 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l0IKd7OQ005416;
	Thu, 18 Jan 2007 13:39:07 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0IKd6Zl014033;
	Thu, 18 Jan 2007 14:39:07 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
To: Quy Tonthat <qtonthat@gmail.com>
In-Reply-To: <45928035.6000605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37138>

Quy Tonthat wrote:
> If user hits enter at the prompt for
> "Who should the emails appear to be from?",
> the value for "From:" field was emptied instead of GIT_COMMITER_IDENT.
> 
> Signed-off-by: Quy Tonthat <qtonthat@gmail.com>
> ---
> It seems the original code assumes readline to accept
> an extra argument for default value. I don't remember I ever encountered
> that feature from readline. Is there anything like that out there ?

I was thinking the same thing.  Almost every call to readline() in 
git-send-email is like that, so could your patch below could be expanded to 
include the other instances?

         $_ = $term->readline("Who should the emails be sent to? ",
                         "");

         $_ = $term->readline("What subject should the emails start with? ",
                 $initial_subject);

         $_= $term->readline("Message-ID to be used as In-Reply-To for the first 
email? ",
                 $initial_reply_to);

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
