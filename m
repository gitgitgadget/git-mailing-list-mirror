From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/3] trace: omit noisy repository discovery report
Date: Wed, 26 Jan 2011 08:45:12 +0700
Message-ID: <AANLkTimB0rJPLkwyrQEibngeRjgHLxhrntG5sMdQ9CW0@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com> <20110126004915.GA11230@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 02:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhuSv-0004Cc-6h
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 02:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab1AZBpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 20:45:44 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36601 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1AZBpo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 20:45:44 -0500
Received: by wyb28 with SMTP id 28so461917wyb.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=769EsYzFwL4D3L4MfM9H93NNM0kGXWXFVuditbLpSgA=;
        b=Tk+dnJ8/IZsVfdrK9aY476fsiLKpJb5FZsyge9emNOwhLEm0s7qQs32R2pfijK7jiu
         Jpv9w1mPneG4wtC6vR3X81QTxduqOa/gdn+ZIaOmUIYfA7x3tJN/5faHY8nOfmXIg4ON
         6KzCWhhW83y6eN6Kcjapng9zivgiETPQ3iOOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pKmHDG2r+hmgIoaU+IbhWLhNC53qvpozgO2i77bd+Y3zXRcYz0LkxRJSLhlGbLikq3
         7QU9NHjc0vubVfIFl7lrN2rJXkICW9+k3rYq5Q4zLngkVyTQ/cCkZxtkaGWZx5GGQU32
         QArcexoEfjVhnBNMWNkqYMXuYT6UGEXh2LfKE=
Received: by 10.216.162.70 with SMTP id x48mr4580814wek.4.1296006342691; Tue,
 25 Jan 2011 17:45:42 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 25 Jan 2011 17:45:12 -0800 (PST)
In-Reply-To: <20110126004915.GA11230@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165496>

2011/1/26 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> +++ b/trace.c
> [...]
>> + =C2=A0 =C2=A0 trace_printf("setup: git_dir: %s\n", quote_crnl(get_=
git_dir()));
>> + =C2=A0 =C2=A0 trace_printf("setup: worktree: %s\n", quote_crnl(get=
_git_work_tree()));
>> + =C2=A0 =C2=A0 trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
>> + =C2=A0 =C2=A0 trace_printf("setup: prefix: %s\n", quote_crnl(prefi=
x));
>> +}
>
> A few days ago I was tracing something or other and decided that thes=
e
> extra lines are annoying.
>
> Patch 1 moves this code from trace.c to git.c, to contain its impact
> to a single translation unit (that is, it let me experiment without
> touching cache.h after that).
>
> Patch 2 removes the repo-setup tracing code, introducing a
> test-repo-setup helper to take its place in the repo setup tests.
>
> Patch 3 does some cleaning up made possible by patch 2.
>
> Thoughts?

I'm fine with this. Although long term maybe we should support pattern
matching or category selection in GIT_TRACE.
--=20
Duy
