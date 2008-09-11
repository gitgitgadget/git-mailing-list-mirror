From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Fri, 12 Sep 2008 00:05:32 +0200
Message-ID: <200809120005.34261.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <3665a1a00809111403v1dfbef2cyf5377925ef087f2f@mail.gmail.com> <48C98F92.40903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	"Dana L. How" <danahow@gmail.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KduJW-0006hX-9S
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbYIKWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbYIKWFm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:05:42 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60350 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYIKWFl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:05:41 -0400
Received: by gxk9 with SMTP id 9so17706526gxk.13
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=toOkvIOdICR0KXvHVsCI2q/4dy4ZJ1mPfsbup147OxE=;
        b=Uk4zonbxN1tpxwh8fmWb9J/gwafIqV5N176A9/C+50CvWI42wNv5+H5nTvz4OUqv+3
         mK7kZTjWeAgc3cmmfjUwIoA67TtHvYnp8okYSd3hdGf62ozOwPjE/FZ/SuyjQJavi1Wt
         pj4o9Kx96c/MZ/xsf8QinPvvXzxdrz5jHquAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Z07lqDcBtSvmsvDVjGZSMxFZwQz21KMxCGk9Os1qKfNZaXvXH+JuW1Sg6gdCS6hGDc
         jN+v42vtIsTnq/7O421aQue5LRXr6gVpQlNghtroHraxucMtCKDsqTsWXtnLpP1oVabO
         COGtu5gDK4qiqpR2IipqFnWD7k4d9VZYqjgI8=
Received: by 10.86.66.11 with SMTP id o11mr2536541fga.69.1221170739015;
        Thu, 11 Sep 2008 15:05:39 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.193])
        by mx.google.com with ESMTPS id l19sm10070559fgb.7.2008.09.11.15.05.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 15:05:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48C98F92.40903@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95655>

Joshua Jensen wrote:
> Anatol Pomozov wrote:
>> Jakub Narebski wrote:
>>>
>>> A bit suprising for me is high place of Perforce.
>>>     
>> Some huge companies use Perforce. A good example here is Google. But
>> at the same time there are a lot of Google employees who interested in
>> git. Especially after Linus TechTalk. Googlers created a wrapper for
>> perforce that tries to bring git to everyone and ~300 people actively
>> use it.
>>
> Many game companies use Perforce, as it has pretty good handling of 
> gigabytes upon gigabytes of art content.  This is one area where a 
> centralized repository trumps the distributed ones with full history.  
> The checkout tree for one product I worked on was 70 gigabytes, and I 
> still mapped out a large number of files.  You can imagine how that 
> becomes too unwieldy to have all history locally.

Dana How (Cc-ed) worked on better support in Git for very large and
not well compressed files (and usually with short history).  Her
solution was to add support to git to limit size of blobs which
entered packs (files/blobs of size larger than given limit were
left as loose objects), and share those loose objects using network
filesystem.  You can search git mailing list to find exact details
of this. IIRC mentioned patches were not accepted; instead there was
proposed a solution where problematic blobs of very large files were
packed into separate kept pack, and this kept pack (or packs, each
containing single blob) were shared using some network filesystem
(network drive).


In addition to that in Documentation/RelNotes-1.5.3 we have:

  - "pack-objects" honors "delta" attribute set in
    .gitattributes.  It does not attempt to deltify blobs that
    come from paths with delta attribute set to false.

(but as far as I can see this attribute is otherwise undocumented).
This can also help performance for a repository with very large files.

-- 
Jakub Narebski
Poland
