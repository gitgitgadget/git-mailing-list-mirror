From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 11:06:16 +1200
Message-ID: <46a038f90808101606j7534b855j9205ae219c350c94@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ken Pratt" <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSK0V-0001cG-UE
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 01:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYHJXGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 19:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYHJXGS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 19:06:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:48048 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYHJXGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 19:06:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3491407wfd.4
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ztLRcaWLwj8hHpLL20k6IkeGnW7OmOkO6A1Y0kISJ9g=;
        b=bMIXJtO//Y5q43ePG4RF7lH589luq9KQsMGSsONx5SLZI8vkbexjKJYbJV0f+yTB9N
         dMcrvWBnFbAaib9xnU49+KQ6ofA42q/S6Qm+yyKeA7DNYolPTZmrv0miw2LUpu2Kbl3S
         UTfQXKZTw+iHfqgeTUSpgAUlWY2MGYpJyKycQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=e2D00p0EMQ5nc34ILOAjor8ygCLwNjUHwuzayRZ9N3JC1roGvSdSQCmqcc2yI/naf5
         rbR1+NFom36pt5TRbLLEIoNS27rtkeqgtiGXQSInnMpeLaAJo5iJScEd05XQZmeekeON
         xBglzVOKTjBoLd3aXBRPADCcZJonuMqsdLlZE=
Received: by 10.142.72.21 with SMTP id u21mr1861779wfa.161.1218409576950;
        Sun, 10 Aug 2008 16:06:16 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Sun, 10 Aug 2008 16:06:16 -0700 (PDT)
In-Reply-To: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91898>

On Mon, Aug 11, 2008 at 7:47 AM, Ken Pratt <ken@kenpratt.net> wrote:
> A "git repack -a -d" only takes 5 seconds to run on the same
> repository on my laptop (a non-bare copy), and seems to peak at ~160MB
> of RAM usage.

As a workaround, if you repack on your laptop and rsync the pack+index
to the server, it will work. This can be used to serve huge projects
out of lightweight-ish servers. Yet another workaround is to perform
initial clones via rsync or http.

In your case, I agree that the repo doesn't seem large enough (or to
have large enough objects) to warrant having this problem. But that I
can't help much with myself - pack-machiner experts probably can.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
