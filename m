From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: respect -q for add/update
Date: Wed, 05 Sep 2012 22:33:39 +0200
Message-ID: <5047B723.4050201@web.de>
References: <1346743880-11379-1-git-send-email-orgads@gmail.com> <50461E18.6020400@web.de> <CAGHpTBJ6hWJKaQvN4oByrest_FB1fGDKa=ge4fM1HWmSWZ1tkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 22:33:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9MIM-0002O5-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 22:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389Ab2IEUdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 16:33:46 -0400
Received: from mout.web.de ([212.227.17.12]:56666 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759373Ab2IEUdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 16:33:44 -0400
Received: from [192.168.178.41] ([91.3.176.88]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0LrJxk-1Tal6B0cQ8-013ybi; Wed, 05 Sep 2012 22:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <CAGHpTBJ6hWJKaQvN4oByrest_FB1fGDKa=ge4fM1HWmSWZ1tkw@mail.gmail.com>
X-Provags-ID: V02:K0:Ow7NaSkP67kNDw6lLRvOsEYclN3WSOPRqeF3TxeuoqA
 dwJRml0gjreWW/eiwINgLMvluVe4Gp8BQrkIzRySqiAJTqS+8B
 LaKp62KPRbmhWcFKQxvk1XppYy092AzAUQaB3tGvfQhwqJMJqj
 /V/vXsK8S3HxwToLU2hR0ioEAtEpOpmZ21mFdHSZAf85h0obx2
 BGE8gW9JdMdKwOk70pEhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204845>

Am 05.09.2012 13:42, schrieb Orgad and Raizel Shaneh:
> On Tue, Sep 4, 2012 at 6:28 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>
>> Am 04.09.2012 09:31, schrieb Orgad Shaneh:
>>> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
>>
>> Before the "Signed-off-by" is the place where you should have
>> explained why this would be a worthwhile change ;-)
>>
>> To me this looks like you make the default noisier and require an
>> explicit "-q" to make it quiet again. There is a reason you don't
>> normally get bothered with the output of the checkout command run
>> under the hood of git submodule add/update, so I don't think this
>> change makes things better.
>>
>> But you might want to think about adding a "-v/--verbose" flag to
>> make the submodule add/update checkouts more verbose, in case you
>> care about the output of the checkout command. That would be a
>> sane thing to do, so what about changing your patch into this
>> direction?
>>
> 
> I don't agree the default should be quiet. That's what the (submodule)
> -q flag is there for.

Nope, the -q flag is to silence *all* output except errors. And it
makes perfect sense for high level commands to hide the output of
the commands run under the hood like we do here.

> When I run 'git submodule update' I don't expect to be in the dark
> until the submodule/s finishes checkout, this sometimes can take a
> significant amount of time and feedback is expected.

As I said, add a verbose flag so you can see in detail what is going
on.
