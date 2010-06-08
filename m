From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Wed, 9 Jun 2010 01:54:34 +0530
Message-ID: <AANLkTimKsdn8Vww_4U4YQDPlpr_BgbVszwG64lEYl-cE@mail.gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
	<201006081446.22587.jnareb@gmail.com>
	<20100608141321.GP20775@machine.or.cz>
	<AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
	<20100608195552.GA3408@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 08 22:24:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM5Ln-0001ny-G0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 22:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab0FHUYg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 16:24:36 -0400
Received: from mail-yw0-f204.google.com ([209.85.211.204]:38214 "EHLO
	mail-yw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0FHUYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 16:24:35 -0400
Received: by ywh42 with SMTP id 42so4596607ywh.15
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OVlkBxnWBnIx2e8OjbKkC6502v3cwGgPFVbjNqi9Z3g=;
        b=yFFCKPTT78ecNtWPuyEMUmii4fcDIFSTwh6EXS7kNdnzWpD3H1p0vL3um1OcYH4pSs
         T7Kz3tDrFqe2WzLVpGKCMZUW4jy7xhpfPKPl2uLwcrCob5BhqJfV1OflVPN1n5qh1P0w
         rXqp6OCELYShh1kOh/IRQOuEVdBtP2SBvNxfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hOIZQooa/MXnjy+DHUwbUMio0OLF01OrJqWfw+LUtEfwRgfgJTVnOpi47vHDE8DBt7
         DArrNwTOYWxSy8ilUXaF/N2+wXkYE5QftxySxXNlVX3PCzf5dsdlFEqQaaat9fojZwjG
         jtznaSBsxXpanf7Uf8/CnnnmmUUPyquu4dRe0=
Received: by 10.100.244.26 with SMTP id r26mr17259027anh.91.1276028674906; 
	Tue, 08 Jun 2010 13:24:34 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Tue, 8 Jun 2010 13:24:34 -0700 (PDT)
In-Reply-To: <20100608195552.GA3408@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148709>

On Wed, Jun 9, 2010 at 1:25 AM, Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Jun 09, 2010 at 12:52:11AM +0530, Pavan Kumar Sunkara wrote:
>> I am graining Gitweb::HTML into Gitweb::HTML::* to reduce circular
>> dependancies of the modules.
>
> I'm sorry, I don't understand. How is splitting up Gitweb::HTML to
> submodules helping to reduce circular dependencies? I don't quite see
> that right now. :-( Can you give a concrete example? Perhaps it would=
 be
> better to refactor the few problematic users instead of convoluting t=
he
> whole module structure because of the offenders.

Ok. I will be combining them into a single module.

>> =A0 Gitweb::Parse
>
> What will this module do?

This module contains all the parse_* subroutines

Gitweb::Format contains all the format_* subroutines

>
>> =A0 Gitweb::Util
>
> What will this module do?

This modules contains all the git utility functions.

>> =A0 Gitweb::Action::* (All action subs like git_blame, git_log)
>
> Do we need to do this right now? I think moving huge chunks of the co=
de
> around like this right now is unneccessary and it might just enlarge =
the
> patch queue and delay you in your main GSoC efforts; perhaps we could=
 do
> this later when the dust settles a bit and we are sure that the rest =
of
> the modular structure we have introduced fits well?

I still have until this week in the timeline. Don't I ?
I strongly hope that I will be able to finalise the patch queue by
this week and will move on to develop write functionalities.

Thanks,
Pavan.
