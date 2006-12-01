X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:16:00 +0000
Message-ID: <200612011216.04555.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011102.17079.andyparkins@gmail.com> <20061201114607.GN18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:16:32 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zw4t1ELkIzulNQ7jZH9of2cfMXN9GWscLC9HLy3gaCIFVcIx2A1YevQdWiGnYEOsjggDfI22xVMfUcCDZbAhyHTLjt9z5irL0BDdSViV7UlemATJ0TvgVWqSBCtjxZkP4kmD6dY0ALH++M2nh31GfbDkPTzcQ6WdxdW/EO75izg=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201114607.GN18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32910>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7JP-0003Yk-5D for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030945AbWLAMQM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030956AbWLAMQL
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:16:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:23318 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030945AbWLAMQK
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:16:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2404549uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 04:16:09 -0800 (PST)
Received: by 10.67.22.7 with SMTP id z7mr7151695ugi.1164975369099; Fri, 01
 Dec 2006 04:16:09 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 53sm22808047ugn.2006.12.01.04.16.08; Fri, 01 Dec 2006 04:16:08 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 11:46, Martin Waitz wrote:

> > That's no different from mine.
>
> Well, there simply is no proxy object inbetween.

That's fine, I was only using the proxy object to allow additional information 
into the submodule object.  Actually, I think it would always be better to 
use a proxy object otherwise you have an error in the tree object, because it 
will refer to an object that does not exist.  The proxy object is allowed to 
refer to objects that don't exist because it's not a tree object.

> > Is that commit in the submodule or the supermodule?
>
> Well, logically that commit belongs to the submodule and is referenced
> by the tree in the supermodule.
> Phyisically it is stored in the projects object database which is
> shared between the supermodule and all submodules (at least in my
> implementation).

Hmmm, "shared"?  It must still be in the submodule physically though, and 
presumably the supermodule uses alternatives to get access to it?  Otherwise 
the submodule will be impossible to separate from the supermodule.

> > I also want to know how we tell the difference between a
> > commit-in-supermodule and a
> > commit-in-supermodule-which-is-actually-in-submodule.
>
> There is no difference.

Okay.  I think I'm still a bit lost then.  I suppose I'll wait for your 
patches to understand.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
