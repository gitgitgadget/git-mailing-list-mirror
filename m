From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 22:59:01 -0400
Message-ID: <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
References: <buofxhr2vta.fsf@dhlpc061.dev.necel.com>
	 <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	 <buoy6vi297q.fsf@dhlpc061.dev.necel.com>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhEgN-0005AW-Mr
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbZCKC7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 22:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbZCKC7F
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 22:59:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:64718 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZCKC7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 22:59:03 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2521608rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 19:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j2tORpYj2wuPP+iCauQjBKhoQi2tTmP5JY83LiNPiCk=;
        b=xUfXgN7+XxYrr48d93zxu1YixxkvBZnBeCG/f06uoxaG/rS3kRb5+8d6PHlOfXEnj8
         CBYBjZQ+ZGRycoage9eFV/hU1Wnq8Sz7S+JYGxkYT0ui9kugp/75RUdjbtwX03xxTxPK
         laE9gy8iyHwSXzJJMTzzS4l8MravCgJI2di9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=obfzdBiAljx3brESZS8/0IomQOIYMXRSBcS/JYlEjTO92na+yg5QviC8cY4PIkksvJ
         QBGMokly60cZkAJwJA3uKNpfiJTK6ZcIpze4J74K2EZHOOpeKhDWdh9s1dnCeTKoV4BG
         WYyv670dTu9mcK/mJ5/IVaoiT/0wtZubGIu94=
Received: by 10.141.155.15 with SMTP id h15mr4101276rvo.158.1236740341512; 
	Tue, 10 Mar 2009 19:59:01 -0700 (PDT)
In-Reply-To: <20090311020409.GA31365@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112871>

On Tue, Mar 10, 2009 at 10:04 PM, Jeff King <peff@peff.net> wrote:
>
>> -u --track [<branch>] <upstream>
>
> Hmm. This seems not quite right to me. Specifically:
>
> =C2=A01. Would you ever want to use "-u" without "--track"? If so, th=
en why
> =C2=A0 =C2=A0 are they two separate options?

=46or when branch grows additional long options that update, er,
something else. :-)

And you can also use it with --no-track.

But the primary reason for the -u is to differentiate the operation,
just like -m and -d.

> =C2=A02. In your example, if I give only a single non-option argument=
, it is
> =C2=A0 =C2=A0 interpreted as the upstream (and presumably the branch =
defaults to
> =C2=A0 =C2=A0 HEAD). =C2=A0But in other branch commands, it is interp=
reted as the
> =C2=A0 =C2=A0 branch, and the upstream defaults to HEAD.

No, look at how -m works. [<oldbranch>] <newbranch>. I modeled it after=
 that.

> For (1), you could just have a single option. Unfortunately --track i=
s
> taken. But maybe you could do --track=3D. And that helps with (2), as
> well, since this syntax would only ever have one or zero arguments. A=
nd
> then you can default zero to HEAD.
>
> IOW:
>
> =C2=A0# track origin/master with the current branch
> =C2=A0git branch --track=3Dorigin/master
>
> =C2=A0# track origin/master with a different branch
> =C2=A0git branch --track=3Dorigin/master other_branch
>
> =C2=A0# stop tracking
> =C2=A0git branch --track=3D
>
> The only two problems I can think of are:
>
> =C2=A01. It is perhaps a little confusing that --track=3D means "don'=
t do the
> =C2=A0 =C2=A0 normal branch operation, but instead do this totally di=
fferent
> =C2=A0 =C2=A0 thing. Of course we already have a similar situation wi=
th "-m", but
> =C2=A0 =C2=A0 it is perhaps more confusing since "--track" and "--tra=
ck=3D" have
> =C2=A0 =C2=A0 totally different semantics.
>
> =C2=A02. This would be the only branch command to operate on HEAD if =
given
> =C2=A0 =C2=A0 no argument. That isn't necessary for this proposal, bu=
t I think it
> =C2=A0 =C2=A0 makes it nicer to use. An alternative would be for git-=
branch to
> =C2=A0 =C2=A0 resolve symrefs (which would also be nice for "git bran=
ch -m HEAD
> =C2=A0 =C2=A0 foo").

Yeah, I like that less than -u, which I agree isn't perfect, but I
think it's closer.

j.
