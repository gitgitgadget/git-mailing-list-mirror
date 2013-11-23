From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git issues with submodules
Date: Sat, 23 Nov 2013 21:10:44 +0100
Message-ID: <52910BC4.1030800@web.de>
References: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com> <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com> <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com> <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com> <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com> <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com> <528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub> <20131122220953.GI4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 23 21:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkJXX-0005Td-N3
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 21:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab3KWUKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 15:10:47 -0500
Received: from mout.web.de ([212.227.15.3]:62688 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755267Ab3KWUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 15:10:47 -0500
Received: from [192.168.178.41] ([91.3.173.138]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Meje0-1Vzn3t129g-00OJQU for <git@vger.kernel.org>;
 Sat, 23 Nov 2013 21:10:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <20131122220953.GI4212@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:HcECqcie0zFEmWzSuQN5ljcuizL5S0Bcyn6FiLou7iXE1xEjr46
 jad0WuNf4VMRoybscXDoYeFKify6hTF2T+3Kg4ZgCRVrChnB7xOguVuMD+dCPUWo2nwOIm3
 rly7mmFKmQDWNwpTRAaZZLELDFEjE9/lV7XxuBtDTxgxjq71qfmYzftjub2Oy39Iz7qkABN
 K6S6XL0DOhXNHtGdIE9/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238243>

Am 22.11.2013 23:09, schrieb Jonathan Nieder:
> Heiko Voigt wrote:
> 
>> After that we can discuss whether add should add submodules that are
>> tracked but not shown. How about commit -a ? Should it also ignore the
>> change? I am undecided here. There does not seem to be any good
>> decision. From the users point of view we should probably not add it
>> since its not visible in status. What do others think?
> 
> I agree --- it should not add.

I concur: adding a change that is hidden from the user during
the process is not a good idea.

> That leaves the question of how to add explicitly.  "git add -f"?
> "git add --ignore-submodules=none"?

I suspect "git add" and "git commit -a" have to learn the
--ignore-submodules option anyway if we go that route. There
are points in time (e.g. releasing a new version or having run
an expansive test successfully) where some users want to update
the submodules that are normally ignored to record the exact
versions involved.
