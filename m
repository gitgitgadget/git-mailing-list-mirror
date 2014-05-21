From: Mitchel Humpherys <mitch.special@gmail.com>
Subject: Re: Why is --graph --max-count=n so much slower than --graph HEAD~n..?
Date: Tue, 20 May 2014 17:13:34 -0700
Message-ID: <vnkw4n0kat01.fsf@mitchelh-linux.qualcomm.com>
References: <vnkwd2f8ayea.fsf@mitchelh-linux.qualcomm.com>
	<xmqq61l0rrng.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jonas@bernoul.li
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 02:13:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmuA5-0007bJ-2I
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbaEUANa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:13:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:57801 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaEUAN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:13:29 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so812224pad.11
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oNbEecS8mgrkxaRstZ7qNQQhN7qA3x0Ef3PKmd3MAmk=;
        b=wLUYM0htTowEDHVJ+KhH2JSCOKHNxFNr2msPsWdV0DQ25AfFzVF0hPHuo+i5SNg4xB
         JTC2wVBuP4DGwOWeKjY9qZ7y36L6kKXQjlFLHO4A4g9Z3VkMJ6/tpfolQ2cZYzTnQQUf
         JvTiMBVW7BkRVWWVwSQ8LbHETMNarxwJ1hUWKkw2innhvgmc4uaWP88KMiZWEoT0oPFl
         l3eMuic8pKgjBgbUi2FbE0imt7ArePKbJdpE2856IPrWKUMHoHBG9T4ugy8rMJVOAGeg
         4z3MwtidgY7eBzokhVle8e8CTv6VuhcROUCKKjOE1QKN8najgUxNYJ8jeOYgBcQY+MT4
         NnZQ==
X-Received: by 10.67.13.134 with SMTP id ey6mr54292906pad.44.1400631208985;
        Tue, 20 May 2014 17:13:28 -0700 (PDT)
Received: from mitchelh-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by mx.google.com with ESMTPSA id av2sm5059314pbc.16.2014.05.20.17.13.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 17:13:28 -0700 (PDT)
In-Reply-To: <xmqq61l0rrng.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 20 May 2014 15:50:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249762>

On Tue, May 20 2014 at 03:50:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Mitchel Humpherys <mitch.special@gmail.com> writes:
>
>> I've noticed that --max-count doesn't seem to speed up `git log --graph'
>> computation time.
>
> AFAIK, --graph wants to compute the whole history and the max-count
> only affects the output phase after --graph does its computation.
>
> Besides, "log --max-count=n" and "log HEAD~n.." compute completely
> different things, so the comparison is apples and oranges.

Yes, apples and oranges in a black box :). I provided the
HEAD~n.. measurements just to show that we can get (almost) the exact
same output another way and it's much faster. It just "seems like"
--max-count=n should speed things up as n decreases...


-- 
Mitch
