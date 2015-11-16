From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Mon, 16 Nov 2015 22:49:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511162246540.1686@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de> <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com> <20151027012336.GK31271@freya.jamessan.com>
 <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com> <alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info> <87si4e6c49.fsf@red.patthoyts.tk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:49:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyReY-0006Xu-E5
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbKPVt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:49:28 -0500
Received: from mout.gmx.net ([212.227.17.22]:63305 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbbKPVtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:49:25 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0M6fXs-1aLcpN3b1Q-00wWxK;
 Mon, 16 Nov 2015 22:49:09 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <87si4e6c49.fsf@red.patthoyts.tk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:7WE0WnQeVKlEhu7Foubf3ZH6NHC86L8HZqRDyXzbVvvj+gNLpf7
 2FkATeF2YySLbAfIsdwkxhjMq+2v8V/Vn0g9s0yGBe9qm0aCTfxVCpflicyhIgVOI4HcIXF
 NoQ9hbF9/GY5A+i2kLlhNeW2NtZAHy4+Qhvb26W2GIgzivoMTm80/pCrvpn0PUh7wfZO6Lc
 bGE34GqIsBEQMv/cQV/sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qA7oC0JjLRw=:HpRYbC077F0XISES4iLVIu
 RUMuof+l/GRrSIz7Pi9Q99rNwljOzQDEuUy66m9OdEu/hGzvSrZK0rVVr3HzMbEyxzRfTKJka
 t48b96wwCYCV3OcWA8mIk75tV1dTJxdxLWjyaF0ZVH+rfc5WK+25DfwFtMmr/4gQTUNREGIC7
 f+YuED86wOMEOYu6cgOwpxjgSXbqVMOIDWYxlPohXO7jVPItRvvdm8z4e4el8Nf1BdetO7UML
 uBWa1rru2TNh6PCuWC/MEBcAIaRdcrpQd1wCXuekd/0rFTVNaU9hlSuL8t0Fb/RyrHX7C+bq9
 2/eXVa9cMmEvSmFcXHdaFLV8Xetyxr0dbL7oVm/aUygNZ1J72kEcnuTJt0MZXetTeen75scGQ
 oEQfkkHbKnCRde7BdJmIZrJnOygmVkZsFPPo7ylyrvWa9VaxQ4S8XLvRwqi9ZwI/KMXJscOpC
 rGWhz8kjeLldXBo7GVnQXK8XsK+InwjGCQScb2P2FdMnTX/8fe69vi+rVUpQ/UGTZHkNg7eo+
 nl2SbXHCQUXKTUS7FWSfQYug7SFFh9bUvWIJpV/5X875Ide6rwsEgAhvxKrWt8cPTM0DBVN8W
 GKX3XXR/zQORfKVkWjZky+SN2qP+ZJ/oGy9OBYbUxJKfhDGFUHN67oBlCyb2qdz8OR99pR/0z
 HHvaTI0GibosUzS8HUkAWh+EdSXzKZ+EhEO2srVYJeO3QOrQ70beN8XK9ZFNR7zjlkq5ogx0z
 dHgSPs5N6OtOzC1dv2zfSZbGnm2KetXGJHDkxdYAUrGjJr47xnlG9TQhNTSlQ6YQ06LF6bMC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281360>

Hi Pat,

On Mon, 9 Nov 2015, Pat Thoyts wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >On Tue, 27 Oct 2015, Johannes Schindelin wrote:
> >
> >> On Mon, 26 Oct 2015, Junio C Hamano wrote:
> >> 
> >> > James McCoy <vega.james@gmail.com> writes:
> >> > 
> >> > >> The code looks OK but the last paragraph makes _us_ worried.  What
> >> > >> is the licensing status of the original at SO?
> >> > >
> >> > > According to Stackoverflow[0],
> >> > >
> >> > >   As noted in the Stack Exchange Terms of Service[1] and in the footer of
> >> > >   every page, all user contributions are licensed under Creative Commons
> >> > >   Attribution-Share Alike[2]. Proper attribution[3] is required if you
> >> > >   republish any Stack Exchange content.
> >> > >
> >> > > [0]: https://stackoverflow.com/help/licensing
> >> > 
> >> > Yes, and (please correct me if I am wrong--this is one of the times
> >> > I hope I am wrong!) I thought BY-SA does not mesh well with GPLv2,
> >> > in which case we cannot use this patch (instead somebody has to
> >> > reimplement the same without copying).
> >> 
> >> Pat, could you please allow us to insert your SOB?
> >
> >On second thought... Junio, could you please sanity-check my claim that
> >this patch:
> >
> >-- snip --
> >@@ -465,6 +465,17 @@ static CURL *get_curl_handle(void)
> > 
> >        if (curl_http_proxy) {
> >                curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> >+#if LIBCURL_VERSION_NUM >= 0x071800
> >+               if (starts_with(curl_http_proxy, "socks5"))
> >+                       curl_easy_setopt(result,
> >+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
> >+               else if (starts_with(curl_http_proxy, "socks4a"))
> >+                       curl_easy_setopt(result,
> >+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
> >+               else if (starts_with(curl_http_proxy, "socks"))
> >+                       curl_easy_setopt(result,
> >+                               CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
> >+#endif
> >        }
> > #if LIBCURL_VERSION_NUM >= 0x070a07
> >        curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> >-- snap --
> >
> >cannot be copyrighted because it is pretty much the only way to implement
> >said functionality?
> >
> >Still, Pat, if you find the time, could you please simply relicense your
> >patch (I know that you are fine with it, but we need an explicit
> >statement)?
> >
> >Ciao,
> >Johannes
> 
> A bit late to the party but 'yes'. Frankly by posting something to SO I
> rather consider it public domain

Yeah, unfortunately it needs to be stated explicitly, though... ;-)

> but I hereby license this patch as required for use by the Git project.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks!

Ciao,
Dscho
