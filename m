From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: RE: [PATCH 1/2] Demonstrate bugs when a directory is replaced with
 a symlink.
Date: Wed, 29 Jul 2009 09:57:36 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB342402A13@azsmsx507.amr.corp.intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <4A70062A.4040008@drmicha.warpmail.net>
 <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCTP-0006KY-S2
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbZG2Q5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755863AbZG2Q5l
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:57:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:33440 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806AbZG2Q5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 12:57:40 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 29 Jul 2009 09:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,289,1246863600"; 
   d="scan'208";a="434415818"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2009 10:04:21 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Wed, 29 Jul 2009
 09:57:37 -0700
Thread-Topic: [PATCH 1/2] Demonstrate bugs when a directory is replaced with
 a symlink.
Thread-Index: AcoQJ0ZwApSLgiTtTISb1ql6yzXO4AARkt9A
In-Reply-To: <7v4osvyjl2.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124372>

On Wed, Jul 29, 2009, Junio C Hamano<gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> Isn't the failure of the second test caused by that of the first one?
>> a/b-2/c/d is gone from the worktree, and master does not touch it, so
>> the merge leaves the worktree version (non-existent) as is.
>
> To avoid that impression the second test should probably have been written
> to start from a clean slate, using "reset --hard" or something.

I'll send a new patch shortly that combines the two tests into one and
includes the "reset --hard".

> Kjetil's patch actually fixes the first one, but the second one will still
> show breakage.
>
> I wonder if the breakage is in recursive merge or in the generic read-tree
> three-way merge code.  I highly suspect that using "git merge -s resolve"
> would make the test pass.  Historically recursive merge is known to be
> careless in many corner cases.

You're right, using the resolve strategy does make the test pass.

James
