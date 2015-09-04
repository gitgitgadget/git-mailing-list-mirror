From: John Keeping <john@keeping.me.uk>
Subject: Re: determine name of tag used for checkout when multiple tags exist?
Date: Fri, 4 Sep 2015 12:19:15 +0100
Message-ID: <20150904111915.GB27660@serenity.lan>
References: <CAL3By-8odLE53iBiNATgiCcnK4Ef5uBeH7E6EMB1K7P-oX0oAQ@mail.gmail.com>
 <20150904075400.GA27660@serenity.lan>
 <CAL3By-8ieAQPyR9k63_T5Fa9ZnAY8qSNZUpr_=fxebEcN=Zi7g@mail.gmail.com>
 <CAL3By-8cgAz1Jau3NO0kkHAVwvy3hPMMUn=xwUtY78TE5WE9vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jesse Hopkins <jesse.hops@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 13:19:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXp1l-0006b8-H2
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 13:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbbIDLT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 07:19:26 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:43460 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbIDLTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 07:19:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id AC26BCDA585;
	Fri,  4 Sep 2015 12:19:24 +0100 (BST)
X-Quarantine-ID: <U20PE4-9u0tw>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id U20PE4-9u0tw; Fri,  4 Sep 2015 12:19:23 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E3D51CDA5D3;
	Fri,  4 Sep 2015 12:19:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAL3By-8cgAz1Jau3NO0kkHAVwvy3hPMMUn=xwUtY78TE5WE9vw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277299>

[It looks like your reply didn't get through to the mailing list,
 presumably because it contained a text/html part.]

On Fri, Sep 04, 2015 at 04:22:04AM -0600, Jesse Hopkins wrote:
> On Sep 4, 2015 1:54 AM, "John Keeping" <john@keeping.me.uk> wrote:
> > When I checkout a tag, "git reflog -1" gives something like:
> >
> >         989d251 HEAD@{0}: checkout: moving from master to v0.9.2
> >
> > Since whitespace isn't permitted in tag names you can do something like:
> >
> >         tag=$(git reflog -1)
> >         tag=${tag##* }
> >         git cat-file tag "$tag" >/dev/null 2>&1 || echo "not a tag!"
> 
> Thanks John that seems promising. One limitation it seems is that the
> reflog doesn't contain the tag name on a freshly cloned repo which used the
> tag as the -b option.   However it seems I can recover the tag name from
> the reflog so long as I clone against something other than the tag,  then
> checkout the tag.

I think it would be a reasonable enhancement to include the branch name
in the reflog message if "-b" is given to "git clone", but I'm not aware
of any (formal) policy on the format of reflog messages so relying on
any particular message may not be 100% reliable across Git upgrades.
