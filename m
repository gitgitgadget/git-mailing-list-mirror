From: John Szakmeister <john@szakmeister.net>
Subject: Re: pre-commit hook to reject whitespace
Date: Fri, 3 Jun 2011 20:12:45 -0400
Message-ID: <BANLkTi=Gh9CStVkgp5gBs7XzG-dCXB+oUw@mail.gmail.com>
References: <isbqsf$vh8$1@dough.gmane.org>
	<isbsf8$6id$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:12:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeU0-0004lf-3V
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab1FDAMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2011 20:12:47 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39238 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab1FDAMq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2011 20:12:46 -0400
Received: by wwa36 with SMTP id 36so2156885wwa.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I/j6y0onRmNAtWsZhs/3oWCd0n/Z8SQST3zCyBGH4Oc=;
        b=RLrD4LxNcBZeeBYeiXpfXBZ7srWkyrewk6u/bFXJjFLFsNt/s0GEXWFUKvH5lu1MjA
         GeeE+seUSQLddMsP1hhDjnyxqfUamI1fD1hI0kPI1wMGM55WdwoXrhDaH9AVNP0ZoEgJ
         CNN6RGOLgD9ptN38KPhy5pFRbS7xLuNLaZMYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=fXyCBI8nbvChL/MTZz/MIcrWaSYp3DcCC3hGS44paBzMZB7Xkc+GAInKFMy4vpruBi
         xHMZQ1KJJy34PEDq6adlUMPVKzdm/V843X9csla8Dj/F+59LZTNrW320e7Ik6QiJqzvH
         JGKyB8/ee3gXw+5aOo6RmHPxkld9QtQXfRS6Q=
Received: by 10.216.132.133 with SMTP id o5mr2087wei.94.1307146365325; Fri, 03
 Jun 2011 17:12:45 -0700 (PDT)
Received: by 10.216.89.212 with HTTP; Fri, 3 Jun 2011 17:12:45 -0700 (PDT)
In-Reply-To: <isbsf8$6id$1@dough.gmane.org>
X-Google-Sender-Auth: 7sQ9yameWk3NECa7yj9VuiHASOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175051>

On Fri, Jun 3, 2011 at 7:58 PM, Neal Kreitzinger <nkreitzinger@gmail.co=
m> wrote:
> On 6/3/2011 6:31 PM, Neal Kreitzinger wrote:
>>
>> The reference manuals state in the hooks documentation that the pre-=
commit
>> hook sample will reject whitespace only changes. =C2=A0However, the
>> pre-commit.sample in the 1.7.1 and 1.7.5.4 downloads do not appear t=
o do
>> this (I'm new to linux scripts). =C2=A0The appear to only reject non=
-ascii
>> filenames. =C2=A0Does someone have a pre-commit hook example I can u=
se to
>> reject
>> whitespace-only changes? =C2=A0Thanks!
>>
> As someone kindly pointed out, the documentation actually says:
> "The default 'pre-commit' hook, when enabled, catches introduction of=
 lines
> with trailing whitespaces and aborts the commit when such a line is f=
ound."
>
> I'm not seeing this functionality in the pre-commit.sample for 1.7.1 =
or
> 1.7.5.4.

I've never tried that hook script myself, but it appears to be on the l=
ast line:
   exec git diff-index --check --cached $against --

In particular, the --check option says:
    Warn if changes introduce trailing whitespace or an indent that
uses a space before a tab. Exits with non-zero status if problems are
found. Not compatible with --exit-code.

HTH!

-John
