From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH/RFC] Unify argument and option notation in the docs
Date: Fri, 08 Oct 2010 13:13:20 +0200
Message-ID: <87fwwhszsf.fsf@gmail.com>
References: <20101008005256.GA21738@headley> <20101008074320.GB4671@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 13:14:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4AuS-0005zU-Tf
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 13:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab0JHLOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 07:14:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55271 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab0JHLOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 07:14:32 -0400
Received: by bwz15 with SMTP id 15so149146bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=Mq0vh3VdQPRTmE/U9NEfZW93OXAhMAKIYBn0jEflWJw=;
        b=XrlLP+/ZpiBMooepv1yfPdmHAALfnUdrBHs+BM1gncGxVB8cN+/qs8XiKNuDx+4t2U
         qq/GDAur+yw5+CXg7RYehmK5AXDw6Z1X9sxpZczj59Rqc7LRL20sRmMBr5V/p0eazpRZ
         CkeFIdy2i+jBTPhfhmNr6m1vnyImheZJI9TEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=HX6nvovnlrZsDs96pT6i6hN22xwa8+xyMm7HM8G4DAr3JX4/DOt7MpK+8ZVVdjo1Q1
         9/oxwWnvkSZJ7YhZtDYDeXe9WGEks5JNhM4cNXh9sgl4Ja7O4xWwg4vXiNGwPp95pGG8
         XZVTHmk9sXNzEJS7z3P5mNsaKIgPQ8gK4/Vys=
Received: by 10.204.131.200 with SMTP id y8mr1890621bks.107.1286536464685;
        Fri, 08 Oct 2010 04:14:24 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id p34sm383117bkf.3.2010.10.08.04.14.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 04:14:22 -0700 (PDT)
In-Reply-To: <20101008074320.GB4671@burratino> (Jonathan Nieder's message of
	"Fri, 8 Oct 2010 02:43:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158497>

Jonathan Nieder <jrnieder@gmail.com> writes:

> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
>> [It is conceivable I could submit this as a series of smaller patche=
s,
>> but the problems this is solving didn't seem diverse enough to me to
>> warrant that.
>
> Since the documentation processor is known to be, um, picky, could yo=
u
> do that?  That way after bisecting a formatting problem, one has a
> diff addressing a single issue to look at.

OK. Another reason I didn't do that is that my patch actually does not
introduce any mark-up not already present in the sources, so it
shouldn't introduce any new breakage AFAICT.

> On the other hand, I am happy enough to comment on a single, monolith=
ic
> patch on list if you publish the smaller patches making it up in a gi=
t
> repository somewhere.
>
>> 1. Is `[--refs [--unpacked | --all]]' in `git-pack-object' documenta=
tion
>> correct? From my reading of builtin/pack-objects.c, `--unpacked' and
>> `--all' do the same thing and both imply --refs, so perhaps [--refs =
|
>> --unpacked | --all] would make more sense?
>
> Doesn't the OPTIONS section explain what --revs, --unpacked, and --al=
l
> mean?

It does, but IMO it contradicts the synopsis. Doesn't the fact that
--unpacked and --all _imply_ --rev mean that you don't need to supply
the latter if you already gave one of the former two? That's also what =
I
understood from looking at pack-objects.c. So neither [--revs
[(--unpacked|--all)...]] nor [--revs [--unpacked|--all]] seem correct t=
o
me.

I also don't see why you would want to supply --unpacked or --all
multiple times, so `...' would be definitely wrong, no?

>> (I also noticed that the
>> --reflog option is shown in the usage string but undocumented.)
>
> Looks like someone forgot to add it to the man page.

OK. I'll leave that to someone who knows what the option is supposed to
do; it's a matter for a separate patch anyway.

>> 2. I left in one special case, namely the GIT_* variables in `git(1)=
'
>> synopsis section as values for the `--exec-path' and other options.
>
> Hmm, --exec-path=3DGIT_EXEC_PATH currently serves as a reminder of th=
e
> name of the corresponding environment variable, but I don't think
> that's very important.  --exec-path[=3D<path>] should be fine.

Yes, that's my opinion as well, thanks for confirmation. I'll include i=
t
in the next round.

=C5=A0t=C4=9Bp=C3=A1n
