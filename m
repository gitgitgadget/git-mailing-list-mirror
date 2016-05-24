From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 17:02:16 -0400
Message-ID: <005601d1b5ff$90f442f0$b2dcc8d0$@nexbridge.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr> <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr> <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr> <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com> <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com> <166C4E9F-6231-47ED-88F3-EAD95DEE7DF2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>,
	"'Francois Beutin'" <beutinf@ensimag.grenoble-inp.fr>,
	"'Git Mailing List'" <git@vger.kernel.org>,
	"'simon rabourg'" <simon.rabourg@ensimag.grenoble-inp.fr>,
	"'wiliam duclot'" <wiliam.duclot@ensimag.grenoble-inp.fr>,
	"'antoine queru'" <antoine.queru@ensimag.grenoble-inp.fr>
To: "'Lars Schneider'" <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 24 23:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5JTH-0002Y6-1e
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 23:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbcEXVCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 17:02:30 -0400
Received: from elephants.elehost.com ([216.66.27.132]:11397 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbcEXVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 17:02:30 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u4OL2Mwu099384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 May 2016 17:02:23 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <166C4E9F-6231-47ED-88F3-EAD95DEE7DF2@gmail.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIL2Z0EoI8qcR9zrUX6F0hnJju9VgLJLMcyAaESwn4C9DPPywHjk1f3AhzO6WECQCA7aAFTJijBAn9O5jABbBeZxJ69XRpQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295532>

On May 24, 2016 3:25 PM Lars Schneider wrote:
> > On 24 May 2016, at 12:16, Randall S. Becker <rsbecker@nexbridge.com>
> wrote:
> >
> > On May 24, 2016 12:08 PM, Matthieu Moy wrote:
> >>> So, when trying a forbidden push, Git would deny it and the only way
> >>> to force the push would be to remove the blacklist from the config,
right?
> >>>
> >>> Probably the sanest way to go. I thought about adding a "git push
> >>> --force-even-if-in-blacklist" or so, but I don't think the feature
> >>> deserves one specific option (hence add some noise in `git push -h`).
> >>
> >> Yeah, I agree --even-if-in-blacklist is a road to madness, but I
> >> wonder how this is different from setting pushURL to /dev/null or
> >> something illegal and replace that phony configuration value when you
> really need to push?
> >
> > May be missing the point, but isn't the original intent to provide
policy-
> based to control the push destinations? A sufficiently knowledgeable
person,
> being a couple of weeks into git, would easily see that the config points
to a
> black-listed destination and easily bypass it with a config update,
rendering
> all this pointless? This seems to me to be a lot of effort to go to for
limited
> value - unless immutable attributes are going to be obtained from the
> upstream repository - which also seems to run counter to the whole point.
> 
> An actor with a bad intent will *always* be able to bypass this. However,
I
> see two use cases:
> 
> (1) Accidental pushes.
> An inexpierenced developer clones a repo from github.com, commits for
> whatever reason company code and pushes. At this point the code leaked.
> The blacklist feature could have warned/stopped the developer.
> 
> (2) Intentional open source pushes.
> At my day job we encourage people to contribute to open source. However,
> we want them to follow our open source contribution process. If they run
> "git push" on a new github.com repo then I want to interrupt the push and
> tell them to look at our contribution guidelines. Afterwards they could
> whitelist the repo on their local machine and push without trouble.
> 
> In summary I think the feature could be a safety net for the developer to
not
> leak company code.

A more paranoid ;) and probably safer approach to satisfy UC.2 is to use
something like Github Enterprise or Stash on a local server inside your
firewall as the place where developers are allowed to push code, and then
firewall block external entities. If you want to allow sharing of specific
repositories, set up a pull from the remote that is allowed through the
firewall and that server on a specific branch that can be shared (the branch
should obviously be secured by a person in a different role/function - or
set up a Jenkins job to do the push, perhaps, from that server. This could
be considered potentially a closer implementation of your contribution
process. For UC.1, if your clone is done via anonymous HTTPS, and push via
SSH, accidents are less likely to happen, particularly if SSH to github is
blocked at the firewall. I think there may be technical solutions to your
problem that do not involve modification to git. These are just suggestions
from what I have observed others doing in harsher environments.

Cheers,
Randall
