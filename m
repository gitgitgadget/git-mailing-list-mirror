From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Tue, 02 Apr 2013 18:53:28 +0200
Message-ID: <515B0D08.4020405@web.de>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com> <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com> <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com> <20130401234016.GC30935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4TN-0001K8-EF
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759798Ab3DBQxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:53:44 -0400
Received: from mout.web.de ([212.227.15.3]:63556 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab3DBQxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:53:43 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LbZpT-1V2Cyf0xmV-00kxJ7; Tue, 02 Apr 2013 18:53:30
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130401234016.GC30935@sigill.intra.peff.net>
X-Provags-ID: V02:K0:qxGMu6iZanWtvSYoQJgdzrU+g3xEOLId2BP73L00L02
 NvU615jILm6iLrDxmMfF6oylL+KKwIBX3KPqwwNPKTACjMvcTm
 jvDS7SLmzphOglHg9xFnp+SMqcw1ltMmq0MOHhHjJS9r+p9y6t
 jTayg9zQcMbOIbLVaaG+INgdU6mKoiIbkN1S+mWCwzfC4cukHQ
 KjQSM8UpVZX8NBI6ElPrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219797>

On 02.04.13 01:40, Jeff King wrote:
> On Mon, Apr 01, 2013 at 11:46:00PM +0200, Antoine Pelisse wrote:
> 
>> On Mon, Apr 1, 2013 at 11:14 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> +export TEST_LINT :=
>>
>> I think "test-lint-executable" still makes sense here.
> 
> Also test-lint-shell-syntax, which finds a problem with the current
> code:
> 
>   $ cd contrib/remote-helpers
>   $ make test TEST_LINT=test-lint-shell-syntax
>   make -e -C ../../t test
>   make[1]: Entering directory `/home/peff/compile/git/t'
>   rm -f -r test-results
>   /home/peff/compile/git/contrib/remote-helpers/test-bzr.sh:139: error: echo -n is not portable (please use printf):   echo -n content > expected &&
>   make[1]: *** [test-lint-shell-syntax] Error 1
>   make[1]: Leaving directory `/home/peff/compile/git/t'
>   make: *** [test] Error 2
> 
> I think the check for duplicate-numbers is the only one that does not
> make sense. 
[]
Not sure about that, I send a suggestion of a patch in a minute.
Highlights:
1) - rename the contrib test cases and assigns real TC numbers
2) - Forward the numbers into the main "test Makefile"

1) Will probably collide with Felipe's changes, so we just can pick up the idea.
2) Is for only review.
  If we agree on the re-numbering of TC's in contrib, we can apply
  a second round of the patch later.

/Torsten
