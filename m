From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git remote update: New option --prune (-p)
Date: Thu, 2 Apr 2009 21:05:47 +0200
Message-ID: <9b18b3110904021205t6b00e486k2d0717e252b01d14@mail.gmail.com>
References: <20090402123823.GA1756@pvv.org>
	 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
	 <20090402134414.GB26699@coredump.intra.peff.net>
	 <9b18b3110904020717h3a0d4b34h7f4b2b83527e6743@mail.gmail.com>
	 <20090402143112.GA26974@coredump.intra.peff.net>
	 <9b18b3110904020907i23f246aelccc2a0770acc2574@mail.gmail.com>
	 <20090402163213.GA28261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:07:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpSG0-0005aL-Sz
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 21:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbZDBTFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756265AbZDBTFv
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 15:05:51 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:63807 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZDBTFu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 15:05:50 -0400
Received: by qyk16 with SMTP id 16so1364602qyk.33
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=69CECJSV4Fmp+BnjOmxJVUE0B/GPQRo0sMq7LXpQ+sI=;
        b=c33ZAL+lIz7XAKdXrONpB0O7F68a7Y4Xy/9cf2BUrTUwzaYjTF8MMjSa54gDCIi9Bk
         Dk3kddmq+uI2hWSxmsvaJOSmlE5MDvlgRUyuCacJSNsh16GoIU6mT0UrsCZ8dfc7TO/L
         yRCELZ/5BcJOLQ6kTT0bd/GXcTzpbvWtsEO3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pTi12CEw7jDM01Kw17yIgPse98KLGJVGIIqiI1B2YMnt2W9UK1BrSB43V/2AMhgzPb
         CywMmuhQK1ZBwXgR2rOQ3c3fz5zfbSQCPUNQSn8ntTeQoGjcn5XDUadFOMnQ6ETmi/oI
         g/eblTn4XF9bNm1RGMJOgWwRFK7muC4pZK3b0=
Received: by 10.231.30.198 with SMTP id v6mr123620ibc.22.1238699147551; Thu, 
	02 Apr 2009 12:05:47 -0700 (PDT)
In-Reply-To: <20090402163213.GA28261@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115487>

2009/4/2 Jeff King <peff@peff.net>:
> On Thu, Apr 02, 2009 at 06:07:33PM +0200, demerphq wrote:
>
>> Er, personally i find that documentation pretty cryptic. And when i
>> check git config for group, i see this:
>>
>> =A0 =A0 =A0 =A0remotes.<group>
>> =A0 =A0 =A0 =A0 =A0 =A0The list of remotes which are fetched by "git=
 remote update
>> =A0 =A0 =A0 =A0 =A0 =A0<group>". See git-remote(1).
>
> Yeah, this should probably say "separated by space" or whatever (I
> actually don't even know). I would assume it contains the remote name=
; I
> can't imagine what other thing it would include. But it wouldn't hurt=
 to
> make that more explicit.
>
> I'm sure a documentation patch would be welcome.

If/when i feel that i understand the subject sufficiently Ill make an
attempt. :-)

>> =A0 =A0 =A0 =A0remote.<name>.skipDefaultUpdate
>> =A0 =A0 =A0 =A0 =A0 =A0If true, this remote will be skipped by defau=
lt when updating using
>> =A0 =A0 =A0 =A0 =A0 =A0the update subcommand of git-remote(1).
>>
>> Neither of which really explain groups, how to define them properly,
>> (the list is separated by what? and includes the remote name?) or
>> whether there are implicit groups. I mean, it seems logical that if
>> you can have user defined groups that there are some built in ones
>> too, like "all" and "none" or perhaps groups defined by transport
>> "http" or "git" for instance.
>
> I think what is confusing is that there is exactly one implicit group=
,
> and it is "the default group", which contains every remote that doesn=
't
> have skipDefaultUpdate set. You refer to the "default group" by not
> mentioning any group.

Yes well an implicit group "default" would be nice.

>
> So no, there aren't other implicit groups (AFAIK).
>
> You can propose implicit groups, but I think they would have to have =
a
> compelling use case over simply creating them manually. To avoid
> conflict with groups people have already defined, they would only be
> used if no remotes.$whatever config existed.

Or perhpas simply use syntax not likely or expected to be used in the
name of a group. Like colon. Or something like that.

>
> I think having "git remote update foo" fall back to a group containin=
g
> only the remote "foo" when "remotes.foo" does not exist makes sense.
> I'm not sure that "none", "http", or "git" is all that useful in
> practice (the only thing I can think of for the latter two is that yo=
u
> might use "git" versus "http" depending on restrictive firewall
> settings).

Well i was think of situations where somebody has coded something that
just must have a group.  Thus 'none' would be essentially  a no-op in
this case. I know you can argue "well dont do that", but people tend
to do silly things whatever they are told, and explicit arguments make
for less special cases in wrapper scripts and the like...

>
> You could give the unnamed "default group" a name (like "all"), but t=
hen
> you risk conflict with existing "remotes.all".

Id much prefer the default group to be called default. Not "all".
Ideally "all" would really be "all". :-)

> And in this case, it is
> hard to remain backwards compatible: "git remote update" will do
> something different now in the case that the user has configured
> remotes.all.

Well, id have a thought a better approach is to use a character that
cannot or is extremely unlikely to be used in an existing group
definition and cannot be used in a remote definition. Like maybe
":all" or something.

Or maybe: `git config remote.implicitgroups true` could be used to enab=
le it?

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
