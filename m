From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 2/3] git-fetch: Support the local remote "."
Date: Wed, 14 Mar 2007 00:01:47 +0100
Message-ID: <8aa486160703131601j19c4e3b2nd0a4e8ccd4cc7114@mail.gmail.com>
References: <87bqixf6qf.fsf@gmail.com> <45F6D718.5080601@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C. Hamano" <junkio@cox.net>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Wed Mar 14 00:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRG0S-00068M-HZ
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 00:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbXCMXBv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Mar 2007 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXCMXBu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 19:01:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:49336 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbXCMXBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2007 19:01:49 -0400
Received: by nf-out-0910.google.com with SMTP id o25so2730609nfa
        for <git@vger.kernel.org>; Tue, 13 Mar 2007 16:01:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZINL5HyjLrs0NEEFoOjaMMANgOQpXYr4ZIaf8q2S3UvoTlI3PaO/yOZh4AYE9uo44AiakzwYqAuXF9AtP6zkRvuwigx9NG4lTJwmENU1cj/Yb3bhEc/BAA8zq+3ByiLCzWmD41a2bk0waNfs6ygrZ8/hm4dDAWOgAw37NGZssLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KajMt17Gc/TBQ526N/k4pfsOKVJ8I3B74a53akSRd1mO6AgR76DKwvUQERW8ndfV22kiMztLIZlp17+jqrfAahXUFGk/C64WUGWfGbX5wfhzowLiT6wvVdSpuoeCG71UBMRJ1nGaFVdilQXG+z/ZC+KeDSrLEaiz4PlvCBBrgyk=
Received: by 10.78.97.7 with SMTP id u7mr658717hub.1173826907499;
        Tue, 13 Mar 2007 16:01:47 -0700 (PDT)
Received: by 10.78.69.4 with HTTP; Tue, 13 Mar 2007 16:01:47 -0700 (PDT)
In-Reply-To: <45F6D718.5080601@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42153>

On 3/13/07, Paolo Bonzini <paolo.bonzini@lu.unisi.ch> wrote:
> Santi B=E9jar wrote:
> > To this end, git-parse-remote is grown with a new kind of remote,
> > `builtin'. This returns all the local branches in
> > get_remote_default_refs_for_fetch. This is equivalent to having a
> > fake remote as:
> >
> > [remote "local"]
> > url =3D .
> > fetch =3D refs/*
> >
> > Based on a patch from Paolo Bonzini.
>
> Can you please compare the times to do "git fetch ."?  The reason
> to touch git-fetch.sh was an optimization that Junio requested.
>
> I found my 2nd submission to be 20% faster than the first.
>
> Paolo
>

Yes. But this optimization is independent of this patch, as it already
exists without this (but it gets worse with this patch).

Also, I think, the split in fetch_main should be base on transport and
not on the definition of the remote.

Santi
