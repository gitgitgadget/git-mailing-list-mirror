X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 10:53:46 +0100
Message-ID: <200611010953.57360.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611010839.35436.andyparkins@gmail.com> <7v4ptj7dfg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 09:54:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PHzY/XFxBrKIeBnuFx7JePaxztoCxxLo8vSnjJO2eAigwpM0Vza7IK45dVaZXupHK8U/dshrdizmc1X7bsQabrNPVvN0wRYm/72nqcWaivLecCM+pxpgEwD0ChHjIv1IPjHXaw48l3yzFfUsITYestuKOnXmZjeqlDkISgK3+F8=
User-Agent: KMail/1.9.5
In-Reply-To: <7v4ptj7dfg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30629>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfCnd-0007qs-8b for gcvg-git@gmane.org; Wed, 01 Nov
 2006 10:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946748AbWKAJyI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 04:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946746AbWKAJyH
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 04:54:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:23306 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1946744AbWKAJyC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 04:54:02 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1671324ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 01:54:01 -0800 (PST)
Received: by 10.66.222.9 with SMTP id u9mr7839379ugg; Wed, 01 Nov 2006
 01:54:01 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 50sm344043ugb.2006.11.01.01.54.00; Wed, 01 Nov 2006 01:54:00 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 November 01 08:56, Junio C Hamano wrote:

> update-index is a plumbing that is about updating index (hence
> its name) and should not care what the HEAD is, and it does not
> even have to have _any_ head to do its work, so in that sense,
> "update-index --reset" is conceptually a layering violation.

Of course; I was really only reporting that git-update-index was the place I 
(as a newbie) went looking for this function.

However, from a UI point of view updating the index from HEAD is just as much 
of an update to the index as updating it from the working directory.  When I 
went looking, I had no idea that update-index was plumbing and not porcelain.  
In fact, as it's a regularly used command (git-update-index; git-commit) I'm 
surprised it's classed as plumbing.

> But these two commands are meant to be used as building blocks,
> so if there are more suitable UI commands at the Porcelain layer
> to implement what we want to do without introducing more special
> cases to these plumbing commands, I would rather not touch them.

As I mentioned in my original email, I was wishing for 

 git-reset --mixed HEAD oops/file1

But of course, that doesn't make any sense in the context of of git-reset, 
which is really only a HEAD manipulator with extras.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
