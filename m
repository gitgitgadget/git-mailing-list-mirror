From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 15:53:51 -0700
Message-ID: <xmqqvbekbpc0.fsf@gitster.dls.corp.google.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
	<xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
	<CAE5ih79KhNXqvSNW-w8pMmiys2Dv24Rt4KFdRdoA9EuPDS3ELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:54:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5ih4-00045y-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbbFRWxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:53:55 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36222 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbFRWxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:53:53 -0400
Received: by igbiq7 with SMTP id iq7so2397459igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nmTqOcG6NnPIHvR/VIQk+9dePfHyF75an/9oBJODSAU=;
        b=ZMzFi1LWH+K6Ms7+D66ZAuHy6uPIcU7ViyN+w0A9sluNBxixSuBAV/qldoBrV9VXyj
         pHthCkDSeXgQ0PY1tFXwTlNc5fkS0iVGSKcfvP6ru4mc3VLLFGSQQph+k0Ibuq6BcQyn
         +davXpA5QWVF1YhbIc4vHYBmjfImsfRG0FudUl66AIZ5mvcMQAg1FZ/hfSwGSf7H2BPK
         VE+PSXOqC+z3j+UhAB8BQuieVqtqivw023bsRIo1vcK6QAIeCFSd8e8G+3uZVKAnYuEK
         7ycKEp3mGac7bbyC0SnkZ3XxdQoEOe/u2aGAEMfW8Z40m026SDpIIorqD7UOkUW5n4fg
         H0qg==
X-Received: by 10.107.168.72 with SMTP id r69mr6505089ioe.4.1434668033205;
        Thu, 18 Jun 2015 15:53:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id a139sm5852957ioa.14.2015.06.18.15.53.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 15:53:52 -0700 (PDT)
In-Reply-To: <CAE5ih79KhNXqvSNW-w8pMmiys2Dv24Rt4KFdRdoA9EuPDS3ELw@mail.gmail.com>
	(Luke Diamand's message of "Thu, 18 Jun 2015 23:47:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272092>

Luke Diamand <luke@diamand.org> writes:

>>> $ git checkout upstream/master -- subtree
>>> $ git diff upstream/master -- subtree
>>> -- still lots of deltas
>>
>> Does this show _ONLY_ additions?  Or does it include modifications
>> and removals?
>
> There are indeed _ONLY_ additions.

http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234912
http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234924

In short, it is an intended behaviour, both Peff and I consider that
the intention is bad and the behaviour should be changed.

But nothing has happened yet (it is listed as one of the "leftover
bits" http://git-blame.blogspot.com/p/leftover-bits.html).
