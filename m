From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Documentation/log: clarify sha1 non-abbreviation in log --raw
Date: Mon, 18 May 2015 15:29:15 -0700
Message-ID: <xmqqegmda5ac.fsf@gitster.dls.corp.google.com>
References: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
	<1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
	<1431971758-979-2-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mn9bobv.fsf@gitster.dls.corp.google.com>
	<vpqd21xpocl.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 19 00:29:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuTXG-0005fS-UW
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbbERW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 18:29:18 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33104 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbbERW3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 18:29:17 -0400
Received: by igbpi8 with SMTP id pi8so91863159igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 15:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9eX9onAk5J1n9lpwGayiO8YKLvbIhztJ2DSzqA6DN50=;
        b=ucAAdFiS9+RZX1tQmXfrF9CMFym0MlE2LauZG7tXAh8aqM3FgMUsxwcl3EJPArbLoC
         K17QtLBut7DOQ7rp1tmXVJQ5UGI1KdIIFe/Sy6UlB7lGEzWE0ZxZNEhfHHTgANnP+1J9
         hSm/mOrskUgc3WMUMj+FoojYsDDJoDIpvrVfRKlhYXAk5bzBX/LOwZWUW1kVYwb8tpIp
         LfyeA3chM+9EARBFOHMY+YsnF6dbcNrxATL2xdY2jvGFCkIlV4QN0BLwbVwhDplMjvL8
         /Jnx+056czByYinJPsFJEdWB0Sc6W5SbkkiKnSV6xcg3UD1VYxnn3RiZASnahNGiSOeH
         mniQ==
X-Received: by 10.50.57.112 with SMTP id h16mr17318214igq.35.1431988156971;
        Mon, 18 May 2015 15:29:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id i4sm6797786igm.2.2015.05.18.15.29.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 15:29:16 -0700 (PDT)
In-Reply-To: <vpqd21xpocl.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	18 May 2015 23:28:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269327>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> +`git log --raw`. To get unabbreviated commits in a raw diff format,
>>> +use `--no-abbrev`.
>>
>> s/commits in a raw/object names in a raw/?
>
> Yes, that is better. Let me know if you want me to resend.
>
>> I wondered what "this format" was, and had to read the patch with
>> "show -U60" to realize that this is about "--pretty=<format>".
>> Perhaps the introductory text of the first paratraph in the section
>> is not clear enough that not just --pretty=raw but --pretty=anything
>> is about how the commit object is shown and has nothing to do with
>> how patches are shown, and that is why this new text is necessary?
>
> I would say no, since other formats do not have this "raw log format" Vs
> "raw diff format" confusion.

I think we are in agrement, then.

I have this queued with the usual "SQUASH" label on top, so there is
no need to resend.

Thanks.

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 998c7b8..2393f17 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -81,7 +81,7 @@ displayed in full, regardless of whether --abbrev or
 true parent commits, without taking grafts or history
 simplification into account. Note that this format affects the way
 commits are displayed, but not the way the diff is shown e.g. with
-`git log --raw`. To get unabbreviated commits in a raw diff format,
+`git log --raw`. To get full object names in a raw diff format,
 use `--no-abbrev`.
 
 * 'format:<string>'
-- 
2.4.1-379-g2a6df60
