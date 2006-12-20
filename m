X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit  hooks
Date: Wed, 20 Dec 2006 14:20:52 +0000
Message-ID: <200612201420.58756.andyparkins@gmail.com>
References: <200612201309.02119.andyparkins@gmail.com> <200612201347.13805.andyparkins@gmail.com> <embfus$d50$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 14:21:14 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MIgNY/sZbgZ8h3byC+1EP02XumTDvDeuj7vCBgr612VeJMfmzuofLh49XqymNo7niDaLRvvlPjgzXugM0ttCtj1S1OXjGvoGUjdpSLi0JlfpVS+IGCfl9NH5UGo0fxlegQCi3ss+BjmpTSFvpR6+UbYKtcWEQGPANSvomMsNgmM=
User-Agent: KMail/1.9.5
In-Reply-To: <embfus$d50$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34932>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx2Ji-000144-NQ for gcvg-git@gmane.org; Wed, 20 Dec
 2006 15:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965085AbWLTOVH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 09:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWLTOVH
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 09:21:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:48274 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S965085AbWLTOVE (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 09:21:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2242040uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 06:21:02 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr10891986ugi.1166624462496; Wed, 20
 Dec 2006 06:21:02 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id w40sm10642474ugc.2006.12.20.06.21.01; Wed, 20 Dec 2006 06:21:01
 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006 December 20 14:07, Jakub Narebski wrote:

> > Unfortunately, it is the hash that is optional.  When you create the
> > file, you don't list the hashes, you list the subdirectories.  I suppose
> > I could make it so you have to give "000000" or something first?
>
> That's the convention git uses in git-diff, reflog, etc.

They are all outputs though; this is an input.  I did it that way round so 
that I could say:

cat .gitmodules <<EOF
submodule1
submodule2
EOF

And that was it.  Of course, this doesn't work when there are spaces in the 
filename, so I guess it's got to be 

cat .gitmodules <<EOF
000 submodule1
000 submodule2
EOF

I'll wait to see if there are more objections before posting an updated patch.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
