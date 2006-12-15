X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Fri, 15 Dec 2006 22:04:17 +0100
Message-ID: <e5bfff550612151304v647106c9v3f042b424bf6cbfd@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <200612112128.06485.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111238560.3515@woody.osdl.org>
	 <200612112154.56166.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612111258050.3515@woody.osdl.org>
	 <e5bfff550612151045q5782e1f2j8686ccab24dbf566@mail.gmail.com>
	 <Pine.LNX.4.64.0612151118270.3849@woody.osdl.org>
	 <e5bfff550612151241pd11f49eqd1666ce0b33855b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 21:04:38 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jgaRgX2mQU420GfOG8LwANt7Q+ZNPjstLnsNKZfCuM/LV+ZJBWtceyZzZAbO/O8fnFXZQbGtUuSDrWJChQlq2HOJ2yEu72UL0kMnXj0s+5u2HA2CVZCTtmT9hb2/ItJdHf+HwQ0dwoNUn8wAd8aNmwvtheqqYmFJnIHsulzVdWE=
In-Reply-To: <e5bfff550612151241pd11f49eqd1666ce0b33855b6@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34550>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvKEG-000826-CZ for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964899AbWLOVET (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWLOVES
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:04:18 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:50944 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964899AbWLOVES (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 16:04:18 -0500
Received: by py-out-1112.google.com with SMTP id a29so502133pyi for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 13:04:17 -0800 (PST)
Received: by 10.35.40.10 with SMTP id s10mr2342832pyj.1166216657389; Fri, 15
 Dec 2006 13:04:17 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Fri, 15 Dec 2006 13:04:17 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/15/06, Marco Costalba <mcostalba@gmail.com> wrote:
>
> IOW the timely select() is already done by Qt library. We just read
> what has been already received and stored.
>

Try to set the timer to a very high value so that never triggers and
there is only one read call at the end, after git-rev-list exited,
when there is a forced call to the data read function.

Times seems to get even better! This is because timely read of the
pipe is _already_ done inside Qt library, not by qgit application.

