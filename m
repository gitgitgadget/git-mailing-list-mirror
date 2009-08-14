From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 00:05:05 -0700
Message-ID: <fabb9a1e0908140005n18a53128n840c2e4ffbe1889a@mail.gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> 
	<1250226349-20397-2-git-send-email-srabbelier@gmail.com> <7vab22ubr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:05:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbqqz-0003Z1-Ue
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbZHNHFZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2009 03:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbZHNHFZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:05:25 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59507 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbZHNHFY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2009 03:05:24 -0400
Received: by ewy10 with SMTP id 10so1307806ewy.37
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WCAbWFQGzn2llFAxgdNmz4hgGSjz9GfyySDMJwercgE=;
        b=oHM35C8O6XYLr+do9V3RK3dUNZ07VhTEFtBC2W89+VMdcdNMercZJKoRTYDUEd+jA3
         619hw7gWejEM4aHCQWAWRfUVkkjPC6d68LJDkkou6cfSYYZGkYheqKnhoDt62HR4Vl08
         Vel5G1tQWMiElG2RmhIWs+HkXdXZbiRPZIUFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e/Xy0kXoVmYh5uuj577rgoC8wOcqzWTWWnz9UKBznHEG4NBTraz1lYTHsb1F6L7xEG
         d2PaHqkYbDOMj0OPinjqA5uIs98ylNCitP6Tu5Tu2AsKHOJAH8SRQk5fBXw6THiY8uHE
         k/Ebz+hNFhYZ6wehN8h8trgMcrj1rrafyWjtc=
Received: by 10.216.70.205 with SMTP id p55mr347421wed.55.1250233525085; Fri, 
	14 Aug 2009 00:05:25 -0700 (PDT)
In-Reply-To: <7vab22ubr5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125910>

Heya,

On Thu, Aug 13, 2009 at 23:53, Junio C Hamano<gitster@pobox.com> wrote:
> I doubt that assumption is warranted. =A0I've seen new people on this=
 list
> who want to be as specific as possible before they get familiar with =
the
> tool (I guess it is in the same spirit that they like to spell out lo=
ng
> option names instead of short ones).

=46air enough.

> Your "old:new" demonstrates a fuzzy understanding of the underlying
> concept. =A0They are not <old> nor <new>. =A0They are <object name> a=
nd
> <destination>; with this object, update that destination.

Not really, I was responding to Jeff's "you can rename a branch like
this", I know that in <left>:<right> the <left> can be anything that
locally resolves to an object, and that <right> can be any valid ref
on the remote side, but that's quite a mouthful :P.

> Also --delete should imply not
> looking at configured refspecs at all. =A0After all, this is incompat=
ible
> with the way git expresses push with refspecs, and trying to mix thes=
e two
> would lead to confusion.

Agreed, I don't think "git push --delete origin master:master
to-be-deleted" is a good idea.

> [...] Being able to
> say "git push --delete branch1 branch2" matches _a_ mental model (per=
haps
> Hg inspired one) _very_ naturally. =A0[...]
>
> [...] In
> git model, you give list of instructions <which branch to update with=
 what
> commit>, and as a special case "what commit" could be "empty" to sign=
al
> deletion, and "push" carries out the instructions.
>
> These are both valid models. =A0They just do not mix, so let's avoid
> confusion by not allowing both at the same time.

Agreed, would it be enough to ensure that there are refs present (as
argument), and
that they do not contain a colon?

Also, how do I go about making sure the local configuration is
ignored, as you mentioned above?

--=20
Cheers,

Sverre Rabbelier
