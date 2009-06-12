From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 19:38:29 +0400
Message-ID: <85647ef50906120838s37c186a9mec301e880b1a8a4e@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	 <20090612084209.6117@nanako3.lavabit.com>
	 <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF8qB-0007JR-EX
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 17:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZFLPi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 11:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZFLPi3
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 11:38:29 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:34182 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZFLPi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 11:38:28 -0400
Received: by fxm12 with SMTP id 12so710098fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nz75O+R5GjePDDzUkrQoSCcM61hVxGNrqgXttTBbr3c=;
        b=xBCdRvV4A5nW5xrrjRyGMjgxJamWB9K3qm8nsIPvKFH/I9JC/hwBasGwbWCtQkZ1iH
         GRKujLM8dBPQziUlqywSyG75jE08Gokwa3oKIUUlQVNmAXWFkRP+wHYIL5tVg3Rc/QCI
         2vpkRsTDpeyfDX1uYpXLLrxn36ozn5kUDhFlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iqq7XxsjaY0WE4UuzCbxbLjUT6rbFr1Z0R9Lq0qUnPU0DmhSJ2seMzqc2nECzboAax
         cSKJSfZzn4oEYpf6B3fby8rEiYdSE0RYHZ39WXrYrmowXVWZJ4bSHp0JqdIrs8n8nXiB
         R+AeiZxWVcWGkslcQackQFxE7L2IEFf9sCpWw=
Received: by 10.204.51.210 with SMTP id e18mr3733479bkg.69.1244821109594; Fri, 
	12 Jun 2009 08:38:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121431>

On Fri, Jun 12, 2009 at 11:56 AM, Daniel Stenberg<daniel@haxx.se> wrote:
> On Fri, 12 Jun 2009, Nanako Shiraishi wrote:
>
>> It would be ideal if you can inspect the certificate and decide if you
>> need to ask for decrypting password before using it (and otherwise you don't
>> ask). If you can't do that, probably you can introduce a config var that
>> says "this certificate is encrypted", and bypass your new code if that
>> config var isn't set.
>
> Is this really a common setup? Using an unencrypted private key sounds like
> a really bad security situation to me. The certificate is never encrupted,
> the passphrase is for the key.
>
For SSH using unencrypted private key is very common for scripting and
cron jobs. For HTTPS situation looks like being worse since there is
no analog of ssh-agent that covers at least some of scripting
scenarios. Do we want to disable scripting for HTTPS?

Constantine
