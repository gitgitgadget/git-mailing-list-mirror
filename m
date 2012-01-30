From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 20:56:40 +0200
Message-ID: <CAMP44s1SzE1h+4Eoebr2LrnLNgFX1UE2+O8z6yYDuukmaijf7Q@mail.gmail.com>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
	<1327944197-6379-5-git-send-email-felipec@infradead.org>
	<20120130175324.GH10618@burratino>
	<CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
	<20120130182547.GA22549@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:56:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwPI-0003W8-1N
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab2A3S4n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 13:56:43 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56262 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752124Ab2A3S4m convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:56:42 -0500
Received: by lagu2 with SMTP id u2so2396969lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 10:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QNc5qRTDfr58viIYEiTE713XIgGPALiy6CERKePrwTM=;
        b=DaFwNcLVHkGn+a72pDXPq4URW56NIa5Qw0tuefOrGNSmfnfepOv+qFAK5rdMpi43N1
         CVAEGHxHulthnBG6O5jGDUzU2rkwTC0Z0akW1taJUkDHNFreRlpG4RGEdxW1MCy96XFv
         H8uN2/EuCY4jc1329qNng3EaEEyveAFQwHysY=
Received: by 10.152.131.40 with SMTP id oj8mr9814100lab.24.1327949801037; Mon,
 30 Jan 2012 10:56:41 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 10:56:40 -0800 (PST)
In-Reply-To: <20120130182547.GA22549@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189396>

On Mon, Jan 30, 2012 at 8:25 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> The commands might fail, that's why '2> /dev/null' was used before,
>> and ':' is used right now.
>
> Wait, what?
>
> : is a no-op command. =C2=A0It does not redirect stderr automatically=
 or
> do any other magical thing.

Why don't you go ahead and try it?

bash -c ': echo "err" > /dev/stderr'

I don't see anything here.

But actually, if I use $(echo "err" > /dev/stderr); _then_ I get
something. Smells a lot like a bug to me.

In any case, if you expected ':' to print errors, now I understand why
you removed 2>/dev/null in eaa4e6e.

> [...]
>> And IMO harder to read. But you are correct that most of the code us=
es
>> [[]], which I think is a shame. But I guess people want to keep usin=
g
>> that.
>
> [[ has simpler syntax wrt quoting and other details. =C2=A0But now th=
at I
> check, the code uses [ a lot, too (which, like "test", is a plain
> built-in command), so I suppose consistency is the only reason to
> prefer one over another. =C2=A0"git log --grep=3D'if \['" tells me th=
e use of
> '[' instead of 'test' here is deliberate.

Maybe '[' then.

--=20
=46elipe Contreras
