X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 5 Dec 2006 10:01:25 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061205090125.GA2428@cepheus>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 09:01:40 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Uwe Kleine-Koenig <zeisberg@informatik.uni-freiburg.de>,
	Andreas Ericsson <ae@op5.se>, Martin Waitz <tali@admingilde.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <456F29A2.1050205@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33321>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWBE-0006Om-1l for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968121AbWLEJBd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968122AbWLEJBd
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:01:33 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:51340 "EHLO
 atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S968121AbWLEJBc (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5
 Dec 2006 04:01:32 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6]) by
 atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60) (envelope-from
 <zeisberg@informatik.uni-freiburg.de>) id 1GrWB9-00064D-NW; Tue, 05 Dec 2006
 10:01:31 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1]) by
 login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id
 kB591Tnq007575; Tue, 5 Dec 2006 10:01:29 +0100 (MET)
Received: (from zeisberg@localhost) by login.informatik.uni-freiburg.de
 (8.13.6/8.12.11/Submit) id kB591T1c007560; Tue, 5 Dec 2006 10:01:29 +0100
 (MET)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hello,

Andreas Ericsson wrote:
> The only problem I'm seeing atm is that the supermodule somehow has to 
> mark whatever commits it's using from the submodule inside the submodule 
> repo so that they effectively become un-prunable, otherwise the 
> supermodule may some day find itself with a history that it can't restore.
One could circumvent that by creating a separate repo for the submodule
at checkout time and pull the needed objects in the supermodule's odb
when commiting the supermodule.  This way prune in the submodule cannot
do any harm, because in it's odb are no objects that are important for
the supermodule.

Uwe

-- 
Uwe Kleine-Koenig

