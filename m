From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 12/17] rebase-todo: introduce rebase_todo_item
Date: Mon, 14 Mar 2016 21:33:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603142131120.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-13-git-send-email-pyokagan@gmail.com> <CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 21:33:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZBB-0003nK-OU
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 21:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbcCNUdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 16:33:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:57804 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917AbcCNUdN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 16:33:13 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MVNDK-1aKBWI2U4U-00Ylk3; Mon, 14 Mar 2016 21:33:04
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:30l+IbRxlwR7IJXkfbk2qaJmd/UAsVTpIkTJWyA1k6vb0JzCSRs
 IYheDA7fcuPryFYqCgnP33edsB8Vi/Oj2cV5Lj4nn0tCN2oiLrgz6vRQY0aSD8QsI5GeqXK
 xxbTqlJZIQhCHpw8wWvdocbs20aeoRLXYaAAP6+/nbDxd2ay++Pk12ScICERjZuLDC8Ek/b
 Rsp8urtmIC92oxV3PTXkw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tU5zrwuaniw=:4T5WCnjedRG86/GImJ0xC/
 DGy8/7L0oUK7h8xvaiHF4/MdGZyP+YYhJn/scO18bRnaBjiYA890QUFup2kDv12K2fAGL31BV
 sYJXmhyQnJZYv7w+Jak14uMEl4UJeoV3uxK5COVFaaxi+hK5EKM+moy3YiFX+NcNyaXHkQVpS
 ROSHMCOA1m82Qd6MRHgDIsINU5be0XRskmOwa2VszpRzOymlAfUrrcI56rF5tNdPL2/yGswyS
 4zJOu/vAIt539BOmfNDKPFM2HXd0lSIP8nkjx/a/KbX3GO8u4Wl7vNMIQ3t7pnayN21DW8r6F
 d2XfvqkOBpcwa/N8bZDC1BMjVu98eRfrFpujSSRbAOSzNdy7PfoNgm+GsD3ku1ggYvPV0quth
 gYhxiyN7kAry2IWHMI/p1GNIHnjoWMxBf8SMJaeCR0rf+qBIrPQO29+nRp0COWn0vehcyP1Mj
 W5PN2uK7mxgtReDXABUosNhTd7y96T/gNzZRsOxg9j6Ip7Qez8nf3MAXHxiV1wrn1iN/FVTsT
 noAaWbtRWDPETOUlGAAAXLZbqQan8pZjvF9j9uX7p1jlz4E+Sxltz7mB4vs9x/iW8UUFxCD7J
 1Whwp54miqAITGhuJyjYA47n/0UGZd/U8Lz4JMI7FLbhzu6ieQQjOY9CLMYgPRZlxY7zHcD/f
 Z8nMaxxxJxTn5XU/qkrN+OtQFApO1kY70nf8F+pjvEPGOdlQ81lBX1dE2xbr8l6thR0UZrb/I
 VF10WpggJyh9uocWG9k+e+NtFpenAvHNu/0EbBGUQ895se7XlW2w3/jLNhG6iB+FRySla/lt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288807>

Hi Christian,

On Mon, 14 Mar 2016, Christian Couder wrote:

> On Sat, Mar 12, 2016 at 11:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> > In an interactive rebase, commands are read and executed from a todo
> > list (.git/rebase-merge/git-rebase-todo) to perform the rebase.
> >
> > In the upcoming re-implementation of git-rebase -i in C, it is useful to
> > be able to parse each command into a data structure which can then be
> > operated on. Implement rebase_todo_item for this.
> 
> sequencer.{c,h} already has some code to parse and create todo lists
> for cherry-picking or reverting multiple commits, so I am wondering if
> it would be possible to share some code?

I did exactly that and plan to work full steam on that because I need it
way before GSoC starts:

https://github.com/git/git/compare/master...dscho:interactive-rebase

Note: there are still a couple of things to be done. I will take care of
them.

Ciao,
Dscho
