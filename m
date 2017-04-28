Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C8D207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 12:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425863AbdD1Mwr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 08:52:47 -0400
Received: from elephants.elehost.com ([216.66.27.132]:32386 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425861AbdD1Mwp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 08:52:45 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v3SCqWGP039736
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 28 Apr 2017 08:52:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Miguel Angel Soriano Morales'" <miguelangel.soriano@esail.es>,
        <git@vger.kernel.org>
References: <000e01d2c002$2dfa4650$89eed2f0$@esail.es>
In-Reply-To: <000e01d2c002$2dfa4650$89eed2f0$@esail.es>
Subject: RE: Git and Active directory ldap Authentication
Date:   Fri, 28 Apr 2017 08:52:25 -0400
Message-ID: <000a01d2c01e$4d9a37b0$e8cea710$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIf/XPl2lLtemioRAphjug3Yo+3yaFAP3PQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 28, 2017 5:31 AM  Miguel Angel Soriano Morales wrote:
> I would like use git in my Company. We use Active directory for
everything, but I prefer install git in ?
> centos7. I Would like authenticate all my user in Git through Active
Directory. And Every Project had
> ACL permissions .It this possible?

The first thing to remember is that local clones will usually be secured to
the user who did the clone and are not usually subject to enterprise
security rules or ACLs. Security is usually applied when interacting with an
upstream repository from where you clone and push changes and authentication
is important at that time.

This might help:

https://technet.microsoft.com/en-us/library/2008.12.linux.aspx

This discusses SSO for Linux. You should already be covered for Windows.
However please give details on where your upstream repository is and what
server which is likely where you have to authenticate. Typically
authentication to upstream repositories is done through SSH - see git push. 

There are discussions of integrating SSH keys and AD here (and elsewhere):
https://social.technet.microsoft.com/Forums/en-US/8aa28e34-2007-49fe-a689-e2
8e19b2757b/is-there-a-way-to-link-ssh-key-in-ad?forum=winserverDS

You should also consider when, in your environment, to use GPG signing to
definitively identify who did the change even in their local repository. AD
is unlikely to help you there, unless you can use a custom attribute to
store and manage a user's GPG key.

Good luck!

Cheers,
Randall


