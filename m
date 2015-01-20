From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git --recurse-submodule does not recurse to sub-submodules (etc.)
Date: Tue, 20 Jan 2015 22:21:11 +0100
Message-ID: <54BEC6C7.8070103@web.de>
References: <CACgLhq_kMv2cj4RHr8Yx5tnYup5enCJVMrZf9Yt9Y5-bkfozLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Voigt, Heiko" <Heiko.Voigt@mahr.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Maximilian Held <maximilian.held83@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 22:21:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDgEk-0001rg-4g
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 22:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbbATVVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 16:21:17 -0500
Received: from mout.web.de ([212.227.17.12]:61511 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbbATVVR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 16:21:17 -0500
Received: from [192.168.178.41] ([79.211.116.130]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MFc9x-1Xzhkd33Tx-00EhZQ; Tue, 20 Jan 2015 22:21:14
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CACgLhq_kMv2cj4RHr8Yx5tnYup5enCJVMrZf9Yt9Y5-bkfozLg@mail.gmail.com>
X-Provags-ID: V03:K0:NxvAu6+r75ghvdivxYcU0Bd22tfshVIAWFUusNZpI0QLKMzcsp/
 Sx4Y58mfe9+pfkIsvTmrnlVfGk83IQF+I4FE8ZnzZTWpbg/x5B9hyeBkl1kD5J6frQV7V+S
 eFtIcqkWkpNSBiUOCEllwx4HzBOpC0AomBzuj9duu882/Aa6hjPlV8I1MN1U5QSG/yQAQcR
 djEG21AJSsHkhUkonP38Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262691>

Am 19.01.2015 um 21:19 schrieb Maximilian Held:
> I have a directory with nested submodules, such as:
>
> supermodule/submodule/sub-submodule/sub-sub-submodule
>
> When I cd to supermodule and do:
>
> "git push --recurse-submodule=check" (or on-demand),
>
> git only pushes the submodule, but not the sub-submodule etc.
>
> Maybe this is expected behavior and not a bug, but I thought it was
> pretty unintuitive. I expected that git would push, well, recursively.

I agree this is unexpected and should be fixed. I suspect the fix
would be to teach the push_submodule() function to use the same
flags that were used for the push in the superproject.
