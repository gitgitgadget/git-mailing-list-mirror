From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 11:23:30 -0700
Message-ID: <xmqq381116xp.fsf@gitster.dls.corp.google.com>
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
	<CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com>
	<xmqqsi91197o.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRGQyFxZ8+yqkzYff_k4ZjWPaegQbBphwXyfBtUOCCw6g@mail.gmail.com>
	<xmqq7fqd17qn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 20:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCB3K-00059s-9R
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbGFSXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:23:34 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34000 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbbGFSXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:23:33 -0400
Received: by igcsj18 with SMTP id sj18so241525599igc.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Tmde2CKfKmE/xqWTYxkT8RARaTZU80Sd1naQBIzTyMs=;
        b=BJyPTTphYMw1CMgcN0bWUkpBx7qygbyoiTHgP9SPq6bF3UB4iyEIxe9kp2X32SxHIL
         SxikJzcNT0c4fNJ9412BCT7QzNE9hGUAneUlzBN9sNz4FOuq3rvFvZIOuYxCvwAHRrA/
         R2PXQEB3t6nt9SxjIkozIdjGy+TyvG/7grNu8HxZprefZjhToGwnscOLMJpxbBoo0mos
         BQgehvs8LdDEMF57Cjuhe3fLqJl9enHuY5h5kgclU6smYL0PT6oYlyGSyZvQB01hxJYz
         FINO3WbX7CTM9q5f/Rj74KF7HBPcqydpo2Emyx+w/1/zR2qwI52Anb3lOtwPREy5odvR
         Wtbg==
X-Received: by 10.50.134.226 with SMTP id pn2mr42814195igb.21.1436207013024;
        Mon, 06 Jul 2015 11:23:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id 140sm12939633ion.16.2015.07.06.11.23.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 11:23:32 -0700 (PDT)
In-Reply-To: <xmqq7fqd17qn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 06 Jul 2015 11:06:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273446>

Junio C Hamano <gitster@pobox.com> writes:

> By clarifying that "sender SHOULD terminate with LF, receiver MUST
> NOT require it" is the rule (and fixing the existing implementations
> at places where they violate the "MUST NOT" part, which I think are
> very small number of places), I think we can drop these LF (or LF?
> for that matter) from all of the PKT-LINE() in the construction in
> the pack-protocol.txt, which would be a very good thing to do.
>
> The example in your sentence will become PKT-LINE(foo SP bar) and
> the "there may be an LF at the end" would only be at one place, as a
> part of the definition of PKT-LINE().

I quickly scanned both the sources where we use packet_write() in
the code and say PKT-LINE in the doc; aside from the actual packfile
transfer that happens on the sideband, which technically _is_ a user
of PKT-LINE, we do not send anything that does not end with a text
in PKT-LINE.  I just wanted to make sure that "there may or may not
be an LF at the end; if there is, it is not part of the payload but
is part of the framing" does not invite new implementors to break
their binary transfer by reading the definition of PKT-LINE too
literally to mean "ok, so I stuffed this 998 byte binary gunk to the
packet and insert an optional LF before sending the remainder in
separate packets".

Thanks.
