From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 13:29:11 +0200
Message-ID: <AANLkTin+i7VZApDRmairgpMth4MzPoDF=oHt-UHCt98E@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local>
	<AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
	<4CAA1BEB.3050908@workspacewhiz.com>
	<AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
	<20101005005902.GC2768@nibiru.local>
	<20101005074144.GA22564@nibiru.local>
	<vpqpqvpf4qm.fsf@bauges.imag.fr>
	<20101005081700.GB22564@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 13:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P35hv-0004FF-5z
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170Ab0JEL3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:29:13 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61152 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758149Ab0JEL3N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 07:29:13 -0400
Received: by qyk29 with SMTP id 29so1751234qyk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=Y3gwg6elIARD+/PwYS4djxBpoylkf5Ebcr6mgGeE++M=;
        b=DqvGU4ljQcyLBO45SBcxp9Z2Bo0fhNRXCJjnVjPkkYpOVltdpbJOiqxtEXb/ajQhES
         Yh+Kxh+QjUHKa+M08yv6Z+K/lkREtBbMr//DiJn81M4LUF3suPqzQ3sXrz/Zz/1I4pWi
         6ZD3AfJlEI7d+qw9es+CMhlJB0UJd+NBlCqvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=wqUod9Ld0oT2CdNyVlLJYsIe+Qg44zsIXixv+h89wQP78Pm3OKIm3zXIBiYE0QX9GC
         X0Mwks8PGM9SibUu6RAzbe+NyTEjhi7OKXLEA8m+SOGtXXJUwAJUfQzSqcl0e8520fhU
         /M+r+7ftTkb7IfUvZsVAw0lLtL4CsgaElP5kM=
Received: by 10.224.3.3 with SMTP id 3mr8182657qal.1.1286278151396; Tue, 05
 Oct 2010 04:29:11 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Tue, 5 Oct 2010 04:29:11 -0700 (PDT)
In-Reply-To: <20101005081700.GB22564@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158187>

On Tue, Oct 5, 2010 at 10:17, Enrico Weigelt <weigelt@metux.de> wrote:
> * Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> git commit will show what's being commited (the output of "git commit
>> --dry-run") in your editor, hence it needs to compute that.
>
> hmm, is there any way to get around this ?
>

Try "git commit -q -uno". This should skip creation of summary in the
commit message and lookup for untracked files.
This will somewhat speed things up
