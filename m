From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC Proposal/RFC] Rolling commit message writing
Date: Mon, 29 Mar 2010 22:05:08 -0500
Message-ID: <20100330030508.GA2887@progeny.tock>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
 <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Thomas <drt24@srcf.ucam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 05:05:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwRlQ-0005iV-6a
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 05:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab0C3DFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 23:05:04 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:23367 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0C3DFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 23:05:02 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3512894qwh.37
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uWhqQfJYu7dEFLo8rM97KTzhzwm5yybjpkLplCr9dvQ=;
        b=r6QkOTSjXusRo0QzLCJZNP5LEixh9VxCTh2rW6tbz9hGvj+kaDD9DziD3kQw+i1PKz
         WcqdXu+r30DWXBO9uLqeTj0/uJHQ/+I1JiKXLjXnthoj3ooJcYwxRU23sUNCFKdly8pV
         9pGfbeRZTsVI9Nn4NY7251kqvCyzzBd9UzBFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kEHjC6ES1XJYWM0LdFTU5w9xh7OJsbSTyCxBAm5/n7LdG2314lLYOWDSLQSYcgQD10
         cdrcoPY4r/PRstrT2k2qQSA7geYbgV3G73AIEWbvThdmwHR4886Hbe7FMZ5/I2ALzXwE
         4T5ytiKGte3fXEvDI6WolJQtbeBERp+bjJUVE=
Received: by 10.224.101.9 with SMTP id a9mr810016qao.263.1269918301568;
        Mon, 29 Mar 2010 20:05:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4676804iwn.0.2010.03.29.20.05.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 20:05:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143538>

Hi,

Avery Pennarun wrote:

> Given these existing capabilities, is it still worth adding the
> feature you propose?

I think it might be, in some modified form.

Suppose I am working on a medium-sized change that for reasons of
bisectability or ontology has to be one commit.  In the middle of
working, I notice I needed to do something nonobvious.  Currently when
this happens, I get out a pad of paper and write it down, so I can be
sure to mention it in the commit message.

Wouldn=E2=80=99t it be nicer in such situations to be able to say git a=
dd
--commit-message or similar, open an editor, and write the note right
away?

In other words, it would be nice to have a file in .git that is

 - cleared on successful commit
 - automatically used to fill COMMIT_EDITMSG, like MERGE_MSG is

I suspect something like this can be achieved by the combination of
the commit.template configuration variable and a post-commit hook to
clear the file, but I haven=E2=80=99t tried it.

Regards,
Jonathan
