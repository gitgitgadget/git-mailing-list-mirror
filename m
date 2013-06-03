From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Mon, 3 Jun 2013 16:10:46 -0500
Message-ID: <CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 23:10:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujc1l-0006HZ-1d
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 23:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab3FCVKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 17:10:49 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:41301 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286Ab3FCVKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 17:10:48 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so1857055lab.17
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pxXuWvaS3V5wrXXfhq3nkQ/lHl7edt+PkujUoJ4oTPc=;
        b=Yf1F4Ld2SGvnmz0cEW+A0uabJA1mIq6LTzG0uobQvJ9+0uoCq8NukKtP5xfMXP+z3n
         /L8wcoXEU2euaGPIzcW/NmUqLf+wMOABuJuFqsNnJVtXPkPQYmd38CsdxcnFn4F+BYKS
         SV59CTiBNORMtBJ58lVDhyQuuVFW1qy3JO9RnrBr6Cyf373p+uvYCiGXpCZYGpzuJPpC
         jaPKeZVE5jZfjkUBDQY5R2qI7B7CbcADipbgwjz79hdXH8UzzLQZnIte+8gvu0UjXl9o
         VvgnRMIaRwGFFBD0vdpjteeCVM78mNLx04LFOuCvNddXBicEWUmEeccIf1PqOvtzvBvO
         vyvQ==
X-Received: by 10.112.33.17 with SMTP id n17mr11556101lbi.72.1370293846903;
 Mon, 03 Jun 2013 14:10:46 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 14:10:46 -0700 (PDT)
In-Reply-To: <7vr4gjdomk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226292>

On Mon, Jun 3, 2013 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Pretty much what it says on the tin.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  Documentation/git-cherry-pick.txt   |  3 +++
>>  builtin/revert.c                    |  2 ++
>>  sequencer.c                         |  6 ++++++
>>  sequencer.h                         |  1 +
>>  t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
>>  5 files changed, 25 insertions(+)
>>
>> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
>> index c205d23..fccd936 100644
>> --- a/Documentation/git-cherry-pick.txt
>> +++ b/Documentation/git-cherry-pick.txt
>> @@ -129,6 +129,9 @@ effect to your index in a row.
>>       redundant commits are ignored.  This option overrides that behavior and
>>       creates an empty commit object.  Implies `--allow-empty`.
>>
>> +--skip-empty::
>> +     Instead of failing, skip commits that are or become empty.
>
> Not quite sure.  Is this "instead of recording an empty commit,"
> (which may or may not fail depending on the allow-empty settings)?

We are explaining --skip-empty, not --allow-empty.

-- 
Felipe Contreras
