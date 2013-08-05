From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Mon, 5 Aug 2013 21:54:05 +0200
Message-ID: <CALWbr2zzepjoBEcPYGoqPs9ro0fk_wNWYCE2ZGhW-FY4Gz8gWQ@mail.gmail.com>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
	<CAMP44s0Wsnqs_t5kJb0Le13MrzN9WNRTrtNEuXHrDU6D7AKjLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Joern Hees <dev@joernhees.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 21:54:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6QrF-0002h7-ES
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 21:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab3HETyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 15:54:13 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36397 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab3HETyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 15:54:06 -0400
Received: by mail-qc0-f176.google.com with SMTP id u12so1906398qcx.7
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Jisp/9IfpJot8t669AjzSk90ZMCdo18MP1x0id+ZkKY=;
        b=yODKda1ZuY/yOnqJoFe8qDFu2I5iHhT3InPVrDt1VZ1DMHSnjlbFtcCO7DILOaLz1G
         WFUNxWQ673j/BAsCq6WcyfphItERtvc8LDWtrbT8pj4OfhjiaYxShJmUvU2aQ+8TV5lx
         Xudg1eJaokyOKnQHTTuzZGXZaZhwYSow26UNeoKNg2kj05hmFeOZVgLGS3dJGomfcm9s
         Rdj8zfeh7wTvPX+ubXWU/qEOmDnGOzxtq4/Hp0hw2JM5UggzbLMj6x48GCapgRV8hG4K
         JSeU/mn6M+WdRr81OyMqaguXn/edBHEecw39gNgUHd1OATeF1nU3dg+Mj346sYWX3yde
         urKQ==
X-Received: by 10.224.76.71 with SMTP id b7mr21532091qak.48.1375732446035;
 Mon, 05 Aug 2013 12:54:06 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Mon, 5 Aug 2013 12:54:05 -0700 (PDT)
In-Reply-To: <CAMP44s0Wsnqs_t5kJb0Le13MrzN9WNRTrtNEuXHrDU6D7AKjLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231698>

On Mon, Aug 5, 2013 at 9:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Aug 5, 2013 at 2:22 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> From: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> 6796d49 (remote-hg: use a shared repository store) introduced a bug by
>> making the shared repository '.git/hg', which is already used before
>> that patch, so clones that happened before that patch, fail after that
>> patch, because there's no shared Mercurial repo.
>>
>> It's trivial to upgrade to the new organization by copying the Mercurial
>> repo from one of the remotes (e.g. 'origin'), so let's do so.
>
> In addition to that, simplify the shared repo initialization; if the
> repository is shared, the pull on the child will use the parent's
> storage, so there's no need for the initial clone.
>
> And make sure the shared repository is always present.

It comes without saying that you can change this description if you want to :-)

> It seems pretty clear to me that we are talking about multiple patches here.

I'm not sure that's necessary. But I may be missing something.
