From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Sat, 15 Feb 2014 07:56:00 +0700
Message-ID: <CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
 <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
 <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
 <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
 <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
 <52FBC9E5.6010609@gmail.com> <loom.20140213T193220-631@post.gmane.org>
 <52FD4C84.7060209@gmail.com> <CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
 <CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
 <52FE68C9.3060403@gmail.com> <CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
 <CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
 <CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com> <CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zachary Turner <zturner@chromium.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 01:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WETYa-0002sE-D7
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 01:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbaBOA4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 19:56:31 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:64673 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbaBOA4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 19:56:31 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so19042014qae.21
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 16:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MMl/LsvcAUpNm5OUoQmEIoDaBNuelmJM+Rc5w1NeuYg=;
        b=SHilGML17CiSAISB1Cci7MhEbm8ZRbN36iLxILiIus7Focj4QDfJEPoz1f2C5REheW
         prae5GfjojN2dB7yvtgIqLXDCaVjX0BoaqQaTun/BQnMf1IpsHtSz/GIOscR9gjHRTLV
         Au4dSpdkpvOK+02OgLlyz8BkW3+jOlRhYFWz9vP1iPAOYOLQKUu5OMI9ddglwhgrfgvY
         zv5Lp9b3y2l4m+zce8H52A5ZC6jQAZjg3nIGx/j9u34d9c5jj1E+Jz8b++HlH/p/h5n0
         SBd2E2UIPV1XRHSP+7FwudIl2RIyPY0S1SFkNUmv7+C6sarmSK/F/ryhTK/qXLx55fpr
         qXKw==
X-Received: by 10.140.107.138 with SMTP id h10mr17251171qgf.30.1392425790571;
 Fri, 14 Feb 2014 16:56:30 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 14 Feb 2014 16:56:00 -0800 (PST)
In-Reply-To: <CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242168>

On Sat, Feb 15, 2014 at 7:50 AM, Stefan Zager <szager@google.com> wrote:
> On Fri, Feb 14, 2014 at 4:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Feb 15, 2014 at 2:16 AM, Zachary Turner <zturner@chromium.org> wrote:
>>> (Gah, sorry if you're receiving multiple emails to your personal
>>> addresses, I need to get used to manually setting Plain-text mode
>>> every time I send a message).
>>>
>>> For the mixed read, we wouldn't be looking for another caller of
>>> pread() (since it doesn't care what the file pointer is), but instead
>>> a caller of read() or lseek() (since those do depend on the current
>>> file pointer).  In index-pack.c, I see two possible culprits:
>>>
>>> 1) A call to xread() from inside fill()
>>> 2) A call to lseek in parse_pack_objects()
>>>
>>> Do you think these could be related?  If so, maybe that opens up some
>>> other solutions?
>>
>> For index-pack alone, what's wrong with open one file handle per thread?
>
> Nothing wrong with that, except that it would mean either using
> thread-local storage (which the code doesn't currently use); or
> plumbing pack_fd through the call stack, which doesn't sound very fun.

Current code does use thread-local storage (struct thread_local and
get_thread_data). Adding a new file handle when NO_THREAD_SAFE_PREAD
is defined is simpler imo.
-- 
Duy
