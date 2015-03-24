From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: Re: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Tue, 24 Mar 2015 14:30:13 -0400
Message-ID: <20150324183013.GA15658@tsaunders-iceball.corp.tor1.mozilla.com>
References: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
 <xmqqy4msizu1.fsf@gitster.dls.corp.google.com>
 <20150319201509.GB21536@tsaunders-iceball.corp.tor1.mozilla.com>
 <xmqq3850it94.fsf@gitster.dls.corp.google.com>
 <20150320001345.GC21536@tsaunders-iceball.corp.tor1.mozilla.com>
 <5510712C.5090906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 19:31:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaTbG-0004jM-Pm
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 19:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbbCXSap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 14:30:45 -0400
Received: from tbsaunde.org ([66.228.47.254]:34316 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbCXSao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 14:30:44 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 6D84FC0A8;
	Tue, 24 Mar 2015 18:30:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5510712C.5090906@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266218>

On Mon, Mar 23, 2015 at 09:01:48PM +0100, Jens Lehmann wrote:
> Am 20.03.2015 um 01:13 schrieb Trevor Saunders:
> >On Thu, Mar 19, 2015 at 02:15:19PM -0700, Junio C Hamano wrote:
> >>Trevor Saunders <tbsaunde@tbsaunde.org> writes:
> >>I have a feeling that an optional feature that allows "git submodule
> >>update" to happen automatically from this codepath might be
> >>acceptable by the submodule folks, and they might even say it does
> >>not even have to be optional but should be enabled by default.
> >
> >ok, that seems fairly reasonable.  I do kind of wonder though if it
> >shouldn't be 'git submodule update --checkout' but that would get us
> >kind of back to where we started.  I guess since the default is checkout
> >if you set the pref then you can be assumed to have some amount of idea
> >what your doing.
> 
> Me thinks it should be "git checkout" for those submodules that have
> their update setting set to 'checkout' (or not set at all). I'm not
> sure yet if it makes sense to attempt a rebase or merge here, but that
> can be added later if necessary.

sgtm

> >>But I do not think it would fly well to unconditionally run
> >>"checkout -f" here.
> >
> >agreed
> 
> Using -f here is ok when you extend the appropriate verify functions
> in unpack-trees.c to check that no modifications will be lost (unless
> the original checkout is used with -f). See the commit 76dbdd62
> ("submodule: teach unpack_trees() to update submodules") in my github
> repo at https://github.com/jlehmann/git-submod-enhancements for
> the basic concept (There is already a fixup! for that a bit further
> down the branch which handles submodule to file conversion, maybe one
> or two other changes will be needed when the test suite covers all
> relevant cases).

ah, I see your already working a more complete solution to this sort of
issue.  I'll get out of your way then unless you want help.

Trev

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
