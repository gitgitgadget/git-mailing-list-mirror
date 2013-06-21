From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Fri, 21 Jun 2013 09:15:13 +0200
Message-ID: <CAC9WiBieEG9zhiAqC+bwCAN8qutRr0L_-Fo19ORBqjecnBynhQ@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com>
	<CAC9WiBgmswSqDHS3XOubvkY6GhBqrQ3YdwgKR4npqHM-kLJuMA@mail.gmail.com>
	<CALkWK0k_2jzQNBjLKZ4SDc9vqoZuQ7937dnO6Z_Ye4Ha+FNcag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 09:15:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpvZ3-0004Bh-9H
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 09:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab3FUHPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 03:15:15 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:58850 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab3FUHPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 03:15:14 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so8206200obc.13
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/ODf9NR4zQ2XkQbdMDxlypPiciQ5QuWcQ7G+6sDXSUw=;
        b=YYrNR4GETkZGC+nDMKLempWpCQ3Hiab8AL5OH50sJeP9fqSMqlC7MggUG4OzcQ74Ev
         VlLyLylfr/lgSccbRw2LJqzdJ5lNMnQMxJj5PW66a9aZU3+uysOfXqeoRI8Ph4mtEK/a
         N0fE62B6TDYHDHFBaekMfQWu0Vr7V4V2axN2g4CkBeY4jpVrOInB8UYMSthaafwKtTfO
         NYP0gWs/MdOmrMHAudesHfEAP+znCPmoDKrD/RnvjuCrQ9uYsuJhs1WP7tsFo0HrzObU
         V0P/1Pv/NM8LbRZmZE8+U13ovuiTOC6XAgrJ4HRuYmvdtQlxfA4PbTpOMFZqpgTVvSMr
         /6oQ==
X-Received: by 10.60.146.202 with SMTP id te10mr2157913oeb.13.1371798913660;
 Fri, 21 Jun 2013 00:15:13 -0700 (PDT)
Received: by 10.182.200.169 with HTTP; Fri, 21 Jun 2013 00:15:13 -0700 (PDT)
In-Reply-To: <CALkWK0k_2jzQNBjLKZ4SDc9vqoZuQ7937dnO6Z_Ye4Ha+FNcag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228582>

Hi,

On Thu, Jun 20, 2013 at 3:47 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Francis Moreau wrote:
>> Basically I have an initial set (or can be several different sets)
>> expressed as a revision specification described by git-rev-list man
>> page. I just want to find the common set of commit which are part of
>> the initial sets *and* is reachable by master.
>
> That's just a generic list intersection between
>
>   [a, b, c] and [d, e, f]
>
> no?  [a, b, c] is a list you built up somehow, and [d, e, f] comes
> from $(git rev-list master), right?

yes.

>
> You could go about determining the revision walk boundaries and
> combine them to set up a revision walk to splice the master line, but
> what is the point of that?

Well, that seems to me a more elegant solution and I was curious about
doing this with git-rev-list only if possible.

>  You'll only be painting yourself into a
> design-corner (you won't be able to do other kinds of filtering), and
> going around your head to touch your nose.

I think what Thomas proposed is fine.

>  You precisely want list
> intersection: so write an efficient list intersection in the language
> of your choice.  Why is it a poor man's solution?

Sorry my wording was poor. I just meant that it was the obvious
solution that I don't find nice. But your implementation was good.

>  If anything, your
> convoluted rev-list solution will probably be more complicated,
> slower, and bug-ridden.

Slower ? why do you think Thomas' solution is slower than the obvious one ?

Thanks
--
Francis
