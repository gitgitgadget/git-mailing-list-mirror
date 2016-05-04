From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 08:50:56 +0200
Message-ID: <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	christain.couder@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 04 08:51:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axqeE-0002Xt-TY
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116AbcEDGu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:50:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38687 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbcEDGu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:50:58 -0400
Received: by mail-wm0-f47.google.com with SMTP id g17so75467338wme.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 23:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hA62+HPuBOA500W2mYv1/gEkVIZ2unbkPdOLkakCkLs=;
        b=JuudpmtMEBDxAByIWmMAV7iPYbUdzRel+rIcYuQfn1LrVbYX7j4hKTkGtsW32pb0Fj
         IXIUdzsgnpMr0mgtbYCK9bTvQQgL6Ln+Bc70TjXlbOLB6S/sC+aHxflOfA7fOTS2ZAaN
         afqJM09jS0+DEe4jFWYv/vca/hEeX8xviV3XcVktQ1Gp2wh4Pbdb9zBTPu0IXiiK1Wo1
         e7FE5l/r+dakjlxnLzUYO5TjDGFg9xEOnv3uE8IC2IXkVRNqMlV/Cy7jTP0gXJJ1Kyk6
         bTBvzP7E+sNp7rTXg+H9Le/yJslf5k8DX005Y+X7NkZfTHp0NgbqFDnzGlkWFFXDOfU2
         TrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hA62+HPuBOA500W2mYv1/gEkVIZ2unbkPdOLkakCkLs=;
        b=TQXvy+iuggsr8xsIMn+OgnQbGD4gSkWdeRAmGZRjqTp0UYsRpBKri25XSGVgfouCiU
         cfrwn6H4zIwJE2mWX5G2+OGojSKviilJgZWJQMuOstchjpApggwSfELk91Aj95P8pPFR
         iUTN3/dAPb+TG9NQhPXxu26zPCFJwU6kQmamDpGodfVVbhSrXdnFU05aPJMQYZu4qo86
         NsLQXRc8l7jIp9UPoFWKJKn0iOLdCQ9N721iu7D/O5T0jmRv7FESzaJ512VH9MdFggLp
         33xd6znKicE5oXcCqWnb7DQ+FSvrI2JDxa69+yzUVDqdbBiSDPNE8s8KxyXX1eFIyh2u
         qxAw==
X-Gm-Message-State: AOPr4FWLs2xn65apV8PzA3LqonguhZnAUIB0GKyLP2UvnQKfEr6EBq77ZH0KM9DGImQcl/1Y+ZbqkwNIoR4VPg==
X-Received: by 10.28.54.33 with SMTP id d33mr7715790wma.62.1462344656847; Tue,
 03 May 2016 23:50:56 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 23:50:56 -0700 (PDT)
In-Reply-To: <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293500>

On Wed, May 4, 2016 at 8:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>
> This subject is too low-level, talking about implementation details,
> whereas it should be giving a high-level summary of the change.

When a patch is all about a low level detail, I think it is good to
talk about the detail in the subject.

Here I think something like "bisect--helper: parse options using
OPT_CMDMODE instead of OPT_BOOL" would be ok for example.

>> `--next-all` is meant to be used as a sub command to support multiple
>> "operation mode" though the current implementation does not contain any
>> other sub command along side with `--next-all` but further commits will
>> include some more subcommands.
>
> You've spelled this as both "sub command" and "subcommand". Choose one
> and stick with it. ("subcommand" is probably more common.)

I agree with that and the other suggestions, thanks.
