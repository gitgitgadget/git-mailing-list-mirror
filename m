From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] Documentation/log: clarify sha1 non-abbreviation in log --raw
Date: Mon, 18 May 2015 23:28:26 +0200
Message-ID: <vpqd21xpocl.fsf@anie.imag.fr>
References: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
	<1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
	<1431971758-979-2-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mn9bobv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 18 23:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuSaU-0002cy-K9
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbbERV2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:28:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45312 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbERV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:28:33 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4ILSN2J003491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2015 23:28:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4ILSQhI003455;
	Mon, 18 May 2015 23:28:26 +0200
In-Reply-To: <xmqq4mn9bobv.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 May 2015 13:52:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 18 May 2015 23:28:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4ILSN2J003491
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432589305.55389@ltZPGfuFVMvrPQVvYS6s4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269322>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> This patch is new.
>>
>>  Documentation/pretty-formats.txt | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
>> index dcf7429..c434ecc 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -79,7 +79,10 @@ stored in the commit object.  Notably, the SHA-1s are
>>  displayed in full, regardless of whether --abbrev or
>>  --no-abbrev are used, and 'parents' information show the
>>  true parent commits, without taking grafts or history
>> -simplification into account.
>> +simplification into account. Note that this format affects the way
>> +commits are displayed, but not the way the diff is shown e.g. with
>> +`git log --raw`. To get unabbreviated commits in a raw diff format,
>> +use `--no-abbrev`.
>
> s/commits in a raw/object names in a raw/?

Yes, that is better. Let me know if you want me to resend.

> I wondered what "this format" was, and had to read the patch with
> "show -U60" to realize that this is about "--pretty=<format>".
> Perhaps the introductory text of the first paratraph in the section
> is not clear enough that not just --pretty=raw but --pretty=anything
> is about how the commit object is shown and has nothing to do with
> how patches are shown, and that is why this new text is necessary?

I would say no, since other formats do not have this "raw log format" Vs
"raw diff format" confusion.

I looked for a way to have this disclaimer under 'PRETTY FORMATS'
outside the 'raw' subsection, but I found no place where this would not
be weird like "oh, BTW, this section has nothing to do with patches"
when the user did not have any notion of patch in mind.

The confusion was rather serious here since 1) looking for the string
"raw format" was directly pointing to the paragraph I patched, and one
may do this search looking for information on raw diff format, and 2)
the text was explicitly saying that all sha1s were unabreviated while
--format=raw --raw still shows abreviated commits. Neither of the
confusion are problematic with other formats.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
