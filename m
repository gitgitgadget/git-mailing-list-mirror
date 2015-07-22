From: Tony Finch <dot@dotat.at>
Subject: Re: What's cooking in git.git (Jul 2015, #01; Wed, 1)
Date: Wed, 22 Jul 2015 14:19:40 +0100
Message-ID: <alpine.LSU.2.00.1507221351420.12758@hermes-1.csi.cam.ac.uk>
References: <xmqqzj3f5wtr.fsf@gitster.dls.corp.google.com> <55AE8ACF.6090508@gmail.com> <alpine.LSU.2.00.1507220957350.16350@hermes-1.csi.cam.ac.uk> <55AF7B9C.4000108@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-415390768-1437571180=:12758"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 15:21:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHtx9-00013R-6M
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbbGVNUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 09:20:51 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58599 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927AbbGVNTm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 09:19:42 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:48338)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1ZHtvw-0004wz-qv (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 22 Jul 2015 14:19:40 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1ZHtvw-0005A9-BZ (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 22 Jul 2015 14:19:40 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <55AF7B9C.4000108@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274444>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-415390768-1437571180=:12758
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>
> A question about implementation: why emptying $path_info in
> evaluate_path_info()?

That was for consistency with other parts of the subroutine which (mostly)
remove items from the global $path_info variable when they are added to
%input_params. But since $path_info isn't used after it has been parsed, I
suppose it is redundant.

> >> - I think that people would want to be able to configure how
> >>   many levels of directory hierarchy gets turned into categories.
> >>   Perhaps only top level should be turned into category? Deep
> >>   hierarchies means deep categories (usually with very few
> >>   repositories) with current implementation.
> >
> > Good question. I was assuming flat-ish directory hierarchies, but that'=
s
> > clearly not very true, e.g. https://git.kernel.org/cgit/
> >
> > I think it would be right to make this a %feature since categories alre=
ady
> > nearly fit the %feature per-project override style.
>
> On the other hand $projects_list_group_categories is a global gitweb
> configuration variable, and $projects_list_directory_is_category was
> patterned after it.

Yes... Which do you prefer? :-)

> A few thoughts about implementation:

Helpful, thanks!

> - can we turn category header into link even if the category didn't
>   came from $projects_list_directory_is_category?

That would mean changing the project filter to match categories as well as
paths. I don't know if this is the right thing to do; perhaps it is,
because the current behaviour of my category headings is a bit surprising.

At the moment, clicking on the "git" category heading on the page linked
below takes you to a page that does not list all the repos that were under
the category heading on the main page.

https://git.csx.cam.ac.uk/x/ucs/

> - even if $projects_list_directory_is_category is true, the category
>   could came from 'category' file, or otherwise manually set category,
>   though I wonder how we can easily detect this...

Yes - I use this to list my personal/experimental repos alongside
the production repos.

I'm not sure why gitweb would need to detect this or what it would do in
response. At the moment it "just works", apart from the oddity with
categories vs project filters i described above.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Viking, North Utsire: Westerly 4 or 5, occasionally 6 at first, backing
southerly 3 or 4. Moderate becoming slight. Occasional rain in north. Good,
occasionally moderate.
--1870869256-415390768-1437571180=:12758--
