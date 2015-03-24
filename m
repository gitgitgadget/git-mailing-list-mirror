From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 24 Mar 2015 18:39:50 +0100
Message-ID: <5511A166.3090009@alum.mit.edu>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>	<xmqq7fudld61.fsf@gitster.dls.corp.google.com>	<551185D9.6050200@alum.mit.edu> <xmqq619q8k0h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSoI-0000cZ-US
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbbCXRkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 13:40:06 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:65437 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753598AbbCXRkB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 13:40:01 -0400
X-AuditID: 12074414-f797f6d000004084-3d-5511a169ed63
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 23.F5.16516.961A1155; Tue, 24 Mar 2015 13:39:53 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9745A.dip0.t-ipconnect.de [79.201.116.90])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2OHdox7015963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Mar 2015 13:39:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqq619q8k0h.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1M1cKBhq8Ocss0XXlW4mi4beK8wW
	j29NYHJg9ph739Lj4iVlj8+b5AKYo7htkhJLyoIz0/P07RK4M443NjEVnBKruNN/lrmBsV2o
	i5GTQ0LAROL45FXMELaYxIV769m6GLk4hAQuM0q0zZjHDuGcZ5J4ce05G0gVr4C2xKQ17xlB
	bBYBVYkdn96xg9hsAroSi3qamUBsUYEgiZe3/jJC1AtKnJz5hAXEFhFQk5jYdgjMZhYwkph1
	4wwriC0sEC6x9N5sJohlBxklnq88BzaIU8Ba4nrPaaAGDqAGdYn184QgeuUlmrfOZp7AKDAL
	yYpZCFWzkFQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESuCI7GI+c
	lDvEKMDBqMTDG7BEIFSINbGsuDL3EKMkB5OSKG/DLMFQIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK8z9uBcrwpiZVVqUX5MClpDhYlcd5vi9X9hATSE0tSs1NTC1KLYLIyHBxKErxNC4AaBYtS
	01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/Q3haQdt7igsRcoChE6ylG
	RSlx3iyQhABIIqM0D24sLB29YhQH+lKYlxmkigeYyuC6XwENZgIafC6fD2RwSSJCSqqBUcZP
	2Dxx1s/65SmpDS96Yp06HZwa5z4+VCteKSt/xrM08ZpKkxYTU+ZdhccmayY2nCwyK/369l3W
	BgetRayTbumffrsjNvv0aVa+lO7ZggIFBn6zji/8t/9LAc8y/y81D7grPvyxFdt+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266209>

On 03/24/2015 04:58 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> It is easy to allow "--abbrev=3D+7"; I would just need to add NUM_PL=
US to
>> those call sites. Should I do so?
>=20
> The more relevant question to ask from my point of view is why you
> need to "add" NUM_PLUS to "enable" it.  What valid reason do you
> have to forbid it anywhere?  Only because you do not accept it by
> default, you need to "add" to "enable".

I want to be able to plunge into this project without first auditing al=
l
call sites to see which features will turn out to be needed. So I'm
erring on the side of flexibility. For now, I want to be able to
prohibit '+' signs.

Currently all of the flags cause additional features to be enabled. My
guess was that most callers *won't* need most features, so it seemed
easiest and most consistent to have all features be turned off by
default and let the caller add the features that it wants to allow.

Regarding specifically allowing/disallowing a leading '+': I saw a
couple of callsites that explicitly check that the first character is a
digit before calling strtol(). I assumed that is to disallow sign
characters [1]. For example,

    diff.c: optarg()
    builtin/apply.c: parse_num()
    maybe date.c: match_multi_number()

There are other callsites that call strtoul(), but store the result in =
a
signed variable. Those would presumably not want to allow leading '-',
but I'm not sure.

I also imagine that there are places in protocols or file formats where
signs should not be allowed (e.g., timestamps in commits?).

>>> Why is it a problem to allow "git cmd --hexval=3D0x1234", even if "=
git
>>> cmd --hexval=3D1234" would suffice?
>>
>> In some cases we would like to allow that flexibility; in some cases
>> not. But the strtol()/strtoul() functions *always* allow it.
>=20
> The same issue.  Whare are these "some cases"?

I admit I'm not sure there are such places for hexadecimal numbers.

I'm coming around to an alternate plan:

Step 1: write a NUM_DEFAULT combination-of-options that gives the new
functions behavior very like strtol()/strtoul() but without their insan=
e
features.

Step 2: rewrite all callers to use that option (and usually endptr=3DNU=
LL,
meaning no trailing characters) unless it is manifestly clear that they
are already trying to forbid some other features. This will already
produce the largest benefit: avoiding overflows, missing error checking=
,
etc.

Steps 3 through =E2=88=9E: as time allows, rewrite individual callsites=
 to be
stricter where appropriate.

Hopefully steps 1 and 2 will not be too controversial.

Michael

[1] That assumption is based on a rather quick look over the code,
because with well over 100 callsites, it is not practical to study each
callsite carefully.

--=20
Michael Haggerty
mhagger@alum.mit.edu
