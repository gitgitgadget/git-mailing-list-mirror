From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 10/19] documentation: add documentation of the index-v5 file format
Date: Sun, 04 Aug 2013 19:58:50 +0200
Message-ID: <878v0hqqw5.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-11-git-send-email-t.gummerer@gmail.com> <CACsJy8D9Q5=TF7MD1PUid-HEsCb7+JKo6=Rv6zXtjRYO3fPVYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 19:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V62aY-0003cX-F8
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 19:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3HDR7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 13:59:17 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:44351 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3HDR67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 13:58:59 -0400
Received: by mail-ee0-f54.google.com with SMTP id e53so1213826eek.27
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=K5Y5+u3IJq5u2uc73kjxT51+dOgHplIKcObCVSK10z4=;
        b=aIbOs1EHOTnF2Wp9d3RE3wFgzF88KlY0zJMfRcPHRdy9HEshZYkR15o4NW46a8ykKV
         tx9T/bzjmkwiVHZHZmcWIUGcLCTHJz5Z9vp+pW7r/jiaFslco/rm6rxS9wqi3Jq7BNEd
         bZpteitS+hzPdVQoj6I3NpFB7KTmfXcQztPjQzDsTgZcftIdDei3og3teKNJeWm4Ewyy
         wSMGU8qMbqlmjuwtWBwmys8Zz/bVPEHAJU2nMeURSBUT0eHpWdEEPo7OHnuh1veIB9ow
         olnb/jl53bWf3gjuufdO42WcFcmX4VLOFD8sDH2MOJx8ZHklmibQfQEIlDDEjOt+b86V
         sp5A==
X-Received: by 10.14.22.71 with SMTP id s47mr13636102ees.95.1375639138413;
        Sun, 04 Aug 2013 10:58:58 -0700 (PDT)
Received: from localhost (host124-14-dynamic.13-87-r.retail.telecomitalia.it. [87.13.14.124])
        by mx.google.com with ESMTPSA id t6sm18143824eel.12.2013.08.04.10.58.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Aug 2013 10:58:57 -0700 (PDT)
In-Reply-To: <CACsJy8D9Q5=TF7MD1PUid-HEsCb7+JKo6=Rv6zXtjRYO3fPVYQ@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231635>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +== Header
>> +   sig (32-bits): Signature:
>> +     The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
>> +
>> +   vnr (32-bits): Version number:
>> +     The current supported versions are 2, 3, 4 and 5.
>> +
>> +   ndir (32-bits): number of directories in the index.
>> +
>> +   nfile (32-bits): number of file entries in the index.
>
> I just noticed that "file" command can show the number of entries,
> something like this
>
> .git/index: Git index, version 4, 2625 entries
>
> Maybe we can swap ndir and nfile to immitate pre-v5 format, so
> unmodified "file" still shows correct number of entries/files with v5?

Cool, I didn't know that worked.  In that case it makes sense to
immitate pre-v5 format.  Will change this in the re-roll.

Just a heads up about my progress, I'm currently trying out your
suggestions about storing the directories as tree-format when reading
and storing the dummy entries in the index.  I'll make some experiments
to see if the change is worth it, and will then send a re-roll, probably
in a couple of weeks.
