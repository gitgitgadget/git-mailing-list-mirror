From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Tue, 11 Dec 2012 19:28:44 -0500
Message-ID: <CACh33FoL4fi4m9ekFeSuHOTs=cn818=-tRTh+nBwXLnWXKTFWA@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 01:29:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiaCV-0002Zm-HL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 01:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271Ab2LLA2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 19:28:48 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62194 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab2LLA2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 19:28:45 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so80510oag.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 16:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=CjbEZ0VnK7XZSeMhJVOL2Ue+/shVZmDw87G1YZR/Y3k=;
        b=dVObYvEDbgoS3p9vEnsgZz5rNlpV4sh1ansZJk2lF5RePucdOP3lso2FEbBrqhHN08
         mjGK9Q2zAmaA4C6sfCjySSMT1g+By9ngzdvslkYeWBE1BphXb6Ye+XhN0xlskPFvVIkC
         xxuHde+0vE+kyK36f0ufgOZCLQaMw6yGSoksyZYzs63sKdoZ5G7WWaVV1gUupa+SGj8J
         62sLhFLh3p+Tce+XBTQ1p6lCUq68b3hJ+/aT2WvI99nv6pR1LV1yNEIIjuCEndLWciVX
         EAJAS29H7oxV7jNc/tbUYhBO+jqoIYdWgTa931s3Fm48Q2dKkCAVyW7vdw+U518uDyO3
         3RLA==
Received: by 10.60.32.44 with SMTP id f12mr10769676oei.61.1355272124920; Tue,
 11 Dec 2012 16:28:44 -0800 (PST)
Received: by 10.76.28.101 with HTTP; Tue, 11 Dec 2012 16:28:44 -0800 (PST)
In-Reply-To: <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
X-Gm-Message-State: ALoCoQnlVPAXkMsZSshq9yIaEtpyORMIeMvO/fdQd+tl/yh4LqLpR3cZnqny2FqBk5lBQgoQ6CeP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211320>

Hi Sitaram,

On Tue, Dec 11, 2012 at 7:09 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On Tue, Dec 11, 2012 at 11:14 AM, Patrick Donnelly <batrick@batbytes.com> wrote:
>> Lua has been an incredible success for Nmap [2](and other projects).
>> As an embedded scripting language, it's unrivaled in terms of ease of
>> embedding, ease of use for users, and performance. I would strongly
>> recommend the git developers to seriously consider it.
>
> [snipping the rest; all valid points no doubt]
>
> Does lua have os.putenv() yet?  The inability to even *set* an env var
> before calling something else was a killer for me when I last tried
> it.

Lua is pretty strict about being entirely ANSI C and makes very few
exceptions (e.g. dlopen). The exceptions that do exist are only in
base libraries which can easily be thrown out.

> That may make it fine as an embedded language (called *by* something
> else) but it is a bit too "frugal" to use as a glue language (calls
> other things).

As a glue language, this is a feature. The Programming in Lua (written
by the architect of Lua) preface [1] contains the philosophy of Lua on
this issue.

For cases where you do need access to functions like putenv, it's
trivial to either write wrappers for the functions you want to expose
or to incorporate a library that does it all, e.g. luaposix which
contains the majority of POSIX's system calls.

[1] http://www.lua.org/pil/p1.html

--
- Patrick Donnelly
