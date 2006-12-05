X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 11:33:34 +0100
Message-ID: <45754AFE.1070207@op5.se>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <20061205090125.GA2428@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:33:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061205090125.GA2428@cepheus>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33333>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrXcK-0000ZP-80 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967468AbWLEKdh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968077AbWLEKdg
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:33:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56924 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S967468AbWLEKdg (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 05:33:36 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id C7C3B6BCC7; Tue,  5 Dec 2006 11:33:34 +0100 (CET)
To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>, Andreas Ericsson
 <ae@op5.se>, Martin Waitz <tali@admingilde.org>, Andy Parkins
 <andyparkins@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Uwe Kleine-Koenig wrote:
> Hello,
> 
> Andreas Ericsson wrote:
>> The only problem I'm seeing atm is that the supermodule somehow has to 
>> mark whatever commits it's using from the submodule inside the submodule 
>> repo so that they effectively become un-prunable, otherwise the 
>> supermodule may some day find itself with a history that it can't restore.
> One could circumvent that by creating a separate repo for the submodule
> at checkout time and pull the needed objects in the supermodule's odb
> when commiting the supermodule.  This way prune in the submodule cannot
> do any harm, because in it's odb are no objects that are important for
> the supermodule.
> 

Yes, but then you'd lose history connectivity (I'm assuming you'd only 
pull in the tree and blob objects from the submodule, and prefix the 
tree-entrys with whatever directory you're storing the submodul in).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
