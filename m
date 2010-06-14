From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Mon, 14 Jun 2010 16:44:15 +0200
Message-ID: <4C16403F.4040400@op5.se>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com> 	<1276175389-6185-2-git-send-email-artagnon@gmail.com> <20100612064250.GB2549@burratino> <AANLkTimtya1Ph5YjlFVAVpE2p4XOHvuaFAmsS4C0J5LH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 16:44:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOAuF-00038e-FB
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 16:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122Ab0FNOoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 10:44:22 -0400
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:37028 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755071Ab0FNOoV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 10:44:21 -0400
Received: from source ([209.85.214.47]) by na3sys009aob106.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTBZAQyngKzwpTCXyCBZRq2FDGdtyNyyh@postini.com; Mon, 14 Jun 2010 07:44:21 PDT
Received: by bwz14 with SMTP id 14so2457426bwz.34
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 07:44:18 -0700 (PDT)
Received: by 10.204.81.201 with SMTP id y9mr4355281bkk.144.1276526658551;
        Mon, 14 Jun 2010 07:44:18 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id v2sm19785785bkz.19.2010.06.14.07.44.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 07:44:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <AANLkTimtya1Ph5YjlFVAVpE2p4XOHvuaFAmsS4C0J5LH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149096>

On 06/14/2010 04:25 PM, Ramkumar Ramachandra wrote:
> Hi Jonathan,
>=20
> Jonathan Nieder wrote:
>>   #ifdef __GNUC__
>>   #define MAYBE_UNUSED __attribute__((__unused__))
>>   #else
>>   #define MAYBE_UNUSED
>>   #endif
>=20
> You'd suggested this earlier, but I was looking more for something
> that we could use to mark some specific functions as unused instead o=
f
> marking everything as unused in the generation macro. Anyway, I have =
a
> patch ready, and svn-fe compiles fine with -Wall -Werror.
>=20
>> Could that work here?
>>
>> The =E2=80=9Cunused=E2=80=9D attribute was added in gcc 2.7.
>=20
> Junio? Is this a good solution, or should we think of something else?
> What about other compilers?
>=20

__attribute__((stuff)) is gcc-specific. It's usually macro'd away with
#ifndef __GNUC__
#define __attribute__(x)
#endif
which is why it requires double parantheses. gcc warns for but doesn't
fail on unknown attributes, so it should be safe to use this with
gcc older than 2.7 as well. Or you make it conditional to __GNUC__
being >=3D 2 and __GNUC_MINOR__ being >=3D 7.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
