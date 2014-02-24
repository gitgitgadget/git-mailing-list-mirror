From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Mon, 24 Feb 2014 20:55:41 +1300
Message-ID: <530AFAFD.2060504@gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>	<53085434.4060106@gmail.com> <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 08:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqOE-0003vF-K4
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 08:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbaBXHzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 02:55:46 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33563 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbaBXHzq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 02:55:46 -0500
Received: by mail-pb0-f50.google.com with SMTP id rq2so6205125pbb.37
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 23:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=flctcseR/NalgMl9nQseWiKvJ42hEU+N44VCaJSenuQ=;
        b=vwp52nZ11uD1rGSnhDXElDmsoz2Gpj770mqXOwcq6PXOB137vWEPmnsPHnr7aJEo/p
         PcDWQ+JH751CxoF7BxDYgBWapnKs5FBKQFzzU2upo52NfEKKDYDGuzTi5PaK44rQyVGA
         nfoxZ6NcB8mGC1tRphglqI91+sDUzayM4ItgfjeWg1+YiHKbakdSwQS7k0tu37qCtiV2
         X2ymshCgZnh17OUkD8NpHAvP1WwyJbajfF/z0Zj76z4wxlb3AOvxRMjlADMMBQ2SnKLX
         KuWWwiFBdHn6LAVfXJ1qZj8IoyP22zV5+OC7VNUb6QAoW1C2HbjVofkPGE1hbX5o0cGk
         4PYw==
X-Received: by 10.68.112.164 with SMTP id ir4mr23344560pbb.153.1393228545706;
        Sun, 23 Feb 2014 23:55:45 -0800 (PST)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id bz4sm47195928pbb.12.2014.02.23.23.55.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Feb 2014 23:55:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242571>

On 24/02/14 09:33, Robert Dailey wrote:
> On Sat, Feb 22, 2014 at 1:39 AM, Chris Packham <judge.packham@gmail.com> wrote:
>> On 22/02/14 18:18, Robert Dailey wrote:
>>> So it seems that the pager doesn't work by default when running `git
>>> log` from Cygwin like it does in msysgit for Windows.
>>>
>>> I know I can pipe to `less` but that requires the additional typing
>>> obviously. Does anyone know how I can get the pager to work in Cygwin
>>> for git log, reflog, and other commands like it does in msysgit?
>>>
>>> Thanks in advance.
>>
>> Add GIT_PAGER=less to your environment. I don't know if you were using
>> the cygwin packaged git or building from source but I'm surprised the
>> pager is not set by default as you actually have to define the use of
>> something other than less.
> 
> Thanks for the response. I did set this environment variable in my
> .bashrc like so:
> 
> export GIT_PAGER=less
> 
> However after I do a 'git log' it is just spitting it out all at once
> and not entering the pager.
> 

Um OK that was the obvious thing to try. There is also the config
variable core.pager but GIT_PAGER should take precedence.

Could something be setting the environment variable LESS? Reading the
git-config man page for core.pager git wants to set LESS to FRSX but if
it is already set git takes that as an indication that you don't want to
set LESS automatically.

If neither of those help you probably want to let us know your cygwin
version as well as your git version and how you installed git (i.e.
built from source or installed via cygwin).
