From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 17:34:13 +0100
Message-ID: <200801161734.13481.jnareb@gmail.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <200801161520.44668.jnareb@gmail.com> <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Petko Manolov <petkan@nucleusys.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:34:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFBE7-0003dm-FL
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 17:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbYAPQe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYAPQe0
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 11:34:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:59208 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYAPQeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 11:34:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so231590ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 08:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FHMdZ4a55YsHvgWalVNxzVMGYBeZ9TNQl7N9dXda32U=;
        b=bWc6H2fxEKNWjypxEUoVwlLU075inr1sodb4wzuoKoJxfHifPaIZoruqqAEaRLlwj2dRNkM3hvDmudrzU7vUAW6aCCzgPOpzVSM/j1EHXvw4YwUInQkvo4H4SUzUFh6And2wepZ4t8Vmm1Q/7GJB9tYjffqWPgQM4sk4DZMNE90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t7FCSJHvJtUS5tCYDOArRGkoCOlLupDhyLnoibmPpNUBJshc4ciFJti3EtaKqmOWQMyGbYW2WmHjh1QJHKHFGKZ+tcK8pk6rxF1hGvcKzOzb7mm/a72o0ROxhKyi9CKT5oDA16xyqU9IfwDKna0ZQAFBugBn7JS+uky0UGpeCko=
Received: by 10.67.15.6 with SMTP id s6mr2254694ugi.82.1200501262359;
        Wed, 16 Jan 2008 08:34:22 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.213.34])
        by mx.google.com with ESMTPS id j34sm1947410ugc.66.2008.01.16.08.34.19
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 08:34:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0801161640010.5260@bender.nucleusys.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70699>

On Wed, 16 January 2008, Petko Manolov wrote:
> On Wed, 16 Jan 2008, Jakub Narebski wrote:
>> Petko Manolov wrote:
>>> On Wed, 16 Jan 2008, Jakub Narebski wrote:
>>>
>>>> You can always tag a blob (like junio-gpg-pub tag in git.git repository),
>>>> but it wouldn't be in a working directory. But it would get distributed
>>>> on clone.
>>>
>>> Hm, how does it work?
>>
>> You use git-hash-object to put file (-t blob) into the object database.
>> It would return sha1 of added object. Use git-tag to create tag to blob
>> (use returned sha1 for head). You can get file (to stdout) with
>> "git cat-file blob tagname^{blob}".
> 
> Sounds like i'll have to play with the above.  Thanks for the tip.
> 
>> The file would be in object database, but not in working directory
>> by default.
> 
> Not a big problem.

Please read carefully section about retagging / changing a tag
in git-tag(1) manpage; you should take care about propagating change
if you ever change the binary blob.

Nothe that I haven't used the technique described.

-- 
Jakub Narebski
Poland
