X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Moving a directory into another fails
Date: Tue, 5 Dec 2006 10:36:13 +0100
Message-ID: <200612051036.13645.jnareb@gmail.com>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com> <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org> <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 09:34:21 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cpRB67lqhhhgQ87D54kCn95vk9zzi6HW2xMfQ2iIwT73aRamJIfG6y6nbml01BWCJhjE8BsjmdJfxaWMhv6C8mEfDcN8GamhNdG80DzW6r0JxM1IwZwfiuIAxSt1JQUx5HGK0IZXBOOh9RCVJSEte3Cxb+vleoaX0NLzocJyww4=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33330>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWgs-0001la-3h for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968086AbWLEJeN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968163AbWLEJeM
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:34:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:36487 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S968086AbWLEJeM (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 04:34:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3272306uga for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 01:34:11 -0800 (PST)
Received: by 10.67.19.20 with SMTP id w20mr13366283ugi.1165311250679; Tue, 05
 Dec 2006 01:34:10 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 50sm8689398ugb.2006.12.05.01.34.10; Tue, 05 Dec
 2006 01:34:10 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> On Mon, 4 Dec 2006, Linus Torvalds wrote:
> 
>> 	[core]
>> 		escapefilenames = true
> 
> I think this goes too far. The problem _only_ showed up with a made-up 
> test case for gitweb. Let's bite the apple when we _have_ to (which I 
> doubt will happen, because for the most part, developers understand that 
> spaces and umlauts have _no_ place in filenames, basically since UNIX was 
> invented by stupid US Americans who did not know anything about nice 
> filenames, let alone other languages than English and C).

No, the problem showed with stupid HFS+ which uses different encoding
for creating file, and different for readdir.

Perhaps we should remove gitweb/test directory, and move testing gitweb
to proper place, t/ directory. 

By the way, would it be correct to use external tools (if they exist),
namely HTMLtidy in gitweb output test to-be-written?
-- 
Jakub Narebski
