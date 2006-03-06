From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Sun, 05 Mar 2006 22:21:40 -0800
Message-ID: <440BD4F4.3060906@gmail.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com> <440BC92E.4060306@gmail.com> <440BCB67.4070406@michonline.com> <20060306055036.GB26820@spearce.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 07:21:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG96I-00089S-Mi
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWCFGVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWCFGVo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:21:44 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:52620 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751376AbWCFGVn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 01:21:43 -0500
Received: by pproxy.gmail.com with SMTP id i75so703489pye
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 22:21:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cJqt8wIWcaAlDvfArvS5+J+6F6UHQPF9+cGvJvVN/+Uk+4VDFG0ZiBj4CfPc4ka72t9ruLgNq3MgG3h6Y+tZqp+TVcdX0u3ShzYWfFFAPdAS/Cpbzb+XDQ+1TjMEfksyQ01AQO7NJubNWa83nkpoIFJ3mj6KbYkqkXiE/9UroAU=
Received: by 10.35.34.20 with SMTP id m20mr727659pyj;
        Sun, 05 Mar 2006 22:21:42 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id n40sm1430719pyg.2006.03.05.22.21.41;
        Sun, 05 Mar 2006 22:21:42 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060306055036.GB26820@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17278>

Shawn Pearce wrote:
> Ryan Anderson <ryan@michonline.com> wrote:
>>A Large Angry SCM wrote:
>>
>>>Ryan Anderson wrote:
>>>...
>>>
>>>>For annotate, the syntax I was using was:
>>>>    git annotate Makefile headname
>>>>
>>>>I'm not married to it, so please, send a patch to change it if you want
>>>>(Please fix up the test case I'm sending in this patch, as well.)
>>>>
>>>Wouldn't
>>>    git annotate <headname> <filename(s?)>
>>>be more consistent with other git commands?
>>>
>>Yes, but <headname> (really, a commitish) needs to be optional.
>>
>>I should probably switch to:
>>    git annotate [-c|--commit <committish>] <filename>
>>but that's partly why I'm asking for feedback.

That works.

Or maybe:
	git-annotate [<committish> --] <filename(s?)>
or:
	git-annotate [<committish>] -- <filename(s?)>

> 
> Yes but doesn't git-diff accept:
> 
> 	git-diff Makefile
> 	git-diff HEAD Makefile
> 
> ?  (Which is rather ugly as what if you have a tracked file actually
> called HEAD and you want the first form when the commit-ish is
> omitted.)  So accepting an optional commit-ish before the filename
> would be in line with what git-diff accepts today.
> 
> But maybe breaking convention from git-diff now is a good thing,
> with a future change to cleanup git-diff.
> 

Looking at the documentation, it looks like all of the commands that 
take paths do so as the last arguments. With any commit/tree arguments 
being, either, required or flagged.

Is there any reason that git-{annotate,blame} can't take more than one 
filename, ever?
