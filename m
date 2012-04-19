From: Junio C Hamano <jch@google.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Thu, 19 Apr 2012 11:49:30 -0700
Message-ID: <xmqqy5prv9ol.fsf@junio.mtv.corp.google.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
	<CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
	<7vsjg1knwr.fsf@alter.siamese.dyndns.org>
	<CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
	<7v8vhsltk3.fsf@alter.siamese.dyndns.org>
	<CAFouetg6T1pgAiTfyAeSxseR-k_omsZDfqv8X8AifekwPLoE2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 20:49:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKwQE-0005KC-3i
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 20:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab2DSSte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 14:49:34 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:50163 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab2DSStd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 14:49:33 -0400
Received: by eaaq10 with SMTP id q10so426415eaa.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=dzpbUZCrrjaATRzPQ2Lxy20CuNtg9VbF88DxxhAUgIA=;
        b=Ey2ckpEjK6X9OzxE8nEj5OsLDnznTNeB1xLs6YBmLbmjsXZaRWcABE6oCcRH8XddfU
         n7tDRKEC0JF9dha8/ZSF0go4ZFf8RJKvxPwr1Z32BZOO9PiPEx9j07ru8SKzrJLcFFuj
         DzABv074KFpxzlT2ZzUFdDN/krdaPPSPpRj8NcvCvVZrQs08MCo7XBOL1DoutLlahA/n
         11JTTrMg3d9uXE2+7I6g96nver57mBLCa/YSe8w9TxXZOVwFN5ZKvcKEClZyEIbO1Q/w
         TGrzOoajnizSmUzbFtXwVv9JFkNU2mWJI13nTuX4Baa8ZF/ExG6bS62I1UQOXEN/VH/o
         8T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=dzpbUZCrrjaATRzPQ2Lxy20CuNtg9VbF88DxxhAUgIA=;
        b=VzzPFKcg83bEUf2rzJFSlI6S1jJm8zjhaAo+4v0BPe0oEozu8gEqmmcPM2ivckfVok
         +VegLP5X9CBq3RSMO5qoHc/UzKr+9CEv6BIopthaW8X+gisXtSfubIz9dZ9sa8/iq6l3
         /akOwMRclPct1FL5lqm9yLTHaz3NfqtNc+lqZK4RdoZ3Xqnnlnznnj+o5NgqRLOWksBf
         LMd8JwII0GpwCQhdGvX1EANBe7nNq8zNr4Mw/5ApeqMG4B9p9AyVNsv+QigmPLrJ2kP1
         43PVMD5QqEi2hwG/Ue5DcgHRD8s7b5BAr8agOCYkTMQtu/OH29fglZiNwhkdup8rHHXX
         OQIQ==
Received: by 10.213.22.197 with SMTP id o5mr300244ebb.8.1334861371957;
        Thu, 19 Apr 2012 11:49:31 -0700 (PDT)
Received: by 10.213.22.197 with SMTP id o5mr300232ebb.8.1334861371816;
        Thu, 19 Apr 2012 11:49:31 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si2897352een.0.2012.04.19.11.49.31
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 11:49:31 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 9C5A820004E;
	Thu, 19 Apr 2012 11:49:31 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id E7DD9E1209; Thu, 19 Apr 2012 11:49:30 -0700 (PDT)
In-Reply-To: <CAFouetg6T1pgAiTfyAeSxseR-k_omsZDfqv8X8AifekwPLoE2g@mail.gmail.com>
	(Tim Henigan's message of "Thu, 19 Apr 2012 13:11:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmWpCyQxuPXLA8RFQoO0L34zmhIg+tKL2DNiNsTtuGYrYj7ZD6rEGu8RbCxzmkftHiHOrZ3bt7kkubUCzhme57kQYMntMAh3Xu/I+gFlkNRhlvxuzLcFZdIYFMUDsQgdOcGnifj6xsBcWYXAX2fSJbGUWzD7n5UukQ556aHFtjz5KfsT5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195962>

Tim Henigan <tim.henigan@gmail.com> writes:

> I have a revised patch that prunes out all of the above and warns the
> user when it does so [1].

Thanks.

As long as it works when the user uses "two temporary trees" mode
without -M/-C, and it keeps working as well as before the change when
the user uses "one invocation per matched path" mode with -M/-C, I do
not care too deeply about how it is implemented in the script.

> However, it also prunes them when difftool is called in serial diff
> mode (i.e. non --dir-diff).

I do not use difftool myself, but I would imagine that it is a grave
regression, no?
