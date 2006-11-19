X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 23:25:49 +0100
Message-ID: <e5bfff550611191425g30d02b98l71cfdc6439d2e09f@mail.gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
	 <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
	 <e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
	 <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 22:26:36 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YdCvUwVx4ZHuYcwnhhJsWOaARkRvbLWNSWRg1y/Ob91rxuzh658+5lOK5c2SsOJOzVJhe0+HYeXqHusFadhGg05uzMR8mXhyDrtkBMBenBvJeppkFOuzOkPE75fCQghCKgnVo+c+1/YRYZDCyRVgCHdBQ2QmMPQiN7PdNHPjLLE=
In-Reply-To: <Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31868>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glv7O-0007MD-Vv for gcvg-git@gmane.org; Sun, 19 Nov
 2006 23:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933472AbWKSW02 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933473AbWKSW02
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 17:26:28 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:46919 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S933472AbWKSW01
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 17:26:27 -0500
Received: by py-out-1112.google.com with SMTP id a29so874985pyi for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 14:25:53 -0800 (PST)
Received: by 10.35.101.1 with SMTP id d1mr2182660pym.1163975149913; Sun, 19
 Nov 2006 14:25:49 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sun, 19 Nov 2006 14:25:49 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 11/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
>
> For example, it's often (but not always) faster to do all the readdir's
> separately, and then sort the thing by inode number, and try to avoid
> back-and-forth movement. But quite frankly, that kind of stuff probably
> isn't sane to do in "git show-refs".

Excuse me for my ignorance, but isn' it the job of OS disk schedulers?

>
> Anyway, I think that if we really want to make "git show-refs" go fast
> when things are cold in the cache, and with lots ot tags and "-d" (which
> is a reasonable case to optimize for: it's probably exactly what we end up
> doing both for gitweb _and_ for "git-send-pack"), we'd need to expand the
> packed-refs file with the deref cache.
>

Probably also gitk, currently it uses (the slower) "git ls-remote"
instead of "git peek-remote" or "git show-refs" but the concept seems
the same.

