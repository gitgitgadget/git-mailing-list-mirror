From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 12:42:12 -0700
Message-ID: <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com>
	 <7v1w3muw8j.fsf@gitster.siamese.dyndns.org>
	 <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com>
	 <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 21:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1RYC-0006CI-TW
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 21:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYE1TmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 15:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYE1TmR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 15:42:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:64470 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbYE1TmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 15:42:16 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3675786rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=f2+rJEMp5qbjjghVvKxxZYMlvmX/4s0FHFw4R0I8AQw=;
        b=n4b0jaspIMf4XMJdcscP6OMguy2BCyNi+FxyE5izpzUj7E3wvLZ1aOXVXKpJMtsAZ8vMRhIt7qHdDC4U1dh/pDMv372wheAFB++lDnFrXEIRz7jjSh+GKVzseU9n+8nOISdG9eCqv6nfasjZgRr9u8b6IgVoKbjrmnYvVOSJtzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=u3DqhTs2e9pKD1SVJ94WZ1kZC7A3MKt3m1KUcyAdBr3cyyjpVooGf3D2t4/CYKkKhVRvq0JKzCJiiX7A5RkF+R668KyKALsCf3fMHm/dJ49k3FCqfAIzYVmdGZRTY/6fovhaObLG7TeFPq7Wj70r0kMyLdCr7yFVHpyeE3lbi0U=
Received: by 10.140.142.4 with SMTP id p4mr1547362rvd.261.1212003733050;
        Wed, 28 May 2008 12:42:13 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Wed, 28 May 2008 12:42:12 -0700 (PDT)
In-Reply-To: <7vod6qtgfs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: f144354030519cfb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83131>

On Wed, May 28, 2008 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Geoffrey Irving <geoffrey.irving@gmail.com> writes:
>
>> On May 28, 2008, at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> "Geoffrey Irving" <irving@naml.us> writes:
>>>
>>>> Would it be straightforward
>>>> to add an option to "git cherry" to ignore differences in metadata?
>>>> The cherry documentation doesn't give its criteria for when commits
>>>> match, and I'm not familiar enough with the code yet to figure out
>>>> those criteria directly from cmd_cherry in builtin-log.c.
>>>
>>> cherry does not look at metadata at all.  It compares patch-ids.
>>
>> Can you define what a patch-id is?
>
> $ man git-patch-id

Thanks!  Here's a patch to avoid duplicating this particular ignorant question.

Geoffrey

commit a1bac5e1aa52f9a78733aa35a0a7e820df618301
Author: Geoffrey Irving <irving@naml.us>
Date:   Wed May 28 12:38:11 2008 -0700

    doc: mention git-patch-id in git-cherry documentation

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index b0468aa..9817fb5 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -41,6 +41,8 @@ has been applied <upstream> under a different commit
id.  For example,
 this will happen if you're feeding patches <upstream> via email rather
 than pushing or pulling commits directly.

+For details about how patches are compared, see git-patch-id.
+

 OPTIONS
 -------
