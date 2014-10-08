From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: let git grep consider sub projects
Date: Wed, 08 Oct 2014 09:24:37 +0200
Message-ID: <5434E6B5.3030605@web.de>
References: <20141007082914.GA2729@aepfle.de> <xmqq8ukrg2j2.fsf@gitster.dls.corp.google.com> <CAHYJk3Qrj3QfBK-MkcCS2AmyTz=AgCcruq7Df-YZKW24LMWTHg@mail.gmail.com> <5434DE29.2010200@web.de> <20141008065947.GA22318@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Wed Oct 08 09:24:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xblc4-00081d-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 09:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbaJHHYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 03:24:41 -0400
Received: from mout.web.de ([212.227.17.11]:65012 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754428AbaJHHYk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 03:24:40 -0400
Received: from [192.168.178.41] ([79.193.66.158]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LbaBL-1Y51cD0yBH-00lDi6; Wed, 08 Oct 2014 09:24:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <20141008065947.GA22318@aepfle.de>
X-Provags-ID: V03:K0:04dgYR9Ae23MLG6e0tgwlouWO8ZOUr3FMZLu45IaLNPzR6qUUup
 6KaHpeOYdHcH/1j6+8JgsVquoxhdrmTWU5e7uvU8ObWt4CXnqtvqCoUG1TOloNy5O04Zk1Y
 EAbNwQClORk7R2pVrAPKgXRAWvfyKkBFwx3xK4sVDajc/Cblnv7aFmMqXya7qME+qPFHq7A
 lia7PbAGxuPXnV9Ba/6QA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.2014 um 08:59 schrieb Olaf Hering:
> On Wed, Oct 08, Jens Lehmann wrote:
>
>>     git foo && git submodule foreach --recursive git foo
>
> Looks like a submodule is yet another thing, or I have to learn what a
> submodule is:
>
> olaf@bax:~/xen $ find . -name .git
> ./.git
> ./tools/qemu-xen-dir-remote/.git
> ./tools/qemu-xen-traditional-dir-remote/.git
> ./tools/firmware/seabios-dir-remote/.git
> olaf@bax:~/xen $ git submodule foreach --recursive git show
> olaf@bax:~/xen $
>
> xen does essentially 'git clone $url1 dir/url1-dir;git clone $url2
> dir/url2-dir'. So the top level .git does not really know about
> dir/*-dir.

Okay, I just checked that xen doesn't use submodules but uses simple
embedded repos ignored by the .gitignore file. From a quick glance
it looks like handling the sub projects is scripted in the Makefiles.
This is perfectly fine, but then you can't really expect git commands
to know about these sub projects. Or am I missing something?
