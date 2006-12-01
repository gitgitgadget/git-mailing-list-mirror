X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] git-add update with all-0 object
Date: Fri, 1 Dec 2006 09:37:07 +0000
Message-ID: <200612010937.08468.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <20061201045727.GA22622@thunk.org> <Pine.LNX.4.64.0612010223010.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 09:37:39 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c8LbVVGdV7d41xRFnQnDqlwufaStzSiH93pwcHOf8TZYeDh492UCC+ZJcem1paoRHIUjU/8+4U8fho6t9ms1tIVc2O+2S3Ip7+xFQpWn84992D08TBhNuUItaxIB4gXTka8qqTK1ehSr8t3/+BhUUwlEkIZwkvkrTJkN3dXw00M=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612010223010.20138@iabervon.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32881>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq4pa-0006ue-R4 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758995AbWLAJhP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759277AbWLAJhP
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:37:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:6687 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758995AbWLAJhN
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:37:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2369507uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 01:37:12 -0800 (PST)
Received: by 10.67.20.3 with SMTP id x3mr6920889ugi.1164965832281; Fri, 01
 Dec 2006 01:37:12 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id o1sm23512254uge.2006.12.01.01.37.11; Fri, 01 Dec 2006 01:37:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 08:10, Daniel Barkalow wrote:

> My position on this subject is that "index" is a good name, but that
> description is a terrible description, and "index" is a word that needs a
> good description in context. If we just said up front:

If we need to explain what "index" means in the context of diff then it's not 
a good name :-)

An index /everywhere else/ is a lookup table.  topic->page number; 
author->book title.  record id->byte position.  There is never any content in 
an index, indices just point at content.

I imagine that's how git's index got it's name.  (I'm only guessing as I've 
not looked at what's actually inside git's "index").  Here's my guess:

git update-index file1 hashes file1, stores it somewhere under that hash and 
writes the hash->filename connection to .git/index.  That is why git's index 
is called an index.  It's a hash->filename index.

Unfortunately, "index" in colloquial git actually means the combination 
of .git/index plus the hashed file itself.  That's no longer an index, it's 
a "book". :-)

It's made worse, I think, by the fact that git doesn't want to do any 
index-like things with the "index".  Being content-oriented rather than 
name-oriented means that an entry like "file1->NOTHING" is impossible in git.  
This leads to the sort of "git-add means track this filename" confusion that 
turns up a lot with new users.

It's probably all too late to change the nomenclature, but I've always been of 
the opinion that names are important, they confer meaning.  When we use a 
common word, with common meaning and deviate from that common meaning we are 
bound to create confusion.  New users don't have any "git-way-of-thinking" 
knowledge when they begin, so when they hear "index" they can only fall back 
on their standard understanding of that word.  We shouldn't be surprised then 
when new users don't get "the index".



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
