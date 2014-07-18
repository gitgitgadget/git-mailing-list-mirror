From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Why is git submodule slow under windows
Date: Fri, 18 Jul 2014 14:08:36 +0200
Message-ID: <53C90E44.6030702@virtuell-zuhause.de>
References: <18956e25b6c14091a64af5a65ce5d13c@FE-MBX1009.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Armbruster Joachim (BEG/EMS1)" <Joachim.Armbruster@de.bosch.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 14:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X86xz-0006cf-O7
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 14:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbaGRMIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 08:08:43 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:60349 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934338AbaGRMIm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 08:08:42 -0400
Received: from p5ddc0319.dip0.t-ipconnect.de ([93.220.3.25] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1X86xp-0002A5-Mx; Fri, 18 Jul 2014 14:08:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <18956e25b6c14091a64af5a65ce5d13c@FE-MBX1009.de.bosch.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1405685322;3f959064;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253813>

Am 18.07.2014 12:14, schrieb Armbruster Joachim (BEG/EMS1):
> Hello,
> 
> We split a monolithic repository into ~50 submodules. The stored data
> has the same size. In the 1:1 comparison to the monolithic
> repository, the submodule handling is very slow. Under Linux
> everything remains fast, but windows is slow.
> 
> So, why is git getting slow when it has to deal with a lot of
> submodules? I read something about the lack of the underlying cygwin
> to handle NTFS in a efficient way. Is this the root cause, or are
> there other causes also?
> 

Hi,

I assume you are using the latetst git from https://msysgit.github.io on
windows.

I would guess that submodules on windows are slow because
git-submodules.sh is a shell script, and bash on windows is not really
that fast.

There has been some (albeit older) discussion on the msysgit
mailinglist, see [1].

You can play around with core.fscache [2] maybe that helps.

Thomas

[1]: https://groups.google.com/d/msg/msysgit/AuPA4EbwchU/N42tsb6GousJ
[2]:
https://github.com/msysgit/msysgit/releases/tag/Git-1.8.5.2-preview20131230
