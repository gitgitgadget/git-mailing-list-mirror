From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH/RFC] submodule: add ability to shallowly clone any branch
 in a submodule
Date: Fri, 12 Sep 2014 07:21:23 +0200
Message-ID: <20140912052123.GN10182@paksenarrion.iveqy.com>
References: <1410455473-2367-1-git-send-email-cole.minnaar@gmail.com>
 <5411F620.4000408@web.de>
 <1410467134-sup-6791@Sasori.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git <git@vger.kernel.org>
To: Cole <cole.minnaar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 07:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSJD0-0000ax-4r
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 07:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbaILFPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2014 01:15:42 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:47327 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbaILFPl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 01:15:41 -0400
Received: by mail-la0-f51.google.com with SMTP id gi9so240003lab.10
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C9VzqkXYqpodAVjQMgC+IloTDU/F1TllrNPtD4qr6hg=;
        b=0Nt3apNpN48WGmL0SK/mVfBF5yr4EVw5Ynv83+MMOK0bHhQfFhEsHqWyGc9mMByebM
         /WXD5DXxZu9rmXV1TxIbOpJGggCS6xgabe46XwgwG4cMrqpStI0qmn8YkMRpRNLmTaMj
         YfBs7aWlWRARdFki5Tqp5jEP0gb4KanHdU5sG6qJ/fv3aWtA7LfcCkLKy2OSVoKxpduj
         2cUtufNq+/LECcXoYG5ocU6xyBrQsMtWUnsNyfcADua0Q14aJf62V/OUnDdULztitLH7
         N3dkwU7cudU4DTsWwfOP10PESwwlBCCONeM0r6yCEzt7CPDvV2uFMVTYIUErAd0Do27w
         N6BQ==
X-Received: by 10.152.27.38 with SMTP id q6mr6183514lag.60.1410498940125;
        Thu, 11 Sep 2014 22:15:40 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-250-238-252.bredband.comhem.se. [83.250.238.252])
        by mx.google.com with ESMTPSA id oc1sm933934lbb.45.2014.09.11.22.15.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Sep 2014 22:15:39 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.82)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1XSJIR-0007qt-PA; Fri, 12 Sep 2014 07:21:23 +0200
Content-Disposition: inline
In-Reply-To: <1410467134-sup-6791@Sasori.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256901>

On Thu, Sep 11, 2014 at 10:33:51PM +0200, Cole wrote:
> Also if there is anything else you are currently looking at regarding
> submodules or thinking about, I would be glad to hear about it or to =
try
> look at it while I am working on these changes. Or if there is anythi=
ng
> you can think of for me to check with regards to these changes that
> would also be appreciated.

When implementing the --depth argument for submodules, I would have
prefered that the depth was set from the commit of the submodules
refered from the superprojekt and not it's branch.

However this can't be done, since you can only clone from refs and not
from a commit. However there's nothing that stops us from allowing to
clone from a commit (of course we need to make sure that that commit is
in a tree with a ref as leaf).

I see this as a natural next step for the --depth function and somethin=
g
needed for it to be really useful. I'm actually suprised that people
successfully uses the --depth function already since you always need to
know how deep down the commit is.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
