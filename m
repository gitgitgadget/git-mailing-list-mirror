X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Tue, 7 Nov 2006 22:53:33 +0100
Message-ID: <200611072253.34291.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200611062258.08320.jnareb@gmail.com> <7v8xiochw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 21:53:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bGjhZH7jsydkzLy7xvc+HYboA8/cE7pA00l1tjHbgTr6b42QnbDsGmHtd6+nBqaEftawhGaPrUtjbMi3IbOc/S7CvcNdrkjKi9FRDpNCLFvs5mXJ8Yvvn6u6YGxDpDxyEL9AYWm3e/5cVdCvUKjV5tKi3xENav5733aKHj40yo0=
User-Agent: KMail/1.9.3
In-Reply-To: <7v8xiochw0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31092>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhYsX-0003AR-S1 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 22:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753241AbWKGVw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 16:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbWKGVw6
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 16:52:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:48218 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753241AbWKGVw5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 16:52:57 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1343840ugc for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 13:52:55 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr9800347ugh.1162936375526; Tue, 07
 Nov 2006 13:52:55 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x26sm50797ugc.2006.11.07.13.52.55; Tue, 07 Nov
 2006 13:52:55 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Here is example code for this:
> 
> Ok.  The issues I raised in the previous round seem to have been
> addressed.  Maybe you would want not to use nested 'sub' and it
> is good to go, I think.

Should I understand this as a statement that you prefer backslash 
sequences aka. Character Escape Codes (CEC) than "Unicode" escaping 
aka. Unicode Printable Representation (PR)?

Should I send better quoting/unquoting work as two patches: unquote 
correction plus '?' using esc_path + esc_path which uses backslash 
sequences and span.cntrl element, or should it be send as one, 
admittedly quite large patch. 

I don't think it would be good idea to separate unquote correction with 
esc_path work, because havin unquote which unquotes fully means that we 
can have filenames which have for exampl newline characters in them, 
hence the need of separate quoting subroutine, esc_path, and using it 
for filename escaping.
-- 
Jakub Narebski
