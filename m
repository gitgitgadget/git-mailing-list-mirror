From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Mon, 23 Mar 2015 22:00:31 +0100
Message-ID: <CACBZZX7JRAavMV4W91k-3ABYj8NPevBvF+CQKSMASYMjghB5pg@mail.gmail.com>
References: <xmqqoanld3v1.fsf@gitster.dls.corp.google.com> <E1Ya5V2-0001bT-QE@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, stefanbeller <stefanbeller@gmail.com>,
	dennis <dennis@kaarsemaker.net>, gitster <gitster@pobox.com>
To: "David A. Wheeler" <dwheeler@dwheeler.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya9Sz-0003oW-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 22:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbbCWVAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 17:00:53 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33003 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbbCWVAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 17:00:52 -0400
Received: by oifl3 with SMTP id l3so121628583oif.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jJlgFZLWArES8KWdYApwHCng+/5GNJMhbBzLmwdt7tw=;
        b=mQ3wS7E5cs1vGtDdUS4tUL6WXJESkvxsbGH3VeUXJov7jFqlLjYPOXFxzDgVAlgw1M
         9dS+sjI/B+rZFI6eAc+3wgdlc8Sy8ZzwZs3CBEXtfUw1DOSMlDEmYuHoxsKWZOTnesCN
         dPI4jsOPB53i9JdMJ+DrDo2SeKcx+6NaqQgVfctf9cJvJ0zkDlPHONRQz/JcpPMbnTs1
         JTQ3GsGsS25kF8sw2Et/07q2mE+enAzdo/+Hn/53/p44vFqgntut6fGr6inv7iX4KzVV
         dtKUk+tMMMCqclZi9SfD+y30QGKlneaNzwCLGa5GGbVGzFYNLHUJ9f1Ph38GrSK/lkzO
         iETQ==
X-Received: by 10.202.108.84 with SMTP id h81mr793632oic.90.1427144452004;
 Mon, 23 Mar 2015 14:00:52 -0700 (PDT)
Received: by 10.76.82.1 with HTTP; Mon, 23 Mar 2015 14:00:31 -0700 (PDT)
In-Reply-To: <E1Ya5V2-0001bT-QE@rmm6prod02.runbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266163>

On Mon, Mar 23, 2015 at 5:46 PM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> Junio C Hamano:
>>    An approach that checks only the top-level directory for fixed
>>    filename pattern would not be an effective way to protect the
>>    cloners, either.
>
> I disagree, I think it's remarkably effective. *Many* projects
> do this, including git itself. After all, many humans need to find out the licensing
> basics too; having a simple convention for *finding* it helps humans and tools alike.
> It's not even limited to open source software; developers of proprietary materials
> (software or now) *also* typically want to declare licensing.
>
> Sure, the top-level licensing text might be incomplete, but having that information
> provides a big help, and it's what most people rely on anyway. Indeed, a *lack*
> of this is a sign of trouble, which is exactly what warnings are good for.

I don't think you're going to find people disagreeing with you that
it's good to have license information where appropriate, but Git is
the wrong tool to warn about this.

It's a generic content tracking tool, it shouldn't be warning on the
assumption that what you're tracking is a) an open source project and
b) that you care to be notified about some arbitrary files being
missing.

A lot of Git repositories don't care at all about licensing, and
having git-clone warn about this would just be useless noise most of
the time. E.g. anything I put on gist.github.com, the code hundreds of
people contribute to at work (we never distribute it anywhere, so a
license would be pointless). I even have open source projects myself
where there's no LICENSE or COPYING files since that would be
redundant to notices in the files themselves, but I digress.
