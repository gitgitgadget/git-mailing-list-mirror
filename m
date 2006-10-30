X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Mon, 30 Oct 2006 10:43:21 +0100
Message-ID: <200610301043.22033.jnareb@gmail.com>
References: <92622.251.qm@web31812.mail.mud.yahoo.com> <200610300905.04454.jnareb@gmail.com> <7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 09:43:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LfMI7JhrtP/Bq9DHwMCU+UXuk9Av38DueiWpIcygZB4f29SXK4osy+aNlAI15Hiq6CefObA9bL+1/jL51B5jg9aVQSI8cEqow3gGHd7AUqyovbtOflCsOgLwROZwg/zk8jD8g+RhfqZWxk1DPdfmz7/2TJSWmSaIZU1ReNo6Au8=
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7qyw6w6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30489>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeTfw-0002ui-3K for gcvg-git@gmane.org; Mon, 30 Oct
 2006 10:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030528AbWJ3JnV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 04:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965503AbWJ3JnV
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 04:43:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:48438 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965501AbWJ3JnU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 04:43:20 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1080510ugm for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 01:43:19 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr3794388ugm; Mon, 30 Oct 2006
 01:43:18 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id j3sm2639041ugd.2006.10.30.01.43.18; Mon, 30 Oct
 2006 01:43:18 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> ..., without
>> resolving the strange filenames problem (it would be nice if somebody was
>> to send code; well Junio send patch to address core git filename quoting
>> issue).
> 
> Having showed that patch, I do not think it is a good way to go.
> 
> I think the UI layer like gitweb should have freedom to choose
> its own pathname handling, and should read from -z output.

That's a very good idea. I'll send separate patch (if noone else will
do this, that is) which would convert gitweb to always use -z output,
both git-ls-tree and git-diff-tree... oh, well, there is no -z patch
output, so in patch part we would have to replace git quoted part by
gitweb quoted part.

BTW gitweb has to do it's own pathname handling, at least LF, perhaps
TAB, perhaps other control characters like ESC; quote quoting character
and mark filename as quoted somewhat (it can be with CSS style, not
necessary by surrounding with some kind of quotes; besides that can
also be added via CSS in modern enough browsers using :before and
:after pseudo-elements and 'content' property).

-- 
Jakub Narebski
