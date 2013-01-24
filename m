From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] push: further clean up fields of "struct ref"
Date: Thu, 24 Jan 2013 17:22:12 -0500
Message-ID: <CAPig+cQL81tSWLz=QOOD-_2yws12jYLayQ8wvUaHXrURPBEFTw@mail.gmail.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
	<1358978130-12216-1-git-send-email-gitster@pobox.com>
	<1358978130-12216-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyVJQ-0005cy-CA
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab3AXWaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 17:30:00 -0500
Received: from mail-ve0-f175.google.com ([209.85.128.175]:54234 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab3AXW36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 17:29:58 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2013 17:29:58 EST
Received: by mail-ve0-f175.google.com with SMTP id db12so1764940veb.6
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 14:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=wGZHkzkyDex9nkheL7jKugwHQu9xstaLFyL0gyjRhFE=;
        b=wogzbg3kgixefrFEL4Ldwv/FQU7PFUf0PyErfV9tUzo3D8MgQUYIdtE44pgOfglHYY
         4d9TOBKhSvBTm31atvzoO9FsJU+QqACqyyNTkLhWCFkJ8l3X+hE6MSztCzyu/ejvwAeY
         iohwVv8IgUEsrJ1LqLwmdO+a4q2TeVQrBTcvCJBthcHyrwRKsAnsbgS8QVp9n1ylc6I3
         LIoW4DkMLYKT3/5EQllQUeTRd12i/+deBuengWo56i3KV1T15Wx/xBOFKYn0Wlog1tX0
         HT4uZgN748XqgIbjAo0oWJicX8ls6NFU9LQNWiohyyNOl/lgQzgxQUzThP1RgUYPguwN
         dyRw==
X-Received: by 10.52.67.133 with SMTP id n5mr3317604vdt.24.1359066133021; Thu,
 24 Jan 2013 14:22:13 -0800 (PST)
Received: by 10.58.75.15 with HTTP; Thu, 24 Jan 2013 14:22:12 -0800 (PST)
In-Reply-To: <1358978130-12216-2-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: lJOwkpf2DBaodNPUHycrf16rAHo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214467>

On Wed, Jan 23, 2013 at 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The "nonfastforward" and "update" fields are only used while
> deciding what value to assign to the "status" locally in a single
> function.  Remove them from the "struct ref".
>
> The "requires_force" field is not used to decide if the proposed
> update requires a --force option to succeed, or to record such a
> decision made elsewhere.  It is used by status reporting code that
> the particular update was "forced".  Rename it to "forced_udpate",

s/udpate/update/
