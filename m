From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Breakage in master since 6d4bb3833c
Date: Fri, 21 Oct 2011 16:01:01 +0200
Message-ID: <4EA17B1D.9000900@alum.mit.edu>
References: <4EA1614D.3090202@alum.mit.edu> <20111021122801.GA3799@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Oct 21 16:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHFet-00021c-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 16:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab1JUOBK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 10:01:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49978 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1JUOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 10:01:09 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9LE13AS021543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Oct 2011 16:01:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111021122801.GA3799@goldbirke>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184065>

On 10/21/2011 02:28 PM, SZEDER G=E1bor wrote:
> On Fri, Oct 21, 2011 at 02:10:53PM +0200, Michael Haggerty wrote:
>> When testing reference-handling performance using my refperf script =
[1],
>> I noticed that there is a problem in master that I bisected down to
>>
>> 6d4bb3833c "fetch: verify we have everything we need before updating=
 our
>> ref"
>>
>> When I run the following commands
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> GIT=3D$(pwd)/git
>=20
>> $GIT fetch origin
>> Then the last "git fetch origin" command gives the following output:
>> remote: Counting objects: 3, done.
>> remote: Total 3 (delta 0), reused 0 (delta 0)
>> Unpacking objects: 100% (3/3), done.
>> usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
>=20
> I suspect this is the same issue as here:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/182339/focus=
=3D182357

Yes, you are right.  Setting GIT=3D$(pwd)/bin-wrappers/git fixes the pr=
oblem.

Thanks,
Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
