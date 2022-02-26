Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45262C433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 09:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiBZJkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 04:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiBZJkG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 04:40:06 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F967286A75
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645868369;
        bh=UWo+hSZJbVajfSwcZhM/NJgoIjV19ertQhOKAYVkWQ4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=q7h+RbzGY1AVCxdscwiVZrJN5n+G7FPcLHEGOoEIEx2N1eT965Ec6xCcPcOZhDyVl
         39fo2QGxd8P2W+kgAhhaOUtKePsxEMc/X6DxAHJCKPPKLNA/tLi+IHRNwOObKPse2S
         OFtkUKtbOGxyV0JbTxZlOc0wmEkj0zfLauJfXw/o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1nI6ea2Rqf-007zfn; Sat, 26
 Feb 2022 10:39:29 +0100
Date:   Sat, 26 Feb 2022 10:39:29 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Hunter Laux <hunterlaux@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git-p4 UnicodeDecodeError on ascii 0x93 character
Message-ID: <20220226093929.uujvrauwatssl2mw@tb-raspi4>
References: <CAMQF8MhTmVs_LE8Te=9EL66Py8OtAMo7APf-cC=Ot6tykvaBpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMQF8MhTmVs_LE8Te=9EL66Py8OtAMo7APf-cC=Ot6tykvaBpg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:LbmysXeFl+92L1I5DSXt424U2pWJ1xVWrU+kGnIlTH+l7VSsHgk
 Y7ECMJWPBqAOGOgez0dIBAjEbns2DKif2v45ec3L7ZQv1AK5VZ4fb1N5g7hRLzPuQ6jDX+I
 bq3gGItZPzenl3/FKc67+hN2WQKBICHoJP9J5dUdEgJk/Kd1bKH5UHFlYGsWpd+F7R7FSoP
 GZfjv0ivBEFvmWxcu30Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VkZuxw308g0=:/6emCdhIIvl/i7CeN7Y5/Q
 E9RYVx3mpPnBgpH3f9UbBAiSEFlBm6OYy1OR72C8MxpFtqnvZCo9iEIYAVRQFUD6JvFdQdnMW
 m4C4ndFGXprfz9G1PQ/ptzw7vJ01dDes6/fb5wFeg59ODio+bkhItMq3lg5yHEbUMUEj4LyqZ
 BzSrAqwGo1W/9oBm1wmI6LmjfnRPgqOH4FsX+IOMzKrsEjal7s8qo2S31/XUMb6pW6pv3Kfb0
 7kFZE8Fwh0vkMQ+Su3TlHNVCF/B4aYDChCc4NMayW9oVHokMg7UThTSHblu2Q2Wi7vX9TDPMh
 ILSgWl2dvtKwwXiJ6a0/NYUEz3UxZXbzNMwh0MTbGiQ7jUKhFYhRwVyxtTs+4ItYXg8kKiq8e
 6xw05ct7WYJNLaPaEX4XLgEQopK91XqjmFg+Mkiu6vO3rj8+IsmO/UOfLhSg+6TO7osgDjx8M
 Whf3VnXfR6RzSnSgHFmK+tJVB1ZtFRuhlb3U6H5G5OQelgSSZzs3FXRkF2zDNnuzjZIjIEmGk
 bXmUZpyv9HlOqhOQ9LVK+PcYKXnkO8yXMNpJdjmTRf8chO7qe/I40h0IBL7sLeH7aQQcjkJGk
 i+66/z9l0dc2MtlhhNmy7GM40NjIpVBKMxVYtEbUvDL75vl/GfmLxVtKNX09KzOOGFK+dHpV/
 5KVIldddEbjymOoYnohjikLQIQ6xAhubZEiuP6djylIpDI/riK1abCRm09WjfGdMaVDf9rvHk
 zhAFhn7VvWjGUuqbNz9LnxEBAMAmjW48tX2RYrkWR3HeHBQe6Dvtl+SFXy1IFvPdjR2VNjaYT
 +p95IQW3+Gs2yi5NJpXmbP91xFFzcCFYmG84XEv4wI6ZcYfd4vs04yPJmvTyHZIsMc4sWqyH0
 1hnIj27JPaZ+z3iTJn1PnuwoIdte8+ypvYTc/zWKsVvKIKjyM0UU7b7ByFkH4jDpVpfdHL4uS
 kTyCK0TltVtBqlUoDDuj3aQaixfzI/cnMOGRLiUpKBo14j44e3dpzJIgbrYLgXUn77eV40meq
 TFbo9N+fnu3bU0nACrD0cwVpoax9ncMU/qK3e7ra0Y7S+VWaaFAOoQKBZhaF05OFaC8vklrUW
 LB0HebY0Y55FfA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 09:20:51PM -0800, Hunter Laux wrote:
> One of my p4 commits has an ???(0x93) character in the p4 description
> and I'm trying to export it to git.
> I'm using the latest git-p4.py as of c70bc33.
>
> I think python2 didn't throw an error, but python3 now treats this as an=
 error.
> The error is.
> Traceback (most recent call last):
>   File "/home/hlaux/.local/bin/git-p4", line 4292, in <module>
>     main()
>   File "/home/hlaux/.local/bin/git-p4", line 4286, in main
>     if not cmd.run(args):
>   File "/home/hlaux/.local/bin/git-p4", line 4043, in run
>     if not P4Sync.run(self, depotPaths):
>   File "/home/hlaux/.local/bin/git-p4", line 3910, in run
>     self.importRevisions(args, branch_arg_given)
>   File "/home/hlaux/.local/bin/git-p4", line 3658, in importRevisions
>     changes =3D p4ChangesForPaths(self.depotPaths, self.changeRange,
> self.changes_block_size)
>   File "/home/hlaux/.local/bin/git-p4", line 1080, in p4ChangesForPaths
>     result =3D p4CmdList(cmd, errors_as_exceptions=3DTrue)
>   File "/home/hlaux/.local/bin/git-p4", line 711, in p4CmdList
>     value =3D value.decode()
> UnicodeDecodeError: 'utf-8' codec can't decode byte 0x93 in position
> 21: invalid start byte
>
> This patch seems to work.
>
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -707,7 +707,7 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b',
> cb=3DNone, skip_info=3DFalse,
>                  for key, value in entry.items():
>                      key =3D key.decode()
>                      if isinstance(value, bytes) and not (key in
> ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> -                        value =3D value.decode()
> +                        value =3D value.decode('latin1')
>                      decoded_entry[key] =3D value
>                  # Parse out data if it's an error response
>                  if decoded_entry.get('code') =3D=3D 'error' and 'data' =
in
> decoded_entry:
>
>
> Does anyone have a better fix?
>
> Thanks,
>
> Hunter Laux


Thanks for reporting.

I think there was a patch for this problem some time ago:
https://lore.kernel.org/git/20210422050504.441-1-tzadik.vanderhoof@gmail.c=
om/

