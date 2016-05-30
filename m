From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Mon, 30 May 2016 20:28:01 +0200
Message-ID: <f80f8c1b-6a69-1356-d300-82b7c5af5821@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527201436.GA16547@dcvr.yhbt.net> <vpq8tyujkb0.fsf@anie.imag.fr>
 <7423b133-cec4-e633-f1ef-70ccc6a6cc02@grenoble-inp.org>
 <vpq8tyshh8f.fsf@anie.imag.fr>
 <0abbc11b-5741-ee2e-292c-245c2b974f8e@grenoble-inp.org>
 <vpqfuszaapu.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 20:28:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RvA-0007t2-Dk
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161792AbcE3S2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:28:07 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:42731 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161732AbcE3S2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:28:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2C62C24F3;
	Mon, 30 May 2016 20:28:03 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nhwe9-4Jfgxg; Mon, 30 May 2016 20:28:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 186AF24D7;
	Mon, 30 May 2016 20:28:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 0DA632077;
	Mon, 30 May 2016 20:28:03 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dY4V4nA-kMJ9; Mon, 30 May 2016 20:28:02 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 8BDE22066;
	Mon, 30 May 2016 20:28:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpqfuszaapu.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295921>

On 05/30/2016 04:20 PM, Matthieu Moy wrote:
>> Is the "lots of email" format still used?
>
> AFAICT, it was initially supported for backward compatibility, and then
> no one removed it, but I wouldn't be surprised if no one actually used
> it.
>
> I vaguely remember a message from Ryan Anderson being surprised to see
> the old format still supported, but I can't find it in the archives.
>
> In any case:
>
> - git log --grep 'lots of email' => shows only 83b2443
> - git log -S'lots of email' => likewise
> - git grep 'lots of email' => just one answer in a comment
>
> I'm not sure the feature is even tested.

`grep "non-mbox" t/t9001-send-email.sh` didn't return anything, 
apparently it's not tested.

Can we consider this feature obsolete and remove it?
