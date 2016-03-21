From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 21:12:18 +0000
Message-ID: <CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
 <20160321202810.GD32071@sigill.intra.peff.net> <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
 <20160321205043.GA436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 22:14:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai7A1-0002cb-Cd
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 22:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbcCUVMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 17:12:41 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36073 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933518AbcCUVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 17:12:34 -0400
Received: by mail-wm0-f54.google.com with SMTP id r129so67366194wmr.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UFDgbdUqifymi9+3uyw1/4ncBlnjaAQbxC5wz9v0Ies=;
        b=Da/FnaMT7u1KFW6G0+rqNutKFkc6QaQ7Dj5E57nMlhnFnNyrBRs8U9eXzuw+YvUtKP
         Sei8ib6p++2RSqFhqzFIbMzrUSHThZYCYvyLfzSa/PdaJAqsuaKRBx59qiGmBx+1vjUq
         bQk4PN7U/TrfynVum8C5xUg7hP9Cb+urq18hRspCftUmipCNXJ39IiamtYPmIWpxfBxs
         u+elUuaLp+yeSbdDGV5lgSEbj8049bxM3l2I6QNoB++0pc2ML3mcdTx2yMcNgxxtkpGC
         Lov/pv9zMTJwSC9+e6akkA5HLjKCbdiha5LkopZvmUW7/jGhDG3XhmqATa4XBUMQbPbL
         PsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UFDgbdUqifymi9+3uyw1/4ncBlnjaAQbxC5wz9v0Ies=;
        b=Wsb5t5M7Vwv77bjpE6sl65tROi0IEf0OlizE4Z4/ISPCeHsXaa8I2AFxMp0mARnMEk
         b85Cp7B9DFJ81QM6sLDGYSRMfvsiOrv6piv1tV9exW3vNj605iL9sPiVA8vkmmXYPxJT
         DZN0C4PXxIVAkwKkdmqIU73UHJwZRYkDkR0sfD3hml6F5z2tYBO5dcg1eokgNor7+IbW
         2bniQLL3C3DPo7dT1fPuWgyU7Ew/qoJiyBApsOOPQ/ThE4R9KG9cdxOeEUmsJjNtLhGL
         8tieHGag1yrn0d/NQESrgjuxHzNQL7fDH5Cd+BldQpr8TXJrSbUr18eIIxGFV8W5cMhm
         yvgw==
X-Gm-Message-State: AD7BkJJg6AIwWu9WQAtiCK8YC3VJuRWdCjdWa39T71cG6yqW5ciMgn+4Bb82duiWrcC5NlFb2uv6CWt/ltQkuw==
X-Received: by 10.28.6.139 with SMTP id 133mr16602554wmg.84.1458594752673;
 Mon, 21 Mar 2016 14:12:32 -0700 (PDT)
Received: by 10.194.110.168 with HTTP; Mon, 21 Mar 2016 14:12:18 -0700 (PDT)
In-Reply-To: <20160321205043.GA436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289462>

On 21 March 2016 at 20:50, Jeff King <peff@peff.net> wrote:
> But that's just my opinion. Did you have some specific change you're
> interested in? I don't think removing that message is productive; it
> _is_ useful information. Perhaps it could be more clear that we are
> talking about the tracking branch?

I don't have a specific change in mind per-se, rather than to discuss
how we might be able to improve the error message, or document
somewhere that it's referring to the tracking branch.  Maybe that's
the point--is it worth mentioning the time/date of when the cache was
last updated?  That is:

"branch-X is uptodate with origin/branch-X (as of DD-MM-YY HH:MM:SS)"

No one's suggesting that this message is removed, I'm not sure where
you got that from?

-- Thomas Adam
