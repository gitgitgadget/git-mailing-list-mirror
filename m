Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97661F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 13:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdFENzA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 09:55:00 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:54360 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdFENxc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 09:53:32 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id HsRmdcKwm9tMzHsRmdeAoE; Mon, 05 Jun 2017 14:53:30 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=WOE9ZTkR c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=U8hVFCaAAAAA:8
 a=NEAV23lmAAAA:8 a=kmOceBAc9GRMa_SNbOMA:9 a=wPNLvfGTeEIA:10
 a=x6DZTiw5zIu89TVj_y6A:22
Message-ID: <D86B4F1CDEF64DEEB961900D30165624@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Konstantin Khomoutov" <kostix+git@007spb.ru>,
        "christienne shultz" <cpshultz86@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CAPMR3RcMK_Dt=4g6JJjQ9DVhCn7PLY2xAPXM1OgZGaqyVSeP=A@mail.gmail.com> <20170605084839.mmirmdtvlpdqgwgo@tigra>
Subject: Re: Git Error Message
Date:   Mon, 5 Jun 2017 14:54:55 +0100
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
X-Antivirus: AVG (VPS 170605-0, 05/06/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDMKSlWTE0hkmtTBq0EKUYOi2XSWztxQ6K6cleUk4bJxT1KCxnsTqYABWnUOVHKy83OzpojBrF3SIl/NTb6ewcjVtOW+xQ44z8AWAG9UtxV+n1+N4djd
 opNWihb3uvwn9rfz5gM/RojDU9yDboc+MiJ/H1v08i5s8VEGBogDxsMfhVeIj9O+XAu7WRSjwBya6DCEWhkvNEJYWxN6A7YVi430Z5v65W7hQyMcDPD5yfwY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
> On Sat, Jun 03, 2017 at 01:13:05AM -0700, christienne shultz wrote:
>
>> I have installed the Git software and upon trying to update a
>> repository by the "open recent repository" link and am unable to
>> access the menu-or anything-from there.  Instead a window pops up with
>> the following error message:
>>
>> "\usage C:\Program Files\Git\mingw64/libexec/git-core\git-GUI[
>> {blame|browser|citool}]
>>

Can you show the full error message / dialog window?

With a little bit of staring you will see the line numbers and a few clues 
about the stack history for the error (i.e. line number and variable)

>> Can you please tell me what this error message means and how to fix
>> the issue?  Thank you!
>
> A shot in the dark until someone with access to Windows chimes in (it
> appears that the "open recent repository" feature of `git gui` is specific
> to Git for Windows): have you verified that repository actually exists
> on your filesystem?

Feature is common but the implementations look slightly different

https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L123
$opts insert end [mc "Open Existing Repository"] link_open

https://github.com/git-for-windows/git/blob/master/git-gui/lib/choose_repository.tcl#L152
-text [mc "Open Recent Repository:"]

I'm not sure how the differences are created between the two source codes.

The nominal upstream by Pat Thoyts has the same as the git.git version
https://github.com/patthoyts/git-gui/blob/master/lib/choose_repository.tcl#L123


--Philip


>
> Another interesting question is whether the pathname of that repository
> includes space characters which could in principle confuse `git gui`.
> 

