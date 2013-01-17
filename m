From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Thu, 17 Jan 2013 00:20:13 -0600
Message-ID: <CAEUsAPb0Zg0x78e+12NqXA4PRBkOUO89KTgxtwxujS1KOx9NYg@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<7vsj61xez2.fsf@alter.siamese.dyndns.org>
	<7vobgpxeel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 07:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tviq7-00049G-LE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 07:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759069Ab3AQGUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 01:20:16 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:37193 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759028Ab3AQGUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 01:20:15 -0500
Received: by mail-la0-f46.google.com with SMTP id fq13so2248052lab.33
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 22:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=YJBcptK786eXyC+IsFCZzZqjGnNlGJ9N9JD1lbayjmE=;
        b=jCFPP4mrT3sWZMJxbxOdd+o6Ife1MEzhnn3lECo5y9aTXqDTdhOQwoAtuzp+zh6G5H
         90Ebd6eRLWRHxf8uFDeIIOR9bRbPTwRQVsV0j5BCNzQCgfFwjfc05p868CYgA2cTXU2d
         7RXklC6eb1TUgbdkl153ok05lHVJ5rqAJ3mXZJC3kPsJ1O8PP3sPLuL/mO3Wu8bhjD7g
         aQF9312j9s8bAfjUmjbc3hjdEcO2n+puSFf6TKxlA0+PJ9ndyEo0KfvIBTGE9u2dSoHb
         Pw3HiyYLB0zbDDFkhcYejoyBAnTw4/SMtRYTf8OK4/PTeINHAkUu9mCWfDRYPGvGdDYo
         +Nbg==
X-Received: by 10.152.123.83 with SMTP id ly19mr3546942lab.51.1358403613466;
 Wed, 16 Jan 2013 22:20:13 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Wed, 16 Jan 2013 22:20:13 -0800 (PST)
In-Reply-To: <7vobgpxeel.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qtbEitEYsplLTxAL7Fljm7QdcQU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213843>

On Wed, Jan 16, 2013 at 10:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It is fine when pushing into "refs/tags/" hierarchy.  It is *NOT*
> OK if the type check does not satisfy this function.  In that case,
> we do not actually see the existence of the destination as a
> problem, but it is reported as such.  We are blocking because we do
> not like the type of the new object or the type of the old object.
> If the destination points at a commit, the push can succeed if the
> user changes what object to push, so saying "you cannot push because
> the destination already exists" is just wrong in such a case.

So the solution is to revert back to recommending a merge?
