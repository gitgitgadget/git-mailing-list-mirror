From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Fri, 8 Jan 2016 17:17:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601081707340.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <xmqq8u7n934i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:17:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZjR-0003iZ-De
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbcAHQRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:17:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:50374 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755454AbcAHQRg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:17:36 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MJBn4-1aEpu50Juk-002mVZ; Fri, 08 Jan 2016 17:17:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq8u7n934i.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qVDSnJdJWfj2mDCNb0OJ1QJCdbmmFvmYvbfo58hrqF6jF18wsbM
 14/hVmgyobYLlsVWkh09F67ZDqXTcb3d6P7OwRNQucF3Ct3sihadDKkFFwoI6xSgGgdArf4
 1nj+2ibMaYEPIGptj7z+CKRQ+2gM0KLC/sAsTHewVCphaDKgTAEGniz72YgMvRU3Fz6AZlQ
 IJ/qpza3aND55OXDid/ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YfaWaqA7x0g=:1oUaYNxAn29bsL9kQHKzNc
 MoE/MxVCWHPz4JSbJkBiVKoenOHu7KnR2qGGk8XuF5GxlvSZXTHpcu1wOa/+HzURdOSNBG/LL
 pWcxHLXbtebJjhvVR7AGcHf4hUeZJVk/Cp9kAyR57i17VaIn8UzSmmS4VhrJOvpz/szY5tDfI
 E70a3rKSZpRSyFly+qmoHdGF+Q7AlNBtu3n3ssV1C/Nv83RkZ5c4sV+lQ4D20JObSZ8KrP5Sv
 kzqrDXMzgEbnA6B2uJfW9k/4aZPTMDzmV4FzCsSmAOnJb9ly4TtMqEtkzCvFrNWcIqvEtiNEM
 cF3GjL8JontoUNxmmSvhDrGWDG1y6nCkdAiwBmi33EyxJLduAkUmIWjpD0W18RJ5uCYtJiEaU
 55dr3ZWuYoxDbk7FDdUoILhxsBRIFXhtLVQAZ1iIxBnxPQMg0IN6KooRNDjk4ulWDxsBTusIQ
 qGabr7wc1XcFaqyFODNm8WOqBOd9/KXdz9P/PcYc6qQecp6FIQ3QR5z1J1uBUiUkNt8xBUzJ4
 uMSMPzQkZzU3MNhspTWBuMTXSNaAmSfAfA0nGDcCuuKuI56iufDHMxn1e8NIm28g1XZGdBut8
 3D1M35+JgI0hrKTmERpgJxP2N9IEtXmqgGy/aVFO9e5HLzRh85zKV5J804pl//+0QQXuwZRik
 99hgC+YsYbj2nORIzAdF5f7B3RycW/5YP5kbyowJB8G1MaT63KCOqmN2SW1CB1Mu76fzjG1M6
 0/rfYC7/5FkMw8lCxMRp6MgAm1rOVSKKYRhEJ0KlK3ELaIe6o2Qe3jni4nIiMHtAz6a+w65C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283561>

Hi Junio,

On Wed, 30 Sep 2015, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/compat/basename.c b/compat/basename.c
> > index d8f8a3c..10dba38 100644
> > --- a/compat/basename.c
> > +++ b/compat/basename.c
> > @@ -13,3 +13,29 @@ char *gitbasename (char *path)
> >  	}
> >  	return (char *)base;
> >  }
> > +
> > +char *gitdirname(char *path)
> > +{
> > +	char *p = path, *slash, c;
> > +
> > +	/* Skip over the disk name in MSDOS pathnames. */
> > +	if (has_dos_drive_prefix(p))
> > +		p += 2;
> 
> Not a new problem, but many callers of has_dos_drive_prefix()
> hardcodes that "2" in various forms.  I wonder if this is something
> we should relieve callers of by tweaking the semantics of it, e.g.
> by returning 2 (or howmanyever bytes should be skipped) from the
> function, changing it to skip_dos_drive_prefix(&p), etc.

In the upcoming v2, this is addressed.

> > +	/* POSIX.1-2001 says dirname("/") should return "/" */
> > +	slash = is_dir_sep(*p) ? ++p : NULL;
> > +	while ((c = *(p++)))
> 
> I am confused by this.  What is the invariant on 'p' at the
> beginning of the body of this while loop in each iteration?

The idea was that 'p' looks at whatever is the next character. And 'slash'
records the location of the latest slash we have seen (to be overwritten
with a '\0' to terminate the dirname).

Since '/' should not be shortened to the empty string, I special-cased
absolute paths to actually shift the 'slash' to one byte later. A little
dirty, but it worked.

Except that Ramsay's tests pointed out that I did not even look at what
the specs say, and I even fixed basename() in the meantime (and I think
dirname() looks more readable, but feel free to contradict me there).

> > +		if (is_dir_sep(c)) {
> > +			char *tentative = p - 1;
> > +
> > +			/* POSIX.1-2001 says to ignore trailing slashes */
> > +			while (is_dir_sep(*p))
> > +				p++;
> > +			if (*p)
> > +				slash = tentative;
> > +		}
> 
> I would have expected the function to scan from the end/right/tail.

Why scan twice (once to find the end, then to find the slashes)?

Ciao,
Dscho
