Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032951F42D
	for <e@80x24.org>; Thu, 24 May 2018 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970567AbeEXOsQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 10:48:16 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:49626 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965555AbeEXOsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 10:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NDqb4ante4WBCa1wftmulWtLADZxWTWguYGyvhuKyVE=; b=qpsiG5NfGarA207uCTgeWbcXtk
        S/u41zPY9D5cLAkjZq+aTzS/96pd3y24MDrup7hxR6/Uup3rCYe4lxrsmGzrn2lQQqTce7BmHH1nM
        LYdodMTmsNQstZ0PFkYtRzu5edP4po9jyWeKK0s6JQiydgCfJC7vNjUGvG4wyldshYpBJzR6A+28L
        MNWC9QEk/rQ5VgIWMPI8Y2if0HRiCulbeW2uTsOTmQsAb3hGxwqh1a/DV/0XjSmM7m/pZDUOyoaND
        mW7lU7L82dfEdE1CdAxXe7Adz1MprCjcDsKv6FIjs6sniADvybwifbJJvvHgs1X8vmer6hBfhWJeM
        kb768XoQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:21281 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLrXI-00HFIG-9H
        for git@vger.kernel.org; Thu, 24 May 2018 10:48:13 -0400
Date:   Thu, 24 May 2018 10:46:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: "man git-tag" inconsistent about whether you can tag non-commit
 objects
Message-ID: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  embarrassed to admit i had no idea that you could tag non-commit
objects, only realized that when i was reading the man page and saw:

  SYNOPSIS
     git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
           <tagname> [<commit> | <object>]
                                 ^^^^^^^^

so i tried it and, sure enough, i could tag a blob object. but if you
read further into DESCRIPTION, about halfway through, you read:

  "Otherwise just a tag reference for the SHA-1 object name of the
   commit object is created (i.e. a lightweight tag)."
   ^^^^^^

which suggests only commit objects. finally, much further down, under
OPTIONS:

  "<commit>, <object>
     The object that the new tag will refer to, usually a commit.
                                                ^^^^^^^^^^^^^^^^

so to clean this up, is it sufficient to just change that middle line
to say "object" rather than "commit object"? or is there more in the
man page that needs tweaking?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


