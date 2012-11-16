From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Fri, 16 Nov 2012 21:40:17 +0100
Message-ID: <20121116204017.GX12052@goldbirke>
References: <CAFj1UpHgPvdDeKZ-Ap7-aVx6p_pxT4a2F01ajmNa00txPyS=Qw@mail.gmail.com>
 <1352980269-15569-1-git-send-email-marc.khouzam@gmail.com>
 <CAMP44s0Guq0nYJEfbvNDyt8Oqaux-cXbTsyro6pxUnEpA4+XOw@mail.gmail.com>
 <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZSiI-0004ug-KP
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab2KPUkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:40:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:51519 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab2KPUkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:40:20 -0500
Received: from localhost6.localdomain6 (p5B130644.dip0.t-ipconnect.de [91.19.6.68])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MKqum-1TZSi20H32-00088m; Fri, 16 Nov 2012 21:40:18 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:1HFF1PK8VSIUFRqqrINeYloUq4r0o6sciOIjbQVIcky
 EjeZko9jYTEw6duFF/WzidaKq9jx3WYYmZvUxjx82cPPeHBTmF
 dPlP2E6slguatAnpTdqA9R6v8rtDFCKm87nHrPiaLIRnkOjP0J
 4VpUYGNjZ2d4tJVy4Ctn3bKwYOj6n8kN2iuZ8SVUMEPRg6M2RF
 C7yMkNRMT5lMFu+pct91iPZyCMSS+b3l6iuNrFsqUqVQ1/KVxa
 yZcazs+A4t2p7E+xVzZ4v4ea2yHJCJAhsOua5WIhVTKa8mvz+k
 ELvi4ftQt5xL99W9taAwsA27kBL9uJIZa+FJf1IX0NvsORiyJ8
 OW0wIGk6wdZ5n0139XQlrm3NoeGTtPDjz3oDIcD5l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209907>

On Fri, Nov 16, 2012 at 09:04:06PM +0100, Felipe Contreras wrote:
> > I agree, and this is why I made the proposed
> > __git_complete_with_output () generic.  That way it could be
> > used by other shells or programs.  But at this time, only tcsh
> > would make use of it.
> >
> > If you think having __git_complete_with_output () could
> > be useful for others, I think we should go with solution (A).
> > If you don't think so, or if it is better to wait until a need
> > arises first, then solution (C) will work fine.

I think it would be useful.

> I don't see how it could be useful to others, and if we find out that
> it could, we can always move the code.

For zsh, perhaps?

As I understand the main issues with using the completion script with
zsh are the various little incompatibilities between the two shells
and bugs in zsh's emulation of Bash's completion-related builtins.
Running the completion script under Bash and using its results in zsh
would solve these issues at the root.  And would allow as to remove
some if [[ -n ${ZSH_VERSION-} ]] code.
