From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 27 Oct 2015 16:53:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de> <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com> <20151027012336.GK31271@freya.jamessan.com>
 <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com> <alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 16:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr6ZQ-00085k-9j
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 16:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbbJ0Pxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 11:53:53 -0400
Received: from mout.gmx.net ([212.227.17.21]:53224 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964838AbbJ0Pxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 11:53:51 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LiWzQ-1aMqsU3va8-00cfKK;
 Tue, 27 Oct 2015 16:53:34 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:sEylmCxhOddLXQ+Dqowiq9RKYVNsaUgTb34cA7U/62yNT/Y2cDx
 ILsCidXF29fibyvDNV2o+fC2sDRhc4zJSjF0yHMnVULFW3KPg24ftLPFWca2rOimsBtfrSE
 NSl5wUsHPctQEWfDNVgJYW9uhHiGciCBhEAiW13QV2Nke8DiEfFMUIhLQN0wEWKe5uCk6yg
 zFBotFDzwcfMg+uRXOy6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NyqRORJnMRg=:AF0NxdaJtCOyaY+zCZIQN0
 ZLsqbqSznPzmSEFLOcK4ia4ijn6GXTispEjoRh35kTUMPdM/JR69urP16zPA/3+JFXIBzzC0r
 7xeQcy4ik9j8gjNgLhdcqD4ZjbfA/2cMEm56PCLdIaL/8IlwZcWlN0JQyo4OPJImS0Vc8YxgW
 44rFBrRr0yTPNHi+mGtRU/6XuTzOmeRmXs+d1GrnffvQSFHVsBo87xUx7RMDks9nAkTsYrL3+
 rQnqJUqKx+kI1kv32s/f4i6eHWXzPCILKA/bWUuKQQu4TV7q78yFbK8tDZEzpRO1PwfjL7oUF
 u8u2EUqLBt9IkJs2FnJn2j7HYZ4ePErGoz9WrMMIlFOvyknl8pwfR4FZHX/cMr/631cOs27tK
 8IQJW2nbQkfG4N1GyNFfLanSN18OTbqVAzPb8iUd6JT87akwuzyAAnuYkLtf337UFANqLc8kT
 9s/vOEJodAOcxkzli9vnJDTsEVWu3AztSiNKpvhs11vWcqKseqbNIOl9q6R7PsxghiuB2v0Rw
 afLMYFc6lVLplk+qav5PQj2vlViOtgXNwVFoTWlEkUiPjRqaYQR37ga3mNm63Sdo8dqmbblj0
 ywnfMvwteSZmeTFTFIRPF/8z3ZC8v8vkE9SrtJ0lN3RKapjH0JI/WtBCPtvp0LXZZQXbUEKtA
 gcvM/qdubzuD6NfJvf4is25pbtCDbkb4YdER8rIto8PH1vZFCTmThUN5EtESyfYEZn677KZw0
 VJYSn/8gdkbQLjA0WMIZHtGqi2E5MnL0paYYfkm0dqhGEki5DVV9s0/y8epPqUIJLEiBbgVf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280267>

Hi,

On Tue, 27 Oct 2015, Johannes Schindelin wrote:

> On Mon, 26 Oct 2015, Junio C Hamano wrote:
> 
> > James McCoy <vega.james@gmail.com> writes:
> > 
> > >> The code looks OK but the last paragraph makes _us_ worried.  What
> > >> is the licensing status of the original at SO?
> > >
> > > According to Stackoverflow[0],
> > >
> > >   As noted in the Stack Exchange Terms of Service[1] and in the footer of
> > >   every page, all user contributions are licensed under Creative Commons
> > >   Attribution-Share Alike[2]. Proper attribution[3] is required if you
> > >   republish any Stack Exchange content.
> > >
> > > [0]: https://stackoverflow.com/help/licensing
> > 
> > Yes, and (please correct me if I am wrong--this is one of the times
> > I hope I am wrong!) I thought BY-SA does not mesh well with GPLv2,
> > in which case we cannot use this patch (instead somebody has to
> > reimplement the same without copying).
> 
> Pat, could you please allow us to insert your SOB?

On second thought... Junio, could you please sanity-check my claim that
this patch:

-- snip --
@@ -465,6 +465,17 @@ static CURL *get_curl_handle(void)
 
        if (curl_http_proxy) {
                curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+#if LIBCURL_VERSION_NUM >= 0x071800
+               if (starts_with(curl_http_proxy, "socks5"))
+                       curl_easy_setopt(result,
+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
+               else if (starts_with(curl_http_proxy, "socks4a"))
+                       curl_easy_setopt(result,
+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
+               else if (starts_with(curl_http_proxy, "socks"))
+                       curl_easy_setopt(result,
+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+#endif
        }
 #if LIBCURL_VERSION_NUM >= 0x070a07
        curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
-- snap --

cannot be copyrighted because it is pretty much the only way to implement
said functionality?

Still, Pat, if you find the time, could you please simply relicense your
patch (I know that you are fine with it, but we need an explicit
statement)?

Ciao,
Johannes
