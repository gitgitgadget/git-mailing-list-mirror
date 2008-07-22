From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: Computing the number of patches in linux-next tree
Date: Tue, 22 Jul 2008 10:13:32 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA306640DDC@orsmsx505.amr.corp.intel.com>
References: <12c511ca0807220919q4db6ee1fr33dc70fe35c58efe@mail.gmail.com>
 <alpine.DEB.1.00.0807221727210.8986@racer>
 <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLSC-0003Xf-94
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbYGVROM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 13:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYGVROM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 13:14:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:44122 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVROL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jul 2008 13:14:11 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 22 Jul 2008 10:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.31,232,1215414000"; 
   d="scan'208";a="420889715"
Received: from unknown (HELO azsmsx001.amr.corp.intel.com) ([10.2.167.98])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2008 10:13:41 -0700
Received: from orsmsx505.amr.corp.intel.com (10.22.226.208) by
 azsmsx001.amr.corp.intel.com (10.2.167.98) with Microsoft SMTP Server (TLS)
 id 8.1.240.5; Tue, 22 Jul 2008 10:13:40 -0700
Received: from orsmsx505.amr.corp.intel.com ([10.22.226.208]) by
 orsmsx505.amr.corp.intel.com ([10.22.226.208]) with mapi; Tue, 22 Jul 2008
 10:13:34 -0700
Thread-Topic: Computing the number of patches in linux-next tree
Thread-Index: AcjsHRWUU4VIpyhoQ6qcqa3+GtJQIQAADZ1w
In-Reply-To: <7vabg9n93f.fsf@gitster.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89505>

>> git merge-base --all <branch1> <branch2>
>>
>> Be warned: there might be multiple merge bases.
>
> I do not think that approach applies to linux-next, which is constantly
> rewound to the then-tip-of-linus and merge remaining bits.  The question
> is "where does this branch begin", which does not have an answer in git.

Using git merge-base on the next-20080701 tag and current Linus tree I get
76 possible merge bases.  None of them appear to be the "right" one (if
I check out this tag and look at Next/merge.log the right answer appears
to be 1702b52 if I'm reading the log correctly).

Perhaps my best hope is to
        $ git checkout $tag Next/merge.log
        ... parse merge.log to figure out $base ...

-Tony
