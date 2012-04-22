From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: contrib/workdir/git-new-workdir broken in 1.7.10 after introducing
 gitfiles
Date: Sun, 22 Apr 2012 20:32:18 +0200
Message-ID: <4F944EB2.6040105@web.de>
References: <CAHsq6J6JOTYfEtK0Z=_qfMFf9N1DWQ4zx46YhBbNu-1gEMyfog@mail.gmail.com> <4F930043.1080506@web.de> <xmqq397wzwwd.fsf@junio.mtv.corp.google.com> <xmqqy5poxtsc.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antonin Hildebrand <antonin@hildebrand.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 20:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SM1am-0002pE-8L
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 20:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab2DVScz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 14:32:55 -0400
Received: from fmmailgate07.web.de ([217.72.192.248]:47894 "EHLO
	fmmailgate07.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab2DVScy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 14:32:54 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate07.web.de (Postfix) with ESMTP id 13D541213AB6
	for <git@vger.kernel.org>; Sun, 22 Apr 2012 20:32:22 +0200 (CEST)
Received: from [192.168.178.48] ([79.193.95.22]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MWAtV-1SkTPO0Hg9-00XNMv; Sun, 22 Apr 2012 20:32:19
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <xmqqy5poxtsc.fsf@junio.mtv.corp.google.com>
X-Provags-ID: V02:K0:LRSUT8r8h9oT5X6hIQ6Tj96R0YoEE8etCAEK+S1G5M1
 TH2PHqklDzyvlzV3UnSHXUAtLbq0mf3i9+ZdupumYoBE/6pVOM
 LV+cKOIgpuOXJvYoAJMl6ng04l1/Kb2NZR/a6x0QwloXPLIonX
 8xX4iwj2iczyoRc9fYvRDwaO3x5q4wqCkG72/lECVSXFhfGl4p
 xpVEhuz3yawP2Oo89oaVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196087>

Am 22.04.2012 06:41, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> As you analyzed correctly, core.worktree lets a GIT_DIR to declare that
>> there is a single working tree associated with it. It fundamentally is
>> incompatible with new-workdir, which is a hack to let more than one
>> working tree associated with a single GIT_DIR.
>>
>> I however do not think a simplistic "unset core.worktree" is a good
>> suggestion, though, as we do not know why the original repository has
>> that variable set pointing at somewhere.  Blindly removing it will break
>> the use of the original repository.  If somebody _really_ wants to use
>> new-workdir for whatever reason in such a setting, I would imagine that
>> doing something like this:
>> ...
>> may work.
> 
> I am too lazy to try it out myself, but a hack something along the line
> of the attached patch _might_ turn out to work well.

A quick test worked just fine. Looks like you fixed git-new-workdir to
be usable with the new gitfile submodules ;-)
