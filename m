From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Problems with unrecognized headers in git bundles
Date: Wed, 22 Feb 2012 21:40:47 +0100
Message-ID: <CAA787r=J_GVcusCXQHsu4Tc=k=oc=NZ9JE0x4JaOdn61wLijbg@mail.gmail.com>
References: <4F451259.7010304@codethink.co.uk>
	<CAA787rm4c1zYgQJ3kP5=ujpEK1Dda9+h_P3BBmg2yX2eZca=TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Izd-0007mm-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763Ab2BVUkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:40:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37183 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2BVUks convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 15:40:48 -0500
Received: by qadc10 with SMTP id c10so5960193qad.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 12:40:48 -0800 (PST)
Received-SPF: pass (google.com: domain of sunny256@gmail.com designates 10.229.78.135 as permitted sender) client-ip=10.229.78.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sunny256@gmail.com designates 10.229.78.135 as permitted sender) smtp.mail=sunny256@gmail.com; dkim=pass header.i=sunny256@gmail.com
Received: from mr.google.com ([10.229.78.135])
        by 10.229.78.135 with SMTP id l7mr24146728qck.113.1329943248048 (num_hops = 1);
        Wed, 22 Feb 2012 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y0t2ZUuhXqFsX0yQo3/18nYCOSs6OKAJC3L9n+WZr9A=;
        b=s2x6kHMLXrfzZDT5Efv+wrTLcTR7Sze9B9VSmfkx7/Bhn5/shVgJkJseVsAV8PzY6B
         lLBMmmdoPEiWHTni/2NtI+4gcK5CSS6ckpCIFKMMKwSQNLuJzlKXdeXyKMz8UfMYUbbL
         Gul7d+NIDLwJagk5PGWUVO7PIY6hW9GHQQprY=
Received: by 10.229.78.135 with SMTP id l7mr20401141qck.113.1329943247931;
 Wed, 22 Feb 2012 12:40:47 -0800 (PST)
Received: by 10.229.240.133 with HTTP; Wed, 22 Feb 2012 12:40:47 -0800 (PST)
In-Reply-To: <CAA787rm4c1zYgQJ3kP5=ujpEK1Dda9+h_P3BBmg2yX2eZca=TA@mail.gmail.com>
X-Google-Sender-Auth: FnsBXl_TeZab8OCntTXBd1aVfE4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191282>

On 22 February 2012 21:25, =C3=98yvind A. Holm <sunny@sunbase.org> wrot=
e:
> On 22 February 2012 17:05, Jannis Pohlmann wrote:
> > creating bundles from some repositories seems to lead to bundles
> > with incorrectly formatted headers, at least with git >=3D 1.7.2. W=
hen
> > cloning from such bundles, git prints the following error/warning:
> >
> > =C2=A0$ git clone perl-clone.bundle perl-clone
> > =C2=A0Cloning into 'perl-clone'...
> > =C2=A0warning: unrecognized header: --work around mangled archname =
on...
>
> Have researched this a bit, and I've found that all git versions back
> to when git-bundle was introduced (around v1.5.4) produces the same
> invalid line. The culprit is commit
> 3e8148feadabd0d0b1869fcc4d218a6475a5b0bc in perl.git, branch
> 'maint-5.005'. The log message of that commit contains email headers,
> maybe that's the reason git bundle gets confused?

=2E..or maybe because the log message doesn't contain any empty lines, =
so
they're joined together into an insanely long line. I've seen this
behaviour before, in git-am or git-apply, I think. Anyway, when the
bundle doesn't contain this commit, the line is not present.

  =C3=98yvind
