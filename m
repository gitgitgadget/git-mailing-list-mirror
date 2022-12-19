Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EBC4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 07:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiLSHbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 02:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSHbd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 02:31:33 -0500
X-Greylist: delayed 882 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Dec 2022 23:31:32 PST
Received: from mx4.uni-regensburg.de (mx4.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC65F51
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 23:31:31 -0800 (PST)
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 70F18600004F
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:31:29 +0100 (CET)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 41B85600004E
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 08:31:29 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 19 Dec 2022 08:31:30 +0100
Message-Id: <63A01350020000A100050851@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.2 
Date:   Mon, 19 Dec 2022 08:31:28 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <git@vger.kernel.org>
Subject: Wtrlt: Antw: [EXT] Re: Strange "git stash pop" conflict (one
 chunk out of many)
References: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
 <967939F9020000A8CE842B1F@gwsmtp.uni-regensburg.de>
 <63A012F0020000A10005084B@gwsmtp.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartF8FA3640.0__="
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartF8FA3640.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry, I forgot to reply to the list, too.


--=__PartF8FA3640.0__=
Content-Type: message/rfc822

Date: Mon, 19 Dec 2022 08:29:52 +0100
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To: <phillip.wood@dunelm.org.uk>
Subject: Antw: [EXT] Re: Strange "git stash pop" conflict (one chunk
 out of many)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> Phillip Wood <phillip.wood123@gmail.com> schrieb am 17.12.2022 um =
11:44 in
Nachricht <6c8e8271-432f-38e3-e70e-1445f874afc6@dunelm.org.uk>:
> Hi Ulrich
>=20
> On 15/12/2022 11:38, Ulrich Windl wrote:
>> Hi!
>>=20
>> This is for a somewhat older git-2.26.2:
>> I had added interactively some changes  using edit of a few junks (I =
tried=20
> to structure my big hacking into logical junks when committing).
>> To test whether the partial commit would be consistent, I did a "git =
stash=20
> -k" before committing, and after committing I did a "git stash pop" =
to=20
> continue hacking.
>>=20
>> Unfortunately I had a "Merge conflict". Looking at it, it is rather=20
> "interesting", however (meaning: I don't understand it).
>> Here is how the conflict looks (to me both variants seem identical):
>=20
> Yes, it does look "interesting". Did you make any changes between=20
> running "git stash -k" and "git stash pop"? I did wonder if there had=20

Of course I did: I did an --interactive add before (required to separate =
to edits affecting the same lines), then I stashed the rest.
Commited that. The I switched to another branch doing a stash pop there to =
interactively add another fix like above. The switched back to the =
previous branch,
did a rebase and then popped the remaining stash to continue.

Yes, I know it's a bad procedure, but frequently when adding a neew =
feature you find an fix bugs that aren't really related to that feature, =
so you want the unrelated fixes to go to another branch. Problably I don't =
use the full power of git yet (meaning: maybe there's an easier workflow).

> been some whitespace changes where spaces were replaced with tabs or=20
> vice-versa ("git stash" uses "git apply" to create the stash so if =
you=20
> have apply.whitespace set to "fix" the stashed changes will not=20
> necessarily match those in the working copy) but diffing the two =
sides=20
> of the conflict does not show any changes.

I'm not aware that I did any white-space fixes in the hunk reported.

Regards,
Ulrich

>=20
> Best Wishes
>=20
> Phillip
>=20
>>          # pre-allocate translations and accesskeys
>> <<<<<<< Updated upstream
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>              $attr{$attr} =3D [translate_attr($attr), undef];
>>              $attr{$attr}->[1] =3D add_access_key($aks, 0, $attr{$attr}-=
>[0]);
>>          }
>>          foreach my $attr (LD_SEARCH_ATTR) {
>> =3D=3D=3D=3D=3D=3D=3D
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>              $attr{$attr} =3D [translate_attr($attr), undef];
>>              $attr{$attr}->[1] =3D add_access_key($aks, 0, $attr{$attr}-=
>[0]);
>>          }
>>          foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>>>> Stashed changes
>>              @n =3D (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});
>>=20
>> (the other conflict junks look reasonable)
>>=20
>> Regards,
>> Ulrich
>>=20
>>=20
>>=20
>>=20





--=__PartF8FA3640.0__=--
