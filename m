From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 22:54:19 -0700
Message-ID: <CAJo=hJsVMGPirxTb4tA1Z_Gt2So7jzEda2pUd=XM2nztcSYBzA@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
 <7vzjvokm7f.fsf@alter.siamese.dyndns.org> <CABx5MBQd8Q-NMdFb4p9hk91mpf4FgbTGc3E0oh1tHMfptZSyUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>,
	git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 07:54:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf20a-0001JI-Nb
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 07:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab3EVFyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 01:54:40 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:42513 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3EVFyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 01:54:40 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so4118843iec.8
        for <git@vger.kernel.org>; Tue, 21 May 2013 22:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tgFdAtHws+CKTsrno8TeXeytZpwMlV6hLN6FQ56RyJ4=;
        b=fQ3Brl/N3gnFcgyI6IvdkUW838ZIlpszndK40oG2NkIhSIoPahRKgZYWTFvZfigjTO
         I4S4j7Q/5BPRiRJNgPg0w0QlCgJmz52S/BlDq4a05DWodhIQMUvax5GC6Ce9xatAlOwv
         HVDnQhOr7uYW7rtRQtX7Fx+TiTzZsKBC6kvW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=tgFdAtHws+CKTsrno8TeXeytZpwMlV6hLN6FQ56RyJ4=;
        b=gAZdAcOm1JQBDwXktGb0IRQAkw3s2In5mA3ohFZK3wQulklwDqhimWg/ZOkserE1/u
         i311Rk2YagoU44yaqk2nC0o1/RDP2RSOu29YANx1fB5jILCL+A0GONSQgckfxT+IuyKb
         7zPv6rYfI7R5I18tOAyZNfHR5Sy4wIcMOf4jUni+aGkflvO0+b/5DVwY0xdN5LxQTcSo
         yqDhG5OFdrLSNAO27924YRuTiZoNruk5W1AVGDlzYB9s/VA4qq3NGmHRyZxYXtsOCI8j
         8l+UVapkw62yw2GlXNuqXsaBJMbd9W+cd9/oV8atNcAjxpM+iT+8Fo3iWsMKgdz6Ee/Q
         GscQ==
X-Received: by 10.42.65.75 with SMTP id k11mr2917095ici.26.1369202079535; Tue,
 21 May 2013 22:54:39 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Tue, 21 May 2013 22:54:19 -0700 (PDT)
In-Reply-To: <CABx5MBQd8Q-NMdFb4p9hk91mpf4FgbTGc3E0oh1tHMfptZSyUQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQndtD58woGJjz+wjULINcY4E21FoFbMpFLWKVUPNOMr0YBLJ/JZkcuYIVW/z7nq6UkyjUl7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225129>

On Tue, May 21, 2013 at 3:33 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
> It was git who created that object.
>
> We're trying to build a improved java library focused in our needs
> (jgit has a really confusing api focused in solving egit needs).

JGit code... is confusing because its fast. We spent a lot of time
trying to make things fast on the JVM, and somewhat comparable with C
Git even though its not in C. Some of the low-level APIs are fast
because they bypass conventional Java wisdom and just tell the #@!*
machine what to do, with no pretty bits about it. Make it pretty, it
goes slower. Or uses more RAM. Java likes RAM.

Good luck making an improved library. JGit of course is also
interested in contributions. The api package has been trying to make a
simpler calling convention for common use cases that match the command
line interface user are familiar with, but its still incomplete and
hides some optimizations that are possible with the lower-level calls.
