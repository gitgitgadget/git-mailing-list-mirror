From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation/remote-helpers: Add invocation section
Date: Tue, 30 Mar 2010 14:59:10 -0500
Message-ID: <20100330195910.GB10977@progeny.tock>
References: <f3271551003300947u4c7c2a83q13aaf786140bfa37@mail.gmail.com>
 <20100330183748.GA10647@progeny.tock>
 <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 21:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwhab-0003Jg-UL
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 21:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab0C3T7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 15:59:00 -0400
Received: from mail-pz0-f186.google.com ([209.85.222.186]:43149 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab0C3T67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 15:58:59 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 15:58:59 EDT
Received: by pzk16 with SMTP id 16so7849366pzk.22
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J1gEjcie6cBe4hD9779nGD2t+TvV9ZjG/DgulHlFAbo=;
        b=to+C16epEyK70I3YTqF5TqeYG5qvx1AWFEbiYLhKvQbW1cKbghukz+SzHLf7NaDBqd
         jUd9TTFcEiz9hsVQcK7tHi6DapirwM1aUis5Q1+w0Syqy5MIpzeZvxVkZEq1UPW6gQ5e
         K0YRwTExRIg3yzj+6r69mXM9syM9aNX4iSWDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YJHOQFE9oA+n0ElUHYtd92SOH+K3cFaByxg5JxLaAqo8fl1S+xtvl/raDPsnMMHfv8
         OuV9qjs4dy1mee4H3ateZoP71tFDnBkFfhL19ZosUr7M9Moy1tKLCJICVibn71o+miO5
         XTyMxfN/3UCP3cOVyAOezYcXkM9nJn+zhlybc=
Received: by 10.114.5.9 with SMTP id 9mr1519466wae.72.1269979137698;
        Tue, 30 Mar 2010 12:58:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1296528pwi.3.2010.03.30.12.58.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 12:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003301217h44c99d5bye4a614840661b05c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143595>

Ramkumar Ramachandra wrote:
> On Wed, Mar 31, 2010 at 12:07 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:

>> =C2=A0The URL in the second argument can be an arbitrary string. =C2=
=A0It is up
>> =C2=A0to the remote helper to assign meaning to it.
>
> I'm not sure this is correct. Here's an excerpt from remote.c
> 	if (argc > 2) {
> 		url =3D argv[2];
> 	} else {
> 		url =3D remote->url[0];
> 	}
> Notice how url is set to remote->url[0], in the `else` branch, where
> the remote is an "ordinary remote" built by remote_get(). Even though
> url may be any arbitrary string in the `if` branch, there'll be
> problems when the program gets into the `else` branch transparently.

Not sure I understand.  Are there restrictions on the content of
remote->url[0]?

What I meant by "arbitrary string" is that it doesn=E2=80=99t have to h=
ave the
form schema://path, it=E2=80=99s not restricted to a particular charact=
er set,
it doesn=E2=80=99t have to avoid conflicting with meaningful URLs defin=
ed by
other helpers, and so on.  So it=E2=80=99s a resource locator but not v=
ery
uniform.

This is probably not very relevant to the user, but it should be releva=
nt
to the remote helper writer, I think.

Jonathan
