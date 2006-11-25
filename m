X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 3)] gitweb: Use git-show-ref instead of git-peek-remote
Date: Sat, 25 Nov 2006 12:08:00 +0100
Message-ID: <200611251208.01047.jnareb@gmail.com>
References: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net> <11644507284105-git-send-email-jnareb@gmail.com> <7v7ixj3izw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 11:06:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gPWpGh+FXaJrI/pexA3esdW24cca7ciI6M6FLfOgHjjVnQRh7et/3w6K/klzxQdQA3OZ2QOnZt8RtxBjygBJq8ZIll8iyYVy21GGUTNtUSlREs/y5Hm6gPgfdDQbR8CB8Clj9XHyMs2V6C8TkgBqLn99tlAGZFBeW9XgwqdSnTI=
User-Agent: KMail/1.9.3
In-Reply-To: <7v7ixj3izw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32283>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnvMY-0003RS-9c for gcvg-git@gmane.org; Sat, 25 Nov
 2006 12:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935152AbWKYLGX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 06:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757919AbWKYLGX
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 06:06:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:31360 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757918AbWKYLGW
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 06:06:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so830086uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 03:06:20 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr8852843ugm.1164452780452; Sat, 25
 Nov 2006 03:06:20 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id e1sm16030278ugf.2006.11.25.03.06.20; Sat, 25 Nov
 2006 03:06:20 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> While at it make git_get_references return hash in list context,
>> and reference to hash (as it used to do) in scalar and void contexts.
> 
> Why did you have to add this?  Generally, context sensitive
> returns make the program much harder to maintain, because it
> forces the call sites to be extremely careful to choose between
> "my ($foo) = func()" vs "my $foo = func()", and people who later
> call the function inevitably make mistakes.
> 
> So unless there is a compelling reason, I'd rather not see more
> "wantarray" in the program.

O.K. I have browsed through gitweb, and I see that we almost always
want the hashref, not hash (for passing further).

-- 
Jakub Narebski
