Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F8520195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbcGORAt (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:00:49 -0400
Received: from gw2.007spb.ru ([78.140.204.222]:60562 "EHLO gw2.007spb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbcGORAs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 13:00:48 -0400
X-Greylist: delayed 770 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jul 2016 13:00:47 EDT
Received: from tigra.domain007.com ([192.168.2.102])
	by gw2.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u6FGlqOV031840;
	Fri, 15 Jul 2016 19:47:53 +0300
Date:	Fri, 15 Jul 2016 19:47:52 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	Ben Peart <peartben@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Plugin mechanism(s) for Git?
Message-Id: <20160715194752.f10351ae84346bd533495496@domain007.com>
In-Reply-To: <loom.20160715T181543-821@post.gmane.org>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
	<2C31984D-310C-4E8C-927B-6D98B7D7570B@gmail.com>
	<loom.20160715T181543-821@post.gmane.org>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, 15 Jul 2016 16:18:28 +0000 (UTC)
Ben Peart <peartben@gmail.com> wrote:

> > Thanks for this great summary of the problem, Christian!
> > 
> > I think a generic plugin mechanism would be great but how would we
> > do it?
> 
> I’m also very glad to see the discussion about coming up with a good
> pattern for how git can interact with external code.  I had also
> noticed all the in-flight topics as I was searching for a good
> pattern to adopt.
> 
> > 
> > We could dynamically load libraries but this would force us to
> > freeze the ABI as mentioned by Duy:
> > http://article.gmane.org/gmane.comp.version-control.git/298463
> > 
> 
> I wouldn’t be too quick to dismiss dynamically loaded libraries as
> there are some distinct advantages over the other patterns especially
> performance and simplicity.  I realize it requires us to version the
> ABI but there are established patterns to manage this.  It also isn’t
> that much different than us having to freeze or version the protocol
> for communicating with a remote-helper.

Using dynamically loaded libraries precludes or greatly complicates
creation of plugins written in languages different from C (or C++ FWIW).

So that could be okay for some type of plugins (let's call them "core")
but not really for third-party / inhouse implementations.
