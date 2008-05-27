From: "=?ISO-8859-1?Q?Barra_Mac_Math=FAna?=" <barrymac@gmail.com>
Subject: Re: cvsimport in cron
Date: Tue, 27 May 2008 10:45:03 +0000
Message-ID: <ce7555260805270345x353cfc76ja3f7ec83a0ab5c61@mail.gmail.com>
References: <17476529.post@talk.nabble.com>
	 <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 12:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0wgq-00016q-4K
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 12:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbYE0KpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 06:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756427AbYE0KpH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 06:45:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:52941 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbYE0KpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 06:45:06 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1897354wxd.4
        for <git@vger.kernel.org>; Tue, 27 May 2008 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LaUzmIsVbai3XriMBrWMaY/2FemvjgUvn4VkZHkj5Sg=;
        b=ngwVKZ4QR8L15rjbV8FtD77lDk05SRI2PjDBR85G1AfS8yPIxUFZnhB4XADkFq+6CPbVpznOc4vW5egg2zDkhaZfNPenhS0dv1CtaBoj/8avOPUeaLNCzVZWtt67OYTwtYRvV7hN7qEsxHvhtlVV3gBxX22IW0wJC8QKo3QWyYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eAcFE9jBJfLuwS9XO5TmpoKeDWHWdoWWTalStodllX71SAgzHSd8Ldw5eyU52MCTdtHBTidfbMMYefVmxM7uQu4ACI8HtlbPdPn/gxPNEM9DFONjptnex7hqQBitFfAYiegxap9DnfJBAde2emwH1vD5RqUlQvJYpAxaiienHwY=
Received: by 10.70.44.20 with SMTP id r20mr1430222wxr.83.1211885103089;
        Tue, 27 May 2008 03:45:03 -0700 (PDT)
Received: by 10.70.51.9 with HTTP; Tue, 27 May 2008 03:45:03 -0700 (PDT)
In-Reply-To: <46a038f90805261613v4ad72ddcxe6ee78fa0b54f89e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83001>

Thanks Martin,

Nice to know how to log the progress! Good tip to try normal cvs over
ssh, which works fine.

I wish it was possible to get more verbose output from the git
cvsimport command. The connection refused error seems to me to be
misleading. I would expect at least some output from cvsps but it
doesn't even get to the first step.

So if everything works at the command line, what significant things
can be different in a cron job?

I also downgraded to the stable version according to gentoo, so I'm on
using 1.5.3.7 now, same result. Unfortunately I might have to give up
soon and ask developers to update their own repositories, as it's
burning up time.

Will post of course if I find the solution.

Thanks,
Barry.


On Tue, May 27, 2008 at 12:13 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Tue, May 27, 2008 at 6:00 AM, barrymac <barrymac@gmail.com> wrote:
>> Apologies if this is a standard mistake, I'm not very experienced with cron.
>> I'm trying to run cvsimport commands from within a cron job but it always
>> returns:
>
> I've done this plenty, so it's known to work. Not sure why it's
> failing in your case.
>
>> I use ssh keys and have tested that they work  by using scp within the
>> script. The script goes as follows:
>
> That's a good start. Have you tried a cvs-over-ssh cvs operation from cron?
>
>> It would also be nice if someone could tell me also how to log the output.
>
> Just wrap the commandline in
>
>  ( $cmd 2>&1) > /tmp/cvsimport.log
>
> HTH, and tell us what the problem was - so the next one to bump into
> it find the answer in the list ;-)
>
> cheers,
>
>
>
> m
> --
>  martin.langhoff@gmail.com
>  martin@laptop.org -- School Server Architect
>  - ask interesting questions
>  - don't get distracted with shiny stuff - working code first
>  - http://wiki.laptop.org/go/User:Martinlanghoff
>



-- 
I must Create a System, or be enslaved by another Man's
Wm. Blake 1757 - 1827
