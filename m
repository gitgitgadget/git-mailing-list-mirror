From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 28 Oct 2013 11:59:47 -0500
Message-ID: <87fvrljpq4.fsf@gmail.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Milton Soares Filho <milton.soares.filho@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 18:00:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaqBI-0007B6-0M
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 18:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab3J1Q74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 12:59:56 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:33959 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756908Ab3J1Q7y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 12:59:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id m1so3885116oag.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i8KNiwnTI4v7e2HznG0Iio6VskZNy/fyZwJjIomBxC0=;
        b=BT3f1PPf8ju+fdV4bW1pzu21MO8aSE8pjgF5tcteL3lyKY5whKnQLjFG28W/6oR/sv
         IfAYeq3L8LHcCjs5u2YAcq6L+kZ/G5Dp37KZIL0K457CdSqzHHB7E1DaxzfPr5hwl+Iq
         Ozv+q75UsmzYC9ZldSy6xyfbWpIWiGbIPDFJpSVpS32i/RwNlXajtz6byaD9dHYhGilO
         2yZEF+gEp9Nb1BpPXsF/PPkEv0MQd2q0ZzqxdzEoN7hFd4oCY37Xl6TtVgGUf0hiwm1Z
         mPOG4sXL+KpwXKuZus9u34W20gDEo5Vh6GAxKDx1U8rVpHP5Qf0j59ca9W8pK5jqUBNO
         QTkw==
X-Received: by 10.182.104.36 with SMTP id gb4mr15751941obb.43.1382979594133;
        Mon, 28 Oct 2013 09:59:54 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id d8sm34579209oeu.6.2013.10.28.09.59.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2013 09:59:52 -0700 (PDT)
In-Reply-To: <xmqqeh75h087.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 28 Oct 2013 08:41:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236840>

Junio C Hamano <gitster@pobox.com> writes:
> [administrivia: please avoid culling addresses from To:/Cc: lines]

Yikes, sorry about that.  I've been sending messages through Gmane
rather than via email, and I didn't realize the list didn't
automatically send messages to the appropriate people who are only
reading the list via actual email (as I am not such a person).

> Keshav Kini <keshav.kini@gmail.com> writes:
>> What about just putting an extra blank line after every root commit line
>> (possibly except the last one)?  That should make it plenty easy to see
>> where the root commits are in --oneline mode.  I think it would actually
>> be easier to spot at a glance than replacing `*` with `x` because it
>> creates a gap in all columns of the output, rather than only in column
>> 1.  Also, this is very subjective but I think it looks kind of ugly to
>> use "x" :P
>
> I agree to all of the above, including the ugliness of 'x' ;-)
>
> A "blank" may however be hard to spot, if the range is limited,
> though.  For example,
>
>     $ git log --graph --oneline a4..
>       * HEAD
>      /* a1
>     | * a2
>     | * a3
>     * b1
>     * b2
>     * b3
>
> where "a4", which is a root, is the sole parent of "a3" and HEAD is
> a merge between "a1" and "b1" might produce something like this,
> while we may get this from the same history, when shown unlimited:
>
>     $ git log --graph --oneline
>       * HEAD
>      /* a1
>     | * a2
>     | * a3
>     | * a4
>     |
>     * b1
>     * b2
>     * b3
>
> A divider line might make it visually a lot more strong, i.e.
>
>     $ git log --graph --oneline
>       * HEAD
>      /* a1
>     | * a2
>     | * a3
>     | * a4
>     |   ~~~~~~~~~~~~~~~~~~~~~~~
>     * b1
>     * b2
>     * b3
>
> but I am not sure if it is too distracting.

I would be fine with that, fwiw.  We can also turn it on and off with a
config option if people really don't like it, I suppose...

-Keshav
