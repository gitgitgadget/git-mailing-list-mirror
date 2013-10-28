From: Milton Soares Filho <milton.soares.filho@gmail.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Mon, 28 Oct 2013 15:18:31 -0200
Message-ID: <CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Keshav Kini <keshav.kini@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 18:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaqSa-00083q-BA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 18:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185Ab3J1RSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 13:18:32 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46613 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178Ab3J1RSb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 13:18:31 -0400
Received: by mail-qc0-f174.google.com with SMTP id v1so3934608qcw.5
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oRv6lvs3P8B53RGU1Jw6Sdk4gkjeWUx8R7p9ITut0uM=;
        b=aVNVT2xONkUHwsJ22qjSF9rcX9dwx/sWxRK5mwFKqbMN2OX98jBU8dX9qCOWbIXi0O
         XGkVoDuxjmE27XjFPgGTU6A9QAgal7v6n1dnDJQBY6TLT4opN1Op9OEoZpUohTq57kwB
         IHLYH8H2iX2otj/UyYOeHhodebKLGKx7U/y7pv+vMm0VwNp8eAKQbGTID4cmeSUBcFOm
         cICITlLg1YLvmH652hJyd7smHGIaY4ZeE+zu3nTqXQrYxejMD4oqKDjgbIal+M9BOKYK
         sIHd8jfOL/NY8EBB0St65FIW3gc5U6tElRPewcWmkWPSx1lBGdOwoITLpV06Wi0th1bm
         ULKA==
X-Received: by 10.224.12.137 with SMTP id x9mr3565124qax.110.1382980711156;
 Mon, 28 Oct 2013 10:18:31 -0700 (PDT)
Received: by 10.229.84.70 with HTTP; Mon, 28 Oct 2013 10:18:31 -0700 (PDT)
In-Reply-To: <xmqqeh75h087.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236842>

On 28 October 2013 13:41, Junio C Hamano <gitster@pobox.com> wrote:
> I agree to all of the above, including the ugliness of 'x' ;-)
>
> A "blank" may however be hard to spot, if the range is limited,
> though.  For example,

A 'x' looks like termination points in some specification languages
such as SDL and MSC and thus translates directly to the idea of a
root-commit, at least IMO. For sure it does not stand out as blatantly
as it should, but it gives a general idea without further
distractions, which seems to be the idea of a simple 'git log --graph
--oneline'.

An idea that have just come to mind is to have a decorator to enforce
this property, like this.

      * HEAD
     /* a1
    | * a2
    | * a3
    | x a4 (root-commit)
    * b1
    * b2
    x b3  (root-commit)

This way the user only gets 'distracted' if he explicitly asks for it
(--decorate), with all its colors and whatnot. What do you think?
Should I aim for it?

Besides anything else, this discussion is becoming very subjective.
I've received private feedbacks thanking for the changeset and not a
word against the poor 'x'. Maybe it's time to talk to a UI designer or
let a benevolent dictator set this quarrel off ;-)

[]s, milton
