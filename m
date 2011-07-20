From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 12:45:38 +0530
Message-ID: <20110720124538.482628e3@shiva.selfip.org>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 20 09:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjR0N-0007ce-RN
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 09:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab1GTHPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 03:15:33 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:56262
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab1GTHPd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 03:15:33 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id C58D91808001
	for <git@vger.kernel.org>; Wed, 20 Jul 2011 09:15:30 +0200 (CEST)
In-Reply-To: <20110720121356.4dc21f6b@shiva.selfip.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177521>

On Wed, 20 Jul 2011 12:13:56 +0530
"J. Bakshi" <joydeep@infoservices.in> wrote:

> Hello list,
> 
> I have this bash script to check php syntax error and prevent the commit if there is any
> 
> ```````````````````
> #!/bin/sh
> 
> ##php_syntax_check
> 
>   for i in $(git diff-index --name-only --cached HEAD -- | grep -E '\.(php|engine|theme|install|inc>
>         if [ -f $i ]; then
>                 output=$(/usr/bin/php5 -l $i)
>                 if [ "$output" == "No syntax errors detected in $i" ];
>                 then
>                         echo "PHP syntax check for $i: OK"
>                 else
>                         echo "=====================================================================>
>                         echo "Pause $i for the commit due to PHP parse errors:"
>                         echo "$output"
>                         exit 1
>                 fi
>         fi
>     done
> 
> ```````````````````
> 
> Running fine when placed it at local copy.
> 
> I have placed the hook at the server under hooks directory and provided the execute permission also
> 
> $ chmod a+x hooks/pre-commit
> 
> But even with wrong php syntax I am able to push the file. Have I missed something ?
> 
> Thanks

seems it should be pre-receive hook at the server. So done accordingly but still not working 
