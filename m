From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix git-pull/git-merge --quiet and --verbose
Date: Thu, 16 Oct 2008 22:08:25 +0200
Message-ID: <4ac8254d0810161308q3d463850k69e4f5615a974367@mail.gmail.com>
References: <1223934148-13942-1-git-send-email-tuncer.ayaz@gmail.com>
	 <7vzll887ps.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810131529l37d67b61q3589f15700d38261@mail.gmail.com>
	 <4ac8254d0810151047p7e12e8efk6fea666d2ac85f0f@mail.gmail.com>
	 <7vy70p3cga.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810151220l48b81325yf3aca48cda49ef3a@mail.gmail.com>
	 <7vprm1pfmd.fsf@gitster.siamese.dyndns.org>
	 <4ac8254d0810152254i615bca9dye0aedd8689c946e7@mail.gmail.com>
	 <7vtzbdjcb8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:09:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZAB-0001tW-Ce
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbYJPUI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbYJPUI1
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:08:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:25886 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbYJPUI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:08:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so160739rvb.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ox0rHn1dv6yMDwRzbGZBbhivjON5HhJV5Tbpcrkq34o=;
        b=oz9oF4itbdeGBD4OlkMyqA0iw5qNzAvRDCaleTp0WfQPFs1zMTFaDurqz8HIXWy9iD
         n/XgxroslUOM2EeQ90o2wQ5B7I50zVGPX+SbgEUINIoVXKaWv3SZvk+VW5rgZSQDjLpI
         DQwJiUXTFcxD5KDHuWjIBFtpZ9CrsynAAEY8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rjzOKdbWKjwT8KO/WZn6qWVFZspR59FKWZVba99al0gCEIB6u9K327mAVsPPE1yVYD
         X2AlJ8AEMNXYxNIytzFUwzP0NvuvBCO3jVG/bwha2xNyHn1b+I4J6s5lxtRxhOVu0lqW
         brYCsGzE6/s2WYSBjaAAMVguYxYQJh/PDwFKc=
Received: by 10.141.36.10 with SMTP id o10mr1938968rvj.176.1224187705820;
        Thu, 16 Oct 2008 13:08:25 -0700 (PDT)
Received: by 10.140.134.3 with HTTP; Thu, 16 Oct 2008 13:08:25 -0700 (PDT)
In-Reply-To: <7vtzbdjcb8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98407>

On Thu, Oct 16, 2008 at 8:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>
>> On Thu, Oct 16, 2008 at 2:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>>
>>>> On Wed, Oct 15, 2008 at 9:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> "Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:
>>>>>
>> Would you prefer to leave -v out?
>
> Not at all.
>
> Perhaps there is a deeper misunderstanding.

Perhaps there was one :-)

> It makes perfect sense _at the end user interface level_ to have -v and -q
> as two separate options, perhaps with "later one wins" semantics.  Another
> possible semantics is "-q and -v are mutually incompatible", but I think
> "later one wins" makes it much more usable from the end user's point of view.
>
> The only thing I was objecting to was your repeated (verbose || !quiet)
> expression in the _implementation_, which would have been much easier to
> read and maintain, if it were expressed as a single variable "verbosity"
> that can have one of three values.

This leaves no space for speculation and is as clear as it gets :D

> IOW,
>
>        static enum { QUIET, NORMAL, VERBOSE } verbosity = NORMAL;
>        ...
>
>                if (!strcmp("--quiet", arg))
>                        verbosity = QUIET;
>                else if (!strcmp("--verbose", arg))
>                        verbosity = VERBOSE;
>                else ...
>
>        ...
>                if (verbosity > QUIET)
>                        print informational message;
>                if (verbosity > NORMAL)
>                        print verbose message;
>
> See?

Yeah, no problem with that.
How do you propose we should integrate this with the
existing usage of parse_options() and OPT_ macros?
I want to keep using it and not redo argv handling
from scratch in builtin-fetch/builtin-merge.
