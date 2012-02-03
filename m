From: Valerie Aurora <valerie.aurora@gmail.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 2 Feb 2012 18:18:50 -0800
Message-ID: <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com>
References: <21056.1328185509@redhat.com>
	<9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
	<15281.1328207789@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 03:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt8jp-0006YB-VW
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 03:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071Ab2BCCSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 21:18:52 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64193 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753210Ab2BCCSw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 21:18:52 -0500
Received: by lagu2 with SMTP id u2so1635494lag.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n84t+lBvtKFgg8qQJWfSZdVh4V8L8YW8pTFGfaLyBUk=;
        b=Rlw5otjBnInsNlskguXOCMg7C9kHgoCqnaeZCtWs6VwrOQp/2q9FLzqyzbLHW1J2QL
         Mq2LNVeJZ3Pz2XOf87L7sDSt9RWK9s0Bf39blrVdnCLlaGCTq/6FHXMlcSLguBqrsWyG
         ISp2lgEhn7jhok52TOkZaCrjcKiOexeVmkpAs=
Received: by 10.152.132.104 with SMTP id ot8mr2821793lab.17.1328235530321;
 Thu, 02 Feb 2012 18:18:50 -0800 (PST)
Received: by 10.112.98.102 with HTTP; Thu, 2 Feb 2012 18:18:50 -0800 (PST)
In-Reply-To: <15281.1328207789@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189735>

On Thu, Feb 2, 2012 at 10:36 AM, David Howells <dhowells@redhat.com> wrote:
> Valerie Aurora <valerie.aurora@gmail.com> wrote:
>
>> There is a line in the kernel doc saying how this should be handled,
>> suggested by Rusty, but it's not being followed.
>
> Do you know where?

A fault in my memory - I asked Rusty for advice on a related problem
and he gave me additional advice, he didn't suggest (so far as I know)
the changes to the kernel docs.  Here's what SubmittingPatches has to
say:

"If you are a subsystem or branch maintainer, sometimes you need to slightly
modify patches you receive in order to merge them, because the code is not
exactly the same in your tree and the submitters'. If you stick strictly to
rule (c), you should ask the submitter to rediff, but this is a totally
counter-productive waste of time and energy. Rule (b) allows you to adjust
the code, but then it is very impolite to change one submitter's code and
make him endorse your bugs. To solve this problem, it is recommended that
you add a line between the last Signed-off-by header and yours, indicating
the nature of your changes. While there is nothing mandatory about this, it
seems like prepending the description with your mail and/or name, all
enclosed in square brackets, is noticeable enough to make it obvious that
you are responsible for last-minute changes. Example :

	Signed-off-by: Random J Developer <random@developer.example.org>
	[lucky@maintainer.example.org: struct foo moved from foo.c to foo.h]
	Signed-off-by: Lucky K Maintainer <lucky@maintainer.example.org>

This practise is particularly helpful if you maintain a stable branch and
want at the same time to credit the author, track changes, merge the fix,
and protect the submitter from complaints. Note that under no circumstances
can you change the author's identity (the From header), as it is the one
which appears in the changelog."

And Rusty's practice as of a year or two ago is for "minor mods" to a
patch, to leave the authorship the same, and add a Signed-off-by:

Signed-off-by: Some Upstream Author
Signed-off-by: Maintainer or Merger (rewrote error handling)

And for a complete (meaningful) rewrite such as David has done, he
changes the commit authorship and adds a Signed-off-by for the
original author.

That's existing guidelines and practice.

-VAL
