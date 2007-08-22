From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 22:19:51 +0100
Message-ID: <3f4fd2640708221419w624a9920o5dc9a9fcbd680be2@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 23:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxcP-00022h-Eb
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbXHVVTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbXHVVTx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:19:53 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:57785 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbXHVVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 17:19:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so318477rvb
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 14:19:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SalXqZoNss20XU+cyOfV0uqxkhFtxDhtU3LV48dWeuqZPOSwgNW/tZBkP1oiH0Q5K+vWlDJUHt5E0/kSpNbXNSwgopRVlE3UyxZxi2RGR9UWkjLBHdr6zpm8G+sMQPAKgsI+3ZHZVWFY43vd1NCVU05xaQ22w7/u2d/psHF7phw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hQQTkB9NEUBpS5s2cDFY1zdta7d5iY9IZ4S6Dkd5+3IWxD381M+Ymt/hoTCf9fCOFTegbtlcjO0nZ6toz3oSrH4cONTlw+majFO3zmi+VmrDVCH0FBG6ygkinbTQLIvulhEhbi9+shgT5OEWhkyr+OLPUQd1EPLxO1gvZYK8UrE=
Received: by 10.141.51.15 with SMTP id d15mr521638rvk.1187817591185;
        Wed, 22 Aug 2007 14:19:51 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 22 Aug 2007 14:19:51 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708221713540.20400@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56421>

On 22/08/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> On Wed, 22 Aug 2007, Nicolas Pitre wrote:
>
> > On Wed, 22 Aug 2007, David Kastrup wrote:
> >
> > > If the scripting engine of choice for cobbling together prototypes
> > > remains the Unix toolchain outside of git proper, then Windows users
> > > will _always_ remain second class citizens since they will get to work
> > > with and on new porcelain much later than the rest of the world:
> > > namely when somebody bothers porting his new favorite tool for them to
> > > C.
> >
> > Right.
>
> And not making the scripts builtins helps Windows users how, exactly?

IIUC, the plumbing is all (or mostly) ported to C code, whereas the
remaining scripts are on the porcelain side.

Given that you have to deal with other Windows issues (line ending,
case insensitive file names, path format), why not put the current
scripts in a posix porcelain directory and have a Windows porcelain
directory where the Windows porcelain is written in C#?

Alternatively, the porcelain could be unified to use Python and
compiled into an executable that is installed on the Windows platform
(removing the need to have anything other than git installed to use
it).

If not Python, then can you compile perl scripts to an executable
form, in which case perl could be standardized on.

This way, both camps (posix and Windows) will be happy.

- Reece
