From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git compile warnings (under mac/clang)
Date: Thu, 22 Jan 2015 22:20:01 +0100
Organization: gmx
Message-ID: <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 22:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEPAk-00060P-65
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 22:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbbAVVUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 16:20:10 -0500
Received: from mout.gmx.net ([212.227.17.21]:53606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbbAVVUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 16:20:09 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Md31i-1XxI1b3v1u-00IAxM; Thu, 22 Jan 2015 22:20:02
 +0100
In-Reply-To: <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:e3PF7RSdX2g5ngO50rtKtC534OltQtmv3SoPgEUkM0b5pWLpUYB
 HXX1e1aTgXk8Mh9173EXPQnaPFXSrKGfTOvpMErU6E+ftovlxA++1EQ0i39LZXfkA5/Rqi2
 X+arzjtad8ykAE+YHa4ak8lAz9nChjdpwp7H9bu85YtD8yJZ54LIPzKuglwZ5HYFEmiXivR
 zKMNSIQrj0WBQydu7YJZw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262872>

Hi Stefan,

On 2015-01-22 20:59, Stefan Beller wrote:
> cc Johannes Schindelin <Johannes.Schindelin@gmx.de> who is working in
> the fsck at the moment
>
> On Thu, Jan 22, 2015 at 11:43 AM, Michael Blume <blume.mike@gmail.com> wrote:
>
>>     CC fsck.o
>> fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
>> always true [-Wtautological-compare]
>>         if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
>>                                      ~~~~~~ ^  ~

According to A2.5.4 of The C Programming Language 2nd edition:

    Identifiers declared as enumerators (see Par.A.8.4) are constants of type int.

Therefore, the warning is incorrect: any assumption about enum fsck_msg_id to be unsigned is false.

Ciao,
Johannes
