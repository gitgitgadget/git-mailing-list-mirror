From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n
Date: Wed, 23 Feb 2011 22:00:35 -0600
Message-ID: <20110224040035.GE7970@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
 <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 05:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsSNj-0001Rw-3J
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 05:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399Ab1BXEAl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 23:00:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57756 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332Ab1BXEAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 23:00:41 -0500
Received: by vws12 with SMTP id 12so119629vws.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 20:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=diNEQHnASr704dccwhl2UvbapyltpQBX6mqxylceErU=;
        b=YettDv6l/p3Vu8+lM5N1LQUgSQttuHPXdDbs32AZ9FYXgsAIkK7U4X40xpt0NFQLGr
         k1Fqj3NT9QBEf3LH0ozulvnyThTcCV4VHOjKPokTZdknnHLNMNcWABrK2+vKFoFX0vzF
         qxivQkbtrwZdNYS+eImiDFBrkEJauJnRULWzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YNvS3r/YMIrl/t0K8F+vzlhA5u3NxXlshpkwv3DjO61cgaxTKDtFFpn/YDddbPOMjy
         ja43WZMF0iZHIjFL5Jiu1Y+ECszO9+fldoGwgK6CrUPTWU1+/XQ51nPH8E1rjOe2vIGM
         M8anVW1NbxpUKuJmvsWzG95ipmxHZMHNCJZ4Q=
Received: by 10.52.164.3 with SMTP id ym3mr538268vdb.240.1298520040116;
        Wed, 23 Feb 2011 20:00:40 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u14sm4010102vcr.1.2011.02.23.20.00.38
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Feb 2011 20:00:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167775>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Feb 24, 2011 at 02:16, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> I still don't like the #-sign business in this commit. =C2=A0Couldn=
't it
>>> be split into a separate patch, not to be applied until just before
>>> the strings in commit/tag/wt-status are marked for translation?
>>
>> That might be a sensible thing to do. =C2=A0 =C3=86var what do you t=
hink?
>
> It could, but I don't want to spend time on it.

That doesn't answer the question, does it?  The question is whether
you'd be okay with the change (in which case we should do it --- it's
not like there's a shortage of people willing to write a one-line
patch) or not (in which case we shouldn't).

>> Yeah I would imagine it would leak. =C2=A0Also blindly running rot13=
 to turn %d
>> into %q is probably not what you want.

The rot13 patch turns %d into 5q (and 5q into "d).  I think that
aspect can wait for later, of course --- a fixed string is not
actively bad or confusing.

> Of course there might be cases where a test will fail because it's
> supposed to end in \n but the poison string doesn't, but since none o=
f
> them did I didn't worry about that.

Right, that's a downside to the rot13 patch --- it takes \n to \n so
it wouldn't catch such cases.  Easily fixable, though.

> I'd much
> rather have a few more tests skipped under this poison mode than 20
> extra lines of C code that effectively give us nothing

No disagreement here.  I think some cases (e.g., adding '# ' before
each line of the translated status hints) would give us something,
namely protection against hard-to-debug translation bugs.

Sorry for the grouchiness, and hope that helps.
Jonathan
