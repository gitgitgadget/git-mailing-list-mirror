From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: git-prompt.sh vs leading white space in __git_ps1()::printf_format
Date: Wed, 28 Nov 2012 21:08:33 +0100
Message-ID: <50B66F41.1030305@xs4all.nl>
References: <CAA01Cso1E4EC4W667FEU_af2=uGOfPuaWEB3y+zPCpB+bPzoaA@mail.gmail.com> <20121128132033.GA10082@xs4all.nl> <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdnwr-0000sc-4y
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 21:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab2K1UJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 15:09:12 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:3550 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab2K1UJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 15:09:09 -0500
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id qASK8Xk5075363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Nov 2012 21:08:34 +0100 (CET)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAA01CspHAHN7se2oJ2WgcmpuRfoa+9Sx9sUvaPEmQ-Y+kDwHhA@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210771>

On 28/11/12 19:02, Piotr Krukowiecki wrote:
>     Is your setting?:
>     PROMPT_COMMAND=__git_ps1
> 
> 
> That's right
>  
> 
>     I believe you need to give 2 parameters in order to use it in
>     PROMPT_COMMAND mode.
> 
> 
> Are you sure? git-prompt.sh says:
> 
> #    3a) In ~/.bashrc set PROMPT_COMMAND=__git_ps1
> #        To customize the prompt, provide start/end arguments
> #        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
> 
> I interpret this as: if you don't want to customize the prompt, the
> simple "PROMPT_COMMAND=__git_ps1" is enough.
>  

I'm sure, although you're right this documentation is wrong...
I guess it must have slipped by when the final changes were made to the
code. (The requirement to have 2 arguments for PROMPT_COMMAND mode were
one of the last changes before being accepted into the release process.)

I've been too busy with other stuff to take another look at this in the
meantime.

perhaps the point should read like this:
#    3a) In ~/.bashrc set PROMPT_COMMAND
#        To customize the prompt, provide start/end arguments
#        PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

Which would not be confusing at all, I think...

> 
> 
>     These last 2 lines say: if 2 arguments are given, use pcmode.
>     Otherwise you get command-subtitution mode, which gives weird
>     effects when being called from PROMPT_COMMAND.
> 
> 
> Still, it seems to work with above "patch"..

It only works in your specific case, since you're expecting the branch
info before the rest of your prompt. The output comes from the part of
the code that is meant for substitution mode ;-)

Cheers

Simon
