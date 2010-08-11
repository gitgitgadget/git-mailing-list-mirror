From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 11:20:39 +0300
Message-ID: <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com> 
	<AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com> 
	<20100809234620.GA6418@burratino> <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com> 
	<20100811075503.GD5450@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:21:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6Ye-0002jT-NP
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493Ab0HKIVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 04:21:03 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59536 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab0HKIVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 04:21:00 -0400
Received: by pxi10 with SMTP id 10so374300pxi.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:21:00 -0700 (PDT)
Received: by 10.142.131.20 with SMTP id e20mr14007972wfd.83.1281514860182; 
	Wed, 11 Aug 2010 01:21:00 -0700 (PDT)
Received: by 10.142.178.20 with HTTP; Wed, 11 Aug 2010 01:20:39 -0700 (PDT)
In-Reply-To: <20100811075503.GD5450@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153201>

Hi;

On Wed, Aug 11, 2010 at 10:55 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> =C4=B0smail D=C3=B6nmez wrote:
>
>> [~]> printf 'Th\360\235\204\236s\n' | sed 's/.*//g'
>>
>> [ismail@havana][08:51:06]
>> [~]>
>
> Thanks for checking. =C2=A0So sed is not completely broken. =C2=A0Cou=
ld you try
>
> =C2=A0sh t4201-shortlog.sh
> =C2=A0cd "trash directory.t4201-shortlog"
> =C2=A0git log
> =C2=A0cat "trash directory.t4201-shortlog/log"

=46irst of all note that this is not Mac's default sed but instead GNU =
sed:

GNU sed version 4.2.1
Copyright (C) 2009 Free Software Foundation, Inc.

Now the output of what you requested;

[~/Sources/git/t]>  sh t4201-shortlog.sh
ok 1 - setup
not ok - 2 default output format
#=09
#		git shortlog HEAD >log &&
#		fuzz log >log.predictable &&
#		test_cmp expect.template log.predictable
#=09
ok 3 - pretty format
ok 4 - --abbrev
ok 5 - output from user-defined format is re-wrapped
ok 6 - shortlog wrapping
ok 7 - shortlog from non-git directory
ok 8 - shortlog encoding
# failed 1 among 8 test(s)
1..8
[ismail@havana][11:18:24]
[~/Sources/git/t]>  cd "trash directory.t4201-shortlog"
[ismail@havana][11:18:33]
[~/Sources/git/t/trash directory.t4201-shortlog]> git log
commit ef6c19b4846d6a3e41f9a3ce746a3bffae653c17
Author: J=C3=B6h=C3=A4nn=C3=ABs "Dsch=C3=B6" Schind=C3=ABlin <Johannes.=
Schindelin@gmx.de>
Date:   Wed Aug 11 08:18:24 2010 +0000

    set a1 to 3 and some non-ASCII chars: =C3=A1=C3=A6=C3=AF

commit d7c0787d081716755e2863f612d171846f503d4f
Author: J=C3=B6h=C3=A4nn=C3=ABs "Dsch=C3=B6" Schind=C3=ABlin <Johannes.=
Schindelin@gmx.de>
Date:   Wed Aug 11 08:18:24 2010 +0000

    set a1 to 2 and some non-ASCII chars: =C3=84=C3=9F=C3=B8

commit 7e9687adfe33f5d2050f0fc4ab5004f324d3559f
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    Test

[~/Sources/git/t/trash directory.t4201-shortlog]> cat log
commit 5fc75f5794d1cd8575fc3e2e86f9c0e1aa31723e
Author: Someone else <not!me>
Date:   Wed Aug 11 08:18:24 2010 +0000

    Commit by someone else

commit 0f5955f471a9d882b0e869752614b5123af19da3
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    a								12	34	56	78

commit 0bb7d083233c266d9051b283913bd83000c9001f
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    Th????s ????s a very, very long f????rst l????ne for the comm????t
message to see ????f ????t ????s wrapped correctly

commit 03a5a848c658751c51925127820491bf2a94a752
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    Th=F0=9D=84=9Es =F0=9D=84=9Es a very, very long f=F0=9D=84=9Erst l=F0=
=9D=84=9Ene for the comm=F0=9D=84=9Et message
to see =F0=9D=84=9Ef =F0=9D=84=9Et =F0=9D=84=9Es wrapped correctly

commit fdfc106190118f705dee70b56930764007353922
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    This is a very, very long first line for the commit message to see
if it is wrapped correctly

commit 7e9687adfe33f5d2050f0fc4ab5004f324d3559f
Author: A U Thor <author@example.com>
Date:   Wed Aug 11 08:18:24 2010 +0000

    Test
