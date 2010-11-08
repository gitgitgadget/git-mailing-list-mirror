From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Mon, 8 Nov 2010 14:41:42 +0100
Message-ID: <201011081441.44572.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <201011081205.12191.jnareb@gmail.com> <AANLkTikK1C5zzfOKSucPhOAQV3E=mrOunpyv4NhN+Od6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:42:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFRz3-0006Oq-Mz
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab0KHNl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 08:41:56 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56812 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab0KHNly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:41:54 -0500
Received: by bwz11 with SMTP id 11so4844568bwz.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=ImZdzzxafpQmdyYN7wY1K/m0kJSEJEiVrKjKdjZnWEE=;
        b=HikGjq48rmrq7/z6id5zhJtOKtIRKq/zeWcPzj/P3jYB72I6AjEBuSVjHPiHLnJ6P7
         vSmYvpGDODkKyBiCWlrah6YPmZ5pdcBJtTQg+5heWGTYImuJ0LA+a0V7cmDhyIxsIDYc
         yahn9wVQ3OXAVM1sm+S8z70fdrAff8YdBcD54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=La9ESbdZKG/H+UvdsahWA8DEDpWIKqZkPzNAga/ybkKUxr5mM94JhwRmK7iG6ch9/F
         0R2GbXKwrCXER9TGHd90eABM6SxdqesVYNDmApHh2BkrDwPA5Pbr/2skKo3I2ER+u2hs
         a/mWjIcBsuc3wd88IwYuBhb/c4w1EUXWPubV0=
Received: by 10.204.60.12 with SMTP id n12mr4979440bkh.61.1289223713123;
        Mon, 08 Nov 2010 05:41:53 -0800 (PST)
Received: from [192.168.1.13] (abvu240.neoplus.adsl.tpnet.pl [83.8.218.240])
        by mx.google.com with ESMTPS id g8sm3873954bkg.11.2010.11.08.05.41.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 05:41:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikK1C5zzfOKSucPhOAQV3E=mrOunpyv4NhN+Od6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160938>

On Mon, Nov 8, 2010, Giuseppe Bilotta napisa=B3:
> On Mon, Nov 8, 2010 at 12:05 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Mon, 8 Nov 2010, Giuseppe Bilotta wrote:
>>> On Thu, Nov 4, 2010 at 11:41 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:
>>>> On Wed, 3 Nov 2010, Giuseppe Bilotta wrote:
[...]
>>>> BTW. would next version of this series include patch to git-instaw=
eb
>>>> enabling 'remote_heads' feature for it (gitweb_conf function)?
>>>
>>> I will look into that.
>>
>> It can be as simple as
>>
>> diff --git i/git-instaweb.sh w/git-instaweb.sh
>> index e6f6ecd..50f65b1 100755
>> --- i/git-instaweb.sh
>> +++ w/git-instaweb.sh
>> @@ -580,6 +580,8 @@ gitweb_conf() {
>> =A0our \$projectroot =3D "$(dirname "$fqgitdir")";
>> =A0our \$git_temp =3D "$fqgitdir/gitweb/tmp";
>> =A0our \$projects_list =3D \$projectroot;
>> +
>> +$feature{'remote_heads'}{'default'} =3D [1]
>> =A0EOF
>> =A0}
>=20
> Thanks.

I forgot about trailing semicolon.  It should be:

    +$feature{'remote_heads'}{'default'} =3D [1];

>>> Either solution is fine, but it would require grabbing all the remo=
te
>>> heads. The real issue here is, I think understanding what is the
>>> purpose of limiting in gitweb. Is it to reduce runtime? is it to
>>> reduce clutter on the screen? In the first case, the limiting shoul=
d
>>> be done as early as possible (i.e. during the git call that retriev=
es
>>> the data); in the latter case, is it _really_ needed at all?
[...]

>> Regarding gitweb performance, it is quite important to pass limit to
>> git-log / git-rev-list needed also for 'summary' view; passing limit
>> to git command really matters here.
>>
>> git_get_heads_list passes '--count=3D'.($limit+1) to git-for-each-re=
f,
>> but I don't think that it improves performance in any measurable way=
=2E
>> Similar with saving a memory: it is negligible amount. =A0So if we c=
an
>> do better at the cost of running git_get_heads_list without a limit,
>> I say go for it.
>=20
> The gain in performance is, I believe, related to the number of heads
> and the number of remotes that are to be enumerated. 11 remotes with =
a
> total of 58 remote branches (the case you mentioned, for example)
> might not feel much of a difference between pre- and post-filtering,
> but something bigger might start to feel the effect.

Actually I would guess it would depend on what git-for-each-ref does
it.  I would guess that git-for-each-ref reads in all refs anyway,
the limit only matters if format contains fieldnames that need accessin=
g
the object,... like e.g. '%(subject)' which git_get_heads_list requests=
,
but git_heads_body doesn't use.  Ehh...
=20
> I think the strongest point in favour of post-filtering is that the
> feature is intended for use mostly for local repositories anyway.

True.
=20
>> Note that the costly part of git_get_heads_list is forking git comma=
nd,
>> so it makes absolutely no sense to run git_get_heads_list once per
>> remote instead of doing limiting per-remote in Perl. =A0The former w=
ould
>> affect performance badly, I can guess.
>=20
> That is indeed the reason why I chose to go the single call way, even
> though it meant having the limit end up being used somewhat
> incorrectly.

I think that single call and post-filtering would be reasonable=20
compromise: reasonable performance (single fork), and correct results.

--=20
Jakub Narebski
Poland
