From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/12] Improve git-am test coverage
Date: Sun, 05 Jul 2015 18:02:55 +0200
Organization: gmx
Message-ID: <341ac4ca31dabe768c106be1b11e8ea4@www.dscho.org>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
 <CAGZ79kaisrdsguxrwMCr5TK9RQaGF-WgVE7d9_=s7GXELqYxXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 18:03:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBmNj-0002HL-Ev
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 18:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbGEQC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 12:02:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:57438 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbbGEQC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 12:02:58 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M9vnQ-1ZIQDA0T2u-00B0WW; Sun, 05 Jul 2015 18:02:56
 +0200
In-Reply-To: <CAGZ79kaisrdsguxrwMCr5TK9RQaGF-WgVE7d9_=s7GXELqYxXA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9RTO6Mk54WkYmpBE+2FU0+oTQy9ot/IwTQjPo4Y4V8gwbQib66V
 jtKZKBDYoUjIrGMmASTxAemsNr0/VL9puIyIsLlQwRlpLNQ1s1PjulhfksSCZRzURQkNUfl
 29KQcoEdB9yNTPdtmvJvvfALP2msDZFvKu+71Go26hgd4aJcFnalE64Db13guaFYMj6TpGV
 qU7mCBEi+YZ/xuNQ+hA4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fbH0JkkvylA=:EWx8rgL5GOIRSdgiAjQA1s
 gv35w+x96DtXj+eRO+1U4iVWUCHsDCj+0aTY22oe/4DXw6ZSlJhgnGNB+w4W3q3vcNfnLadpg
 /HCn2qBCgSCBctsGK+1oHpFnwPuwMQyJ60eMd8QAYdqym3lrACvRQqdUlpOu7vWN876oKr3JW
 pGMtz+53VxdhUHqDMDjpAUTo22c/02kY44vaFKDSqb9lruox2fsHSQs6/PWB1XD3wLBZ5duId
 LLdpWhKWSQoPMbBp2+s7s2Ml/pty1yw9wrk3cn3xMFdgNDPJazDfyDPaKyRYqs+Bdw0YBt5ZZ
 ybXmuHg4y5mejzO52bpf2yquUVqd9I60ege+g/wtjSYjJrY03pbaaXE5DxJSl4I4rgsV7OK0y
 /NQIYev4FYNQ00usN59qWFIs0SVlj1ANUrkIxs1cAqiud83WHbGH7RasJ9H+RCE23SrTXvVSD
 kELOa4B8cqetJeY/y71VYRsw9iPGcf5qPyw4MUM1M4aAQdCzVpbphZgqUPai/YNbp6ERdYfU2
 8KG7JwBWnfx31rmEacyGXghL+9j+3gLtfJ1YvR2R3iCq/C7JIyNvC2dLJEetBdHXhLRpQ9wN1
 YzRxaIizM83jGO7IiQBEpXN9YbNzg9jTP6EnNZkdl+AHQlirXw4sXbSK1u68j5kRTTWXAQs/4
 xWy+WgZq2mRnTzm8yOCc/Vb44BLM5uHtAPwgaJkCOPYoze5DbgbN9Q64jwTbcY3P1QSM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273369>

Hi,

On 2015-07-03 18:24, Stefan Beller wrote:
> On Thu, Jul 2, 2015 at 11:16 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> Increase test coverage of git-am.sh to help prevent regressions that could arise
>> from the rewrite of git-am.sh to C. This patch series, along with
>> pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
>> 67.3%[2].
>>
>> No tests for git-am's interactive mode, though, as test_terminal does not seem
>> to attach a pseudo-tty to stdin(?), thus making git-am's "test -t 0" check fail.
>>
>> This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].
> 
> The whole series looks good to me.

I concur (my two comments really are minor nit picks).

Thanks,
Dscho
