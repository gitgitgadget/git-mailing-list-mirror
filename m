Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E031F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeBIU5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:57:06 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:40803 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeBIU5G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:57:06 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Feb 2018 15:57:05 EST
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id kFbMecVvmQS2UkFbMejdXP; Fri, 09 Feb 2018 20:48:56 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=WbR8UwpX c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=CEtC_dnCAAAA:8
 a=XOxY3HnQNKVfunGf7XsA:9 a=wPNLvfGTeEIA:10 a=Fr9QGtSrJqje8MTI1nyQ:22
Message-ID: <9803DEA99A6545F7A3F9A3CE08FE2263@PhilipOakley>
Reply-To: "Philip Oakley, CEng MIET" <philipoakley@theiet.org>
From:   "Philip Oakley, CEng MIET" <philipoakley@theiet.org>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        "Git Mailing list" <git@vger.kernel.org>
References: <alpine.LFD.2.21.1802090817550.6248@android-a172fe96dd584b41>
Subject: Re: "git bisect run make" adequate to locate first unbuildable commit?
Date:   Fri, 9 Feb 2018 20:48:55 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180209-0, 09/02/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfEwHZBXpZTU+dDkftLP8oNwqTSg4yuEBnvTKkyFkhsNp5TJAqDSZbD2s07V2X+ObNUVyq9/xM4ctcj1BAAP7Aq6LhbQmz+OA+t9ewiIiHB0Fn0IWocLu
 MEsrzpcN8h03zaaf8wlUEqo09tTGt5/P3QVwflTlAU1XlACy/qFe9/Sv0wMGbE+lhX/yhyZAy1vpn2Y6zLygfO4PSoio5CC48TU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Robert P. J. Day" <rpjday@crashcourse.ca>
>
>  writing a short tutorial on "git bisect" and, all the details of
> special exit code 125 aside, if one wanted to locate the first
> unbuildable commit, would it be sufficient to just run?
>
>  $ git bisect run make
>
>  as i read it, make returns either 0, 1 or 2 so there doesn't appear
> to be any possibility of weirdness with clashing with a 125 exit code.
> am i overlooking some subtle detail here i should be aware of? thanks.
>
> rday
>

In the spirit of pedanticism, one should also clarify the word "first", in 
that it's not a linear search for _an_ unbuildable commit, but that one is 
looking for the transition between an unbroken sequence of unbuildable 
commits, which transitions to buildable commits, and its the transition that 
is sought. (there could be many random unbuildable commits within a sequence 
in some folks' processes!)
--
Philip 

