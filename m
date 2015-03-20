From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Thu, 19 Mar 2015 20:13:45 -0400
Message-ID: <20150320001345.GC21536@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
 <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqq3850it94.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYkZX-0003Cn-Ig
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 01:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbbCTANv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 20:13:51 -0400
Received: from tbsaunde.org ([66.228.47.254]:57563 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCTANu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 20:13:50 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id E5A9EC07C;
	Fri, 20 Mar 2015 00:13:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq3850it94.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265853>

On Thu, Mar 19, 2015 at 02:15:19PM -0700, Junio C Hamano wrote:
> Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> 
> > On one hand it seems kind of user hostile to just toss out any changes
> > in the submodule that are uncommitted, on the other for any other path
> > it would seem weird to have git checkout trigger rebasing or merging.
> 
> I think that is exactly why we do not do anything in this codepath.

yeah, and not only is it weird, but git diff will still report that
there's a difference which I imagine people will find strange.

> I have a feeling that an optional feature that allows "git submodule
> update" to happen automatically from this codepath might be
> acceptable by the submodule folks, and they might even say it does
> not even have to be optional but should be enabled by default.

ok, that seems fairly reasonable.  I do kind of wonder though if it
shouldn't be 'git submodule update --checkout' but that would get us
kind of back to where we started.  I guess since the default is checkout
if you set the pref then you can be assumed to have some amount of idea
what your doing.

> But I do not think it would fly well to unconditionally run
> "checkout -f" here.

agreed

Trev

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
