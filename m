From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Re-Transmission of blobs?
Date: Fri, 13 Sep 2013 19:16:08 +0700
Message-ID: <CACsJy8AdG=fY-utKdrsnJg-vnpdPqazLzqWO-bsikw3XLXGUgg@mail.gmail.com>
References: <20130910130837.GA14259@raven.wolf.lan> <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan> <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan> <20130912092339.GA30702@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D132085571A7A1B@umechphj.easf.csd.disa.mil>
 <20130912195654.GE32069@sigill.intra.peff.net> <871B6C10EBEFE342A772D1159D132085571A7E5C@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Josef Wolf <jw@raven.inka.de>, Jeff King <peff@peff.net>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Fri Sep 13 14:16:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKSIo-0007GV-CE
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 14:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab3IMMQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 08:16:42 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64214 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755584Ab3IMMQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 08:16:42 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so1033498oag.26
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uSrUAcpTMUBQcW2+9ps53q6FypFRoLGmnFjzEVzvbDE=;
        b=W70ZIoc0s+R6cKaEWot4deDoNwF+eRYPgQAF/u9Vf9OI1AX2fYdU6NdH2Y4TKYZenn
         xoO6VinMNQFss/6QeXGNvRfDjSHCizl06qoRrKU1vBLGGlFwJ5I53qFHfu5KDhI1DdzT
         YReurhXZASmnjwXUzSfHmS0EgTjdekU0XNOxRgaQq+iJ/BKn9oLthJKU2oP5Ql1JjL9r
         vkDp+g1k8+tCkYnfmKBsh41xF3rPdHqX9mh3JrYrfqFDiNKvPM8Is4z7SmhP/Ak/2jdk
         TIpXAuabS0qOvSf/K2A9mOWezTsPG55QkySfYI57aLYCcI1F/Jtnwyh/QvkL+JZURk4o
         G7VA==
X-Received: by 10.182.237.14 with SMTP id uy14mr24045obc.102.1379074598363;
 Fri, 13 Sep 2013 05:16:38 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 13 Sep 2013 05:16:08 -0700 (PDT)
In-Reply-To: <871B6C10EBEFE342A772D1159D132085571A7E5C@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234748>

On Fri, Sep 13, 2013 at 3:06 AM, Pyeron, Jason J CTR (US)
<jason.j.pyeron.ctr@mail.mil> wrote:
> But, again if the connection drops, we have already lost the delta advantage. I would think the scenario would go like this:
>
> git clone url://blah/blah
> [fail]
> cd blah
> git clone --resume #uses normal methods....
> [fail]
> while ! git clone --resume --HitItWithAStick
>
> replace clone with fetch for that use case too

Sorry if I missed something in this thread. But I think we could
stablize the transferred pack so that --resume works. The sender
constructs exactly the same pack as in the first "git clone" then it
starts sending from the offset given by the client. For that to work,
the first "git clone" must also be "git clone --resume". I started
working on that but now my focus is pack v4, so that has to wait.
-- 
Duy
