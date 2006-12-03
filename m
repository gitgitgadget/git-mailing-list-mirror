X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 02:02:34 +0100
Message-ID: <200612030202.34990.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <200612021450.46005.Josef.Weidendorfer@gmx.de> <20061202204350.GV18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 01:02:46 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061202204350.GV18810@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33073>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqfkg-0007S4-NS for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936605AbWLCBCj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936607AbWLCBCj
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:02:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52941 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936605AbWLCBCj (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:02:39 -0500
Received: (qmail invoked by alias); 03 Dec 2006 01:02:37 -0000
Received: from p5496B2C8.dip0.t-ipconnect.de (EHLO noname) [84.150.178.200]
 by mail.gmx.net (mp028) with SMTP; 03 Dec 2006 02:02:37 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 21:43, Martin Waitz wrote:
> On Sat, Dec 02, 2006 at 02:50:45PM +0100, Josef Weidendorfer wrote:
> > On Saturday 02 December 2006 11:04, Andy Parkins wrote:
> > > > So what do you do with deleted submodules?
> > > > You wouldn't want them to still sit around in your working directory,
> > > > but you still have to preserve them.
> > > 
> > > Now that is a tricky one.  Mind you, I think that problem exists for any 
> > > implementation.  I haven't got a good answer for that.
> > 
> > That suggests that it is probably better to separate submodule repositories
> > from their checked out working trees. Why not put the GITDIRs of the submodules
> > in subdirectories of the supermodules GITDIR instead?
> 
> Why not simply use a shared object database instead?

Sure. I have no problem with this.

But can we go one step further?
AFAICS your submodules store the .git/ directories of submodules directly
at submodule position in the working tree - but you have a link .git/objects
into the object database of the supermodule.
When the user wants to delete the submodule, he would remove this .git/ directory,
too. So you loose the .git/refs of the submodule etc. I would suggest to put
the submodule .git dirs into the .git dir of the supermodule.

