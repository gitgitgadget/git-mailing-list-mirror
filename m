From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 7/9] submodule: teach unpack_trees() to remove submodule
 contents
Date: Fri, 07 Feb 2014 22:24:58 +0100
Message-ID: <52F54F2A.6050305@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com> <52EFF25E.6080306@web.de> <52EFF391.7040503@web.de> <20140203201052.GB16057@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:25:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsv6-00039W-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbaBGVZB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Feb 2014 16:25:01 -0500
Received: from mout.web.de ([212.227.15.3]:64718 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbaBGVZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:25:00 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lb1wz-1VVyVv49m5-00kehU for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140203201052.GB16057@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:pJ6VYNPuq5Vv3aqNS+g+ruz1gJBiu2rgcr46UVEeeQKVcBYg8Bs
 gXXSf0zyrTecPAazloodJ0tZX0avXdEgtyZGLz6IRhPdPv4f7falATUxz7CSoB64/vNGso5
 ijWJL3jR0HfAWp/uIjxU3mdcOMNiqt64PQLLFoSAo84qEygePboDsT1nKDk/tytPTsCaV1T
 +rtNWwoRwxtOIZ+hUquUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241803>

Am 03.02.2014 21:10, schrieb W. Trevor King:
> On Mon, Feb 03, 2014 at 08:52:49PM +0100, Jens Lehmann wrote:
>> Implement the functionality needed to enable work tree manipulating
>> commands to that a deleted submodule should not only affect the inde=
x
>> (leaving all the files of the submodule in the work tree) but also t=
o
>> remove the work tree of the superproject (including any untracked
>> files).
>>
>> That will only work properly when the submodule uses a gitfile inste=
ad of
>> a .git directory and no untracked files are present. Otherwise the r=
emoval
>> will fail with a warning (which is just what happened until now).
>=20
> I'm having trouble parsing this one.  How about:
>=20
>   Add a depopulate_submodule helper which removes the submodule
>   working directory without touching the index.  This will only work
>   properly when the submodule uses a gitfile=E2=80=A6

Thanks, that's better.
