From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] Teach --recursive to submodule sync
Date: Fri, 26 Oct 2012 20:50:19 +0200
Message-ID: <508ADB6B.5040905@web.de>
References: <507EF86C.4050807@web.de> <1351034141-2641-1-git-send-email-hordp@cisco.com> <1351034141-2641-2-git-send-email-hordp@cisco.com> <5089BBE1.3040107@web.de> <508AC63E.6010502@cisco.com> <CABURp0q0uELTS4DQ=Kqfr+8Pr-KgLcGJaBY_kJE_AiO=BZu+Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 20:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRozn-0002hq-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 20:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966044Ab2JZSuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 14:50:37 -0400
Received: from mout.web.de ([212.227.15.3]:50621 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965243Ab2JZSu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 14:50:26 -0400
Received: from [192.168.178.41] ([79.193.90.117]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0MCqkB-1TaNQL3KvT-009C7T; Fri, 26 Oct 2012 20:50:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CABURp0q0uELTS4DQ=Kqfr+8Pr-KgLcGJaBY_kJE_AiO=BZu+Bw@mail.gmail.com>
X-Provags-ID: V02:K0:QyZeEOz7jRwQU5aQMovO9z1PPdsUZyiXYeERdqn0hnf
 jZHqIl+XuSQpbhOrcViLzAASvsI3gVU/2JTO53RVwmPgRyW0P4
 +IbQs/IRvrMp4Mf7t/zug8oNaelOIXqMwME7ccRUE3Zy2exoB0
 iVVLLYp6ymII2DSQ9tFGGLnKdq1pQNBnx3ExVvd592OnqGGZMH
 VYnMTD9Lc1qOwYhoTGSfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208476>

Am 26.10.2012 19:55, schrieb Phil Hord:
> On Fri, Oct 26, 2012 at 1:19 PM, Phil Hord <hordp@cisco.com> wrote:
>>
>> Yes, thanks for catching that.  I think I should add a test for that
>> except I notice that sync doesn't take any other flags useful for passing.
> 
> Which, of course, suggests that I should not add this
> flag-propagating-machinery to submodule-sync at all. yes?

Nope, the new --recursive option has to be passed on!

To catch that bug in your test you'd need another submodule inside your
sub-submodule. The first level submodule is initialized by sync anyways,
the sub-submodule is initialized by the --recursive logic you added but
the sub-sub-submodule would not have been synced because the option was
dropped. I really can't blame you for not adding that third level of
submodules ;-)
