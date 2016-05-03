From: "Philip Oakley" <philipoakley@iee.org>
Subject: avoid duplicate patches from git log ?
Date: Tue, 3 May 2016 21:11:55 +0100
Organization: OPDS
Message-ID: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 22:12:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgfp-0000hc-2y
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbcECUL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 16:11:57 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:37097 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095AbcECUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 16:11:56 -0400
Received: from PhilipOakley ([92.16.246.238])
	by smtp.talktalk.net with SMTP
	id xgfiaOKo0fqzwxgfiaualf; Tue, 03 May 2016 21:11:54 +0100
X-Originating-IP: [92.16.246.238]
X-Spam: 0
X-OAuthority: v=2.2 cv=ItxcS/3g c=1 sm=1 tr=0 a=6h1yBlRVFNKLyN041wWm2Q==:117
 a=6h1yBlRVFNKLyN041wWm2Q==:17 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8
 a=B_llWTc1Ycu6tFLlG6EA:9
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKbYgl6n5p5vDVLbX0bLsGSVGp+djfNQnBNHYi4DMydHeiKION5gyDlGJZWdQ5F51x48dS36pksiBl/ik4RKJPqGZMDNJqYwBj9u+5ciUpFPGdN+kqwU
 4dSXeTYgC4bmpBM2VtpnbYvOpa+P5jGFJAdYeZEiIcT4j9eH3Dp8DUDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293450>

I was trying to search the Git for Windows (G4W) history for commits that 
touched MSVC.

I've used 'git log -SMSVC --pretty='tformat:%h (%s, 
%ad)' --date=short --reverse' to get a nice list of those commits.

However, as the G4W project (https://github.com/git-for-windows/git/) 
follows the main git repo and its releases, it needs to rebase it's fixup 
patches, while retaining their original series, so has repeated copies of 
those fix patches on the second parent path (a technique Dscho called 
rebasing merges).

for example:
> bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
> a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
> 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
> 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
> 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)


How can I filter out all the duplicate patches which are identical other 
than the commit date?

The --left --right and --cherry don't appear to do what I'd expect/hope. Any 
suggestions?
--
Philip
