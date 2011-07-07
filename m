From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 13/14] revert: Introduce --continue to continue the operation
Date: Thu, 7 Jul 2011 12:05:31 +0530
Message-ID: <CALkWK0kSqOkUBZhK2ZxrGpJCMmgzB2mPeLoyZUGLDnHzdDvJsA@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-14-git-send-email-artagnon@gmail.com> <7vliwbjebk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Drew Northup <drew.northup@maine.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 08:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeiBp-0005al-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 08:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab1GGGfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 02:35:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36490 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab1GGGfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 02:35:52 -0400
Received: by wyg8 with SMTP id 8so415904wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oKO2uVDgZRTJlrcingkMT5pZHBLWn2OPzCoV2/g6qPE=;
        b=n8z59UShk6sG2QWzSF86Gbe2ev30mHdjs0lhDIwaYo/gtjBYkkQ6RZsE/b8GG1D9Pc
         vuDidCFxFzLZHRdhhB9483Elso+YoV2ZZY8BwHRuTIMZV9mvtErOyAvxSA75RKcJv71w
         Ka7qiVwcPasoYD8E8I03OzW90LLr/2XapbQTQ=
Received: by 10.216.187.75 with SMTP id x53mr6310282wem.92.1310020551120; Wed,
 06 Jul 2011 23:35:51 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 23:35:31 -0700 (PDT)
In-Reply-To: <7vliwbjebk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176751>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 9e18d64..6ef56ee 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -47,6 +47,7 @@ struct replay_opts {
>> =C2=A0 =C2=A0 =C2=A0 enum replay_action action;
>>
>> =C2=A0 =C2=A0 =C2=A0 int reset;
>> + =C2=A0 =C2=A0 int contin;
>
> As Jonathan mentiond, these three look like all action's to me.

True.  I'll try to figure something out before the next iteration.

>> +static void verify_opt_mutually_compatible(const char *me, ...)
>> +{
>
> Isn't "being compatible" by definition "mutual"?
>
> I.e. verify-option-compatibility perhaps?

There's already a verify_opt_compatible which checks that the first
option supplied is compatible with all the other options.  This one
checks that all the the options all the options are compatible with
each other.  What names do you suggest?

-- Ram
