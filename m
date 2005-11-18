From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: "make test" fails with current HEAD
Date: Thu, 17 Nov 2005 19:23:16 -0800
Message-ID: <437D4924.50307@gmail.com>
References: <pan.2005.11.17.15.31.56.755022@smurf.noris.de> <Pine.LNX.4.63.0511171652020.17402@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 04:23:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcwqQ-0004ni-2J
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 04:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVKRDXT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 22:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbVKRDXT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 22:23:19 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:53539 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751469AbVKRDXS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 22:23:18 -0500
Received: by xproxy.gmail.com with SMTP id s14so94540wxc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 19:23:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OH6YBT9/TOPbQ6+qQGAGghymz84wYL7nNQTq65trjFGmGUvkL4W5nmOgIPi/8DbZhgS0URfNlmxjSkHpLp8JpRBlzM7Fnp0SiSlRp29hYcso6fDgGiuFkel9mzLOAQflCrrRrhiB42YctWqfaCBc2uZdCJyBoRjzcvIYozVmDYY=
Received: by 10.70.50.4 with SMTP id x4mr3983524wxx;
        Thu, 17 Nov 2005 19:23:18 -0800 (PST)
Received: from ?10.0.0.6? ( [70.32.120.109])
        by mx.gmail.com with ESMTP id h14sm411652wxd.2005.11.17.19.23.17;
        Thu, 17 Nov 2005 19:23:18 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511171652020.17402@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12187>

Fails at home (Suse 9.3) but passes a work (Ubuntu Hoary).

*** t4103-apply-binary.sh ***
*   ok 1: stat binary diff -- should not fail.
*   ok 2: stat binary diff (copy) -- should not fail.
*   ok 3: check binary diff -- should fail.
*   ok 4: check binary diff (copy) -- should fail.
*   ok 5: check incomplete binary diff with replacement -- should fail.
*   ok 6: check incomplete binary diff with replacement (copy) -- should 
fail.
* FAIL 7: check binary diff with replacement.
         git-checkout master
                  git-apply --check --allow-binary-replacement BF.diff
* FAIL 8: check binary diff with replacement (copy).
         git-checkout master
                  git-apply --check --allow-binary-replacement CF.diff
*   ok 9: apply binary diff -- should fail.
*   ok 10: apply binary diff -- should fail.
*   ok 11: apply binary diff (copy) -- should fail.
*   ok 12: apply binary diff (copy) -- should fail.
*   ok 13: apply binary diff without replacement -- should fail.
*   ok 14: apply binary diff without replacement (copy) -- should fail.
* FAIL 15: apply binary diff.
         do_reset
                  git-apply --allow-binary-replacement --index BF.diff &&
                  test -z "$(git-diff --name-status binary)"
* FAIL 16: apply binary diff (copy).
         do_reset
                  git-apply --allow-binary-replacement --index CF.diff &&
                  test -z "$(git-diff --name-status binary)"
* failed 4 among 16 test(s)
make[1]: *** [t4103-apply-binary.sh] Error 1


Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 17 Nov 2005, Matthias Urlichs wrote:
> 
>>t4103.sh:
>>
>>fatal: patch with only garbage at line 30
>>* FAIL 7: check binary diff with replacement.
>>        git-checkout master
>>                 git-apply --check --allow-binary-replacement BF.diff
> 
> Does not fail here.
> 
> Did you set your GIT_EXEC_PATH?
> 
> Hth,
> Dscho
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
