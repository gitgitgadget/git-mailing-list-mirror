From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Thu, 05 Mar 2015 21:49:22 +0100
Message-ID: <54F8C152.7010203@web.de>
References: <54F88684.3020905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTci2-0001zs-IP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 21:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbbCEUt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 15:49:26 -0500
Received: from mout.web.de ([212.227.15.3]:64859 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbbCEUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 15:49:25 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MFcPd-1YHr0Q1oUn-00Eck7; Thu, 05 Mar 2015 21:49:23
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <54F88684.3020905@alum.mit.edu>
X-Provags-ID: V03:K0:i5q3bQYAq7DOBStIlXU6pn9x2aKUgvS5My02Pz6vpoHRhXGBSgm
 Jqx7OLVXMSoJTODoTqTSS4+TBkGKt7DFRdCXIxG5BTLSjCAyc3Vlo73Y0Uhov7UHW651Dzn
 yYKs0fEi5k4jI9FJak0XpNRG/H84KtXzC92E2SsvhQF9D8gGeCZMmtb92pstsdPAncWzlTA
 ZsMpLvsYxLzVPASMhOpkA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264865>

On 2015-03-05 17.38, Michael Haggerty wrote:
> I would expect that the following .gitattributes file
> 
>     *       eol=crlf
>     *.png   -text
> 
> would leave EOL translation turned off for PNG files. In other words, I
> would expect that explicitly setting "-text" would take precedence over
> the fact that setting "eol" implies that a file should be considered to
> be "text".
> 
> I would even more strongly expect
> 
>     *       eol=crlf
>     *.png   binary
> 
> to turn off EOL translation for PNG files.
> 
> But in fact, in both of the above cases, EOL translation is turned *on*
> for PNG files.
> 
> I propose that "-text" should override any setting for "eol" (which
> would of course fix both problems, since "binary" is equivalent to
> "-diff -merge -text"). What do people think?
> 
> Michael
> 

("binary" is not supported, we need "-text")
Beside that,  

>     *       eol=crlf
>     *.png   -text
should work as you describe.

Do you think you make a test case for this ?
In best case as a real patch :-)

(I know that attributes should take precedence over eol settings in the
config file, and this is not always the case)
