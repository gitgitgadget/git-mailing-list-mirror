From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: allheads feature
Date: Fri, 17 Sep 2010 09:24:37 +0200
Message-ID: <AANLkTinQaad7vDCqRKQkDcdRY=M+wLmx6eD3ftg6Nxh=@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009162326.01656.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 09:25:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwVJg-0004C9-SK
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 09:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab0IQHY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 03:24:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42595 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0IQHY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 03:24:58 -0400
Received: by iwn5 with SMTP id 5so1751643iwn.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/uB/znr4txFeT9yFxumb+0Mmz9FG99Al0JGzsR8h6K4=;
        b=GhlvS4BBgWslBzoG3nWuniWbEpPTALAUW+bSxt9k2WV/1H9WU23+UMXxI4gGIUnWrJ
         eQEvOAoEFKOtSXm7PQQZZDhCEaUt858GiMxyQCPXhz4PDR2L2ITyC4zjvnRESW8LE45w
         WTMOeUngWq/q61pekE+s9NYHzYtZm9/xjwivw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wO/OvU2yCm/xzz6xVdW9rcLqnTRJ7OZEx8i8SuWKunlWlDu+iMmZgi0KHBEx6b8Xt1
         hwoAbISCwsV35p4A3cMyeId8QJrGAdsMYOQ3LKUsPKW8KbdqR9OOLnVEp+U6eaVY+AOc
         oIWhT3YyB4KjilbeX9E6alhXveO4jALJlpRh4=
Received: by 10.231.160.17 with SMTP id l17mr4769501ibx.102.1284708297124;
 Fri, 17 Sep 2010 00:24:57 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 00:24:37 -0700 (PDT)
In-Reply-To: <201009162326.01656.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156374>

2010/9/16 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>
>> This is a rehash of an old patchset of mine that got stalled waiting=
 for
>> other independent patches to go in first, and then for me to get the
>> time to work on it again.
>>
>> The first 4 patches are IMO ready for inclusing in gitweb, and their
>> purpose is to introduce a new view (and a new summary block) that
>> display all the remote heads (assuming the feature is enabled).
>> Somebody suggested via email that this could even the basis for some
>> kind of 'social graph' for gitweb repositories, in a way similar to =
what
>> is found on sites like github or gitorious, but for me the feature i=
n
>> itself can already be useful.
>
> We might want to make git-instaweb enable this feature (and probably
> other disabled-by-default features). =A0Otherwise some of information
> about git repository you examine is hidden. =A0So I agree that this
> feature is useful by itself.

I'll add a patch to that effect in the next iteration.

>> The final result is rather curious and you can see it in action at
>> <http://git.oblomov.eu/rbot/remotes>, although it would be nice to f=
ind
>> a way to layout the blocks in a smarter way.
>
> Thanks for providing demo site.
>
> Note that clicking on header for remote block, which should lead to
> displaying of only single remote displays all remotes, see e.g.
> http://git.oblomov.eu/rbot/remotes/a3li. =A0Moreover when I tried to
> handcraft URL i.e. http://git.oblomov.eu/rbot/remote/a3li (with
> 'remote' rather than 'remotes' action) I get an empty list of heads.

The /remote/<thing> is just the standard behavior of git when any
random string is passed as PATH_INFO (try
http://git.oblomov.eu/rbot/whatever), so I cannot fix that unless I
map remote to remotes. The remotes/<headname> is a TODO

(This led me to think: do we want heads/<headname> to point to the
shortlog of that head? It currently does nothing)

> About layout of 'remotes' view: to have remotes information aligned
> we would have to either put everything in one single table (with remo=
tes
> headers being "colspan"), or style them with minimum width (which cou=
ld
> be good idea anyway).

I don't like the 'one single table' approach because, in contrast to
the current approach it doesn't allow for automatic block
rearrangement based on the window width.
The minimum width helps align the blocks vertically, but it doesn't
align the contents of the tables in it, so it's not really that big an
improvement (actually, I find it even funnier that way because of the
illusion of alignment provided by the blocks).

>> What I really don't like (at the moment) is the way things come out
>> in summary view instead.
>
> What you don't like about it? =A0Should it be smarter and display onl=
y
> list of remotes, perhaps even limited to 15 elements, if there are ma=
ny
> remote-tracking branches? =A0Or is it something else?
>
>> The issue there is that we only gather 16 remote heads, so some remo=
tes
>> might have no branches displayed, but it becomes difficult to detect=
 and
>> indicate when remotes have incomplete information being displayed. A
>> possible solution would be to call show-ref N times (N being the num=
ber
>> of remotes) with a limit of 16/N heads, but that can be a lot of cal=
ls.
>> So I'm open to suggestions on how to improve this part (maybe just s=
how
>> a flat view in the remotes section of summary view?)
>
> Ah, I see...
>
> Alternatively we could use smart limiting on the gitweb side.

That was an option I was considering. I thought the limiting to 16
refs and tags in summary view was for performance reasons, so I
thought that grabbing all remote heads would kind of kill the remote
view, but for sure it's more efficient than doing a ref retrieval for
each remote. OTOH, once we get all the refs, why would we only display
some of them?

--=20
Giuseppe "Oblomov" Bilotta
