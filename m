From: Felix Ruess <felix.ruess@gmail.com>
Subject: Re: git 2.8.1 not working with socks5h https proxy anymore
Date: Sat, 9 Apr 2016 14:05:11 +0200
Message-ID: <CAEc+GFerpBC_O4jMvtmUhVdLReEN4nvuz5Q30SFUp8qZnQZBmQ@mail.gmail.com>
References: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
	<xmqq8u0nx66h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 14:05:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aordj-0007ZC-CE
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbcDIMFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 08:05:15 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:32848 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcDIMFN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 08:05:13 -0400
Received: by mail-lf0-f45.google.com with SMTP id e190so104037282lfe.0
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BCb75K5MgfNNF0GbqI7RfkmR8EapodfPV/zz0KQulVk=;
        b=KsfYt6qV1qBF4S5zj5MRVJYo6BaiHnvJ40rPjkrlyzrM8eh+ONiSs7FMEl9KBUonhu
         WGz1XIDMFstYQkYPeAfFmeNn73D7U5jl1VVlzniZU1RVxi9KysAJPouRXDznhf2eQMfS
         1N/ivEmRRM/Tqspxs9Lwz1wWj8ycZZWeWGLEAzC7hrr8fyGyxYXg3ElxdpJvwBRQQI9T
         Je2YqQBiw8iHQMjseHH/HUyA/z8WcgJknEP1Q6YjVm/FyRFtGVTBLX8twCg4eG/CH+fw
         r+Q1l+690ka7TNr+i8eARQLU3U1UTHdL0SY84Lr2+aDLyV7XeXY85dHLnhDIITnc3luk
         5x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BCb75K5MgfNNF0GbqI7RfkmR8EapodfPV/zz0KQulVk=;
        b=NZpNRWtwJCLvTdeSWddFAvoa72qH46Ni/RLttrFUpU9MZf+9Njs0x5lZmKgYqiFasV
         BC02x2QMWM5yh02f2bPAMp5oHtTqdncUfdMEzvvy/u11W5YEdEq/r151pWMm5WSWP1tU
         Vzw+aqwdHexbl0Atrv3Iw5CVhMUJ1R6kHXdzpM49woI7uZiW21/YZdaO1UG2lqpBCtjM
         Q2sFhR9buI4faKE6PAXNm9B470FFelRx1vA5JmYAZwN4KLp9J1kY++fUgnOL0y9XBp/V
         gbRo4iVDwNlR/KHE538GCsbuD9czTfgsN7donUx3vX0nPhM1xN5aViA4GDJWiFThOOve
         onpQ==
X-Gm-Message-State: AD7BkJJrqiETg2mZfglA8du6CjsAcHd5yHbygmmMBF5pqn0NL4kkT2fQaBztCuRNX2EWvOp4nN+gUlBIyXEZlA==
X-Received: by 10.112.13.193 with SMTP id j1mr5615185lbc.24.1460203511797;
 Sat, 09 Apr 2016 05:05:11 -0700 (PDT)
Received: by 10.114.68.70 with HTTP; Sat, 9 Apr 2016 05:05:11 -0700 (PDT)
In-Reply-To: <xmqq8u0nx66h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291089>

Thanks a lot!
Tested the patch and it works as expected :-)

On Fri, Apr 8, 2016 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felix Ruess <felix.ruess@gmail.com> writes:
>
>> I just encountered a problem with the latest git version (2.8.1) that
>> looks like a regression to me:
>> When trying to clone a repo via a https socks5 proxy the connection times out:
>>
>> $ git config --global 'http.proxy=socks5h://127.0.0.1:1080'
>
> The first version of Git that has code that explicitly supports
> socks proxy is 2.6.4, it seems.  Since then we have always used
> CURLPROXY_SOCKS5 for curl_http_proxy that begins with a string
> "socks5".
>
> Checking
>
>     https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions
>
> I find that that at curl 7.18.0, curl added a separate
> CURLPROXY_SOCKS5_HOSTNAME that can be triggered by "socks5h:" that
> is separate from CURLPROXY_SOCKS5, and I am guessing that the
> differences in behaviour between these two is what is causing you
> trouble.  https://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html says
>
>   ..., socks5h:// (the last one to enable socks5 and asking the proxy
>   to do the resolving, also known as CURLPROXY_SOCKS5_HOSTNAME type)
>
> and because not using _HOSTNAME variant would likely not ask the
> proxy to do the resolving, it explains the stall on your end, if
> your box cannot resolve external hostname.
>
> Perhaps the attached patch may help?
>
> I do not know if Pat is still active as a developer, but I am
> wondering what the reason was to use starts_with(..., "socks5")
> instead of "socks5:", "socks4a:", etc. when identifying the proxy
> type.
>
>  http.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/http.c b/http.c
> index 69da445..4304b80 100644
> --- a/http.c
> +++ b/http.c
> @@ -605,7 +605,10 @@ static CURL *get_curl_handle(void)
>         if (curl_http_proxy) {
>                 curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  #if LIBCURL_VERSION_NUM >= 0x071800
> -               if (starts_with(curl_http_proxy, "socks5"))
> +               if (starts_with(curl_http_proxy, "socks5h"))
> +                       curl_easy_setopt(result,
> +                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
> +               else if (starts_with(curl_http_proxy, "socks5"))
>                         curl_easy_setopt(result,
>                                 CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
>                 else if (starts_with(curl_http_proxy, "socks4a"))
