From: J Smith <dark.panda@gmail.com>
Subject: Re: grep.patternType
Date: Fri, 5 Oct 2012 01:38:15 -0400
Message-ID: <CADFUPgfkm9kAFguodP1N23B2GHNbCQ86bu=s6rZ0eH0T4inmOQ@mail.gmail.com>
References: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org> <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <7vmx032of1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	=?ISO-8859-2?Q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2Bd-00061j-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab2JEHS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 03:18:56 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33667 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2JEHSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:18:55 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1417199oag.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WdMOLex16BrYBo71Gx04YqSwFQeWb72uYJZ9o3+592k=;
        b=zHbFEMka/iFI7Q9V2WDGFZM/A7DidWKDDQFlGx6bNhbySpUSYPdPeNiJMOUYosUiSO
         DNErZUsaq+Ru7XZ/dK1I+BX82RREK6yMOylOk692Ezt2y1E28y1Obtq19K5wLYfLlrvE
         BSGzQ40q2OqCTB47bAbYSDSOteJqGNwql3IOaHmuwuulY1fQUQ3AiIJbpqQFGeB8KjRc
         qGDq060NcOip8dShHeY41/K1CIhLM3SH5dTxbCApRKOMLZ7nN0lk5EUOc7Zq1CKAtYpu
         oj2gFSpVS3h3doYhrvLG/U5ci6oWtxdn9uL0005876aRX22aKQaTJ1nWlD88EQqZTL1i
         SB/Q==
Received: by 10.60.11.67 with SMTP id o3mr6468814oeb.43.1349415515616; Thu, 04
 Oct 2012 22:38:35 -0700 (PDT)
Received: by 10.76.174.40 with HTTP; Thu, 4 Oct 2012 22:38:15 -0700 (PDT)
In-Reply-To: <7vmx032of1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207081>

On Wed, Oct 3, 2012 at 6:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  * "git grep" learned to use a non-standard pattern type by default if
>>>    a configuration variable tells it to.
>>
>> This addition makes
>>
>>     git grep -e "(integer|buffer)"
>>
>> work as expected, when grep.patternType is set to "extended".
>>
>> Should this
>>
>>     git log --grep="(integer|buffer)"
>>
>> also honor the same configuration variable?  If not, why not?
>>
>> One more thing.  Currently you can say
>>
>>     git log -E --grep="(integer|buffer)"
>>
>> to ask for the ERE.  Should we also support -P to ask for pcre?  If
>> not, why not?
>
> Answering to myself who has been in tying-loose-ends mode.
>
> My answers to these questions are both yes, and I have a neatly
> lined up series that begins with a small bugfix and then
> enhancement, but I do not think these do not deserve to in the
> upcoming release.  The topic came too late, and even the fix is
> for a bug that has been with us for a long time.

Yeah, I think that could be useful and consistent. I took a look at
the grep situation in the log command briefly when writing the
original patch but ended up leaving it as-is as for the time being due
to time constraints and the like. But yeah, that behaviour is
definitely desirable. I think any commands that work with grep should
probably follow suit, for that matter. (Are there others other than
log and grep itself...?)
