From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 00/26] inotify support
Date: Mon, 10 Feb 2014 17:55:31 +0100
Message-ID: <52F90483.7050206@web.de>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com> <1391401754-15347-1-git-send-email-pclouds@gmail.com> <52F5E521.4090707@web.de> <CACsJy8C0x1FL_6KtYj4MMnhtR6RrPSxR6_yysnZykubdotT9GA@mail.gmail.com> <52F7E2BC.5030905@web.de> <CACsJy8A9JxDWhEWpdUUL_6tTJZvmf93Ga_nPt09yUzG44mc-Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 10 17:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCu8w-0005uU-Hp
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 17:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbaBJQze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 11:55:34 -0500
Received: from mout.web.de ([212.227.15.3]:64152 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751807AbaBJQzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 11:55:33 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M5fsK-1VFjx60C2i-00xd3e for <git@vger.kernel.org>;
 Mon, 10 Feb 2014 17:55:32 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CACsJy8A9JxDWhEWpdUUL_6tTJZvmf93Ga_nPt09yUzG44mc-Qg@mail.gmail.com>
X-Provags-ID: V03:K0:yFGW58FgBZlJfX1yMmkwyPkppswtwdz3BIJcJ1ol5pAIyHtiB75
 U1DPMrfuW03yJlBFLgKe2/MXm8H7O1YZRw1o19H0zWJSvGG5sgH51M+NRDLU45vZ8+YX+x+
 +zNnhHjFkLXqPjIez9KPzcOuzDq1BThK2l6fNmO4uAot2BG/BStCFY9WyqzZbByE5iDzQRd
 DGiVqk0l4X+10aJiuFxUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241915>

On 2014-02-10 11.37, Duy Nguyen wrote:
>>
>> Could we use relative path names internally, relative to $GIT_DIR ?
> 
> No because this is when the client tell the server about $GIT_DIR. I
> guess we can use realpath(1) here.
Good.

I realized that the watcher can watch several repos at the same time.

However, we could allow relative path names, which will be relative to $SOCKET_DIR,
and loosen the demand for an absolut path name a little bit.
And $SOCKET_DIR can be the same as $GIT_DIR, when we are watching only one repo.
> If you want I can update test-file-watcher to accept "send<" and
> "recv>" instead of "<" and ">", respectively. The only command with
> the same name for response and request is "hello". I can make it
> "hello" and "helloack" (or "bonjour" as response?).

helloack looks good. 
