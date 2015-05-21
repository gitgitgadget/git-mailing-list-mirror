From: Junio C Hamano <gitster@pobox.com>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Thu, 21 May 2015 09:45:21 -0700
Message-ID: <xmqq1ti9lw0u.fsf@gitster.dls.corp.google.com>
References: <20150519132958.GA21130@frolo.macqel>
	<20150519233925.GA22748@peff.net> <20150520131359.GA7043@frolo.macqel>
	<20150520132534.GI10518@serenity.lan>
	<20150520141238.GA13990@frolo.macqel>
	<20150520161815.GA12521@peff.net> <20150521070523.GA8026@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Thu May 21 18:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTbA-000814-Nh
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbbEUQp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:45:27 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34774 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757017AbbEUQpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:45:24 -0400
Received: by ieczm2 with SMTP id zm2so12673499iec.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5PwltEf9aqNTDgzmla1Gq79Yzc2+LYj+69g7RBxSFxM=;
        b=W60ejLtGUsSrytiujF0Sbb3ZVw1nmEKv7eDOwstBThLf0DBZh1SpbrarVHuRltXXRL
         Ip2m/N9D9T4jgRzKLQgxuWjD94Gej1XUrqcB58nYuDbmJjZn9zAKL3Egai1jv5js83Jl
         YCJPr3uVntaMKkUY1T9ywCOGJ9Y5KNNrtTScKesztFd2dKoSmU2IG9LngU1Pgp7qQzb9
         DYfMavSMYGbkGWbBSNZlSCvVTOjhvXKwhYCDzrs0mpQvnX7UPDsCiU5K9Y1TGgbapxgp
         uN/p82SONQi36k8ompVjixZ0MAYEHTZOGKeHmj62jNtC7TmR6hiqqaAC6v5h/weg+0F+
         yYxw==
X-Received: by 10.42.88.197 with SMTP id d5mr4369949icm.44.1432226723665;
        Thu, 21 May 2015 09:45:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id x12sm12630045ioi.41.2015.05.21.09.45.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 09:45:22 -0700 (PDT)
In-Reply-To: <20150521070523.GA8026@frolo.macqel> (Philippe De Muyter's
	message of "Thu, 21 May 2015 09:05:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269608>

Philippe De Muyter <phdm@macq.eu> writes:

> So we trade correctness for speed :(

No corretness is traded with anything else here.

There are applications where topology matters and where it doesn't.
When topology really matters (e.g. drawing the graph), the caller
can choose to use --topo-order to have git do the work.  Of course
the caller could accept output without --topo-order in streaming
fashion and stitch the parent-child relationship itself.

And of course, in applications where topology does not matter, you
do not have to wait.

That is called "choice", not "trading".
