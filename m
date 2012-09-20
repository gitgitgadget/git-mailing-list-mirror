From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Fri, 21 Sep 2012 00:45:04 +0100
Message-ID: <CAOkDyE-28Lf8_AO3g8SkiemAhT5OzU=AU+c6rUWB0yPWj-kF2w@mail.gmail.com>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
	<1348170383-15751-1-git-send-email-git@adamspiers.org>
	<7v4nms9yja.fsf@alter.siamese.dyndns.org>
	<7vsjac8j52.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 01:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEqQp-00045B-6d
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 01:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070Ab2ITXpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 19:45:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39377 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2ITXpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 19:45:05 -0400
Received: by bkuw11 with SMTP id w11so509828bku.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=KaKDYtvQfHnwcNb2dtDv6fwI+GIbFuv4M8QslMryZWM=;
        b=Lqc2RAMAqpbX4y1Bsrvu/7T4KF4u1/cmc3+I9oYV6HnpjrIzL2E4SilY9lhW7GoLn+
         LVycP3rBPKWFbSypEfU4031tQ9wUrNBg5Axuokl/fjZbqybuWCWWYG4X3afdBXyuPie+
         IOaioJpmSPOGQvV4zwPoK9G8W4hkh0wVntCBHFKYrdB4mxAn5hqgn3nEXIh06a1lGES9
         taaQqD2VQOCpQCKgO8C3h80nKmofQwTvDKauoDhpLwMxEjQL9FhPg81YJerYzsz2OSHa
         VqoJ4N35jwqyusOJegpUoeQ4p9WdXj3X1q46MmlERQD7JgH4y4qJ2fXKJQoIAj77c4f+
         ypSQ==
Received: by 10.204.4.154 with SMTP id 26mr1409984bkr.91.1348184704185; Thu,
 20 Sep 2012 16:45:04 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 20 Sep 2012 16:45:04 -0700 (PDT)
In-Reply-To: <7vsjac8j52.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: MGX1jpfgmRSm_VHZEC1ZA_H10do
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206101>

On Thu, Sep 20, 2012 at 10:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Adam Spiers <git@adamspiers.org> writes:
>>> Adam Spiers (14):
>>>   Update directory listing API doc to match code
>>>   Improve documentation and comments regarding directory traversal API
>>>   Rename cryptic 'which' variable to more consistent name
>>>   Rename path_excluded() to is_path_excluded()
>>>   Rename excluded_from_list() to is_excluded_from_list()
>>>   Rename excluded() to is_excluded()
>>>   Refactor is_excluded_from_list()
>>>   Refactor is_excluded()
>>>   Refactor is_path_excluded()
>>>   For each exclude pattern, store information about where it came from
>>>   Refactor treat_gitlinks()
>>>   Extract some useful pathspec handling code from builtin/add.c into a
>>>     library
>>>   Provide free_directory() for reclaiming dir_struct memory
>>>   Add git-check-ignore sub-command
>>
>> Please retitle these to have a short "prefix: " that names a
>> specific area the series intends to touch.  I retitled your other
>> series to share "test :" as their common prefix.
>
> Just to clarify, I think most of them can say "dir.c: ".

Sure, I can do that, but shouldn't this convention be documented in
SubmittingPatches?

> I saw quite a few decl-after-statement in new code.  Please fix
> them.

Again, I can do that no problem, but again this convention is
undocumented and I am not psychic ;-)  I see that a patch was provided
5 years ago to document this, but was apparently never pulled in:

    http://thread.gmane.org/gmane.comp.version-control.git/47843/focus=48015

It would save everybody's time if these things are documented, since
then they wouldn't create noise during the review process.

I also see in the same thread that a patch to add
-Wdeclaration-after-statement to CFLAGS was also offered but never
pulled in, presumably on the stated grounds that that option was
relatively recent 5 years ago.  But wouldn't it be trivial to do

    gcc -v --help 2>&1 | grep declaration-after-statement

at build-time?

I'm also curious to know why this convention exists.  Are people
really still compiling git with compilers which don't support C99?

> As to the "who owns x->src and when is it freed" question, it may
> make sense to give el a "filename" field (command line and other
> special cases would get whatever value you deem appropriate, like
> NULL or "<command line>"), have x->src point at that field when you
> queue many x's to the el in add_exc_from_file_to_list().  Then when
> you pop an element in the exclude_stack, you can free el->filename
> to plug a potential leak.
>
> Also I do not see why you need to have the strdup() in the caller of
> add_excludes_from_file_to_list().  If you need to keep it stable
> because you are copying it away in exclude or excludde_list,
> wouldn't it make more sense to do that at the beginning of the
> callee, i.e. add_excludes_from_file_to_list() function?

Thanks, I'll take a look at these suggestions tomorrow.
