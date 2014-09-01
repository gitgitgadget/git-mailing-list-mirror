From: "Finucane, Stephen" <stephen.finucane@intel.com>
Subject: Dealing with conflicting tags - multiple remotes
Date: Mon, 1 Sep 2014 15:36:22 +0000
Message-ID: <6A74A01C3512C646A9ED99AFA28AEB9813F6F138@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Gray, Mark D" <mark.d.gray@intel.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 17:37:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOTfW-0003u9-Am
	for gcvg-git-2@plane.gmane.org; Mon, 01 Sep 2014 17:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbaIAPg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 11:36:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:40546 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101AbaIAPg5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2014 11:36:57 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 01 Sep 2014 08:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,443,1406617200"; 
   d="scan'208";a="566670812"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by orsmga001.jf.intel.com with ESMTP; 01 Sep 2014 08:36:23 -0700
Received: from irsmsx108.ger.corp.intel.com ([169.254.11.157]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.112]) with mapi id 14.03.0195.001;
 Mon, 1 Sep 2014 16:36:22 +0100
Thread-Topic: Dealing with conflicting tags - multiple remotes
Thread-Index: Ac/F+VK/5wO5U2eeSkaWPYUTHoJojA==
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256307>

Hi,

Take a repo with multiple remotes. These remotes each have a specific branch/tag naming convention, and there are tags in each that conflict with those in other remotes. In order to avoid conflicts, it seems possible to add something like this to the '.git/config' file:

    [remote "origin"]
        url = git@github.com:schacon/simplegit-progit.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = +refs/tags/*:refs/tags/origin/*

This is discussed here:

    http://stackoverflow.com/a/5496610
    http://git-scm.com/book/en/Git-Internals-The-Refspec

However, when you try to pull in these tags, you'll see two different sets of tags - one with the prefix ('origin' above) and one without. Why is this? Is this a bug, or by design?

If this is not the recommended approach to avoid conflicts, could someone suggest a better one?

Regards,
Stephen Finucane

PS: system info -
 * Fedora 20 64-bit (3.15.7-200.fc20.x86_64)
 * git version 1.9.3

--------------------------------------------------------------
Intel Shannon Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
Business address: Dromore House, East Park, Shannon, Co. Clare

This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). Any review or distribution by others is strictly prohibited. If you are not the intended recipient, please contact the sender and delete all copies.
