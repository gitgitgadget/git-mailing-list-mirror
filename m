X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Sat, 9 Dec 2006 00:53:47 +0100
Message-ID: <200612090053.48186.jnareb@gmail.com>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <200612082354.34488.Josef.Weidendorfer@gmx.de> <200612090025.24234.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 23:51:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JOmqUomIg363dkf4a1fT0v6jeZd1uon1ROAQrCIp6Ur8vkWcZFA8xGww1Bg2IqK2B9pcn2/16XnZedqExdIeXiq9BgC7OTOql8BmOHjHqK46Jqdm2exjg+vciINfB9mn6MsUQKbw1k/SjtwR0vuhAGH79+fPMEiswZlrsGXS4NU=
User-Agent: KMail/1.9.3
In-Reply-To: <200612090025.24234.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33773>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GspVA-0007zL-45 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947508AbWLHXvd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947509AbWLHXvd
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:51:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:46559 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947508AbWLHXvc (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 18:51:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so894378uga for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 15:51:31 -0800 (PST)
Received: by 10.67.26.7 with SMTP id d7mr6164337ugj.1165621890808; Fri, 08
 Dec 2006 15:51:30 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id o30sm3657889ugd.2006.12.08.15.51.30; Fri, 08 Dec
 2006 15:51:30 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:
> On Friday 08 December 2006 23:54, Josef Weidendorfer wrote:
>> Jakub Narebski wrote:
>>> NAME = name
> 
> Forgot to mention in the proposal:
> If you recursively have light-weight checkouts inside each other,
> the real "name" (for .git/external/<name/ and for further submodule
> configuration e.g. in .git/modules of the base repository)
> should of course be the concatenation of the names in the .gitlink
> files while going up to the base repository.

Why concatenation? I thought the name would be ID of submodule,
and should be just somehow unique.

And if concatenation, pehaps some forbidden character inserted between
them? Like '/' for example ;-)
 
>>> Perhaps instead of adding arbitrary number of .. in front of
>>> relative path, we better use some magic, like ... for finding
>>> somewhere up? 
> 
> No need. Something like
> 
>> 	/home/user/.../linux
> 
> is crazy. Do you want to scan all of your home directory everytime
> this  lookup is needed? So "..." really only makes sense in front of
> the relative path, but there, you also can leave it out.

No. I meant /home/user/.../linux to mean searching for
  /home/user/linux
  /home/linux
  /linux
but I don't think it is useful. As to relative path matching in any
parent directory... well, that differs only in direction (up instead of 
down) in matching filename in .gitignore when path does not contain /
(well, actually it is taken as fileglob).
-- 
Jakub Narebski
