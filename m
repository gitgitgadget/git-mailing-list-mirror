X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 21:54:32 +0000
Message-ID: <200612012154.33834.andyparkins@gmail.com>
References: <20061130170625.GH18810@admingilde.org> <200612012104.39897.andyparkins@gmail.com> <20061201213722.GK18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 21:57:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hjgP5UMUtA5TO6n2KE164cyC/jVxbM7ywt5P51fbsfIjJSMXGuPKCvE3s9zjsxP20/atVBbuS4OjK6Ww1zk49lk3eKpdHgynvo+vvYmbJf8ryMKnbGPtCM2YAr6U10P7enx5ZRuNasw4oYfUVLAWCICUbM08Q3thTaexZpaZxt4=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201213722.GK18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32969>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGNl-0007dG-9B for gcvg-git@gmane.org; Fri, 01 Dec
 2006 22:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162038AbWLAV5S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 16:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162022AbWLAV5S
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 16:57:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:10075 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1162038AbWLAV5R
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 16:57:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2544765uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 13:57:16 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr7952525ugh.1165010236407; Fri, 01
 Dec 2006 13:57:16 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id o30sm22273379ugd.2006.12.01.13.57.15; Fri, 01 Dec
 2006 13:57:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006, December 01 21:37, Martin Waitz wrote:

> > I'm going to guess by reachability analysis, you mean that the
> > submodule doesn't know that some of it's commits are referenced by the
> > supermodule.  As I suggested elsewhere in the thread, that's easily
> > fixed by making a refs/supermodule/commitXXXX file for each
> > supermodule commit that references as particular submodule commit.
>
> I wouldn't call this "easily".

Of course it is; when you write a supermodule commit you have it's hash, 
$SUPERMODULE_HASH, you have the commit-hash of the submodule commit you're 
referencing, $SUBMODULE_HASH.  It's not really hard to do

echo $SUBMODULE_HASH > 
submodule/.git/refs/supermodules/commit$SUPERMODULE_HASH

Is it?


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
