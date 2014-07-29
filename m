From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: "error: Tweaking file descriptors doesn't work with this MSVCRT.dll"
 on wine
Date: Tue, 29 Jul 2014 14:20:11 +0200
Message-ID: <53D7917B.8060100@redhat.com>
References: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com> <53D73F7D.1010902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 14:19:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC6NO-0007Pk-Hq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 14:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbaG2MT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 08:19:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41278 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaG2MT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 08:19:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TCJOYG005655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2014 08:19:24 -0400
Received: from brasov.str.redhat.com (brasov.str.redhat.com [10.33.193.1])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s6TCJLOU000823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2014 08:19:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <53D73F7D.1010902@web.de>
X-Enigmail-Version: 1.6
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254424>

On 07/29/2014 08:30 AM, Torsten B=C3=B6gershausen wrote:
> On 07/28/2014 12:39 PM, Duy Nguyen wrote:
>> I know wine is kind of second citizen but is there a cheap trick to
>> make it work on wine? Reverting fcd428f (Win32: fix broken pipe
>> detection - 2012-03-01) could result in conflicts in compat that I'm
>> not comfortable resolving. I don't have Windows at home. Wine is the
>> only option for me (or if somebody has a modern.ie image for KVM, or=
 a
>> simple recipe to make one, that'd be great). "Fix wine" is not reall=
y
>> an option.
Why is fixing Wine not an option? The guy working on MSVCRT in Wine is
very responsive; all that is needed is just a bug in
https://bugs.winehq.org/ and he'll look at it. Or give me more details
and I'll create the bug entry.

> Is it only that patch that needs to be reverted to make things work g=
ot
> wine?
> For me It seems as if the patch is not that huge, and manually do a
> copy-paste
> with the help of a diff tool can be done.
>=20
> It seems as if even both implemenations can live side-by-side in the =
code.
> And if there is a run-time detection for wine, we could switch betwee=
n the
We frown upon detecting Wine just to workaround bugs there.
If one insists on workarounding Wine then please detect the broken
behavior instead. That way the app will automatically use the default
code path once Wine is fixed.

> old one and the new one which is dependent on how MSVCRT.dll has laye=
d out
> internal data structures:
>  "ioinfo structure (exposed by MSVCRT.dll via  __pioinfo"

bye
	michael
