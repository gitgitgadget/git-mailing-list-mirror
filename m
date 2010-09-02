From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 20:51:32 +0100
Message-ID: <AANLkTi=D7t+cNSdmZORwBEUU6wy-4QXHpw6YcXe61ADa@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 21:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFou-0003s5-U1
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab0IBTve convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:51:34 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37279 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756726Ab0IBTvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 15:51:33 -0400
Received: by vws3 with SMTP id 3so636740vws.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RjQYw7bQo8WVBFzS6XBrVOAa6asEzidJrXVjIjF3lKg=;
        b=f5AFOQqH3obi5zSHAczlkr3t8bqXnmaPXqFu52G7sfXFTkVkAtTWxaJpaOE0dO/Qk2
         DAVLEfTWMFWxscgSVTvb2X1xZIpRn8W2grbKb67Ud/QOoCqceNp9WCnLatJ8MdjMXev4
         eNNOgSFW0hCXhGhwdnn9t+UV7/cCUDxHyMfiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S4kZdDecNZcGntRlH+Xvl9hOVYjO176YEo3UnkaUMwUOxdK8FYyP/b4E2i5Nlkpfm4
         DbuoAfRGKsrODafDG/RJsxFETITRvx2joaLMquI7K4vJKW+jyXM8jzvtLkQhfat8pA/2
         LHireDMe7fqcbbljVB7cmQT7xLNr+F3lJ+yeQ=
Received: by 10.220.88.84 with SMTP id z20mr5610968vcl.92.1283457092434; Thu,
 02 Sep 2010 12:51:32 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 12:51:32 -0700 (PDT)
In-Reply-To: <20100902192910.GJ32601@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155188>

On Thu, Sep 2, 2010 at 8:29 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
>>
>> =C2=A0* based on what you kindly mentioned about "git repack -f", wo=
uld a
>> (well-written!) patch to git pack-objects to add a
>> "--single-thread-only" option be acceptable?
>
> Probably not. =C2=A0I can't think of a good reason to limit the numbe=
r
> of threads that get used. =C2=A0We already have pack.threads as a
> configuration variable to support controlling this for the system,
> but that's about the only thing that really makes sense.
>
>> =C2=A0* would you, or anyone else with enough knowledge of how this =
stuff
>> reaallly works, be willing to put some low-priority back-of-mind
>> thought into how to create a "canonical" pack format
>
> We have. =C2=A0We've even talked about it on the mailing list. =C2=A0=
Multiple
> times. =C2=A0Most times about how to support a p2p Git transport.
> That whole Gittorrent thing you are ignoring,

 i'm not ignoring it - it was abandoned and sam created mirrorsync
instead!  and i can't ignore something when all the damn information
on it has been withdrawn from the internet!  i _have_ been looking,
and just can't darn well find anything.   fortunately, i'm reasonably
bright, catch on fast, and listen well.  ok.  _sometimes_ i listen
well :)

> we put some effort
> into coming up with a pack-like format that would be more stable,
> at the expense of being larger in total size.

 ahhh goood.

> Nico, myself, and a whole lot of other very smart folks who really
> understand how Git works today have failed to identify a way to do
> this that we actually want to write, include in git, and maintain
> long-term.

 bugger.  *sigh* ok.  so, scratch that question, nico (the
canonical-pack question but not the --single-thread one)

 so, this, and...

> In general pack files don't change that often, so there are fairly

 ... this, all tend to point towards the idea of sharing packs by
{ref}-{commitref}-{SHA1}.torrent as being a reasonabe and "good
enough" idea.  on the basis that anyone who happens to be doing
git-sharing _right now_ is likely to end up sharing the exact same
pack object generated by the same one (original) seed.

i'd better start looking at bittornado in more detail...

 l.

p.s. thank you to everyone who's responding, i dunno about you but
this is fascinating.
