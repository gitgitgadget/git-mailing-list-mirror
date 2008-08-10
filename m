From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Sun, 10 Aug 2008 16:12:16 -0700
Message-ID: <a6b6acf60808101612l300227e9od97e767fe4621dc5@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <46a038f90808101606j7534b855j9205ae219c350c94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSK6B-00038u-J4
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYHJXMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYHJXMR
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:12:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:1029 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbYHJXMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:12:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1975064rvb.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 16:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=UW5cNR+bcKwqSnbcmLJzd75rvNry3HMagZ2lj5XODcY=;
        b=mUKvUlQWhAfwQFYWhjQcgxASpokDapyWdrGDhQAJdmjAaeEsY474BPsfJGIziUgSU2
         xHVghgL9BRKW4Qr751REZWyeyvwp1+x5SZHgjc4qw4oLJkapVdyglRLP99RwH7uvvq+0
         SoUTq5ct5a0bWXOWwR/8ms/O63kSYH229sNaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=GnkXAz7jirHFk9Uggbz3QIVpHHMk1lVofzj4+WlWN9l3aAkkDRvhtJUu3EL1GbZRhf
         zCHkE8iVgYY8BEmfIB/OUEAHMYaW0PvKGKcfaOUdBNUURaxwNH/fuyD+jHxPFwO3kjXz
         liiLO4yThYOvFAakiJSnXgw2EcQaMTQkxr7Vw=
Received: by 10.141.19.9 with SMTP id w9mr3039355rvi.202.1218409936455;
        Sun, 10 Aug 2008 16:12:16 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Sun, 10 Aug 2008 16:12:16 -0700 (PDT)
In-Reply-To: <46a038f90808101606j7534b855j9205ae219c350c94@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 08dd58b7b3baacdf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91902>

Thanks for the tips, Martin.

How does git over rsync work? It is unauthenticated, like git over
http? Or authenticated, like git+ssh?

Great ideas though. Unfortunately I don't think I'll be able to use
the repack locally and then upload strategy for this particular
workflow, but the rsync clone approach might do it.

-Ken

On Sun, Aug 10, 2008 at 4:06 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> On Mon, Aug 11, 2008 at 7:47 AM, Ken Pratt <ken@kenpratt.net> wrote:
>> A "git repack -a -d" only takes 5 seconds to run on the same
>> repository on my laptop (a non-bare copy), and seems to peak at ~160MB
>> of RAM usage.
>
> As a workaround, if you repack on your laptop and rsync the pack+index
> to the server, it will work. This can be used to serve huge projects
> out of lightweight-ish servers. Yet another workaround is to perform
> initial clones via rsync or http.
>
> In your case, I agree that the repo doesn't seem large enough (or to
> have large enough objects) to warrant having this problem. But that I
> can't help much with myself - pack-machiner experts probably can.
>
> cheers,
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
Ken Pratt
http://kenpratt.net/
