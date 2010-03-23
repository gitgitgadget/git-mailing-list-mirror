From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Bug - crash on large commit
Date: Tue, 23 Mar 2010 09:25:27 +0100
Message-ID: <40aa078e1003230125n5be565drb55fa7fdf731c72e@mail.gmail.com>
References: <310ba29b220a70e5624819e6ef80bff0.squirrel@www.pkts.ca>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: P Fudd <fink@ch.pkts.ca>
X-From: git-owner@vger.kernel.org Tue Mar 23 09:25:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtzQs-0005ul-4j
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 09:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab0CWIZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 04:25:31 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57461 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0CWIZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 04:25:29 -0400
Received: by wwe15 with SMTP id 15so3898793wwe.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SiXlofTJiPKdkrVWkQsyZLLJh2yYFrq7e6R9Y6NHFg4=;
        b=la5C2AMIOnpWs8W8MGYjB0XyOknSIVHjiWbDCRJ8IMBQhv0JsqvgM9LLZ9CbyCW3xa
         7MEdkVZT9EjCD/BSyFdR615D7eCBmSuScQqGl9V6FkpiGVHG671SexfOlJdtIeqJvszK
         Ee6Jp4IDe9dXc1txafd+y4rRp4wlBDiIEEmy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=t6Oa9L+6gZWNOFQH/1jtg2Kii/l9d+wX1Sfhaf0qTET0vx8UNhpYEsGQzNAPXiWDhi
         +ZvpEFJgUwZgUDfU05oSk9YZsUf949m3I4xm3ttQef/GbPHWU8N/I3iJ4nCz7e9j6Ix3
         IPyEiAJXg0q1WV7OTlhGO8k7EaArEPBZ9l5M8=
Received: by 10.216.86.67 with SMTP id v45mr2280186wee.70.1269332727122; Tue, 
	23 Mar 2010 01:25:27 -0700 (PDT)
In-Reply-To: <310ba29b220a70e5624819e6ef80bff0.squirrel@www.pkts.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142997>

On Tue, Mar 23, 2010 at 12:36 AM, P Fudd <fink@ch.pkts.ca> wrote:
> Bug 2: git died with an out-of-memory error on the commit:
> ------
> # git commit -a
> [master (root-commit) 62b52e2] The initial checkin of the whole hard =
disk.
> =A0Committer: System Administrator <root@Mac-Pro.local>
> Your name and email address were configured automatically based
> on your username and hostname. Please check that they are accurate.
> You can suppress this message by setting them explicitly:
>
> =A0 =A0git config --global user.name "Your Name"
> =A0 =A0git config --global user.email you@example.com
>
> If the identity used for this commit is wrong, you can fix it with:
>
> =A0 =A0git commit --amend --author=3D'Your Name <you@example.com>'
>
> git(4667) malloc: *** mmap(size=3D1964838912) failed (error code=3D12=
)
> *** error: can't allocate region
> *** set a breakpoint in malloc_error_break to debug
> git(4667) malloc: *** mmap(size=3D1964838912) failed (error code=3D12=
)
> *** error: can't allocate region
> *** set a breakpoint in malloc_error_break to debug
> fatal: Out of memory, malloc failed
> [Mac-Pro:/] shadministrator# git version
> git version 1.7.0.2

Is your git built as a 32-bit program? If so, it can't handle files
larger than ~1-2 gb, which looks like it might be the case here...

--=20
Erik "kusma" Faye-Lund
