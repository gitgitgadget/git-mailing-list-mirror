From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Sun, 04 Aug 2013 19:34:48 +0200
Message-ID: <51FE90B8.8030203@web.de>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net> <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net> <20130803181415.GF2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 04 19:35:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V62Cr-00024S-4R
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 19:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab3HDRe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Aug 2013 13:34:57 -0400
Received: from mout.web.de ([212.227.15.4]:55116 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700Ab3HDRe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 13:34:56 -0400
Received: from [192.168.178.41] ([91.3.181.161]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0LyftH-1U0cSg1i9X-0169th for <git@vger.kernel.org>;
 Sun, 04 Aug 2013 19:34:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130803181415.GF2893@elie.Belkin>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:Hijw6gec3Ues7kzw7RWxCh+T834BAUeqCtsA+kIYN6xHN7/OTCq
 fQsAK0WPJHg5LrnKOTT+kGsQkdu37XTpiaPpNnRzSWxK+fULTOKL66o8+oVSOeZcSi+2FWC
 YSuWnAsK7U7ky+nn79Z9O40BeBA29WDhcJOOYhoxe8ugx1yjxS4D1DkvKQvp4d/Kar27xj/
 uX8F+EP9Al7HSAZ/phAig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231634>

Am 03.08.2013 20:14, schrieb Jonathan Nieder:
> brian m. carlson wrote:
> 
>> cmd_summary reads the output of git diff, but reads in the submodule
>> path into a variable called name.  Since this variable does not
>> contain the name of the submodule, but the path, rename it to be
>> clearer what data it actually holds.
> 
> Nice.

I totally agree. Paths and names of submodules are often confused
(especially as they are identical for a submodule that was never
moved), so cleaning up our sources so they use the correct term is
The Right Thing.

But we'll have to use sm_path here (like everywhere else in the
submodule script), because we'll run into problems under Windows
otherwise (see 64394e3ae9 for details). Apart from that the patch
is fine.
