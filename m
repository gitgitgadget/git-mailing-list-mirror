From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 09:55:40 +0100
Message-ID: <CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
	<7vy5hmgovt.fsf@alter.siamese.dyndns.org>
	<CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 09:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TddR2-0000tE-Ra
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 09:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab2K1Izn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 03:55:43 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52366 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346Ab2K1Izm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 03:55:42 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5543761bkw.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 00:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9Ezv3TM3wfgOrJkHFOQ+EEwWqsuBV2XFm2tEynXBvBY=;
        b=F5pDb2j6dyas2k/p5UhW8eJdX6MqZCKfH4CdvAYjFnyQlw45XRNzDpK7i+EiJSgt+s
         z7RlF7vgQsAUHwx6bQDqAFqVoiXt6RXPHcqk3E6OOx/SA12cqukG+wwQ89jnqpzXnVdf
         R3BXshUz4NupAWmWpc3Q+fG9Ej5wolaVN04vjG/IpWweODF1D3JAraeeykBfhapPDa24
         AC5YBIz4pc1hQaYM6ZBy4waEGwhQHx8wBIjMb90DQ9ToCB9131rAaPusbZCw3yfo+DmM
         0T1ZdUHhtTa9D7ABRRRRwImyFEzT5vaTlmucBLNn2sNIm478s4t6s0ZX3mVuyM89YW5w
         tRvA==
Received: by 10.204.147.67 with SMTP id k3mr5276431bkv.117.1354092941003; Wed,
 28 Nov 2012 00:55:41 -0800 (PST)
Received: by 10.204.129.70 with HTTP; Wed, 28 Nov 2012 00:55:40 -0800 (PST)
In-Reply-To: <CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210722>

On Wed, Nov 28, 2012 at 9:03 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Nov 28, 2012 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> All the python scripts except contrib/svn-fe/svnrdump_sim.py
>>> start with "#!/usr/bin/env python".
>>>
>>> This patch fix contrib/svn-fe/svnrdump_sim.py to do the same.
>>
>> I suspect you need a bit more than that.
>>
>>     $ make git-p4
>>     $ diff -u git-p4.py git-p4
>>
>> shows you how we tell the scripts how to find their interpreters
>> (that way, there is no need to rely on the existence of
>> /usr/bin/env).
>
> That works if somebody managed to export PYTHON_PATH, which very very
> often is not the case for me.

Yeah, and even if PYTHON_PATH is used, in t9020-remote-svn.sh,
svnrdump.py is used as is.
So if your python is not /usr/bin/python, you cannot just add
something to $PATH to pass the test.

Best regards,
Christian.
