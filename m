From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 08:34:05 -0700
Message-ID: <xmqqsi6sdgnm.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<xmqqwpw4dh4a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 17:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYFTo-00077f-IV
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 17:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbIEPeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 11:34:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34430 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEPeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 11:34:07 -0400
Received: by padhy16 with SMTP id hy16so50111234pad.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lb3OGqzv17mWpfupqWflnyPhtb+eIUggGTRqdj/xWs0=;
        b=E/P48X64Pa4/Ue5CHUEZZyKb5JqLQOX1JYDh3c9VZ+SG0T/Cy4R+QaTHaRhHOsJxQY
         qF4m8r6+gNoNzuvnb0j23HhLNAb88Dzxv5Me7RRqvgbRglKMZ3JmAfJbleHKpQH1yf+s
         lprmQToWWI2QpIwit/PYVWW5MmIStlHUBygt8zZuh09Ei+x8Ph2v+qoXyE6w0ubL1Tr+
         73wJAYqbHS6TwcsTwoSWRf02aXOCq3G5iGFKy/sgVqwCQiTQSXk0LTT+MBCDQ1DufoR7
         S/iBhg3yh2zGwhRK+VsxfL/gwS9Z6ZYX5gOUWifz2w5qYMWxizpqfEroWvD5yBhnjXEA
         F+rg==
X-Received: by 10.68.227.8 with SMTP id rw8mr22275506pbc.74.1441467247366;
        Sat, 05 Sep 2015 08:34:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id p4sm6189014pdh.44.2015.09.05.08.34.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 08:34:06 -0700 (PDT)
In-Reply-To: <xmqqwpw4dh4a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 05 Sep 2015 08:24:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277385>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Why do we need a new rule? The old git-am had a logic that pleased
>> everyone, and it must have been implemented somewhere. Shouldn't it be
>> sufficient to just re-implement or re-use that logic?
> ...
> Perhaps we would need to tell has_conforming_footer() function who
> the caller is, and use a different logic (i.e. "just re-implement")
> when the caller is append_signoff().

Ah, I think I misunderstood you.  "just re-implement" could be "not
to use the existing helper used by other callers and instead do it
manually all inside builtin/am.c", and I agree that it would be the
safest way to go.
