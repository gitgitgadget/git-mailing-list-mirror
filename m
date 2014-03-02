From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH v2] Replace tmpname with pack_tmp_name in warning. The
 developer mistook tmpname for pack_tmp_name.
Date: Sun, 2 Mar 2014 15:18:38 +0800
Message-ID: <CAJr59C0vf7F9eXgJVmFfC4gbHDHFvx14Z1ywz8YeLMSWLgVRkA@mail.gmail.com>
References: <1393728219-3142-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cQS53vzZQrkeZDX7ci4708o9bVp5QMvNnesZU17u1Fz2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:18:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK0fk-00040A-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 08:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbaCBHSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 02:18:40 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:55637 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbaCBHSj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 02:18:39 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so3261437wib.2
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 23:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=D1njC7nigKcVXgkue8cRfMcoTqBwedb6vn528kbbF9Q=;
        b=KSvXBUS/jIVE32w7q1P1Ku+/65hNoQcEjsBtAM60A9IWP/EcpbGReZYhMyHTr0PC4h
         OttZ3mdCoFRo+KX4KJ5XsSXcA0y5keTof3C3V6IZqVHfj62WBkQpE5nCmZsMkrctmyvR
         CZXNlLEnfPRaxeRuwhYepQxLRcXqZZ+OmOheTn9or1qDNWYtzB4tBghFpBo9rcQ1jby1
         +iJMBd4ij64xsLBB2gEU7LgaQQpzhHxCEdG+s/trLzFEcf2PbcdC70i8GHNR2BxoGAjJ
         dVaLQ1c7rhzhn5rpY4Faomp3NVLFL/U1hOoKt63BkbY2f+exwgvG5jtnZ+iJ9gZQL0BZ
         bpUQ==
X-Received: by 10.180.205.204 with SMTP id li12mr9268678wic.34.1393744718575;
 Sat, 01 Mar 2014 23:18:38 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 23:18:38 -0800 (PST)
In-Reply-To: <CAPig+cQS53vzZQrkeZDX7ci4708o9bVp5QMvNnesZU17u1Fz2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243134>

2014-03-02 11:59 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Sat, Mar 1, 2014 at 9:43 PM, Sun He <sunheehnus@gmail.com> wrote:
>> Subject: Replace tmpname with pack_tmp_name in warning. The developer mistook tmpname for pack_tmp_name.
>
> The subject should be a short summary of the change, and the rest of
> the commit message before the "---" line provides extra detail
> explaining the change.
>

OK, got it.
Thank you very much.

>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>
>>  As tmpname is used without initialization, it should be a mistake.
>
> This is valid information for the commit message above the "---" line.
> So, your full commit message might say something like this:
>
>     Subject: write_pack_file: use correct variable in diagnostic
>
>     'pack_tmp_name' is the subject of the utime() check, so report
>     it in the warning, not the uninitialized 'tmpname'.
>

Thank you for your suggestion, I will modify it right now. :-)

>>  builtin/pack-objects.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index c733379..4922ce5 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>>                                 utb.modtime = --last_mtime;
>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>                                         warning("failed utime() on %s: %s",
>> -                                               tmpname, strerror(errno));
>> +                                               pack_tmp_name, strerror(errno));
>>                         }
>>
>>                         /* Enough space for "-<sha-1>.pack"? */
>> --
>> 1.9.0.138.g2de3478.dirty
