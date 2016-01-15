From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Combining APPLE_COMMON_CRYPTO=1 and NO_OPENSSL=1 produces
 unexpected result
Date: Fri, 15 Jan 2016 15:28:06 -0500
Message-ID: <CAPig+cQ5kKAt2_RQnqT7Rn=uGmHV9VvxpQ+UgDPOj=D=pq6arg@mail.gmail.com>
References: <CAMYxyaVQyVRQb-b0nVv412tMZ3rEnOfUPRakg2dEREg5_Ba5Ag@mail.gmail.com>
	<CAPig+cS2+NP=-XEYA6e=doQu=+Qn-Lzut-7OCeYJRFZFchNepg@mail.gmail.com>
	<xmqqy4cf9ugm.fsf@gitster.mtv.corp.google.com>
	<20160102234923.GA14424@gmail.com>
	<xmqqfuxyisjp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>,
	Tim Harper <timcharper@gmail.com>,
	Jack Nagel <jacknagel@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKAyp-0006U5-W1
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbcAOU2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:28:12 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33152 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbcAOU2H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:28:07 -0500
Received: by mail-vk0-f46.google.com with SMTP id i129so166648622vkb.0
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 12:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VY4gINWGonhfpfKn94EfW/0mUYwjwfy2wG9alv/pd+M=;
        b=KPHd3fFyY7QMIsuY4JfrmP3YcN81lbrBuIAxq8H56EI5IQCz3qBJ/kOYuvLSYsMprM
         i4BKttfkuBi6VUFC+SYc8SrwbSt/3eJbLAxVcNVbQgno56B2X1LLaqcjOYsS+NP4EoOk
         dX7VyEzdbqonl49EtXHnnjfdq7p4V0ZETgLJsBq2EfrE7boEW8QfhhBkJix1UyA34EV0
         lKOL8zBVugx6MR2nJSA2YOdz5L3WWsS3oCTMkOnv2yOx+GS/W7iHnzXZ3UsnUVCorGKt
         pf1e2Zsmcx7wwMfxYg7mVCjkRy/cmG9dEVwHIrJafloBGypvwxWrzXBQyh396GoKJApU
         hazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VY4gINWGonhfpfKn94EfW/0mUYwjwfy2wG9alv/pd+M=;
        b=ks8ggWA2kgCPQ5AtdeTpgXON6Ui/p+UedOsAXeYCLlbMKHBZHl4TYoV4zOiVvCaxx0
         4Cf+peFTmnsYOm9xIz/2W1BbZE9iKm+Fd5MZ3U+6aIe951KBJHJEGv1SwUl6On5fihvZ
         eMGbueyyzdwNgvaAC3FFOs2HrHDmluy0DCWU10XWRZvZLPe/cHN4AVh3xdtPAnKHTuNx
         0i9pn+fHmgoxciYn682b/2vnNO6uatLwTd44e3ccmwT6gA0zrvbBMVU43YNJynZmPCc/
         i+b3f/lrLVwmeVRyCSdFDx+3r5Qle0Qie/4eSyuh8VFuVGwzdeDYrEwjUwEs21xqJoeR
         dpCA==
X-Gm-Message-State: ALoCoQlX9ZK+p9IXGaujFv63zhPsw6GkI5y6sLd1Ka6leMu0ISSUcOLPpW2PoghPGEqj8bkDie1f70wNiGBkGxAJFSYGfUOdoA==
X-Received: by 10.31.150.76 with SMTP id y73mr9154364vkd.84.1452889686678;
 Fri, 15 Jan 2016 12:28:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 15 Jan 2016 12:28:06 -0800 (PST)
In-Reply-To: <xmqqfuxyisjp.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: JKTXDDW7SrhQci1Z78W5Lo0Z3W8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284211>

On Fri, Jan 15, 2016 at 1:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>> I'm curious to see what others think about dropping CommonCrypto.
>> It seems like a good choice from a maintenance POV.
>
> Judging by a week-long silence, it seems nobody seems to have much
> to say on this issue.  Let me summon the git_osx_installer
> maintainer to hear from somebody who know a lot better than me about
> things around OS X.

Dropping CommonCrypto seems reasonable to me. Since Apple's
CommonCrypto provides only a subset of the OpenSSL functionality Git
uses, we still end up bringing in OpenSSL anyhow in addition to
CommonCrypto, so CommonCrypto isn't buying us much (if anything).
Unfortunately, we'd still want to keep the ugly hack to suppress the
unavoidable "noise" Apple thrust upon us by populating the OpenSSL
headers with #warnings about unstable ABI.
