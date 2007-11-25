From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Backing git repos to tape?
Date: Sun, 25 Nov 2007 13:00:06 +0100
Message-ID: <200711251300.06575.jnareb@gmail.com>
References: <027601c82f52$2433fdf0$5267a8c0@Jocke> <fibkt4$q6g$1@ger.gmane.org> <028101c82f58$0e26f200$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sun Nov 25 13:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwGA5-0000cx-Bt
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 13:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbXKYMAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 07:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbXKYMAN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 07:00:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:9150 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbXKYMAL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 07:00:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so350050nfb
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 04:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=RRMbv2aUkVeB5SSZm/HHxuHbpvFeEDHqkQYKuJtm6lU=;
        b=NYgejfE5/Vcl5Jp6/Fw1TbcvOiblBeMKfcjDSl93+01kR/f0/8u9YufaI+ZKsQCwFv4Cq7u2UcpWFsFV0y3xptsmeDf6nSaQEESIdA6tcEh33b8sHKMhC/HrPFroKtkKVEbKQVxLvXBNF3Pm+EO7xwNgdY/tII2GSh+LRKi6p5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IxiGQyblc0DUrivR2gt07a7B6TMlRPn6hvSDkJeAjnkl2dhXSzm3lEYzP/N4cgWW73Gg1UxuJ3uqqp+o6jqZh7JYcbCHMBVjkM/qGnheNKUdsoHWtFVgkIWA7Obe30UUFFeVrT4KiAPFE0yDEKku2+Ggf2qnhubQLZIs0rok3Tw=
Received: by 10.86.58.3 with SMTP id g3mr1502661fga.1195992009534;
        Sun, 25 Nov 2007 04:00:09 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.240.234])
        by mx.google.com with ESMTPS id 4sm270690fgg.2007.11.25.04.00.07
        (version=SSLv3 cipher=OTHER);
        Sun, 25 Nov 2007 04:00:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <028101c82f58$0e26f200$5267a8c0@Jocke>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65968>

On Sun, 25 Nov 2007, Joakim Tjernlund wrote:
> Joakim Tjernlund wrote: 
>> Jakub Narebski wrote:
>>> Joakim Tjernlund wrote:
>>> 
>>>> Is there a preferred way to do the above?
>>>> 
>>>> To do a full backup I could just copy the whole repo, but how
>>>> do I do inrecmental backups(and restore)?
>>> 
>>> Try git-bundle. There were in the mailing list archive the recipe
>>> on how to do an "incremental" bundle...
>>> 
>>> ..ahh, there it is, by Johannes "Dscho" Schindelin:
>>> 
>>>         git bundle create retort.bundle --all \
>>>                 --not $(git ls-remote the-other.bundle | cut -c1-40)
>> 
>> Thanks, will look into git bundle

Please note however thatgit-bundle was created for easy and efficient
off-line (sneakernet) transport, not for backups of repositories.

Nevertheless it might be a good tool to use.
 
> Just did a
>   git ls-remote ./.
> in my linux repo and got a lot of ^{} in the printout.
> What do the ^{} mean?
>  
> ...
> 0b8bc8b91cf6befea20fe78b90367ca7b61cfa0d        refs/tags/v2.6.23
> 7d57c74238cdf570bca20b711b2c0b31a553c1e5        refs/tags/v2.6.23-rc1
> f695baf2df9e0413d3521661070103711545207a        refs/tags/v2.6.23-rc1^{}
[...]

----
git-rev-parse(1):

SPECIFYING REVISIONS
--------------------

A revision parameter typically, but not necessarily, names a
commit object.  They use what is called an 'extended SHA1'
syntax.  Here are various ways to spell object names.

[...]

* A suffix '^' followed by an empty brace pair
  (e.g. `v0.99.8^{}`) means the object could be a tag,
  and dereference the tag recursively until a non-tag object is
  found.

----

refs/tags/v2.6.23-rc1 is a ref which points to a _tag object_ 7d57c742...,
which in turn points to commit f695baf2...

-- 
Jakub Narebski
Poland
