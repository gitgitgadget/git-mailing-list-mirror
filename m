From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Wed, 03 Oct 2012 15:51:07 +0200
Message-ID: <506C42CB.90903@web.de>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com> <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com> <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com> <506C3F23.9000009@web.de> <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPMC-0005Id-BE
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab2JCNvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:51:12 -0400
Received: from mout.web.de ([212.227.15.4]:64196 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2JCNvL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:51:11 -0400
Received: from [192.168.178.41] ([91.3.173.123]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MaJc8-1SzY5E1QzY-00K7Wf; Wed, 03 Oct 2012 15:51:08
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
X-Provags-ID: V02:K0:DU2FvfhhY1u1gNZdSIbM57RjNM69BTL4z23E24tTvCo
 Te+OdULv+sKyOG8sNfLLUOSYHgpBuSdKuEWYDDcZvrdoop/Tzi
 81mL76FN/ydhf6lLQJU9iIvqqyVBfMQqg16S4J2NbCCfV41k5Z
 rZk3Mx6m49AoPXdoY8P6S/pmcy0JDqTKQpGDQeA/0ccso3XryZ
 1xc8ydD04Ncdq4m39Vl7A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206896>

Am 03.10.2012 15:42, schrieb Nguyen Thai Ngoc Duy:
> On Wed, Oct 3, 2012 at 8:35 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> */foo/bar
>> */*/foo/bar
>> */*/*/foo/bar
>>
>> Using "**/foo/bar" instead would be a great improvement
> 
> If this "**/foo/bar" (i.e. no wildcards except one ** at the
> beginning) is popular, we could optimize this case, turning fmatch()
> into strncmp(), just like what we do for "foobar*"

I expect the logic "ignore <pattern including a slash> in any
directory depth you find it" to be one of the major use cases for
"**", so I think optimization makes sense here.
