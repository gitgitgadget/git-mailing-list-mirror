From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: preventing destructive operations to central repository
Date: Thu, 15 Apr 2010 20:58:15 -0400
Message-ID: <t2q76718491004151758p8862970bua5e7d60ccda8cdae@mail.gmail.com>
References: <j2yef38762f1004151739x497106eeo190b97f3eecc153f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Brendan Miller <catphive@catphive.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:58:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Zt3-0000VQ-2w
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756228Ab0DPA6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 20:58:17 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:58533 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0DPA6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 20:58:16 -0400
Received: by gxk9 with SMTP id 9so1178482gxk.8
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=vEBdBytj9odmbXgFqK6gG1OcMBIlVaszXBXR1oWvK4A=;
        b=m1n1lQgpcYLqcVLMTQ6LYB/d8QifEZukzHBP40vdDISZhkjakM3CeVSpk4vnjnULqA
         cROewhNs36z5z1aafVXz3CR5RyxCiJad1FRZGgqId9TVq0Swo22iyssoK4JdkbZbXvd4
         dA3BUC2V2CEGg6X3rb3VMWqDxB1bu8hC8voDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=N3+ORAd/S8dVVZTFSvYJx7PqL1k5TYOtYe0Xt9uacOfdbN/sk0Gci0+8cP6LYrR4Mh
         x6+RMZZRw5SNPRsUioA5FqklVNzxWWwhbyhQ3dKmHvwHZlYEG4hWFPmNmYXhhyAGSuOr
         ytHSEv3HajbAB0mcXbXDUM3mMVPshigTIGThk=
Received: by 10.231.36.9 with HTTP; Thu, 15 Apr 2010 17:58:15 -0700 (PDT)
In-Reply-To: <j2yef38762f1004151739x497106eeo190b97f3eecc153f@mail.gmail.com>
Received: by 10.101.139.28 with SMTP id r28mr1738806ann.188.1271379495181; 
	Thu, 15 Apr 2010 17:58:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145042>

On Thu, Apr 15, 2010 at 8:39 PM, Brendan Miller <catphive@catphive.net> wrote:
> Let's say you have a bare git repository writeable by a number of
> different people. How do you prevent them from borking the central
> repository?

Depends what you mean by borking, but you might consider starting with
reading the "git config" man page for the following entries:

- receive.denyDeletes
- receive.denyNonFastForwards

> Also, is there an automated mechanism to ensure that the timeline
> stays clean? Say, force people to rebase their repositories before
> merging into the shared repository?

In order to prevent merges, you will need to use a a receive-pack hook such as:

http://lists.gnu.org/archive/html/bug-gnulib/2008-10/msg00221.html

You might also consider something like gitosis/gitolite/gerrit
depending upon how formal you want to be.

j.
