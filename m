From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: "error: Tweaking file descriptors doesn't work with this MSVCRT.dll"
 on wine
Date: Tue, 29 Jul 2014 08:30:21 +0200
Message-ID: <53D73F7D.1010902@web.de>
References: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC0vn-0000RP-In
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 08:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbaG2Gaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 02:30:35 -0400
Received: from mout.web.de ([212.227.17.11]:58578 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbaG2Gaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 02:30:35 -0400
Received: from [192.168.1.87] ([77.119.129.132]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M5Oct-1WHGVz2bgl-00zTnx; Tue, 29 Jul 2014 08:30:33
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
X-Provags-ID: V03:K0:XXevZtZeYxXmboWRtkl2NFq4kmsAj2m/uZB8GaSXhK06vjm7nVw
 EBWSU5xwVKd8iEAmkevjir2b3ZbVnqTlyCZ1qM0WVHSyt2KnZy+PP21BJg5rw0mtIJEqSSt
 eELlyUfJA74d+F8XNw8tlOgRyeClWc+NJCA3LsaHwuLhOVilUkegp6KHvEgrDEF/hduhVQ8
 ZwHQYblO/ZbAJwbMq4bjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254394>

On 07/28/2014 12:39 PM, Duy Nguyen wrote:
> I know wine is kind of second citizen but is there a cheap trick to
> make it work on wine? Reverting fcd428f (Win32: fix broken pipe
> detection - 2012-03-01) could result in conflicts in compat that I'm
> not comfortable resolving. I don't have Windows at home. Wine is the
> only option for me (or if somebody has a modern.ie image for KVM, or a
> simple recipe to make one, that'd be great). "Fix wine" is not really
> an option.
Is it only that patch that needs to be reverted to make things work got 
wine?
For me It seems as if the patch is not that huge, and manually do a 
copy-paste
with the help of a diff tool can be done.

It seems as if even both implemenations can live side-by-side in the code.
And if there is a run-time detection for wine, we could switch between the
old one and the new one which is dependent on how MSVCRT.dll has layed out
internal data structures:
  "ioinfo structure (exposed by MSVCRT.dll via  __pioinfo"

Sorry being not more helpful
