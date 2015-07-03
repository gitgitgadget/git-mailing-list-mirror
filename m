From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Fri, 03 Jul 2015 10:31:20 -0700
Message-ID: <xmqqfv555es7.fsf@gitster.dls.corp.google.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
	<CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
	<19801032cd7af95bc8030f54d740bf48@www.dscho.org>
	<20150630122323.GY18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Lawrence Siebert <lawrencesiebert@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jul 03 19:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB4oD-0003uj-KX
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 19:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbbGCRbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 13:31:25 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37316 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbbGCRbX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 13:31:23 -0400
Received: by igblr2 with SMTP id lr2so80873888igb.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pqL2jwd8bUUHWy4KoHN7IuhB7+Y2uN77RRV0nibiJcQ=;
        b=g5t63XETB6JM3ya4MuVLPhZYmJRictcLo34xhwtzMXak/xrznc9gFB2n6jI3hcKGci
         SKxoRbogB/OiHuMlUeS+GK9hGeFh2oEwSukAekLni2Nc1c9dt1Xx1xJLJCFSyXYYlDBt
         s9XBhD4DXEeNW1af3Y5tlt4SAqLTl4sBhACoau0esGHlC6rzIiJBve6QUUpOshXr0719
         Uh+y1xRUnjmI4BgFa9UTwe0tfLtMO+X8oAvBPc8SVWMKKyMhHY8KL2euhtN1AncQvrna
         vTYYylrB4rZknPnfY0T+/QAPBz/PxWqSiBmO7tine/ilO0RZ2ZXXyFIjJT8xy6W99HhT
         ueCA==
X-Received: by 10.50.114.5 with SMTP id jc5mr23695100igb.43.1435944683244;
        Fri, 03 Jul 2015 10:31:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:846f:c5d0:52c9:d18a])
        by mx.google.com with ESMTPSA id p8sm3845027iga.13.2015.07.03.10.31.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 Jul 2015 10:31:21 -0700 (PDT)
In-Reply-To: <20150630122323.GY18226@serenity.lan> (John Keeping's message of
	"Tue, 30 Jun 2015 13:23:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273298>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jun 30, 2015 at 02:10:49PM +0200, Johannes Schindelin wrote:
>> On 2015-06-29 18:46, Lawrence Siebert wrote:
>> 
>> > I appreciate your help. Okay, That all makes sense.
>> > 
>> > I would note that something like:
>> >  git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc
>> > 
>> > seems like it run much faster then:
>> > 
>> >  git log --oneline "$FILENAME" | wc -l
>> 
>> How does it compare to `git rev-list -- "$FILENAME" | wc -l`?
>
> Or even `git rev-list --count HEAD -- "$FILENAME"`.

Ahh, OK.  I didn't know we already had "rev-list --count".

Then please disregard the suggestion to add the option to "log"; it
still holds true that the option does not belong to "shortlog", but
I do think "how many changes were made to this path" statistics
driven by a script should use "rev-list" plumbing, and if it already
has "--count" option, that is perfect ;-)

Thanks.
