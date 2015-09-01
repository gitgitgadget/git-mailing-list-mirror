From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/3] submodule: implement `clone` as a builtin helper
Date: Tue, 01 Sep 2015 12:13:23 -0700
Message-ID: <xmqqy4gqq7fw.fsf@gitster.mtv.corp.google.com>
References: <1441131869-29474-1-git-send-email-sbeller@google.com>
	<1441131869-29474-4-git-send-email-sbeller@google.com>
	<CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 21:13:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWqzq-0004tP-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 21:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbbIATN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 15:13:26 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34445 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbbIATNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 15:13:25 -0400
Received: by padhy1 with SMTP id hy1so4888146pad.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WqUr2PXyPqyKpAVN+thEAri+/VP4Z0yRhwq9prZUmJ0=;
        b=Fc3Wh626YXKSDxKI6n1gQwBixB8IejFMTQc+heX3b2n8sj00jNKmM9TrqFKawdUrpm
         bXIjmltSHuQhy9wY6L3TWbJ1VRK91956slsNCeWok9IkZXUaHGvix8qr1Q4v4aJEIJFz
         lBSwH5HJjCPoQAQSZDGfME6FH/Rri70m352OqrBXojPwtbk3f1W923ZjYO4ZiavpKsJn
         ORNnAgmmnyaVQfsc+lFx1xbApuc3lgI4YlSSewqPTMp2uK/jRAxr5nFvN649HrZR/TAP
         BUlLQHk2nnrH4Mh64nIo3oDq18MR/FND8P303leZOQick/KID4wx7t3cVHSCdDTxu/cS
         rCbg==
X-Received: by 10.68.93.133 with SMTP id cu5mr49548731pbb.71.1441134805242;
        Tue, 01 Sep 2015 12:13:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id fz8sm9822768pdb.0.2015.09.01.12.13.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 12:13:24 -0700 (PDT)
In-Reply-To: <CAPig+cRxQdquKZXdmpiZjj8JFB2wdCE4UcbW6qYUwvtZsVw=ug@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 1 Sep 2015 14:52:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277033>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 1, 2015 at 2:24 PM, Stefan Beller <sbeller@google.com> wrote:
>> This converts implements the helper `module_clone`. This functionality is
>
> Mentioned previously[1]: "converts implements"?
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/276966

Stefan, perhaps another round of proofreading before sending would
have helped.

I am neutral with asterisk around const myself.  I think I saw this
often spelled with SP on both sides, i.e.

	$ git grep ' \* const ' \*.c | wc -l
        121
        $ git grep ' \*const ' \*.c | wc -l
        45

Majority of the latter, when viewed without pipe to wc, tells me
they are mostly borrowed code.

All the other comments from you on this patch makes sense to me.

Thanks.
