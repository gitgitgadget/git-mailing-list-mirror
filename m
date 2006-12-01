X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Fri, 1 Dec 2006 12:33:20 +0000
Message-ID: <200612011233.21210.andyparkins@gmail.com>
References: <200612011106.42272.andyparkins@gmail.com> <7vd573amuy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:35:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QSrJJwVLlSgch/aVA/zYXjvGqPRKPlAs3zf4NxP8okJiHZVCuII6sXVrBJFBAo0w5051StuXhI+yYVURl9y6xuPS75q4qjimKwQCdRgScmgX47OVFkIjJ9B0LkV7vKl45+ETXt+UvqyA9zHc+OIA0RabD7oEBDR0uqllXC4Ugqk=
User-Agent: KMail/1.9.5
In-Reply-To: <7vd573amuy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32913>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7a8-0007Yu-Os for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030823AbWLAMd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030953AbWLAMd2
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:33:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:5227 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030823AbWLAMd1
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:33:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2408346uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 04:33:26 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr7170800ugm.1164976405948; Fri, 01
 Dec 2006 04:33:25 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id o30sm21537967ugd.2006.12.01.04.33.25; Fri, 01 Dec 2006 04:33:25
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 11:15, Junio C Hamano wrote:

> I think another exception should be needed.  If the index does
> not match the working tree, it should not default to "-a".

No problem: just don't apply the patch :-)  What you've asked for leaves it as 
a no-op.

This patch activates "-a" when the index equals HEAD.  i.e. git-commit would 
do nothing in this situation.  If it is disabled when the index doesn't match 
the working tree, then we're back to "do nothing".  i.e. HEAD==index==working 
tree.

> So, please turn this "cleverness" off when the index does not
> match the working tree.

How does that help you?  You've updated the index manually, so the 
automatic "-a" is already disabled.  Without this patch you would still have 
committed the wrong thing.

 $ edit builtin-blame.c
 $ git update-index builtin-pickaxe.c
 $ git commit

What is that you would like to have happened at this point?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
