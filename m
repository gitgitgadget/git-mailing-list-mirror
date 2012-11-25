From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 22:43:08 +0100
Message-ID: <CAMP44s2ft7vvaGqHUa2CytpAsX8vOF3YQo24PLPsD6y1Dk3GZQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<20121125095356.GA22279@thyrsus.com>
	<CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com>
	<20121125173229.GA32394@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sun Nov 25 22:43:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcjz3-00071t-IL
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 22:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485Ab2KYVnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 16:43:10 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33428 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474Ab2KYVnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 16:43:09 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10204828oag.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8aMagqLSXO7cRFnr5FyGGLTG8MsLxUePKdoe3NTNjsI=;
        b=DMwMdhs56LJ7VwG5obepFSmVBY4ZoRpO0U9W6ANcwh8+JyJEIKe7NUAAbT2gygQre1
         Qn8sIZBzyFTfU0zQymrV2/USqRMkTx7VKkZ0LBq5FkeGS2nK1O7sQFzaZLzOjIdU2zyo
         9AIeuF/wkXOqlquO9zvUNY5g5rS6n/iY9ZLvmObYIjJHzQ97X7VsxO0eJCWNV+FZsA8s
         XYJm61DoC3nCxqbutyWHvKPXMyahpyHwqxmjooVQ23Lj75JFn1z73wCGiL7MTYOr7uK1
         vBmJrS9CgVI7HlqGOhYUBUAp8Cul+8/DSyUPrYCX8OlX4V8EsZnQrb5jR+TDX8s+QEHy
         upKA==
Received: by 10.60.169.173 with SMTP id af13mr7632544oec.97.1353879788887;
 Sun, 25 Nov 2012 13:43:08 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 13:43:08 -0800 (PST)
In-Reply-To: <20121125173229.GA32394@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210385>

On Sun, Nov 25, 2012 at 6:32 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> Seems sensible, but I don't know what "rejection" would actually mean.
>
> Why is this mysterious?  We reject a patch when we don't choose to merge it.

Why would you reject it? If, according to you, it's very simple to fix
the portability, then presumably it would take you less time to fix
it, than to reject it (and everything that implies).

>> Too late.
>
> I'd be happy to help you out by auditing them for version dependencies.

Be my guest:
http://git.kernel.org/?p=git/git.git;a=tree;f=contrib/remote-helpers;h=adfdcc164e634c74024c8f69bb0cdb9f3b4a9f18;hb=7b4a70c62f3a83fbd8b44bf712141754a5f64205

Some patches might be missing, so:
https://github.com/felipec/git/tree/fc/remote/hg

>> I don't see what this means in practical terms. People are going to
>> write code in whatever language they want to write code in. How
>> exactly are "we" going to "encourage" them not to do that is not
>> entirely clear to me.
>
> One way is by having clear guidelines for good practice that *include*
> Python, and tell people exactly what the requirements are.

The key word being guideline, which is different from a strict rule.

>> Subcommands are also probably more efficient in c. And lets remember
>> that most people use git through the *official* subcommands.
>
> See my remarks on the 80-20 rule elsewhere in the thread.  Execessive
> worship of "efficiency" is a great way to waste effort and pile up
> hidden costs in maintainance problems.

According to the results of the last survey, our users do care about
performance, so I don't think there's anything excessive about it. Are
there any hidden costs in maintenance problems? I don't think so.

The people that like to improve the performance of git, would keep
doing so, and the people that want to use fancy scripts to do fancy
stuff, will keep doing so. It just happens that the former have
actually managed to do it, and go all the way into the mainline.

It would be great if we had a finished libgit2 with all the essential
stuff, and good bindings for python (and other languages), and it
would be great if python really was this touted language, that is easy
to read, and would make things more maintainable. Unfortunately,
that's not the case.

I could write an endless list of what things in the python language
don't make any sense, and how in ruby, for example, they do.
Fortunately, I don't have to.

Git does have problems, but they have nothing to do with maintenance,
or C; they have to do with the user interface, and the documentation
(again, according to our users (and me)). So, I don't see why worry
about moving code from C to python when barely any code in git is
python, specially if it doesn't fix any real issue.

Cheers.

-- 
Felipe Contreras
