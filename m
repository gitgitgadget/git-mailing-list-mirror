From: Gavin Kistner <gkistner@nvidia.com>
Subject: Re: unpacker error on push
Date: Fri, 18 Jun 2010 10:41:30 -0700
Message-ID: <26F05D1B-E6A7-4039-B337-DA5C027A4EE5@nvidia.com>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
 <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
 <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 18 19:41:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPfZT-00032a-B1
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 19:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab0FRRle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 13:41:34 -0400
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15252 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220Ab0FRRld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 13:41:33 -0400
Received: from hqnvupgp03.nvidia.com (Not Verified[172.17.102.18]) by hqemgate03.nvidia.com
	id <B4c1bb0640001>; Fri, 18 Jun 2010 10:44:04 -0700
Received: from hqemhub01.nvidia.com ([172.17.108.22])
  by hqnvupgp03.nvidia.com (PGP Universal service);
  Fri, 18 Jun 2010 10:41:32 -0700
X-PGP-Universal: processed;
	by hqnvupgp03.nvidia.com on Fri, 18 Jun 2010 10:41:32 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.12]) by hqemhub01.nvidia.com
 ([172.17.98.26]) with mapi; Fri, 18 Jun 2010 10:41:32 -0700
Thread-Topic: unpacker error on push
Thread-Index: AcsPDX3cXgd4g5MtTi2cjRI+6W4u1Q==
In-Reply-To: <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149354>

On Jun 18, 2010, at 11:35 AM, Nicolas Pitre wrote:
> On Fri, 18 Jun 2010, Gavin Kistner wrote:
>=20
>> On Jun 16, 2010, at 1:34 PM, Nicolas Pitre wrote:
>>> On Wed, 16 Jun 2010, Gavin Kistner wrote:
>>>> Local: OS X 10.6.3, git 1.7.1
>>>> Remote: Ubuntu Lucid, git 1.7.0.4
>>>>=20
>>>> How can I fix whatever is broken so that I can push again, and=97m=
ore=20
>>>> importantly=97get the important changes I made last night over to =
the=20
>>>> remote, by hook or by crook?> -_-_-_-_-_-_-_-_-_-_ On the local=20
>>>> machine -_-_-_-_-_-_-_-_-_-_
>>>>=20
>>>> Slim2:bugbot3 phrogz$ git push
>>>> Counting objects: 70, done.
>>>> Delta compression using up to 2 threads.
>>>> Compressing objects: 100% (31/31), done.
>>>> Writing objects: 100% (40/40), 26.91 KiB, done.
>>>> Total 40 (delta 11), reused 37 (delta 8)
>>>> error: unpack failed: unpack-objects abnormal exit
>>>> To git://10.20.16.110/bugbot3.git
>>>> ! [remote rejected] planning -> planning (n/a (unpacker error))
>>>> error: failed to push some refs to 'git://10.20.16.110/bugbot3.git=
'
>>>=20
>>> Could you try doing "git config receive.unpackLimit 1" on the _remo=
te_=20
>>> machine in the receiving repository?
>>=20
>> I ran into this problem again. I backed up both repositories in full=
,=20
>> ran the command above in the remote repository, and it did not fix t=
he=20
>> problem.
>=20
> The error message changed a bit though, right?

Yes, it failed in "index-pack" instead of "unpack-objects". Here's the =
new result:
Counting objects: 116, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (63/63), done.
Writing objects: 100% (63/63), 11.19 KiB, done.
Total 63 (delta 40), reused 0 (delta 0)
error: unpack failed: index-pack abnormal exit
To git://10.20.16.110/bugbot3.git
 ! [remote rejected] planning -> planning (n/a (unpacker error))
error: failed to push some refs to 'git://10.20.16.110/bugbot3.git'



>> I deleted my local copy and cloned using ssh instead if git://, copi=
ed=20
>> over the same changes and was able to push again. This looks to be m=
y=20
>> workaround.
>>=20
>> If anyone wants to dive deeper into this problem, please let me know=
=20
>> and we can fight it using the snapshots I have.=20
>=20
> I would be interested in them.

OK, I'll coordinate with you off-list.
-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
