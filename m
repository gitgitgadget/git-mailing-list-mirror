X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Mon, 11 Dec 2006 11:50:59 +0100
Message-ID: <dbfc82860612110250g73708f7al88c1b50acb2c0dcd@mail.gmail.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:51:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=URyWOG0IcsIEc/G/BdIABSppaJaDCoqx5mE592mdrVUXBqctleaEb1ARddq7q5VMDjiCgsBRdEphZZy6U4Ji2CX8ljKRMTwUiZrBO736kr8GArVdBPufcbgd1A7mg4yectHoRdzy60iyK21Y5KCobbar3IDye/Q5ACk87zhYVrM=
In-Reply-To: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Content-Disposition: inline
X-Google-Sender-Auth: c6e073b88a9ec233
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33991>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtikU-0000BI-MY for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762653AbWLKKvB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762654AbWLKKvB
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:51:01 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:45150 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762653AbWLKKvA (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 05:51:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1547623wxd for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 02:51:00 -0800 (PST)
Received: by 10.90.78.1 with SMTP id a1mr6427602agb.1165834260026; Mon, 11
 Dec 2006 02:51:00 -0800 (PST)
Received: by 10.90.31.6 with HTTP; Mon, 11 Dec 2006 02:50:59 -0800 (PST)
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

On 12/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> I've recently become somewhat interested in the idea of using GIT to
> store the contents of various folders in /etc.  However after a bit
> of playing with this, I discovered that GIT doesn't actually preserve
> all permission bits since that would cause problems with the more
> traditional software development model.  I'm curious if anyone has
> done this before; and if so, how they went about handling the
> permissions and ownership issues.

I keep the files I want to track in a separate folder that I track
with Git and use a Makefile for updating /etc.  I basically have a
rule for checking for differences between the tracked folder and /etc
and a rule for installing changed files (with the correct
permissions).  It works, but it does require some "Makefile magic" to
work right (or the way /I/ want it anyway).

