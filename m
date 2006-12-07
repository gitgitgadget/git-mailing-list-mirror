X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git pull and merging.
Date: Thu, 7 Dec 2006 23:54:01 +0100
Message-ID: <200612072354.01830.Josef.Weidendorfer@gmx.de>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <200612071227.46194.Josef.Weidendorfer@gmx.de> <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 22:54:28 +0000 (UTC)
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vhcw7ttj9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33644>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsS8D-0002aG-G0 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163559AbWLGWyI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163563AbWLGWyI
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:54:08 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:36119 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1163559AbWLGWyE (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 17:54:04 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 3D0842236; Thu,  7
 Dec 2006 23:54:03 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thursday 07 December 2006 20:06, you wrote:
> Once you place something like "branch.*.merge" in configuration
> file (either $GIT_DIR/config, or a $GIT_DIR/remotes/* file), you
> are talking about other repositories you regularly interact
> with, so it might be probably Ok to require the user to use a
> tracking branch if he wants the convenience of "branch.*.merge",
> and make its value name the local tracking branch instead of the
> remote branch.
> 
> But that means I would never be able to benefit from the
> convenience of "branch.*.merge";

Hmm... that's true; actually, I did not thought about people
which do not want to have any tracking branches (again!). So

[remote "repo"]
  url = ...
  fetch = branch1
  fetch = branch2

[branch "mybranch1"]
  remote = repo
  merge = branch1

actually looks fine, and is the only possible way.
But still, this does not work. You have to specify

  merge = refs/heads/branch1

That's confusing (perhaps I can come up with a patch
to allow "branch1" alone).

So probably the best way is to write some more detailed
explanation into the docu ...

