From: Dominik Fischer <d.f.fischer@web.de>
Subject: Re: [PATCH/RFC/GSoC 0/2] add a add.patch config variable
Date: Thu, 21 Apr 2016 18:30:04 +0200
Message-ID: <34fb607f-1c4c-528a-cb5d-eca95e0e7c68@web.de>
References: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD0KZk1nTgR8gdbedsAuw2ztWZDWri6EkeEkf8FhwS9yag@mail.gmail.com>
 <cover.1459946531.git.d.f.fischer@web.de>
 <alpine.DEB.2.20.1604211737170.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 18:30:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atHUh-0003DS-K2
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 18:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbcDUQaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 12:30:11 -0400
Received: from mout.web.de ([212.227.17.12]:61001 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbcDUQaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 12:30:10 -0400
Received: from [192.168.178.38] ([95.116.240.233]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LylnX-1bq7Q236jH-016Bd5; Thu, 21 Apr 2016 18:30:05
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <alpine.DEB.2.20.1604211737170.2826@virtualbox>
X-Provags-ID: V03:K0:VQEXS5KF2zrZZSGZ0zK6NGRV3MvTEYYdgQ/dVkll4jlsSsd3ux5
 AYfLaH6IRs1+ofQyo7QAwZwnMdswSIjofUq7YwQLHQ83KZfn8kpmCFrJNktvUXmwXku13NB
 SL7f61MBYVKj0JXUlkgTBWTq4+Jkhrg2iJ52lpZ5D+j4PkXDZ3TcmCBsraItiFCgCVQHwmK
 Sr/gim5hOISTPnNe0pPYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lowT7Bc7v+8=:W8Y+dgZDIqplWgE8Hcu5Hp
 SD/S5UZWCUQpa6ndMt3SIDoxn9j9oI6TLyQQC8enIQSbGnMtm4IaLwZ+DOSQYlS6QzCQD3QJc
 voQHVbXb7t4fpadY/PfDgUIPrv8TCC29xSS7cptOaCwEkT916KcPu6NWhJjCddFWvM6nsSnMy
 xll+dXXGt8tbp4lu7Zg+IIFGCxbKEEIKhdEj0b2SizPlW1D/GUg5m/Z5tgtptEUoDCwmsLE5g
 oQ8j313k/6toGeA+Ivh0S4H1T8RmeZu+/xsDq94nY1GxZsXMi26d/p0zvMPvwwAiTw78iTiXF
 HUWbX8HRyFboY7HuNZByASXFHPc/4S5SXd+4rXZuFKzRH1Y53bIuFIaWZa8DTOVJ777VXMqgd
 Nqp8QxiILEwP0Gxscx1cclJ5qcffjM6fdCkDLogcNvT99/sLFyH/4Rs/Egv1Bpo7b/ncU3pkj
 rqgHRLrgZwiTwMjUWw8XZ0Hr9Xd3s08TJfM5NtJZsVoThWCDlada3iWdFxoSxVc7aG4AQmcEu
 aTdmlZDXidDysu6k4Nnwzyi/yLKXGtIumXkE4zw7LuuoPu/9uaaWtb9/WyBJ0gJ5pFQkPSBYQ
 8dL/vWb7dT6Y2xrGTHkqvnmdcqimMlG8FH9GlyKnH/2O1i1dX3+1IQmha64n08xWMPfbOT9p9
 TSlIrNncn0fZyz6YKDZ9iRnFzPJ8wM4ARoDq3Zc4Z1tkdNJSFC+Xuc+rt3AvxVPjKWjlEa97n
 IqCHTt5WzrOcXemiDf5e3xJsX1T1hh9nLbYh5eRGIYYxSO1okBsOLWZqD7JJhX3hoCxHTpR/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292120>

Indeed this needs more explanations for everyone who did not read the 
posts before.

I strove to create an add.patch configuration option that did the same 
as always passing the parameter --patch to git-add. Junio C Hamano then 
made me aware that when set, this option would influence and possibly 
destroy other commands that internally use git-add. So I implemented the 
recursion counter, which is now the first of the two commits. With this, 
git-add is able to only consider the configuration option when run 
directly by the user, not affecting any commands building upon it.

I would be interested whether this is a suited method to restrict the 
effect of a configuration option to cases where a command is explicitly 
invoked by the user.

Regards.
