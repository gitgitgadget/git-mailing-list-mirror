From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 3 Apr 2015 14:32:24 -0700
Message-ID: <51689E6C-93FD-4E77-8FF3-BB8EC7EA735A@gmail.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com> <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net> <551DD887.2010403@web.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"Reid Woodbury Jr." <reidw@rawsound.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org list" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:32:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9Cb-0004Bv-0G
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbDCVc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 17:32:29 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34096 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbDCVc1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 17:32:27 -0400
Received: by pactp5 with SMTP id tp5so127269184pac.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=SUWWCIJn6aKNnZ+N4oNMp8GuSCrYyDSybZx8iKXUDRU=;
        b=xYVjiwIYSRwY6chPzWajg057mZSM7Lnx2RfMkbbItS6iLJtzeWTqVdpI6q4ws4UDM2
         Mwse2qSa93RJuwIRfRhuTvNlX0mCTL0kcL6PEYPYf9/URZ7+qgWw/n8mJE24pgWiNGUq
         ZKuJsG0sX0F8vjmSD4SNpgdXazZPIjY9LY78AR9+54pHyU1BslwbjWjc8BahJR4Eut9d
         oYd60NjR2k+tur9ViQKTiefaD03ZN1mTKcUFKWgDoRLyG0H0ao77NEZs70v3gYRkJhDK
         UcE3LArWr7p4SBnMc26CwSMxjGpsqchYeg3IJA0JH5vv7Qv4YDkqNCTZb4sxuujLsCkK
         977A==
X-Received: by 10.68.110.195 with SMTP id ic3mr7410150pbb.124.1428096747512;
        Fri, 03 Apr 2015 14:32:27 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id da2sm8967446pbb.75.2015.04.03.14.32.25
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 Apr 2015 14:32:26 -0700 (PDT)
In-Reply-To: <551DD887.2010403@web.de>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266732>

On Apr 2, 2015, at 17:02, Torsten B=F6gershausen wrote:

> On 2015-04-02 21.35, Jeff King wrote:
>> On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:
>>
>>> Ah, understand. Here's my project URL for 'remote "origin"' with a
>>> more meaningful representation of their internal FQDN:
>>>
>>> 	url =3D ssh://rwoodbury@systemname.groupname.online:/opt/git/inven=
tory.git
>>>
>>> The "online" is their literal internal TLD.
>>
>> Thanks. The problem is the extra ":" after "online"; your URL is
>> malformed. You can just drop that colon entirely.
>>
>> I do not think we need to support this syntax going forward (the =20
>> colon
>> is meaningless here, and our documentation is clear that it should g=
o
>> with a port number), but on the other hand, it might be nice to be =20
>> more
>> liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten =20
>> to see
>> whether supporting that would hurt some of the other cases, or =20
>> whether
>> it would make the code too awkward.
>>
>> -Peff
>
> Thanks for digging.
>
> This makes my think that it is
> a) non-standard to have the extra colon

It's not.  See RFC 3986 appendix A:

   authority =3D [ userinfo "@" ] host [ ":" port ]

   port =3D *DIGIT

"*DIGIT" means (see RFC 2234 section 3.6) zero or more digits.

> b) The error message could be better
> c) We don't have a test case
> d) This reminds my of an improvement from Linus:
> 608d48b2207a61528
> ......
>    So when somebody passes me a "please pull" request pointing to =20
> something
>    like the following
>
>    	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.gi=
t
>
>    (note the extraneous colon at the end of the host name), git =20
> would happily
>    try to connect to port 0, which would generally just cause the =20
> remote to
>    not even answer, and the "connect()" will take a long time to =20
> time out.
> .....
>
> Sorry guys for the regression, the old parser handled the extra =20
> colon as "port 0",
> the new one looks for the "/" as the end of the hostname (and the =20
> beginning of the path)
>
> Either we accept the extra colon as before, or the parser puts out a =
=20
> better error message,

[...]

> Spontaneously I would say that a trailing ':' at the end of a =20
> hostname in the ssh:// scheme
> can be safely ignored, what do you think ?

You know, there is a "url_normalize" routine in urlmatch.h/urlmatch.c =20
that checks for a lot of these things and provides a translated error =20
message if there's a problem as well as normalizing and separating out =
=20
the various parts of the URL.  It does not currently handle default =20
ports for anything other than http[s] but it would be simple enough to =
=20
add support for ssh, git, ftp[s] and rsync default ports too.

-Kyle