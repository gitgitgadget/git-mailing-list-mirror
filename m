From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 10:34:19 -0700
Message-ID: <xmqqsi91197o.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 19:34:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAHi-0000uT-9X
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbbGFReW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:34:22 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37938 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbbGFReV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:34:21 -0400
Received: by igrv9 with SMTP id v9so121098937igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tCReZb8SmIoT9J/E5Fq3ZG6XUeQvvMZnu/tHia/EFV8=;
        b=YNQozmCOect+JfvsuAaQPVtUvtP3pmhdnO78xk8HyH5dJ4abMuSMEhnjivibTzIa+I
         xa6SnDDGMuX1VOKBHJnMIw6rtGB2bUZORzZvH6h3pLa2lOPKZ2ItD2sWYdC37qnsWC4F
         xWhtDyc4bXMJC/Txjurex8LhTgXEiLRPte23LZapfayFZAQtOzFyxxnVNXSKdHb0Z7ww
         effm/oC9ofToQBtDJTheAbwhigFftS/6roeFJzXZqYFfyv0wpK8F6TSQ0n00ohjXF6ec
         BiF6/ixEp+ftjR0JlcBvD/Og8W95z0sgYSqbGx1Xb8wlqMWicXICi9QX4YYQkrFsyQ5a
         qFaA==
X-Received: by 10.42.167.129 with SMTP id s1mr38539700icy.54.1436204060565;
        Mon, 06 Jul 2015 10:34:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id q16sm10088760igr.12.2015.07.06.10.34.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 10:34:19 -0700 (PDT)
In-Reply-To: <CAD0k6qQW3TbgXDsc2Wzid8RNyugumUbSu4KTzO21euO3y_OWGw@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 13:18:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273437>

Dave Borowitz <dborowitz@google.com> writes:

> Another way of looking at the problem with my assumptions is, I was
> assuming "pkt-line framing" was the same thing as "pkt-line header".
> You seem to be saying the definition of "pkt-line framing" is "header,
> and optional trailing newline".

Yes.  I thought that was what "Server SHOULD terminate with LF;
client MUST NOT require it" in the existing text meant.

Ah, that reminds me of one thing I already said elsewhere.  We need
to correct the above with s/Server/Sender/; s/Client/Receiver/; I
think.
