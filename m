From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix 'git log' early pager startup error case
Date: Wed, 25 Aug 2010 13:05:04 -0700
Message-ID: <AANLkTi=49opoB-4kA-cjGEUXmVjO6_d-Qdh6tiRxqPM4@mail.gmail.com>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org> <7vtymiqz9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:06:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoMEZ-0002MR-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab0HYUGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 16:06:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536Ab0HYUGA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:06:00 -0400
Received: from mail-yw0-f46.google.com (mail-yw0-f46.google.com [209.85.213.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o7PK5TJ0028983
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 25 Aug 2010 13:05:30 -0700
Received: by ywh1 with SMTP id 1so23020ywh.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 13:05:24 -0700 (PDT)
Received: by 10.151.40.15 with SMTP id s15mr4264123ybj.382.1282766724403; Wed,
 25 Aug 2010 13:05:24 -0700 (PDT)
Received: by 10.231.39.75 with HTTP; Wed, 25 Aug 2010 13:05:04 -0700 (PDT)
In-Reply-To: <7vtymiqz9c.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.891 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154465>

On Wed, Aug 25, 2010 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> The only difference is that after the user dismisses the pager, the e=
rror
> message is lost. =A0I am not sure if that is a problem, though.

No, there's a much more annoying difference. You mentioned it, but igno=
red it.

The "user dismisses the pager" part.

That's ANNOYING. I made a damn typo, my command line was bogus. I
don't want that pager. I don't want to have to press 'q' to get out of
the pager just to fix the mistake I made. I didn't ask for a pager in
the first place, and git isn't really outputting any data, so having
the pager there is wrong.

Having the pager there when git actually outputs pages and pages of
data is right. I think the "use pager by default" is absolutely the
right design decision. But that doesn't mean that we should use the
pager when there is no data output, just a command line mistake.

                    Linus
