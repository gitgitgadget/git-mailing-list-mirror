Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12A591F404
	for <e@80x24.org>; Sun, 15 Apr 2018 17:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDORRY (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 13:17:24 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:61769 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDORRX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 13:17:23 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 7lHEfc8iLLjjA7lHEfVBKL; Sun, 15 Apr 2018 18:17:22 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=EN3i_-nqppLNFYm6C0sA:9 a=QEXdDO2ut3YA:10
Message-ID: <BA40DE939AF14BC18B496FDA27281CA2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     <phillip.wood@dunelm.org.uk>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        "Git List" <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Phillip Wood" <phillip.wood@dunelm.org.uk>,
        "Igor Djordjevic" <igor.d.djordjevic@gmail.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        "Sergey Organov" <sorganov@gmail.com>
References: <cover.1519680483.git.johannes.schindelin@gmx.de> <cover.1523362469.git.johannes.schindelin@gmx.de> <fb797f32b7385317b9dc18524e3863ba627f6c98.1523362469.git.johannes.schindelin@gmx.de> <2bec489c-521e-0277-3a15-00b39126e652@talktalk.net>
Subject: Re: [PATCH v6 04/15] sequencer: introduce new commands to reset the revision
Date:   Sun, 15 Apr 2018 18:17:20 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180414-2, 14/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfEo4oo9d3G+neUDVIC1gSy8F0GDAtnQESYvJsV4lYTP4RjCtNJaIoADf+1yEdS8vNTlcd3rPA7YmRX9GxPe6SD5o5Fz7KO4EiUEb45dzJxV8Esm5Qp9/
 iC5cy89BJjWYTF09GazUF1ETkeGjgt4w93MlICZsI7xSRPrsZXNpOYVOgSnuxf7wqIYOvWhdpgXqKzjajwHetC6dkMoQsRODy3fcN2AFWFCnNi7mFOQms4OI
 Q8182JQgfZhJuZFU2mHLUpzH2g+OU3YOIEbu1DW6xbJHtOSuBWgMdsgWaJ1f/EYTrLFpezb8DyDLtwbG9V2bEFVofLujtj6GOO2USvUDnI0xKHqmwATO8Uwo
 sonqfCFMOKi2dzZXapr/N7P0RHPnyfNifURGgC//5uXgcitqDrCUKT2ALkDRNAsx+mPzDo878k4E8YFNl034BU5My3pxqfJ33kO1r9IxXlJmB57HPmoZX1d0
 ySWM61iXq14+vdo3kckjBxQlNy7o+Ne3I6+3ZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Phillip Wood" <phillip.wood@talktalk.net>
: Friday, April 13, 2018 11:03 AM
> If a label or reset command fails it is likely to be due to a
> typo. Rescheduling the command would make it easier for the user to fix
> the problem as they can just run 'git rebase --edit-todo'. 

Is this worth noting in the command documentation? 
"If the label or reset command fails then fix
the problem by runnning 'git rebase --edit-todo'." ?

Just a thought.

> It also
> ensures that the problem has actually been fixed when the rebase
> continues. I think you could do it like this
> 
<snip>
--
Philip
(also @dunelm, 73-79..)
