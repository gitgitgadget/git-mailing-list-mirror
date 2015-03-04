From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t5516-fetch-push: Correct misspelled pushInsteadOf
Date: Wed, 04 Mar 2015 10:36:13 +0100
Message-ID: <54F6D20D.903@drmicha.warpmail.net>
References: <alpine.DEB.2.10.1502282316150.7008@buzzword-bingo.mit.edu>	<xmqq385nb2yg.fsf@gitster.dls.corp.google.com>	<54F5D869.4010104@drmicha.warpmail.net> <xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:43:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT5pc-0000Ga-MZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759148AbbCDJnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 04:43:00 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60981 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755160AbbCDJm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2015 04:42:58 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2015 04:42:58 EST
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2FC73209B0
	for <git@vger.kernel.org>; Wed,  4 Mar 2015 04:36:14 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 04 Mar 2015 04:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Hrbk7pciuLsEKtcY8bdIzi
	kgcik=; b=bENTj4kNffLNtRzSXVVcxaD8+rRz4eGx27iNfu7iqzJV/+1I7Lb3uD
	Zw5zBLqLrGjhOfL4h9UujY65GDftx3kNd52v3CF4BboQhIwi3ugG9OdXNrq7fJN8
	xqdM5tgErvbHG3A7F8E/xrBNsnGgskN++qxwEIhthbNGSzo6f1uiw=
X-Sasl-enc: ksEUHvKr44aU1KRxyLwAHg+sTBE/rVIKX1bAMrvwL/7U 1425461775
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id ABF17C00297;
	Wed,  4 Mar 2015 04:36:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq8ufdc0c7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264739>

Junio C Hamano venit, vidit, dixit 03.03.2015 21:06:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 02.03.2015 20:43:
>>> Anders Kaseorg <andersk@mit.edu> writes:
>>>
>>>> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
>>>> ---
>>>>  t/t5516-fetch-push.sh | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
>>>> index 85c7fec..594d7a6 100755
>>>> --- a/t/t5516-fetch-push.sh
>>>> +++ b/t/t5516-fetch-push.sh
>>>> @@ -238,7 +238,7 @@ test_expect_success 'push with pushInsteadOf' '
>>>>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>>>>  	mk_empty testrepo &&
>>>>  	test_config "url.trash2/.pushInsteadOf" testrepo/ &&
>>>> -	test_config "url.trash3/.pusnInsteadOf" trash/wrong &&
>>>> +	test_config "url.trash3/.pushInsteadOf" trash/wrong &&
>>>>  	test_config remote.r.url trash/wrong &&
>>>>  	test_config remote.r.pushurl "testrepo/" &&
>>>>  	git push r refs/heads/master:refs/remotes/origin/master &&
>>>
>>> Interesting.
>>>
>>> Now an obvious and natural question after seeing this change is how
>>> the original test passed with misspelled configuration.  Is a test
>>> that pushes into "trash/wrong" checking the right outcome?  If the
>>> reason why the existing tests passed without this patch is because
>>> they do not test the right thing, then shouldn't they be corrected
>>> together with the above fix?
>>>
>>
>> Ha, I was look there, too, just today and was wondering the same.
>>
>> I guess the test wanted to make sure (among other things) that
>> url.trash3/.pushInsteadOf does not affect the push to remote r (which
>> has an explicit pushurl)...
> 
> OK, so it makes sure the push goes to testrepo/ but it does not make
> sure trash2 or trash3 are not touched.  Makes sort of sense.
> 
> Thanks.
> 
> I am not sure how the intention of the commit 1c2eafb8 (Add
> url.<base>.pushInsteadOf: URL rewriting for push only, 2009-09-07),
> which introduced the behaviour verified by this test, interacts with
> the desire to redefine what URL and pushURL mean in our recent past,
> what e.g. e6196ae1 (remote: add --fetch and --both options to set-url,
> 2014-11-25) wanted to do, though.  Thoughts?
> 

Wow. That looks strange to me on first read. Sorry I didn't catch it
back then. "--fetch" sets both url and pushurl??

Also, talking about these things (in the commit msg etc.) can be
confusing very quickly because there are the config names url and
pushurl, the struct members url und pushurl, and then suddenly the
notion of "fetch URL" appears.

So, for definiteness sake, I'll use "url" and "pushurl" for the config
names and struct members (which the config values end up in), and I'll
use "URL for fetch" and "URL for push" for the URLs that git will use
for fetch resp. push.

If there is no "pushurl":
  "url" will be used as the "URL for fetch" and as the "URL for push".
  if we are pushing and there is "pushinsteadof" for (part of) "url"
    subsitute that within "url"
  else if there is "insteadof" for (part of) "url"
    substitute that within "url"

If there is a "pushurl":
  "url" will be used as the "URL for fetch" and "pushurl" as the "URL
for push".
  if we are pushing and there is "insteadof" for (part of) "pushurl"
    substitute that within "pushurl"
  else if we are fetching and there is "insteadof" for (part of) "url"
    substiute that within "url"

I don't know what "remote set-url" does, I think the whole remote
command as it is does not fit in well with our UI, but that applies to
other commands with non-option subcommands as well (or bad). I would
have hoped it is set-url and set-pushurl to set those two config
options. Maybe that's not useful.

The logic above may look a bit strange regarding pushinsteadof, but it's
really what makes this useful. An example:

[url "git://github.com/"]
        insteadOf = github:
[url "github:"]
        pushinsteadOf = github:

This allows me to use
git remote add <remotename> github:<user>/<reponame>

and have fetches over git protocol, pushes over ssh since my ssh_config has:

host github
Hostname github.com
User git
IdentityFile ~/.ssh/repoor_dsa

[url "https://bitbucket.org/"]
        insteadOf = bitbucket:
[url "https://grubix@bitbucket.org/"]
        pushinsteadOf = bitbucket:

This allows me to use

git remote add <remotename> bitbucket:<user>/<reponame>

and have fetches over https, pushes over https with my username preset.

I rarely use pushurl, but could use it to override url, or to do the
above magic on a case by case level, such as if I need to specify
different usernames for the same host.

So, that's my understanding of how these things are supposed to work and
why it is useful.

Michael
