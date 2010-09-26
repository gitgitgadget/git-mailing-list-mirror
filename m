From: Andreas Ericsson <ae@op5.se>
Subject: Re: Minimum Perl version?
Date: Sun, 26 Sep 2010 12:22:23 +0200
Message-ID: <4C9F1EDF.1030104@op5.se>
References: <20100924100019.GT23563@ece.pdx.edu>	<AANLkTin_wrCnpz-fz=FuJ96j+xBHM1-5HTGG0vP7bmDY@mail.gmail.com>	<20100924204032.GU23563@ece.pdx.edu> <AANLkTinQQxsbUHiKLaCJ0b5-dcvdE4JhLMVWOV5P2bkh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 12:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzoNT-0006Gb-AN
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 12:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0IZKW3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 06:22:29 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48734 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756075Ab0IZKW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Sep 2010 06:22:28 -0400
Received: from source ([209.85.215.45]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTJ8e4+ws5gzLPkaMT8ykLnahgMFPwr8u@postini.com; Sun, 26 Sep 2010 03:22:28 PDT
Received: by ewy27 with SMTP id 27so1926142ewy.18
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 03:22:27 -0700 (PDT)
Received: by 10.213.34.208 with SMTP id m16mr4671053ebd.87.1285496546832;
        Sun, 26 Sep 2010 03:22:26 -0700 (PDT)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id u9sm6429438eeh.11.2010.09.26.03.22.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 03:22:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <AANLkTinQQxsbUHiKLaCJ0b5-dcvdE4JhLMVWOV5P2bkh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157219>

On 09/25/2010 12:39 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Fri, Sep 24, 2010 at 20:40, Tait<git.git@t41t.com>  wrote:
>>>> What is the minimum Perl version git expects to support?
>>>>
>>>> I ask, because f922df8... seems to have introduced a open() syntax=
 that
>>>> is not compatible with some older Perl versions.
>>>
>>> We generally support 5.6 or above, but 5.8 or above for some other
>>> programs.
>>
>> I am having to use a system with 5.6.1 to do cvsimport and cvsexport=
commit,
>> and interactive add. I haven't tried sendmail or other functions, ye=
t. This
>> system was previously using git 1.6.5.something, and did not have th=
ese
>> problems as of that release, but now that I'm building git 1.7.3, th=
ey
>> have appeared.
>=20
> Maybe marking everything as needing 5.8 or later isn't the right thin=
g
> to do. E.g. the git-*cvs*.perl code mostly isn't touched, but
> cvsexportcommit does use Git.pm, so that would also need to be pinned
> at 5.6 if cvsexportcommit was.
>=20
>> Perl 5.6.1 doesn't support the list open syntax, so one must replace
>> open(my $fh, '-|', @list) with open(my $fh, '-|'), and then exec(@li=
st).
>> I'm working up a patch set to fill my own needs on this system, but =
based
>> on the subsequent discussion about setting 5.8 as the minimum, it so=
unds
>> like it's not worth submitting.
>=20
> The issue isn't that we don't have a workaround for individual bits
> like open(my $fh, '-|', @list), but rather that keeping all of the
> code 5.6 compatible is a burden on ongoing maintenance for a very
> marginal benefit.

If someone steps up and makes various snippets of code 5.6 compatible w=
hile
not introducing any penalties for 5.8 users, I see no reason to drop th=
ose
patches.

Tait, submit your patches and I'm sure they'll be reviewed the same as
everything else. If they make the code a lot harder to understand or a =
lot
slower, I'm sure they'll be dropped. If they don't, I'm reasonably cert=
ain
Junio will take them on. I barely speak Perl though, so reviewing them =
will
have to be done by someone else.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
