X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Fri, 8 Dec 2006 15:16:41 +0100
Message-ID: <81b0412b0612080616t3d43f739gc201879fddcc20a3@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207221503.GA4990@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 14:17:06 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2CBsrwBfmmTd4+9bakmoXiTqNONRK5NMmnutCTVo2eMmx401jyJoOoxU+64C9oIe5TMrASxXHlPNq6Q0NlWFkG1OTEJC+srQHG+IiApTqN6OrrqHwm1+WBx+/7w5xdaGn+qIoNaSwAe5uc58Q6wTYWdXWGVV6zeaCtMZJZyJg4=
In-Reply-To: <20061207221503.GA4990@steel.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33696>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsgXA-0003wh-KT for gcvg-git@gmane.org; Fri, 08 Dec
 2006 15:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425524AbWLHOQp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 09:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425525AbWLHOQp
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 09:16:45 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:49563 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425524AbWLHOQo (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 09:16:44 -0500
Received: by wr-out-0506.google.com with SMTP id i7so990980wra for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 06:16:43 -0800 (PST)
Received: by 10.78.193.19 with SMTP id q19mr1771985huf.1165587401753; Fri, 08
 Dec 2006 06:16:41 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Fri, 8 Dec 2006 06:16:41 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/7/06, Alex Riesen <fork0@t-online.de> wrote:
> > Maybe you want "assume unchanged"?
>
> If that is core.ignoreState you mean, than maybe this is what I mean.
> I haven't tried it yet (now I wonder myself why I haven't tried it).
> But (I'm repeating myself, in
> <81b0412b0612060235l5d5f93d0hd1aaf34924f7783@mail.gmail.com>)
> I do not really understand how it _can_ help: "I ask because it does
> not ignore stat info, as the name implies. Because if it would,
> there'd be no point of calling lstat at all, wouldn't it?" That last
> question was about refresh_cache_entry - it calls lstat
> unconditionally.
>
> Still, I guess I'll have to try it.
>

Tried. No noticeable difference:

$ git repo-config core.ignorestat true; time gup --refresh
real    0m8.004s
user    0m1.936s
sys     0m5.702s
$ git repo-config core.ignorestat false; time gup --refresh
real    0m7.787s
user    0m1.890s
sys     0m5.703s
$
