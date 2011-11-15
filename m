From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/5] sequencer: factor code out of revert builtin
Date: Tue, 15 Nov 2011 18:18:33 +0900
Message-ID: <buo4ny5u4k6.fsf@dhlpc061.dev.necel.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-2-git-send-email-artagnon@gmail.com>
 <20111106001232.GC27272@elie.hsd1.il.comcast.net>
 <CALkWK0n7v15n_s3CNq1Qu3LHjYkV-ENAkv2b+oB+VBkyV+Sphw@mail.gmail.com>
 <7vvcqnmxeu.fsf@alter.siamese.dyndns.org>
 <CALkWK0mtmRYyFosQNJixhheUmHpRjWc4A5zPQ6AaBfmw4H4eLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:18:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQFAF-0001un-Ae
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab1KOJSm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 04:18:42 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:42436 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab1KOJSl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 04:18:41 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUP008B9374KEE0@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 18:18:40 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LUP00DDC3745590@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 18:18:40 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 0891E48087; Tue, 15 Nov 2011 18:18:40 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 0109648070; Tue,
 15 Nov 2011 18:18:40 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id UAD08878; Tue,
 15 Nov 2011 18:18:39 +0900
X-IronPort-AV: E=Sophos;i="4.69,513,1315148400";   d="scan'208";a="54853547"
Received: from unknown (HELO relay51.aps.necel.com) ([10.29.19.60])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 15 Nov 2011 18:18:39 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.50])
	by relay51.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAF9IdC4020872;
 Tue, 15 Nov 2011 18:18:39 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id B376952E283; Tue,
 15 Nov 2011 18:18:38 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <CALkWK0mtmRYyFosQNJixhheUmHpRjWc4A5zPQ6AaBfmw4H4eLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185447>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> Junio C Hamano writes:
>> [...]
>> With that observation, it would probably make more sense if "foo.c"
>> included the headers in the following order:
>>
>> =A0- Anything the declarations in "foo.h" depends on;
>> =A0- "foo.h" itself; and finally
>> =A0- Other headers that "foo.c" implementation needs.
>>
>> That way, people who want to use "foo.h" can guess what needs to be
>> included before using "foo.h" a lot more easily.
>
> That's a good rule-of-thumb.  Thanks :)

Does git not use the common practice of self-contained headers?

-miles

--=20
=46ast, small, soon; pick any 2.
