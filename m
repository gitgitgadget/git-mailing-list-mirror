From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: .gitmodules containing SSH clone URLs should fall back to HTTPS
 when SSH key is not valid/existent
Date: Thu, 29 May 2014 13:35:41 +0200
Message-ID: <53871B8D.40608@web.de>
References: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Albietz <inthecloud247@gmail.com>
To: Jonathan Leonard <johanatan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 13:35:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpycj-0006v7-4l
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 13:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbaE2Lft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 07:35:49 -0400
Received: from mout.web.de ([212.227.15.3]:61760 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbaE2Lfs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 07:35:48 -0400
Received: from [192.168.178.41] ([79.193.74.212]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MJCEk-1WrcFc0r50-002s9R; Thu, 29 May 2014 13:35:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CA+OJ3uv0XqeodTCzeauUrH9FjzknBupMd5kxh+3qgyji5TwOzA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:V6vZCWWPPfginbrRLpPIY6qkNuGQQ7vSg5iTRCAR7JjWM2CfiCA
 xD+AaPF00Feg+Depa4eSAomdSLFNZUpLfs2i+Fxxbq+GxtlGesu72ihh5Utkk6NRnWe5jSO
 plRNX2wxi2Vcd8cvYn/ykIl46ZlUCsQfc4Ve0aZJK16IX8plTkM4LDj9nEKOsYmuwDipqmh
 dyBmJKDOZcM55NAq2xXvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250361>

Am 29.05.2014 04:07, schrieb Jonathan Leonard:
> The title pretty much says it all.

But you do not give much information about your special use
case. I assume you have submodule repositories for which some
developers have a valid ssh key and others don't (maybe
because they should only have read access via https)?

If that is the case you might want to look into access control
tools like gitolite.

>  Lack of this feature (or presence
> of this bug [depending on your perspective]) is a major PITA.

But why is https special? Why not fall back to the git
protocol? Or http? (And no: I'm not serious here ;-)

After the first failed clone of the submodule at via SSH the
developer could also just do a

   git config submodule.<name>.url https://host/repo

and override the URL from .gitmodules.

But maybe I misunderstood why you want to have a fall back?
