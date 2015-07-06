From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 10:30:33 -0700
Message-ID: <xmqqwpyd19dy.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
	<xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRLu1d7Sa8aVrHtDCsJNtVXwzHBAyOmmUHmVAx7qHmOPg@mail.gmail.com>
	<xmqq615x2ph1.fsf@gitster.dls.corp.google.com>
	<CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAEH-00076T-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbbGFRas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:30:48 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36517 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbGFRan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:30:43 -0400
Received: by iecvh10 with SMTP id vh10so118179159iec.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bbZhGzl1yna26zSaItJhWB4+BrcKqL/Ie7JyrYHDf0E=;
        b=sRmVnfMEsZz8gAYhaKDZ1b/HhJKkTyaBm6RAhXk/dfjRc3q4MRJyyY2WVuKc9MJ7Fl
         bRtoKAt0ko0J2Gjo3c7vlR3WH3J2emKhO1E4q8KgDPh3KznvO5zXXmTRs3D+S6+/mX8R
         JzdjCmzmmLHydD+XcnlHtfOeVOTHYtr9d/I41QVptwYZRljam3ySCjSeLDDIkZ+Z7nNO
         GjKgejPoDFlA7tG/rKp5xpqBJ5MkjlcnTK3VYV+fefu31nmNZVPxOrVpR6j1BJV/bkdQ
         gKVQMF6fIPzP3PZguE45F4mIcnh74N4FXrZO/pUz/V0VGl91ud4MupprpmwCoHEpN1ks
         dfoA==
X-Received: by 10.107.129.230 with SMTP id l99mr33036ioi.32.1436203837214;
        Mon, 06 Jul 2015 10:30:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id m1sm10086894igv.8.2015.07.06.10.30.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:30:36 -0700 (PDT)
In-Reply-To: <CAD0k6qT8=xQb6MRcLkyvZBm0MRdQ0Z-8ojqghovdgeJQ2EBNEA@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 13:11:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273412>

Dave Borowitz <dborowitz@google.com> writes:

> I think I understand the confusion now. I think you and I are working
> from different assumptions about the client behavior.

I agree that we now both understand where we come from ;-)

And sorry for not being clear when I did the "push-cert" originally
in the documentation.  As I already said, "packets between push-cert
and push-cert-end are contents of individual lines of the GPG signed
push certificate" was the design meant from day one, and a85b377d
(push: the beginning of "git push --signed", 2014-09-12) could have
made it clearer.

> The problem with the documentation, then, is that the documentation
> does not say anything to indicate that the signed payload is anything
> other than what is on the wire.

Yeah, that was untold assumption, as I considered "what is on the
wire" to include pkt-line framing when I wrote a85b377d (push: the
beginning of "git push --signed", 2014-09-12).

> So maybe this series should include an explicit description of the
> singed payload outside of the context of a push. Then, in the push
> section, we can describe the set of transformations that the client
> MUST perform (splitting on LF; adding pkt-line headers) and MAY
> perform (adding LFs).

Yes, and the latter is not limited to push-cert but anything sent on
pkt-line.

That incidentally is the only point I deeply care about.  I just
want to minimize "the protocol is this way in general, but only for
this one you must do it differently".

One example of "only for this one you must do it differently" is
another caveat for protocol implementors for the sending side (again
not limited to "push cert"). 

That existing implementations of the receivers treat an empty packet
(i.e. "0004") as if it is the same as a flush packet (i.e. "0000"),
so even if the sending side chooses to ignore the "SHOULD terminate
each non-flush line using LF", it is strongly advised not to do so
when it wants to send an empty payload.  This needs to be documented.

The receiving end SHOULD NOT treat "0004" the same way as "0000".
I think that must be documented and implementations (including our
own) should be fixed.

Thanks.
