From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Wed, 04 Sep 2013 22:40:44 +0200
Message-ID: <52279ACC.2070308@web.de>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net> <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net> <vpqa9jtayiq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, jrnieder@gmail.com, judge.packham@gmail.com,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:40:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHJsj-0004sG-NM
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606Ab3IDUku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:40:50 -0400
Received: from mout.web.de ([212.227.15.3]:60107 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097Ab3IDUks (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:40:48 -0400
Received: from [192.168.178.41] ([91.3.170.120]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MgwZQ-1VdMya2Ljc-00M2Gg for <git@vger.kernel.org>;
 Wed, 04 Sep 2013 22:40:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <vpqa9jtayiq.fsf@anie.imag.fr>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:+SGKEsi9OwNLh8du95eDn6X4Z8Ct1mfCZkasYZZv9GFiGTBkYYl
 vMQl/1ks0e/6eNePC8DoF5P2zaGoGpeUV/PSi3VrmJz5XtPXgCQeyDBiq5wkbvtXDFTnbo3
 50dnViG7JEAsQAMTBQS/eKK14+Jt2y+Nwc82Ma7RXQIFTFzMdflvyPKDAiQTkqYcmMtONok
 4tG7geylHFKMEF7n88I2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233871>

Am 04.09.2013 08:31, schrieb Matthieu Moy:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> Tests are included which verify that this change has no effect on git submodule
>> summary without the --for-status option.
> 
> I still don't understand why this is needed.

To avoid a change in behavior for "git submodule summary", as that
never honored the submodule.*.ignore nor the diff.ignoreSubmodules
setting (and I don't think it ever should).

> Why do we want "git status"
> and "git submodule summary" to display different information? Wasn't it
> a nice property that the part of "git status" about submodule is the
> same as "git submodule summary"?

I changed that in 2010 (1.7.3) to make the output of status consistent,
meaning that submodules that didn't show up in the regular status output
don't appear in the summary part either. And I still believe it is the
right thing to do for the target audience of the ignore settings, as
they want to hide any changes in submodules that are either expensive to
traverse or uninteresting for the developer until they explicitly use
the submodule commands, which still behave as they always did (I might
be wrong here as I'm not in that group myself, but so far no one spoke
up).

> This should at least be explained in the commit message IMHO.

Fine by me, what would you propose to clarify that? (Though I have the
suspicion that the explanation will be three years late ;-)
