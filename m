From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: dereference tags with --ignore-if-in-upstream
Date: Mon, 01 Jun 2015 15:46:08 -0700
Message-ID: <xmqqwpzn3v4f.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
	<1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
	<xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
	<xmqq6177728a.fsf@gitster.dls.corp.google.com>
	<20150601174712.GA18364@peff.net>
	<xmqq4mmr5fqy.fsf@gitster.dls.corp.google.com>
	<20150601223409.GB140991@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 00:46:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYTI-0002p2-GC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 00:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbbFAWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 18:46:12 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38579 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbbFAWqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 18:46:10 -0400
Received: by igbjd9 with SMTP id jd9so73654366igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 15:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NxqUi2hRGDqBKoywwvRYhxGTFIrRoDAabS1WQ5pSz7c=;
        b=gQlI5easFp3o9AbcxtE9bAY5qKEWHE/jO0/7BW/6n5ZPkqSSNH/uqThAH8QTLN8n3Q
         BFLb03FuFe7+FUBz/fErAgTxaKTlu7W3tW1pNpEB3+MKfKvESeEp02pXQRiAjhigdiev
         ku2plkNH9Kh2gyYBDC+jqrxxXSnLy2JiUaRTNnw2WZcmMma/KjmmCN+gvQmJtWLpOaUu
         6R+Ujb4qTZ7NTd1jqec1vByTYtNGeuDSzxzLAOCVqCsfy6F7qafdyN0qlfwtbtQj4EnS
         gKH4GJz9RKrpe3O1e3hEmPk4eyIdGCMK7I/jV87DY/MBr5UkEefcA9VWqghtGFkbxiZn
         QfMg==
X-Received: by 10.107.137.170 with SMTP id t42mr30197656ioi.16.1433198769926;
        Mon, 01 Jun 2015 15:46:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id j3sm7594677ige.0.2015.06.01.15.46.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 15:46:09 -0700 (PDT)
In-Reply-To: <20150601223409.GB140991@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 1 Jun 2015 22:34:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270477>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> In the longer term, it might be a more correct fix to teach
>> clear_commit_marks() to do the same "committish to commit"
>> dereferncing that is done in the revision traversal machinery, but
>
> "dereferencing".  Otherwise, looks exactly like what I would have
> written in my reroll had you not gotten to it before me.

Heh thanks.

I do not mind if you sent in a replacement.  What I sent was done
primarily because I saw multiple people coming up with essentially
the same solution and I was afraid everybody would say "it is being
taken care of by others" and we end up not having any patch ;-).
