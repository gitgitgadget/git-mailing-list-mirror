X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 09:39:31 +0100
Message-ID: <200611010839.35436.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com> <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 08:39:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ozi2KAG9ERQu63YwqORCTaRQZffkznr1T0PS5InnmfiSbmTly0l0ddsc/MQM1WOx0LllJAB8G7RNSQfZBDvMA9MnGJg3mESX8noGzfRd1MHOMMULuFizs/BQBxOGvM1hCbO+8Sp95ep06csvdQJA4WYVDVhKH1+fXGH1qli3vyk=
User-Agent: KMail/1.9.5
In-Reply-To: <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30622>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfBdR-000414-FV for gcvg-git@gmane.org; Wed, 01 Nov
 2006 09:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423936AbWKAIjl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 03:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423940AbWKAIjl
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 03:39:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:62740 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423936AbWKAIjk
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 03:39:40 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1662349ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 00:39:39 -0800 (PST)
Received: by 10.67.93.7 with SMTP id v7mr7736066ugl; Wed, 01 Nov 2006
 00:39:38 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id x26sm267786ugc.2006.11.01.00.39.38; Wed, 01 Nov 2006 00:39:38 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


> > I would prefer "git update-index --reset frotz" or "git checkout
> > --index HEAD frotz". git ls-tree|git update-index is too cryptic for
> > me and too long for my fingers.
>
> Then perhaps you can use "git checkout HEAD frotz", which is the
> simplest?

Doesn't that update the working directory as well as the index?  My original 
question was addressed perfectly with the point at the "--index-info" switch. 
However, before I asked here I was looking at the man page for update-index 
looking for something like

  git-update-index --reset $FILE

I suppose, if it were being implemented it should be

  git-update-index --reset $COMMIT $FILE

Incidentally, this wouldn't be exactly the same as
  
  git-ls-tree $COMMIT $FILE | git-update-index --index-info

because the git-ls-tree version needs to be run from the root of the working 
directory (this bit me when I first ran it) while the 
(imaginary) "git-update-index --reset" would not.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
