From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] Teach 'rebase -i' the command "reword"
Date: Tue, 06 Oct 2009 00:43:17 -0700
Message-ID: <4ACAF515.2060403@gmail.com>
References: <4ACA1BD1.6050905@gmail.com> <4ACAACAB.3020707@gmail.com> <4ACAEBBA.9000806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 09:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv4jI-0000XV-5z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 09:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbZJFHmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2009 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbZJFHmT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 03:42:19 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:46367 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbZJFHmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 03:42:18 -0400
Received: by qw-out-2122.google.com with SMTP id 3so1390612qwe.37
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=8cbx5D+YAQohnZyRaclf1dpylhEcImO7+L23hMGkLhM=;
        b=SEIb6zcG/G9nDpBMT8ltZ1DKyMZgQeoAhdDXBbw1hl+YC07Uiop6gIbeIGA1xtEygN
         xVGRlbcCgA8mfZgfI7I24IDAUMRobCRBntpWxGMXvIfY++9RDRNhNzouFE+5O/LRVwRW
         x5XYPf5yh9A5Z9effLYpqwUZY2YYtqT5+kkn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=oNYmS6uSehFmdKjbRtx329tkvZqUlHM6ncJUpFfABcSDjbnlG7lcyuzp6xcL8b4TuV
         sYQKbQKkdwXp5+jihOLJzkjRqhavu1M0uCu8BTpLZzQp57+wckVyT3L7rXU7OPId6g4A
         4EECq7CyeCPaj5/AlCpDRrT/MvEVudak+HG90=
Received: by 10.224.117.212 with SMTP id s20mr973234qaq.95.1254814871052;
        Tue, 06 Oct 2009 00:41:11 -0700 (PDT)
Received: from ?192.168.1.2? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 21sm290442qyk.8.2009.10.06.00.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Oct 2009 00:41:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <4ACAEBBA.9000806@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129610>

Bj=F6rn Gustavsson wrote:
>> How about this?
>>
>> use commit, but stop to edit (or reword?) the commit message
>
> No, I think that would be misleading, as "stop" means exit to the she=
ll
> so that you can run other git commands. (The documentation says:
> "...the loop will stop to let you fix things, and you can continue
> -the loop with `git rebase --continue`")

Ok, "stop" being misleading makes sense but I still think the English i=
s
wrong. Particularly the part about allow editing. Maybe just remove
"stop", so

    use commit, but edit the commit message

>
> -In both cases, or when a "pick" does not succeed (because of merge
> -errors), the loop will stop to let you fix things, and you can conti=
nue
> -the loop with `git rebase --continue`.
> +When "pick" has been replaced with "edit" or when a "pick" does not
> +succeed (because of merge errors), the loop will stop to let you fix
> +things, and you can continue the loop with `git rebase --continue`.
>  =20

Patch looks good, but if you decide to resend due to my comment above
maybe you could think about replacing the word "loop" with "rebase". We
should probably just say "the rebase will stop" and "you can continue
with `git rebase ..."

Or we could combine yours, mine, and Hannes' versions.

The rebase will stop when "pick" has been replaced with "edit" or when =
a command fails due to merge errors. When you are done editing and/or r=
esolving conflicts you can continue with `git rebase --continue`.
