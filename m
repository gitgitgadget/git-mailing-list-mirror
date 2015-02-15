From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 0/2] Getopt::Long workaround in send-email
Date: Sat, 14 Feb 2015 22:13:52 -0800
Message-ID: <CA+sFfMetZv_sr9EUOQDJpdq0E9bYYKWrSh4OeFfRDBY3SjRxeg@mail.gmail.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
	<1423858769-1565-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 07:14:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMsSz-0001Ro-3z
	for gcvg-git-2@plane.gmane.org; Sun, 15 Feb 2015 07:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbbBOGNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 01:13:53 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33776 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbBOGNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 01:13:52 -0500
Received: by iecar1 with SMTP id ar1so28110044iec.0
        for <git@vger.kernel.org>; Sat, 14 Feb 2015 22:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QZdYHKMnUOobd5JzA84N+uc3+cwFsMLTEO4tjiQyomo=;
        b=enI6km74bZpjIyEeaIPYpxNZIJGUDQ+HuM2gzkvlQ2sV++Haj1MtU+BtA9NtoJSI95
         Q7oxkveFtuiTm63CNa3vsAFvdzrCE8vsobS5UxLxNhHTAvmNDLn/eq9wChy7RvZsFvX6
         Qf76tsE1boPjUqxAzp6XaUBFOd52bmcXwqEhZl4YWWVZs6Fpid4uWFtLX7RrCtNfapPp
         DKMnC4bDXO/TqPmANd8zzbbRJD0Qqi8db4JY8iDYb6TTD0ta1tVmaIbnIcfYN1V5V7Qp
         nTRwtHkADGHtQ7Iwy8T2HfqnpARCPC1OAE5Na1tS6e6zzfcnVSzPlRP1W4OEav38h0SR
         qLxA==
X-Received: by 10.107.34.149 with SMTP id i143mr22623154ioi.1.1423980832123;
 Sat, 14 Feb 2015 22:13:52 -0800 (PST)
Received: by 10.64.58.201 with HTTP; Sat, 14 Feb 2015 22:13:52 -0800 (PST)
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263851>

[apparently it is impossible to send a plain text email using Google
Inbox, maybe people on this list know someone to talk to about that?
Sorry for the dup for those on cc]

On Fri, Feb 13, 2015 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The first one is a replay of Kyle's workaround for older versions of
> Getopt::Long that did not take "--no-option" to negate a boolean
> option "--option".  The second one revert the workarounds made to
> the test script over time, and should break if the first one does
> not work well for older Getopt::Long (I have no reason to suspect it
> would break, though).

The only downside I can see is that we're going to end up carrying
around these extra options for the forseeable future and possibly
adding more over time with this precedent.  Maybe that's not so bad.
The extra options are not ugly at all.  My original thinking in just
fixing up the tests was that the platforms with ancient versions of
perl/Getopt::Long would just disappear over time and we'd eventually
stop fixing up the tests to be backwards compatible when people
stopped showing up saying that the tests failed on their ancient
system.

What platforms are actually affected?  RHEL3?  Other ancient UNIX?  I
know the systems I was fixing up were ancient SunOS and IRIX.

Unfortunately (or fortunately, depending on how you look at it), I
don't have access to any ancient systems to test on anymore.  So I
can't run the updated tests to make sure they still pass.  The patches
"look" fine to me though. :-)

-Brandon
