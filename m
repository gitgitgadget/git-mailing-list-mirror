From: David Michael Barr <davidbarr@google.com>
Subject: [linux.conf.au] VCS Interoperability
Date: Mon, 9 Jan 2012 23:30:36 +1100
Message-ID: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 13:30:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkENA-0007Gs-5l
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 13:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab2AIMai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 07:30:38 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59604 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab2AIMah (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 07:30:37 -0500
Received: by yenm10 with SMTP id m10so130771yen.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 04:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:x-system-of-record
         :content-type;
        bh=RbOzTPmE8dAEYhurueGpEr4QRKiUTcymVKcdWXqTHQ8=;
        b=CxSRV6ENlC9Aepsv4eCpk7BvbPKee+dH6DUWsm/RpQ1143cNRt1+X/0l/XaA9zT8hU
         +4v78khVzbWP5fQ15/C0T3AFHfLBhtmWbEO16DeR57mxqdwzdQscJQ/+ymawi5qdD8Vv
         nUKnRpsjQzDJ/IlEQe5TMYvkJNd350TX5pZBo=
Received: by 10.236.191.134 with SMTP id g6mr19097408yhn.95.1326112236801;
        Mon, 09 Jan 2012 04:30:36 -0800 (PST)
Received: by 10.236.191.134 with SMTP id g6mr19097392yhn.95.1326112236703;
 Mon, 09 Jan 2012 04:30:36 -0800 (PST)
Received: by 10.100.56.25 with HTTP; Mon, 9 Jan 2012 04:30:36 -0800 (PST)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188168>

Hi there good folk of the git community,

Next week, I'll be presenting  a summary of the past 2 years work
on improving svn interoperability for git.
I'm requesting feedback from anyone who cares with regard to
what they'd like to hear about.

 http://linux.conf.au/schedule/158/view_talk?day=friday

Jonathan put together an overview for Dmitry in preparation for
Google Summer of Code 2011:

 svn-fe is very young, so a sufficiently bored person (meaning: I am
 not advocating that you do this; this is just an excuse to provide
 references to avoid getting stuck when you have questions) could
 probably read its history in full without getting lost.  Here are some
 references on the initial design (i.e., how responsibility is divided
 between the svndump driver and repo_tree and fast_export modules).
 The division of responsibilities between modules mostly survives,
 while the details of mechanism are quite different now.

  announcement and following thread:
  http://thread.gmane.org/gmane.comp.version-control.git/143180/focus=143388
  http://thread.gmane.org/gmane.comp.version-control.git/143187

  first public review (not much big picture stuff yet):
  http://thread.gmane.org/gmane.comp.version-control.git/147587

  second review (focuses on infrastructure, most of which is
  obsolete now :))
  http://thread.gmane.org/gmane.comp.version-control.git/148409

  third review (some serious thoughts about design begin here)
  http://thread.gmane.org/gmane.comp.version-control.git/148866/focus=149097

  fourth review (with a program to test with based on David's original
  program; review mentions some unresolved wishes: appropriate
  incremental import bookkeeping, properties, empty directories)
  http://thread.gmane.org/gmane.comp.version-control.git/149571/focus=149934

  fifth review, which is the one that stuck.
  http://thread.gmane.org/gmane.comp.version-control.git/151086/focus=151144

Also of note is the contributions made by Ram in 2010 that eventually
became a headlining feature for Subversion 1.7:

 http://subversion.apache.org/docs/release-notes/1.7.html#svnrdump

Dmitry ended up submitting a number of short and pointy series.
My favourite by far was:

 fast-import: improve deltas for blobs
 http://thread.gmane.org/gmane.comp.version-control.git/179774

This optimisation was glaring in hindsight.
Respect to Dmitry for spotting it.

I believe a number of people have been contributing to the
remote helper infrastructure lately. They also deserve credit.

Maybe a better historian than myself can provide additional links.

The overhanging issue after all this work is that there are about
95 outstanding patches waiting to be detangled and resubmitted.
I regret not having time to complete this exercise myself.

I hope the process has been insightful and maybe to renew some
interest. Thanks for reading.

--
David Barr
