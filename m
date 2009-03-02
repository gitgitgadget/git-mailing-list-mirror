From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 17:58:07 -0500
Message-ID: <76718490903021458s497a04a9p5c81a302cb09666a@mail.gmail.com>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
	 <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
	 <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
	 <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
	 <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
	 <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeH6r-00056c-Ku
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbZCBW6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbZCBW6L
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:58:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:37154 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZCBW6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 17:58:10 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2479447rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 14:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7hll3RXEB+cTCtwOkKzb5EYo4sshx5EQyaZehcAbMFY=;
        b=vcg5CBMT5ro94j39KI7ERFZiTV66t9SCXJWUN6sB4Rk6xcv11UuASKx+UkmSNK76b7
         agH1t7mVJ1zSYdzV7Idm3cLU0nlFsJL6yXDX6SfQ62QZG47PeUhSEphMqSEO7Pu1gzEy
         FMxPqfkt3ZF1OzhNJhYhUrMZg+M03umPQwbYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ms11HWEiKfO9pL9+ZeOermpG5YNn0RvlRRNhypzpPEGDZCsnP1oLumaVV5q6zKwc83
         fDLgBQJ1TuniL128uSAjsXHMpvZunjHwaKgRe4RBjpEJDvFaY652893aHY5wl0ALyZd/
         lCuJrqlJzhiTPFhdOf6u7aK3EjpXirWCcdErc=
Received: by 10.141.114.19 with SMTP id r19mr3121243rvm.135.1236034687977; 
	Mon, 02 Mar 2009 14:58:07 -0800 (PST)
In-Reply-To: <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111972>

On Mon, Mar 2, 2009 at 5:39 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> I personally do not think that makes much sense (and I find ** ugly, =
too).
>
> We traditionally supported '*' only at the end, and it always has mea=
nt
> "match through the end, including slashes".

Oh, good point, I had not thought that through very well.

> Requiring 'match including slashes' to be spelled as '**' only when i=
t is
> not at the end is unnecessarily confusing.
>
> Is there a valid use case when * wants to match across directory
> boundaries when it is not at the end? =C2=A0I offhand do not think of=
 a sane
> one.
>
> So, it might make it easiest to understand if we say * usually does n=
ot
> match slash, except when it is used at the end immediately after a sl=
ash,
> in which case it means "match through the end".

That seems simple enough.

j.
