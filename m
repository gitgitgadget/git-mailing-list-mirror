X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git tag: don't complain of empty messages
Date: Thu, 16 Nov 2006 02:27:37 +0100
Message-ID: <455BBE89.6070005@xs4all.nl>
References: <ejfc1t$6am$1@sea.gmane.org> <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net> <455BAD80.1080108@xs4all.nl> <ejgbrq$o5u$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 01:28:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 48
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <ejgbrq$o5u$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31538>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkW2g-0003JR-4P for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031036AbWKPB1q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031038AbWKPB1q
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:27:46 -0500
Received: from main.gmane.org ([80.91.229.2]:28331 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1031036AbWKPB1q (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:27:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkW2Y-0003IC-Ds for git@vger.kernel.org; Thu, 16 Nov 2006 02:27:42 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 02:27:42 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 02:27:42
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski escreveu:
> Han-Wen Nienhuys wrote:
> 
>> Junio C Hamano escreveu:
>>> I do not have a strong objection against allowing tags without
>>> messages, but at the same time I do not see a compelling reason
>>> to allow them either.  Care to explain what workflow is helped
>>> by an empty tag?
>> the tagname usually is enough of a description, but I want the tags to 
>> end up in the object DB, eg.:
>>
>>    git tag release/2.10.0 HEAD
>>
>> now I have to use
>>
>>    git tag -m "this really sucks"  release/2.10.0 HEAD
> 
> Why not
> 
>    git tag -m "release 2.10.0" release/2.10.0 HEAD
> 
> This way you would know what tag points to even if you loose it's
> reference...

that would double, given that the tag name is already in the tag object. 
Currently, I have

**
[lilydev@haring gub]$ cat .git/refs/tags/gubrelease-2.9.29-2
1ac5c78609a9f79787825b62c9576542eedce795


[lilydev@haring gub]$ git cat-file tag 
1ac5c78609a9f79787825b62c9576542eedce795


object b75db784e3d6a9e1d2cff3f77036aaa88598b53c
type commit
tag gub-2.9.29-2
tagger Han-Wen Nienhuys <lilydev@haring.localdomain> 1162921716 +0100

build and upload
**

'build and upload' is a polite way of saying 'this really sucks'.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
