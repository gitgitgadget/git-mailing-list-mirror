From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Common setting for interoperability repo across windows and unix?
Date: Tue, 3 Nov 2009 11:33:25 -0400
Message-ID: <32541b130911030733i734b9f6doc366934873bf7713@mail.gmail.com>
References: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 16:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5LOM-00010a-Nk
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 16:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZKCPdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 10:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbZKCPdl
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 10:33:41 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56252 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZKCPdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 10:33:41 -0500
Received: by yxe17 with SMTP id 17so5490110yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lbj95OzX04tnkg/lpb85wEr5ozhSZxOE96EIInuZ5U8=;
        b=jVoQakru+ulmXmKv+mnXPb52D3RINjAf+EP8UvkW5mwhZy5cDXyQU6ZYtgNLK1Ae8q
         4hnNTGI4aICYglMmrMVD+fDYPY7Qi72y6aXa57EGBT1Njce9Ppq+rfolHze7ksIl77y1
         9mx0gsLJd2rHU88uwYVTGuNlSraSjtgpAoRX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xqg1MXt3mHTt99Dn0XnucSjTVf9CAyesDV2natpQso9qGO7oYsFFkQlUE8Uw+ah9hZ
         FURtHY0tSd95jJlnIcLkHcucHZM37qZYwJ+EvItWUFP7J6ReU+iDh382vYQzG6fikC5z
         Dl4yOwJM5HQ7I8nsbteyTWhueBSoYVUiBDkg0=
Received: by 10.151.93.15 with SMTP id v15mr418629ybl.171.1257262425362; Tue, 
	03 Nov 2009 07:33:45 -0800 (PST)
In-Reply-To: <c94f8e120911030709h29c5b8edr53df269632990e81@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131973>

On Tue, Nov 3, 2009 at 11:09 AM, Dilip M <dilipm79@gmail.com> wrote:
> I have repo in unix. The same repo is cloned onto windows.I have set
> "core.autocrlf=input" in both the repos.
>
> When I do some change to a file in windows and push to unix repo, I
> get file deleted If I do "git status"?
>
> What is the setting to be done if I want an repo to be
> access/push/pulled across windows and unix?

It sounds like you are pushing to the currently-checked-out branch of
a non-bare repo.

If this is true, you should do one of the following:

- have a central "bare" repo (created with git init --bare) and
push/pull from that rather than directly

- pull, rather than push, when transferring data between repos.

You can pull from a Windows box by running git-daemon on that box from
the command line.  (It's easier than it sounds.)

Have fun,

Avery
