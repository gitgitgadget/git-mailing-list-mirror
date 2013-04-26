From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Fri, 26 Apr 2013 16:17:20 +0530
Message-ID: <CALkWK0kSWHS0JJ9E4PPihRru0-H13mNffJ5Hndg+LqvFzsYG8Q@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 12:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVgCF-0005yU-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 12:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758869Ab3DZKsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 06:48:02 -0400
Received: from mail-ia0-f182.google.com ([209.85.210.182]:37333 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3DZKsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 06:48:00 -0400
Received: by mail-ia0-f182.google.com with SMTP id w33so1200238iag.41
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 03:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fQ6jGnBOBu/xcBT6lEaT53tpfMVfVysnsEaOvhQPu3k=;
        b=JsSv10NzBOHY2zHI9B5ZzNw9tqd55QWDVevKIzty7l3Ba1UHhmXGtGYAPN57p9Tajx
         PLwx9jhEzuMEijc5DXuoI+BD8/XpAcIc9NPuR9j/ytdz66eoyKANBZeRdAmPSJH4Xzcq
         5HrAvTT2M6ng9/YtGehVA1oiSRd3MZpJLcSK4A667QybM1sp1OTRm/xJznkqxaZiXc6+
         DdnRlvDVHBh2vytatsNT6/jW9DU6Ng+OLfo7YcB4d9wyAnMlnwpN2EwHJpkzwDTPH0U5
         gSJmyhRNuKAefI7T5KnDjtYNA2/gT+EJvxmEUAJTgawwtwtH6cuHUdIY9t7G8Uhf2kse
         NHeQ==
X-Received: by 10.50.66.197 with SMTP id h5mr1422040igt.63.1366973280229; Fri,
 26 Apr 2013 03:48:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 03:47:20 -0700 (PDT)
In-Reply-To: <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222526>

Ramkumar Ramachandra wrote:
> The range version of $(git merge-base A B) B is B ^$(git merge-base A
> B), and not B --not $(git merge-base --all A B) [which is equivalent
> to B ^A or A..B].

Let me make this easier for you, and everyone else.

In git.git, checkout master and merge 9915605c^2 (rr/shortlog-doc).
So, my changeset has graduated from 'pu' to 'master' (I know 'master'
is directly ahead of 'pu', and this is not what you do; but this is
just an exercise).  Now, I execute git log master..pu and search for
the author "Ramkumar Ramachandra".  I can see that my shortlog-doc
commits aren't present; so I infer that my changes have graduated to
master.  I can also see the merge commit corresponding to
rr/shortlog-doc, and infer that master merged in rr/shortlog-doc
differently.

If I execute git log pu ^$(git merge-base master pu), I see the merge
commit rr/shortlog-doc _and_ the shortlog-doc commits.  Here, I don't
want to know if my change graduated to master or not: I just want to
know what changes were introduced by the pu branch since the last
fork.  Think of it as a time-truncated version of git log pu: it has
nothing to do with reachability.  The only reason that master even
appears in the command is because I need to specify where pu forked
off from.

I would argue that this is incredibly useful: to see what changes were
introduced by "my branch" independent of everything else.  What do you
think?
