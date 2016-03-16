From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement rebase_options_load()
 and rebase_options_save()
Date: Wed, 16 Mar 2016 18:11:10 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161802080.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-6-git-send-email-pyokagan@gmail.com> <CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com> <alpine.DEB.2.20.1603160901520.4690@virtualbox>
 <CACRoPnS4JpNNACz4T0F0vFs3ogG+nzk-y1=zc1UrtAZKaEnggg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 18:11:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEyj-00061u-L3
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 18:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933838AbcCPRLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 13:11:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:60148 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932595AbcCPRLT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 13:11:19 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOBOi-1alj9n3JBs-005WpR; Wed, 16 Mar 2016 18:11:11
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnS4JpNNACz4T0F0vFs3ogG+nzk-y1=zc1UrtAZKaEnggg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/zqZ7FO5JvfHrGtTWRlG1w1gMm/r9M/B2u9NPIrZw0hsRQlTYmb
 44f5/AYlaAnWKI2U70dT65+N8ietc1AD4X5GXnXKmgTYBvkYRrCKjoe8+jaJYSgD5shEO66
 xYEJeGKuN/P/IQu89nMsQpGBb6iMLAP5feb6eaSODMd4UVe0S2XYaxaMXNPTOY4NZTVQYOP
 xANOxzMUawVHtmrzzQiEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ktdiflltlBE=:BMU0AlMSAkWXjNyiiNSnch
 +OJNw5DnHl8V+l079fO31VUa+4f06df1AuuJoN5RixUzDFQm2bssKJLlNZPIxM4DwLSfAfarJ
 Eq71P1yiqESX437V5uf/oJG+MKhMIHtvqrj1zgYo2p9KQljt85fIFyrZFgCAEd3VJnP57kjrA
 Lud7vYiBcUkvvWYiYBcJ0z53URTx/0NoAMUuxh6ywquoQ/l2v9HIoA2pJtMeRhvWb8epcA6+F
 PCBBYIQeo14sDUKhKJx0rAIZbLCAEnzxbuo+TGtylG2rny6wG4E5r4gfcPxdlfT793LvUTwGD
 DywuK/oqxId45cUitFIq6cg7t+TQ0ra34VRi6X7IJCTMwGXDYPXZIIMzDqv7Pno9rBdsxyE/u
 ahkhPnGnTbjboFYaab04O4oIsRP/5WbKdZRftvNE1eMUfoeBvnJUDgCJXOXNcRWjxavD7O9KQ
 O9o8zsyr7g/but0w5eMvAuz2NcNnj77+i3tqRWA/Lt6Hiils0nE6YeyqkOL+cH2k2gFCglruu
 PrJaq75n0Q9AV8bAKsHTox1ZOJR+LujRLv4KCJyMRY9XFJfnR4c7wgAVtz2QyrOU6x+BthuLE
 4wPImaii29fEG/Aiaju7A61FOZal3HViPoeqNeIDBCqOm1NQ5NA1xvnq+LZQALAb4ACf7tl8V
 rIivbX7V6S73+hfTbkauRnW5sluNz9un1Mc6wQz3Ko+UhylTgHE29+ayosOueqofsfNj5fc6M
 ZtUVlMflYaIWZd8ndQs9PKoT1nnyThKrVtGEUQxqEcHr1qKs9X5Qujh/Izx6Wpsa4wiaibJ3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288996>

Hi Paul,

On Wed, 16 Mar 2016, Paul Tan wrote:

> On Wed, Mar 16, 2016 at 4:04 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > In addition I want to point out that sequencer's replay_opts seem to be at
> > least related, but the patch shares none of its code with the sequencer.
> > Let's avoid that.
> >
> > In other words, let's try to add as little code as possible when we can
> > enhance existing code.
> 
> Well, both git-rebase--am.sh and git-rebase--merge.sh do not use the
> sequencer functionality at all, and we don't see git-am for example
> needing to be aware of onto, orig-head, head-name etc.

That is arguing that the implementation of --am and --merge is too far
away from the sequencer and therefore should not be made closer.

By that token, has_unstaged_changes() should never be allowed to call
init_revisions(): it *never* looks at any revisions at all!

And the idea of the sequencer is so much more related to --am and --merge
than unstaged changes are to revisions: the entire purpose of the
sequencer (no matter the *current* implementation with all its
limitations) is to apply a bunch of patches, in sequence. That is pretty
much precisely what *all* members of the rebase family are about.

In other words: please do not let current limitations dictate that we
should introduce diverging code for essentially the same workflow.

Ciao,
Dscho
