From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Mapping file contents from one repository to another
Date: Mon, 13 May 2013 10:46:43 +0200
Message-ID: <5190A873.2040101@alum.mit.edu>
References: <1368372120.73994.YahooMailNeo@web160305.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jason Timrod <jtimrod@yahoo.com>
X-From: git-owner@vger.kernel.org Mon May 13 10:46:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UboPF-0004yB-SO
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 10:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab3EMIqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 04:46:49 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:64796 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752456Ab3EMIqr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 04:46:47 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-ca-5190a876da09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 82.E8.02295.678A0915; Mon, 13 May 2013 04:46:46 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4D8kj0N028762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 May 2013 04:46:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1368372120.73994.YahooMailNeo@web160305.mail.bf1.yahoo.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqFu2YkKgwYbdlhZdV7qZLNZdfczi
	wOTxeZOcx6xZh5kCmKK4bZISS8qCM9Pz9O0SuDPe7ZcpuM9Vce5bL1sD4wmOLkZODgkBE4k/
	X9YzQ9hiEhfurWfrYuTiEBK4zCgxf+9kZgjnOJPE1LMfwap4BbQlth1tZQKxWQRUJTp3X2QH
	sdkEdCUW9TSDxUUFwiRWrV8GVS8ocXLmExYQW0RARWL+/01gNrOAvsSnPwfA6oUFHCXWzL4G
	NkdIwEPizIPFYDWcAp4S95ZvZ4eo15F41/eAGcKWl9j+dg7zBEaBWUhWzEJSNgtJ2QJG5lWM
	cok5pbm6uYmZOcWpybrFyYl5ealFuoZ6uZkleqkppZsYIYHKs4Px2zqZQ4wCHIxKPLwLlCcE
	CrEmlhVX5h5ilORgUhLldV8OFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCmzQfKMebklhZlVqU
	D5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV4eBQkuDtARkqWJSanlqRlplTgpBm4uAEGc4l
	JVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2NoG08xYXJOYCRSFaTzEac8za+uQ1I8fKK0BSiCUv
	Py9VSpw3H6RUAKQ0ozQPbhEsRb1iFAf6WxjiHh5geoOb9wpoFRPQqjMe/SCrShIRUlINjLbs
	dgLPp/i2BVnusOVT6Oj/GZvz8Wjq0iksy+9GTJu6/uf5ZZPsZk9T2fRwkrnraz3/eXnmU+Mr
	z34ombfN+y3ny2dGzhdytRXmae09ahGcFDw1WMaKb9Ml+xD9N22CD0RzZ668dp29 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224114>

On 05/12/2013 05:22 PM, Jason Timrod wrote:
> Hi all,
> 
> This is a complicated question to try and ask, let alone answer, so I had best give some background.
> 
> I have two repositories --- one of them, which I'll call "repoA", is the main repository, it's the one which most of the code we develop ends up.  The other repository, "repoB" is our portable version of the code---the one which is used to deploy on systems other than the one which repoA is deployed on.  As such, "repoB" often (and does) contain commits specific to repoB which will never appear in repoA, such as OS-specific things.
> 
> In this case, in repoA we have a man page.  Up until recently, this used to be the same file in both repositories.  But because of the way the files in repoB are deployed, unlike in repoA this file has had its name changed from:
> 
> foo.1 -> foo.1.in
> 
> Because the man page is run through some sed script to replace various things which never need to happen in repoA

Why don't you name it foo.1.in in both repos and pipe it through "cat"
on repoA (i.e., just copy it to foo.1)?  Then you would only have to
maintain a small difference in your build system between repoA/repoB
rather than having to coordinate two versions of the bigger source document.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
