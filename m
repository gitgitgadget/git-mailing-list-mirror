From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: [feature request] 2) Remove many tags at once and 1) Prune tags
 on old-branch-before-rebase
Date: Fri, 08 Mar 2013 14:37:21 -0500
Message-ID: <513A3DF1.7020009@giref.ulaval.ca>
References: <51390E43.60704@giref.ulaval.ca> <7v38w6lr8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 20:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE375-0005TH-4B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 20:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3CHTh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 14:37:28 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:55328 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab3CHTh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 14:37:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 07817101226;
	Fri,  8 Mar 2013 14:37:26 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 99y-aKH5TRTH; Fri,  8 Mar 2013 14:37:21 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id AB1AA101222;
	Fri,  8 Mar 2013 14:37:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7v38w6lr8n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217679>

Hi Junio,

On 03/07/2013 06:33 PM, Junio C Hamano wrote:
> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>
> What you want is a way to compute, given a set of tags (or refs in
> general) and a set of branches (or another set of refs in general),
> find the ones in the former that none of the latter can reach.  With
> that, you can drive "git tag -d $(that way)".
>

Yes, this is *exactly* what I want...

> In other words, the feature does not belong to "git tag" command.
>
>> 2) git tag -d "TOKEN*"
>
> Again, not interesting.  You already have:
>
>      git for-each-ref --format='%(refname:short)' refs/tags/TOKEN\* |
>      xargs -r git tag -d
>

I don't agree here for one reason:

git tag -l "TOKEN*"

already exists and works very well...

So why is it not interesting to have:

git tag -d "TOKEN*"

?

We can also write:

git tag -d `git tag -l "TOKEN*"`

but a simple addition to "-d" feature looks like a receivable behavior 
here, no?

Thanks,

Eric
