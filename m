From: Bill Lear <rael@zopyra.com>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 09:48:31 -0600
Message-ID: <17893.42063.186763.291346@lisa.zopyra.com>
References: <17892.64236.443170.43061@lisa.zopyra.com>
	<20070228035713.GC5597@spearce.org>
	<20070228044719.GA6068@spearce.org>
	<17893.40847.313519.283218@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:48:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMR2i-0007Vg-7s
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbXB1Pse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbXB1Pse
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:48:34 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60585 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbXB1Pse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:48:34 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SFmXc21837;
	Wed, 28 Feb 2007 09:48:33 -0600
In-Reply-To: <17893.40847.313519.283218@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40950>

On Wednesday, February 28, 2007 at 09:28:15 (-0600) Bill Lear writes:
>On Tuesday, February 27, 2007 at 23:47:19 (-0500) Shawn O. Pearce writes:
>>"Shawn O. Pearce" <spearce@spearce.org> wrote:
>>> Bill Lear <rael@zopyra.com> wrote:
>>> > Using 1.5.0.1.  Can't see what is wrong with this clone...
>>> ...
>>> > Indexing 4589 objects.
>>> > remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
>>> >  100% (4589/4589) done
>>> > Resolving 2209 deltas.
>>> > fatal: cannot pread pack file: Success
>>> > fatal: index-pack died with error code 128
>>> > fetch-pack from '/home/rael/devel/project/.git' failed.
>>> 
>>> I think the pread() in get_data_from_pack of index-pack is wrong,
>>> it really should be looping until we fill the buffer in case the
>>> OS doesn't fully satisfy our read request the first time.
>>
>>Does this fix your problem?
>
>Just got back: I will try applying this patch and testing with it
>and let you know.

No, does not fix.  I added a bit more printout on the error:

% git clone --bare ~/devel/project
Initialized empty Git repository in /austin/users/rael/repos/git/project
remote: Generating pack...
remote: Done counting 4594 objects.
remote: Deltifying 4594 objects.
remote:  100% (4594/4594) done
Indexing 4594 objects.
remote: Total 4594 (delta 2210), reused 4591 (delta 2209)
 100% (4594/4594) done
Resolving 2210 deltas.
fatal: cannot pread pack file: Success [n=0; rdy=0; len=207]
fatal: index-pack died with error code 128
fetch-pack from '/home/rael/devel/fusion/.git' failed.


Bill
