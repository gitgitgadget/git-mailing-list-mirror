X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 23:51:22 +0200
Message-ID: <845b6e870610241451x578efe9n77017f3a9404e81c@mail.gmail.com>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	 <87zmbozau2.wl%cworth@cworth.org>
	 <20061022185350.GW75501@over-yonder.net>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
	 <20061024002657.GD17019@over-yonder.net>
	 <87y7r6zgic.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 24 Oct 2006 21:52:12 +0000 (UTC)
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j5nHQ9qwpD2foajj2hybHqFhsH3L5vZFjSmtOhwNLSCffTTeL4p1U5N+/Nekyk+SMHuuq8bGuB934zboK7NArDlmrWsF4NCx7OxeXdESjmzz/G2S+pDFOHXb9StKiyBthgpnnjJqHDXHjVykMYBRq2UVvgTIS9DvZ2eEJpPm3xA=
In-Reply-To: <87y7r6zgic.wl%cworth@cworth.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30015>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcUBE-0003Mz-Vd for gcvg-git@gmane.org; Tue, 24 Oct
 2006 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422644AbWJXVvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWJXVvZ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 17:51:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:45122 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1161226AbWJXVvY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 17:51:24 -0400
Received: by nz-out-0102.google.com with SMTP id z3so754059nzf for
 <git@vger.kernel.org>; Tue, 24 Oct 2006 14:51:23 -0700 (PDT)
Received: by 10.35.94.7 with SMTP id w7mr9680028pyl; Tue, 24 Oct 2006
 14:51:22 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Tue, 24 Oct 2006 14:51:22 -0700 (PDT)
To: "Carl Worth" <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Sorry for going back to an old mail... but....

On 10/24/06, Carl Worth <cworth@cworth.org> wrote:
> On Mon, 23 Oct 2006 19:26:57 -0500, "Matthew D. Fuller" wrote:
> >
> > On Mon, Oct 23, 2006 at 04:24:30PM -0700 I heard the voice of
> > Linus Torvalds, and lo! it spake thus:
> > >
> > > The problem? How do you show a commit that is _common_ to two
> > > branches, but has different revision names in them?
> >
> > Why would you?
>
> Assume you've got two long-lived branches and one periodically gets
> merged into the other one. The combined history might look as follows
> (more recent commits first):
>
>  f   g
>  |   |
>  d   e
>  |\ /
>  b c
>  |/
>  a
>
> The point is that it is extremely nice to be able to visualize things
> that way. Say I've got a "dev" branch that points at f and a "stable"
> branch that points at g. With this, a command like:
>
>         gitk dev stable
>
> would result in a picture just like the above. Can a similar figure be
> made with bzr? Or only the following two separate pictures:

I wanted to test how hard it is. So I created a small plugin that will
show the relationsships between revisions... The following commands

bzr init-repo repo --trees
bzr init repo/branchA
cd repo/branchA
bzr whoami --branch "Test Devel 1 <test1@devel.com>"
bzr ci --unchanged -m a1
bzr ci --unchanged -m a2
bzr branch . ../branchB
bzr ci --unchanged -m a3
bzr ci --unchanged -m a4
cd ../branchB
bzr whoami --branch "Test Devel 2 <test2@devel.com>"
bzr ci --unchanged -m b1
bzr ci --unchanged -m b2
bzr merge ../branchA
bzr ci -m merge
bzr ci --unchanged -m b3
bzr ci --unchanged -m b4
cd ../branchA
bzr merge ../branchB
bzr ci -m merge
bzr ci --unchanged -m a5
cd ../branchB
bzr ci --unchanged -m b5
cd ..
bzr dotrepo > test.dot
dot -Tpng test.dot > dotrepo.png

Creates the picture you can see at
http://erik.bagfors.nu/bzr-plugins/dotrepo.png

Please remember that this is a 15 min implementation and as such might
suck (the output is not perfect for example, it's slow, etc).  This
just brings in every revision in the entire repo, but to expand it to
just take the branches on the command line, is perfectly possible.

But still.. there is no problem to create this.

/Erik
ps. the plugin can be bzr branched from
http://erik.bagfors.nu/bzr-plugins/dotrepo/
-- 
google talk/jabber. zindar@gmail.com
SIP-phones: sip:erik_bagfors@gizmoproject.com
