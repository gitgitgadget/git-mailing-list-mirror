From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 20:47:54 +0600
Message-ID: <CAErtv25uWbsH15yohh+6Jun3eD51dZzvj7udoBf14_EwXzSUPg@mail.gmail.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
	<vpqwqiqpe80.fsf@anie.imag.fr>
	<CAErtv25URyB3znN1CMd87374NUjaSFvg=cee_-c=s8bB2j052A@mail.gmail.com>
	<20131227183958.b8e55d7e3c8c38b46137ea9c@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git List <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYhk-00039V-0M
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab3L0Or4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:47:56 -0500
Received: from mail-vb0-f49.google.com ([209.85.212.49]:33233 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab3L0Orz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:47:55 -0500
Received: by mail-vb0-f49.google.com with SMTP id x11so4667252vbb.22
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FhYJM4bCr0j15y6Ljdu8ZvpdCzdQn/bo9pyNYTfS99g=;
        b=bP+o0pogF+KHHntCIcE5vZOgfQiBoNNHvs5khcAW6HMkW0Qc9o4tfdGw5PjKrQ12Zv
         4Xa9U/7ixYIrCjvFt7Ak7dvE+yKWBwQov+wQ27sXsL9E6+ecF39e8YwSWHdM/PfezFCt
         ZvgwL8y5aZlR04KvheURL8f1IVp51g/Rz7DeYcp/yWrjGKaECTJ2GztKxZsBXylWv3w9
         RxY7u8rAazO7ndioJtKFW+ua2eQlDLNrQ3nrECGGCkyzEXgbQuGvqcK0k/tZgVm9I+a8
         KJbuOgd/bDMAHfCaq27npIrRqP1puTjBYQCe3T4H9RGcyQ7LyS9daXWv4tp27vpq3cbK
         2VHw==
X-Received: by 10.58.67.9 with SMTP id j9mr26695315vet.3.1388155674583; Fri,
 27 Dec 2013 06:47:54 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 27 Dec 2013 06:47:54 -0800 (PST)
In-Reply-To: <20131227183958.b8e55d7e3c8c38b46137ea9c@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239740>

>> As for "smart" http, this seems pretty much cool.However, we're
>> currently using lighthttpd, so it might be an issue. We'll check on
>> whether "smart" http is used there, and if not guess it wouldn't be a
>> big deal to switch to apache.
>
> The web server software has nothing to do with HTTP[S] used by Git being
> "smart", I think, it just has to be set up properly.

Misunderstood git doc then which says "it has to be Apache, currently
- other CGI servers don't work, last I checked".

> As discussed in an earlier thread here, a good indication of the
> dumb version of the protocol being in use is no display of the
> fetching progress on the client while doing `git clone` because this
> information (like "compressing objects ..." etc) is sent by the
> server-side Git process which is only there if HTTP[S] "was smart".
> Otherwise the client just GETs packs of objects, traverses them, GETs
> more and so on, so batches of HTTP GET requests correlating to clone
> sessions in the web server logs should also be indicative of the
> problem.

Just to verify, if i see messages like "Receiving objects:   1%
(7289/705777), 1.72 MiB | 340.00 KiB/s" it means server is "smart" ?



-- 
With best regards, Sergey Sharybin
