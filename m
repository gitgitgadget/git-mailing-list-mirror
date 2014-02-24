From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Supporting non-blob notes
Date: Mon, 24 Feb 2014 02:29:10 +0100
Message-ID: <CALKQrgeJGD=68=OV499-PZNCiP0vt9YLMgS_WPjSjoTxySggow@mail.gmail.com>
References: <OF23F26261.C9E4823A-ONC1257C82.0032DA0B-C1257C82.0040D57A@local>
	<CALKQrgff4tnekfkQn9JpJbGrNJzNBYNv=sW6vc3FE+hySkjf3g@mail.gmail.com>
	<CACsJy8C5Hxyj27cX=Jh60ouWpXf-iEeMd9PigKaJTp3rNZrydQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: yann.dirson@bertin.fr, git list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 02:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHkMf-0004f3-48
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 02:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbaBXB3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 20:29:19 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:59432 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaBXB3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 20:29:18 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1WHkM7-0004FU-QP
	for git@vger.kernel.org; Mon, 24 Feb 2014 02:29:15 +0100
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WHkM6-000LJf-6K
	for git@vger.kernel.org; Mon, 24 Feb 2014 02:29:14 +0100
Received: by mail-pd0-f176.google.com with SMTP id w10so5614216pde.35
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 17:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NqPwUpPcbkZnCFynk4B1MJlg5W45ByAi3gVuF/83LX0=;
        b=he0J/aL/D6EHuy+ZZMmQwP1FuM3tNMZE8JeyPszXjfyvm5r4nhLKtnhk14dlsQsjtf
         0kNrdWl6i5W7CS8vcVluijL8YgXbYKj29+AXVffaKz+MlvW0V9za7301/RVPGiH0t09d
         o0EtLPvtkIqiDyoT2tKv8e6TjfbQGSl/7blowm95zdhbFqRHgTp5kiIHyC76JhVtL89n
         spMaQNaYdLenoeFtdnCiYHOAyXwfvMAaESW9XbFZQ6xDqlvGdzRxceflOFe6BbAkdZJ1
         rNQvMDYnrvJfapNwWNTP5VOW7+G2Pv5/csQedVgDG8P84JuIdG5YDtSEIy4Se8Z+5roV
         DkLQ==
X-Received: by 10.66.156.4 with SMTP id wa4mr22066330pab.49.1393205350305;
 Sun, 23 Feb 2014 17:29:10 -0800 (PST)
Received: by 10.70.48.228 with HTTP; Sun, 23 Feb 2014 17:29:10 -0800 (PST)
In-Reply-To: <CACsJy8C5Hxyj27cX=Jh60ouWpXf-iEeMd9PigKaJTp3rNZrydQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242553>

On Wed, Feb 19, 2014 at 12:10 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 18, 2014 at 9:46 PM, Johan Herland <johan@herland.net> wrote:
>> On Mon, Feb 17, 2014 at 11:48 AM,  <yann.dirson@bertin.fr> wrote:
>>> The recent "git-note -C changes commit type?" thread
>>> (http://thread.gmane.org/gmane.comp.version-control.git/241950) looks
>>> like a good occasion to discuss possible uses of non-blob notes.
>>>
>>> The use-case we're thinking about is the storage of testrun logs as
>>> notes (think: being able to justify that a given set of tests were
>>> successfully run on a given revision).
>>
>> I think this is a good use of notes, and organizing the testrun logs
>> into a tree of files seems like a natural way to proceed.
>
> Notes from the previous attempt to store trees as notes (something to
> watch out maybe, when you do it again)
>
> http://article.gmane.org/gmane.comp.version-control.git/197712

Thanks for that link. It is good to see that these issues have been
considered/discussed previously.

I've been thinking about this for a while now, and I find myself
agreeing more and more with Junio's argument in the linked thread.

I think notes are fundamentally - like file contents from Git's POV -
an unstructured stream of bytes. Any real structure in a git note is
imposed by the surrounding application/context, and having Git impose
its own object model onto the contents of notes would likely be an
unnecessary distraction.

In Yann's example, the testrun logs are probably best structured as a
hierarchy of files, but that does not necessarily mean that they MUST
be stored as a Git tree object (with accompanying sub-trees and
blobs). For example, one could imagine many different solutions for
storing the testrun logs:

 (a) Storing the logs statically on some server, and putting the
corresponding URL in a notes blob. Reachability is manual/on-demand
(be retrieving the URL).

 (b) Storing the logs in a .tar.gz archive, and adding that archive as
a blob note. Reachability is implicit/automatic (by unpacking the
archive).

 (c) Storing the logs on some ref in an external repo, and putting the
repo URL + ref in a notes blob. Reachability is manual/on-demand (by
cloning/fetching the repo).

 (d) Storing the logs on some ref/commit in the same repo, and putting
the ref/commit name in a notes blob. Reachability depends on the
application/user to sync the ref/commit along with the notes.

 (e) Storing the logs in a commit, putting the commit name in a blob
note, and then creating/rewriting the notes history to include the
commit in its ancestry. Reachability is automatic (i.e.follows the
notes), but the application must control/manipulate the notes history.

Whichever of these (or other) solutions is most appropriate depends on
the particular application/context, and (from Git's perspective), none
of them are inherently superior to any of the other. Even the question
of whether testrun logs should or should not be reachable by default,
depends on the surrounding application/context.

Now, the intention of Yann's RFC is to store the testrun logs directly
in a notes _tree_. This is not too different from alternative (e)
above, in that reachability is automatic. However, instead of having
the surrounding application manipulate the notes history to ensure
reachability, the RFC would rather teach Git's notes code to
accomodate the (likely rather special) case of having a note that is
BOTH structured like (or at least easily mapped to) a Git tree object,
AND that should be automatically reachable.

Even though there is a certain elegance to storing such a tree object
directly as a notes object, there is AFAICS no other inherent
advantage (e.g. performance- or functionality-wise) to following that
approach. I'm not at all sure that it justifies increasing the
complexity of the notes code.

Furthermore, considering the RFC's original intention of also making
commit and tag objects directly usable as notes, and realizing the
fundamental difficulties in teaching Git to handle this (outlined in
my previous email in this thread), I must conclude that the simplicity
and flexibility of something like alternative (e) above far outweighs
the added code complexity to support allowing any object type to be
used as a note.

Maybe we should instead consider making it easier to do alternative
(e), by providing a command-line option for supplying additional
parents to a notes commit?


...Johan

[1]: The only "structure" in notes contents expected by Git is the
text format expected when showing notes with "git log", or when
editing/appending notes with your default text editor. However, these
are typically bypassed and/or customized by an external application
storing custom data in notes.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
