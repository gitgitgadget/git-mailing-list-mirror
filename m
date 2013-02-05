From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is anyone working on a next-gen Git protocol (Re: [PATCH v3 0/8]
 Hiding refs)
Date: Tue, 5 Feb 2013 21:07:45 +0100
Message-ID: <CACBZZX6bKJPRio6992xMK+fK3G+M2_HZ4NG=gShwfDHKRQEE+A@mail.gmail.com>
References: <CACBZZX7G=V9L+zEA2MQFjQW8tRA0i1Gk3nUYdg5dDy35v74SEw@mail.gmail.com>
 <7vfw1avjcw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2oog-00060W-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab3BEUIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 15:08:07 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:44746 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3BEUIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 15:08:06 -0500
Received: by mail-oa0-f44.google.com with SMTP id h1so672762oag.3
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=6fPX7xdc7lZABc8cmsSL9DNOrWnRU8RiNiQmDOjQpc0=;
        b=xEwrLRmWzIA1dVQv36MHXUyOB4OehicMmYUCwWRcUE82fYqlQkR5/onEOSCBK58VT6
         SCXhdHTMqcD+OeMMt8CAlHABCwcbO9KKW7+wC5d7aFNV4hr0XTUB+0ddxgBzMCxDSxNx
         uezI8+04bjkEpHAsJPA5xMjUezOuEIrmDxc5iuEDrGEr/E4Wt3OMkRdsTm+jJPKdji9Y
         08y9T/cNtbwOSEKO4pxsjXd4r0r5yo7Lqwyv6dR8MMB/u8J/bRe24jJdT5+3/Rt+fcjf
         el9QYmELaDtueKDkraBojS249qVAiV43C2OMBbG4vPuHjXKNIy0ijDYcTFkLw4uF/8kZ
         vLLQ==
X-Received: by 10.182.155.66 with SMTP id vu2mr16203933obb.6.1360094885380;
 Tue, 05 Feb 2013 12:08:05 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Tue, 5 Feb 2013 12:07:45 -0800 (PST)
In-Reply-To: <7vfw1avjcw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215531>

On Tue, Feb 5, 2013 at 5:03 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Do you have any plans for something that *does* have the reduction o=
f
>> network bandwidth as a primary goal?
>
> Uncluttering gives reduction of bandwidth anyway, so I do not see
> much point in the distinction you seem to be making.

Doing this work wouldn't only give us a way to specify which refs we
want, but if done correctly would future-proof the protocol in case we
want to add any other extensions down the line in a
backwards-compatible fashion without having the server first spew all
his refs at us.

Anyway, an implementation that allows a client to say "I want X" is
simpler than an implementation where a server has to anticipate in
advance which X the clients will ask for.

>> Is this what you've been working on? Because if so I misunderstood y=
ou
>> thinking you were going to work on something that gave clients the
>> ability specify what they wanted before the initial ref advertisemen=
t.
>> ...
>> 4. http://thread.gmane.org/gmane.comp.version-control.git/207190
>
> "Who speaks first" mentioned in 4. above, was primarily about
> "delaying ref advertisement", which would be a larger protocol
> change.  Nobody seems to have attacked it since it was discussed,
> and I was tired of hearing nothing but complaints and whines.  This
> "hiding refs" series was done as a cheaper way to solve a related
> issue, without having to wait for the solution of "delaying
> advertisement", which is an orthogonal issue.

Oh sure. I just wanted to know if you were working on delaying ref
advertisement to avoid duplicating efforts. I had the impression you
were given your earlier E-Mail, but obviously we had a
misunderstanding.
