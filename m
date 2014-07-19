From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git_inetd_server: run git-http-backend using inetd
Date: Fri, 18 Jul 2014 17:08:18 -0700
Message-ID: <DC1EBA8C-1443-42DA-BA96-CB38D13502ED@gmail.com>
References: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com> <20140717221056.GO12427@google.com> <8E3CD89B-2E47-4CA8-8F3D-598A9BE2AD9F@gmail.com> <20140718022208.GQ12427@google.com> <50047EE8-4EF8-49E3-9067-1C88B2FB9D58@gmail.com> <20140718171635.GR12427@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 02:08:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8ICR-0000EY-2O
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 02:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbaGSAIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 20:08:22 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52289 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaGSAIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 20:08:21 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so6345849pad.39
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=bHzm+6095oF5s4RsBRkwxnw/f0u7Us2r9AwU0Av8EwU=;
        b=bsXfQe6TqD3DB1P9PaTl7WOC6b+OTT0D/ce0+3FRxziY/rQeWfokYwoIH/FM7PL50n
         WZBMRbgKyOG11hnGqm1v1RmerEq8q/FdepyXzunxKw2nMGuyS6SuXwExXD7ht9u9055K
         fdeL6UKAOJC7rUlYbHZlkaTIR2QH7AcYM7uaeVdd5tKFIt15MRKPghhB6ZcMLlACgWN8
         Ox7Teh/DJ5kcwxk2m3JQ19ieYrb+2q71tAZz5aZArxfBExrHYyPZLYee+9BDZj1X7gyJ
         knn6UDPFwcgnK8XZYo1Utf7uGc65ust2cw5aae/5il8GiS9TyTqasUBYT35WKxQDop8j
         XHew==
X-Received: by 10.70.33.228 with SMTP id u4mr9204035pdi.6.1405728501249;
        Fri, 18 Jul 2014 17:08:21 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ec2sm6734429pbc.63.2014.07.18.17.08.20
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jul 2014 17:08:20 -0700 (PDT)
In-Reply-To: <20140718171635.GR12427@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253859>

On Jul 18, 2014, at 10:16, Jonathan Nieder wrote:

> Kyle J. McKay wrote:
>
>> You might also want to take a look at [1] which suggests that when
>> doing SRV lookups for URLs they should be done regardless of whether
>> or not a port number is present (which then eliminates the RFC 3986
>> issue the current SRV lookup code has).
>
> "Git URLs" as described e.g. in git-clone(1) weren't intended to be
> actual URIs.

According to RFC 3968 section 1.1.3:
"A URI can be further classified as a locator, a name, or both. The  
term "Uniform Resource Locator" (URL) refers to the subset of  
URIs" [...]

So actually they are URIs.

> What would be the interoperability advantage of making
> them URIs?

According to RFC 3968 they are already considered URIs.


> This has come up before, with e.g. people asking to introduce a
> git+ssh:// and git+http://

How is a discussion about changing the scheme name relevant to a  
discussion about treating a URL with an explicit default port the same  
as one without (which Git already does but stops doing with the 0010  
git SRV patch)?  That would seem to be an orthogonal discussion to  
whether or not to change the scheme name(s) used by Git more than 9  
years after it first came out.
