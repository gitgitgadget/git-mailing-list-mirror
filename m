From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Tue, 26 Nov 2013 19:44:33 +0100
Message-ID: <5294EC11.2010405@web.de>
References: <20131122151120.GA32361@sigill.intra.peff.net>	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de> <xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 19:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlNcm-00032D-Kx
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 19:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab3KZSog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 13:44:36 -0500
Received: from mout.web.de ([212.227.17.11]:61655 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753907Ab3KZSof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 13:44:35 -0500
Received: from [192.168.178.41] ([91.3.171.107]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M0hne-1VVDO00UxC-00uuo7 for <git@vger.kernel.org>;
 Tue, 26 Nov 2013 19:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:RwrCyn51N+a1VwO0TcN1KO4hnTV33FyMcGbLkxyLIqljKdVqF7P
 BOgLDlXZLfd+jnYbVACxoODhe9KjYsagL8UkzkteMPJqNFSrq7jwbp+oeVbGnXPp7BfcOv8
 dJuuD4VkjT695pHMsxUjkvX9ImfUXioDBXfO8xhIB/yZEkH1xh41PagWz4H3cqsiSUCHVRC
 PkdXqJPHWfKh9DqSkROww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238387>

Am 25.11.2013 22:01, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Looking good to me. Please add tests for "diff.ignoreSubmodules"
>> and "submodule.<name>.ignore", the latter both in .gitmodules and
>> .git/config. While doing some testing for this thread I found an
>> inconsistency in git show which currently honors the submodule
>> specific option only from .git/config and ignores it in the
>> .gitmodules file ...
> 
> Sorry, but isn't that what should happen?  .git/config is the
> ultimate source of the truth, and .gitmodules is a hint to prime
> that when the user does "git submodule init", no?

"git submodule init" only copies the "update" and "url" settings
to .git/config, all others default to the value they have in the
.gitmodules file if they aren't found in .git/config. This allows
upstream to change these settings unless the user copies them to
.git/config himself.
