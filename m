From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] http: honor no_http env variable to bypass proxy
Date: Thu, 10 Mar 2016 09:50:13 +0100
Message-ID: <CA+EOSBmaWNrpvPiiYZJ270UeAbKVcBS2d2Tr5byoW4HX9R79Hw@mail.gmail.com>
References: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
	<xmqqio179uxn.fsf@gitster.mtv.corp.google.com>
	<xmqqr3fmni4d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Knut Franke <k.franke@science-computing.de>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <xin.jiang@huawei.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 09:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adwIV-0002oz-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 09:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbcCJIuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 03:50:16 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33223 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbcCJIuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 03:50:14 -0500
Received: by mail-vk0-f45.google.com with SMTP id k1so87616543vkb.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 00:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lzfAH1mPvA5SJFJ7Wy7h+Z8Vi7YdHXETCasCcuXI0BE=;
        b=GiP/sT7ftaaBIB/FHIpVNq4MJt4qxvYH96Rbq95ZkBRFOulYrcorV6hr84TNBjv24X
         xHYYZlJdEHMe/CKKJLND7HiGsWEss7Pi1goIh/JH1FD+Y7LX4f7MhUtUv0jiOyiaD6v5
         L6Ee0Alr0SAGu8Vfb3mKFgtjjjF583QlEbyRW9lxr2FQ2LeadjJb1EDpomaDvkJEMa5r
         0mDV7y7xeMLFKgmne5+zAuLMFZys4eHImDruSQawdX89ip+Hd/3sBE5rqnU64De9LzS7
         pc0BY5LkBNPNXVvkiCU5lFgyfRNf6r3pHSMAurUbzC0ulbbghoF/N0aSTR052ISkil9H
         isug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lzfAH1mPvA5SJFJ7Wy7h+Z8Vi7YdHXETCasCcuXI0BE=;
        b=K3Pv+ZnoMti9S4nC4wY0nGgwuFjsmagNa3/lH6l23nxdMfAIYoj27+ePUszeCldwBK
         gYAMpj7cLEsuGeJYPFkR7VirI2fwX3mxnxatz37k+6o0boDwIuHsXTRi152Q2mJ9o9tM
         B3n//yA3uTCh6OiMHBA2JdG1j/ovIKYAJOXTsO2HG8wv1BQs9SLg6e4h8KIV5U7aYIcc
         uqM+4aQtyIC1XSESxBKIAFVS55klwrBe8sINpYLmiTFHUhxW1FgyLb4i7eZePGMshtwg
         3G2IMbOU55V1hnjiUd1BdsiZWqc6NdM15aD7bpbAoB2X5fEu+4tWnsfZRkwwBReFSAfs
         UnNw==
X-Gm-Message-State: AD7BkJKjUJis7otdXdU89aAdX3R8IN3IpJps2kjhA87e6P406CnKBIfqt9Q9aATTn3ivUVgPy0nUcBS4zM7SaQ==
X-Received: by 10.31.180.215 with SMTP id d206mr2303494vkf.125.1457599813548;
 Thu, 10 Mar 2016 00:50:13 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Thu, 10 Mar 2016 00:50:13 -0800 (PST)
In-Reply-To: <xmqqr3fmni4d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288604>

2016-03-07 21:33 GMT+01:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
> Second call for help.  I hate having to revert 30f302f7 (Merge
> branch 'kf/http-proxy-auth-methods', 2016-02-03) this late in the
> cycle.
Ok. I made the original merge commit for master. So,  if it is
sufficient, for me the patch is correct.

I am sorry for the delay in the response.

Best
>
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> From: Jiang Xin <xin.jiang@huawei.com>
>>>
>>> Curl and its families honor several proxy related environment variables:
>>>
>>> * http_proxy and https_proxy define proxy for http/https connections.
>>> * no_proxy (a comma separated hosts) defines hosts bypass the proxy.
>>>
>>> This command will bypass the bad-proxy and connect to the host directly:
>>>
>>>     no_proxy=* https_proxy=http://bad-proxy/ \
>>>     curl -sk https://google.com/
>>>
>>> Before commit 372370f (http: use credential API to handle proxy auth...),
>>> Environment variable "no_proxy" will take effect if the config variable
>>> "http.proxy" is not set.  So the following comamnd won't fail if not
>>> behind a firewall.
>>>
>>>     no_proxy=* https_proxy=http://bad-proxy/ \
>>>     git ls-remote https://github.com/git/git
>>>
>>> But commit 372370f not only read git config variable "http.proxy", but
>>> also read "http_proxy" and "https_proxy" environment variables, and set
>>> the curl option using:
>>>
>>>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>>>
>>> This caused "no_proxy" environment variable not working any more.
>>>
>>> Set extra curl option "CURLOPT_NOPROXY" will fix this issue.
>>>
>>> Signed-off-by: Jiang Xin <xin.jiang@huawei.com>
>>> ---
>>>  http.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>
>> Sounds sensible; I am guessing that this is 2.8.0-rc0 regression
>> that we need to fast-track?
>>
>> Knut, does this look good?
>>
>> Thanks.
>>
>>> diff --git a/http.c b/http.c
>>> index 1d5e3bb..69da445 100644
>>> --- a/http.c
>>> +++ b/http.c
>>> @@ -70,6 +70,7 @@ static long curl_low_speed_limit = -1;
>>>  static long curl_low_speed_time = -1;
>>>  static int curl_ftp_no_epsv;
>>>  static const char *curl_http_proxy;
>>> +static const char *curl_no_proxy;
>>>  static const char *http_proxy_authmethod;
>>>  static struct {
>>>      const char *name;
>>> @@ -624,6 +625,11 @@ static CURL *get_curl_handle(void)
>>>              }
>>>
>>>              curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>>> +#if LIBCURL_VERSION_NUM >= 0x071304
>>> +            var_override(&curl_no_proxy, getenv("NO_PROXY"));
>>> +            var_override(&curl_no_proxy, getenv("no_proxy"));
>>> +            curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
>>> +#endif
>>>      }
>>>      init_curl_proxy_auth(result);
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
