From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] test-lib.sh: unfilter GIT_PERF_*
Date: Tue, 15 Jan 2013 20:47:52 +0700
Message-ID: <CACsJy8BaPfiHL86uh8QOKXzBXb3eKiRnN1MV0e8WegsFzodWHQ@mail.gmail.com>
References: <1358254409-15187-1-git-send-email-pclouds@gmail.com> <87ehhmr28g.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 15 14:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6se-0001Ky-JL
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab3AONsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 08:48:24 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42596 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066Ab3AONsX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 08:48:23 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so111841obc.17
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zFulUj+RyG5mqTFKOnuLRKpiJYjYcohmMpvLcdxRxs8=;
        b=inDs195CDt/LEDXUNwmf5Ln9eWCbHU11v8YZTvKiffvP4Npi/YLZWbwZr/QBN+GOC2
         rjCQHqooXpwwSlsBeS91jQLp8PEHs1i1TzwKPN7vHmlCbza5MQc0QFt9w3qXtE3fQCg3
         2wpoZECmMZytu/ILboAM4/mNjlUt6uEMGpkAs0teVum89WQ2uOri9TWY5qZ/GEBDW0C1
         q+SmlZ+0ck2gU0z8y+krzFt1ndX4W/+4AWReVNqtM0JH8XPko2IJe5JSLQSwT0ArAy+8
         0RX3wW9hYRWo9l1ZFfrvZu5rzuAXm2EVsBdnX+GtATrdjDF0QcOTMBSZkfycmceWtifd
         gURA==
Received: by 10.182.131.3 with SMTP id oi3mr5296211obb.84.1358257702689; Tue,
 15 Jan 2013 05:48:22 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 15 Jan 2013 05:47:52 -0800 (PST)
In-Reply-To: <87ehhmr28g.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213636>

On Tue, Jan 15, 2013 at 8:43 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> These variables are user parameters to control how to run the perf
>> tests. Allow users to do so.
> [...]
>> @@ -86,6 +86,9 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH"=
 -e '
>>               PROVE
>>               VALGRIND
>>               PERF_AGGREGATING_LATER
>> +             PERF_LARGE_REPO
>> +             PERF_REPEAT_COUNT
>> +             PERF_REPO
>>       ));
>
> Wouldn't it be more futureproof to put simply PERF as an entry, and r=
ely
> on the leading-match logic
>
>>       my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
>
> to allow all GIT_PERF variables?

Yeah.

> Other than that, Ack.  I never noticed because I set mine through
> config.mak, which goes to GIT-BUILD-OPTIONS.  Those options are not
> exported, which means perl does not pick them up.  (That just took me
> far too long to realize.)

By the way is there an option to skip the first few runs (too lazy to
check out the source code, apparently)? I tried linux-2.6 as the large
repo and I think the first (cold cache) run ruins the numbers.
--=20
Duy
