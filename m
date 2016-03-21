From: Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 21:01:01 +0100
Message-ID: <20160321200101.GE20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
 <20160321192904.GC20083@spk-laptop>
 <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:01:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai60k-0002oO-QN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbcCUUBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:01:06 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:34223 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbcCUUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:01:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id 42DB7FF016;
	Mon, 21 Mar 2016 20:01:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqvb4fliq6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289450>

On Mon, Mar 21, 2016 at 12:43:45PM -0700, Junio C Hamano wrote:
> > You know that when you have sign configuration enabled globally annotate is
> > implicite, so its difficult to join both world.
> 
> Sorry, I am not sure what you mean by that.  It is unclear what two
> worlds you are referring to.

Command line options and configuration, but forget about it.

> 
> > I use same idea as in your patch
> > `55ca3f99ae4895605a348322dd2fc50f2065f508`.
> 
> That is not a good comparison.  55ca3f99 (commit-tree: add and
> document --no-gpg-sign, 2013-12-13) is about signed commit, and over
> there there are only two choices, i.e. a commit that corresponds to
> an annotated tag, and a signed commit that corresponds to a signed
> tag.  There is no "lightweight-tag" equivalent.
> 
> >> If you are forcing users to always leave a message and then further
> >> forcing users to always sign with the single new configuration, i.e.
> >> 
> >>     $ git tag v1.0
> >>     ... opens the editor to ask for a message ...
> >>     ... then makes the user sign with GPG ...
> >
> > I'm not forcing this type of user to enable global configuration, that will be
> > annoying for them of course.
> 
> Good.
> 
> If so, then the configuration is "when the user gives us a message
> to create a tag without explicitly saying -a/-s, we create an
> annotated tag by default, but create a signed tag instead in such a
> case", I would think.  That is:
> 
>     $ git tag -m 'foo' $tagname
> 
> would create signed tag under such a configuration option, and I
> think such an option may make sense.  And the way to override it
> would be
> 
>     $ git tag -a -m 'foo' $tagname
> 
> So there is no need for --no-sign option.  When the user explicitly
> asks to create an annotated tag with
> 
>     $ git tag -a -m 'foo' $tagname
> 
> it is unreasonable to override that explicit wish with a
> configuration setting.
> 

Ah, I think I understand now, I think this will not take to much effort to fix.

-- 
Laurent
