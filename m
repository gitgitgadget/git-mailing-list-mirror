From: Johan Herland <johan@herland.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Thu, 3 Feb 2011 14:10:58 +0100
Message-ID: <201102031410.58623.johan@herland.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <201102020322.00171.johan@herland.net> <AANLkTinrqCaD_vg7Ah4Tjgoa-njEBEmiYt15ojtsazKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 14:11:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkyxx-0007Bk-NK
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 14:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092Ab1BCNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 08:11:10 -0500
Received: from smtp.opera.com ([213.236.208.81]:51464 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab1BCNLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 08:11:09 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p13DAw0n025848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 Feb 2011 13:10:59 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTinrqCaD_vg7Ah4Tjgoa-njEBEmiYt15ojtsazKw@mail.gmail.com>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165971>

On Thursday 03 February 2011, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 2, 2011 at 9:21 AM, Johan Herland <johan@herland.net> 
wrote:
> > Migration plan:
> > ...
> > In v1.8.0, we should default to the new default refspecs when
> > creating new remotes. However, existing remotes (created
> > pre-v1.8.0) must continue to work as before, so we cannot simply
> > remove the implicit refspecs (or tag auto-following). Instead we
> > need to make sure that the implicit refspecs is NOT applied to the
> > new-style remotes. Identifying new-style vs. old-style remotes can
> > be done by looking at the refspec itself (old-style:
> > "refs/remotes/$remote/*", new-style:
> > "refs/remotes/$remote/heads/*"), or (worst case) by introducing a
> > config variable specifying the desired behavior (defaulting to
> > old-style).
>
> I'd prefer config var (remote.*.implicitRules, maybe). We don't
> reserve heads, tags... in remote namespace for ourselves. Some users
> might have already have branches heads/ant, heads/bee... making new
> style detection unreliable.
>
> So I propose add remote.*.implicitRules = false since 1.8.0 for new
> remotes as a way to detect new/old style. The default value would be
> true.
>
> But I don't want to keep adding remote.*.implicitRules on new remotes
> forever. I suppose one year after 1.8.0, the new behavior is
> widespread enough. We can then annoy users to add
> remote.*.implicitRules for all old remotes. There should be no more
> default value after 1-2 years. We then flip the default value and
> won't automatically add remote.*.implicitRules = false on new
> remotes.

I don't have a problem with this, other than bikeshedding over the 
variable name: I find remote.*.implicitFetchRefspecs more descriptive.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
