From: Scott Chacon <schacon@gmail.com>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 11:47:34 -0800
Message-ID: <d411cc4a1002121147i67317ec8k69c7274ba49d6e38@mail.gmail.com>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>
	 <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
	 <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>
	 <20100212091635.GA22942@glandium.org>
	 <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de>
	 <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com>
	 <alpine.LNX.2.00.1002120923060.14365@iabervon.org>
	 <fabb9a1e1002120841o71651f82h782eab46206df402@mail.gmail.com>
	 <alpine.LNX.2.00.1002121158430.14365@iabervon.org>
	 <fabb9a1e1002121130uf16efeeyea6f763be18d27d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:47:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng1UM-0001dz-Dq
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 20:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134Ab0BLTrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 14:47:37 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:52642 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab0BLTrg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 14:47:36 -0500
Received: by ey-out-2122.google.com with SMTP id 9so169755eyd.5
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cRJqSqrn1x1tV6Zb5qr6UVPXSch23Qqh7HblORlZSI0=;
        b=GkzZBgBNa3Vn7YiDxpTDYTfCCOZedS3gF2tTFWaFB7aRRJugs0DXQ1FjbdLzexYr2V
         IvSk5y26AxdydKJWrUI/DG4jlyjoJHWhEM+yoa7Ni01ipfVij/SN4EGut43uYeBD7ajN
         0MsJDfQp7OJ7rY0FK6/nBzB5cjt1uMbdhU8tA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aCf919Jc67DJYNZw9m8wkR4TFi4JMU77wgWudNBltCDUr5yT1+02r+4b5twUc98BsP
         Txsrkj7K3Hr/wA3jl5lhSDIF6JYFiHIUEgANxxxpJtB3VQFCcZu+M1EjKOOCRU7Pnu1D
         E/gCJSQC4S0/nWjdKTHxuOpgwvpID6aAeyJoE=
Received: by 10.216.89.82 with SMTP id b60mr1079996wef.170.1266004054827; Fri, 
	12 Feb 2010 11:47:34 -0800 (PST)
In-Reply-To: <fabb9a1e1002121130uf16efeeyea6f763be18d27d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139741>

Hey,

On Fri, Feb 12, 2010 at 11:30 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Fri, Feb 12, 2010 at 20:16, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> I think that 'export' will always have this effect, because the
>> export/reimport roundtrip is practically never going to be exact with a
>> remote system that isn't actually git (and the state that you see the
>> remote as having after a successful push should match what you see if you
>> were to clone again).
>
> Not so, currently round-trips to Mercurial using hg-git result in
> identical commits.

In most cases, this is true, but unfortunately not every VCS is as
denormalized data-wise as Git is. Hg records rename info and a
manifest of changed files in the changeset explicitly, whereas Git
figures them out from the linked trees.  This means that if some
plugin does not write the file listing or rename info properly, it's
difficult to recreate perfectly.  It also doesn't help that the method
that writes that changed-file list from contents in memory operates
subtly differently than the one that writes it from files in the
working directory.  This caused days of headaches for me trying to
keep bidirectional losslessness.

Possibly not terribly helpful information, but interesting to me nonetheless.

Scott
