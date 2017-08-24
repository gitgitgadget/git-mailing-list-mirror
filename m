Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAEC208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 08:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdHXIYj (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 04:24:39 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57574 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbdHXIYB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 04:24:01 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1dknQc-0001fL-At; Thu, 24 Aug 2017 17:23:50 +0900
Date:   Thu, 24 Aug 2017 17:23:50 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        git-for-windows@googlegroups.com
Subject: Re: [git-for-windows] Re: Revision resolution for remote-helpers?
Message-ID: <20170824082350.6ed6jqkn6aeylvnv@glandium.org>
References: <20170818064208.plkppke7efpucuwm@glandium.org>
 <20170818220637.GN13924@aiede.mtv.corp.google.com>
 <20170818221754.3rbh35aewj5xnu4z@glandium.org>
 <20170818223323.GO13924@aiede.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1708222212320.19382@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1708222212320.19382@virtualbox>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 10:15:20PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 18 Aug 2017, Jonathan Nieder wrote:
> 
> > Mike Hommey wrote[1]:
> > > On Fri, Aug 18, 2017 at 03:06:37PM -0700, Jonathan Nieder wrote:
> > >> Mike Hommey wrote:
> > 
> > >>> The reason for the <helper>:: prefix is that it matches the <helper>::
> > >>> prefix used for remote helpers.
> > >>>
> > >>> Now, there are a few caveats:
> > [...]
> > >>> - msys likes to completely fuck up command lines when they contain ::.
> > >>>   For remote helpers, the alternative that works is
> > >>>   <helper>://<host>/etc.
> > >>
> > >> Hm --- is there a bug already open about this (e.g. in the Git for
> > >> Windows project or in msys) where I can read more?
> > >
> > > It's entirely an msys problem. Msys has weird rules to translate between
> > > unix paths and windows paths on the command line, and botches everything
> > > as a consequence. That's by "design".
> > >
> > > http://www.mingw.org/wiki/Posix_path_conversion
> > >
> > > (Particularly, see the last two entries)
> > >
> > > That only happens when calling native Windows programs from a msys
> > > shell.
> > 
> > Cc-ing the Git for Windows mailing list as an FYI.
> > 
> > I have faint memories that some developers on that project have had to
> > delve deep into Msys path modification rules.  It's possible they can
> > give us advice (e.g. about <helper>::<url> having been a bad choice of
> > syntax in the first place :)).
> 
> I think it is safe to assume that :: is not part of any Unix-y path. That
> is why the MSYS2 runtime does not try to play games with it by converting
> it to a Windows path.
> 
> (And indeed, I just tested this, an argument of the form
> "a::file://b/x/y/z" is not converted to a "Windows path")

Note that there are people out there using msys, *and* git for windows,
although I don't know if such people exist outside Mozilla.

Mike
