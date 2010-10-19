From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Tue, 19 Oct 2010 10:27:44 +0200
Message-ID: <201010191027.44859.jnareb@gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com> <m3ocar5fmo.fsf@localhost.localdomain> <20101019080523.GB22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Tue Oct 19 10:28:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P87YB-0007bi-O6
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 10:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760Ab0JSI16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 04:27:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37140 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab0JSI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 04:27:56 -0400
Received: by bwz10 with SMTP id 10so78907bwz.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4Hw7a2BIgpOXKo5lU0CGExtY5RVOTQAaUA/TuIpnFT4=;
        b=O7WDfe2UEHGCXSSbnYDtKUzx6wA/7Q/9BRzYLr+Vgg4czN9M2KZHA/EGd/8Ldb1t01
         3W+3mo8XCpSLITJNaQGfkumW3+C8NlgaV2hs+2UTgOxAg0vtMvL62hiAKXzyON4ejdma
         5AJbgfybGrbkvLClaVYa3+jfinQhM7NQd2cWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Ux79GaJPCJcikwVBI37+eISSHGge2HbbufySdnF+ZYRZu7w4y9UttzW5mIDURNkp2r
         f6rxt0jaPSKZEaRWlkGo+DwpDdHP0mKFmR1zbMZX+04TZ+9cEj7m3ZYzhil2XatTBdsq
         hYVJ1mlMcaeyLyY9zpJTDEoVhsOs8biM0zz1o=
Received: by 10.204.53.4 with SMTP id k4mr5301283bkg.145.1287476875367;
        Tue, 19 Oct 2010 01:27:55 -0700 (PDT)
Received: from [192.168.1.13] (abvs158.neoplus.adsl.tpnet.pl [83.8.216.158])
        by mx.google.com with ESMTPS id t10sm12033252bkj.16.2010.10.19.01.27.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 01:27:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101019080523.GB22067@login.drsnuggles.stderr.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159314>

On Tue, 19 Oct 2010, Matthijs Kooijman wrote:

Note that the excerpt cited (quoted) below is directly from gitcli(7)
manpage.

> >  * The `--cached` option is used to ask a command that
> >    usually works on files in the working tree to *only* work
> >    with the index.  For example, `git grep`, when used
> >    without a commit to specify from which commit to look for
> >    strings in, usually works on files in the working tree,
> >    but with the `--cached` option, it looks for strings in
> >    the index.

Mnemonic: operate on _cached_ contents.  We could use `--staged`
instead of `--cached` here, but for me it doesn't as strong as
`--cached` this meaning.

> > 
> >  * The `--index` option is used to ask a command that
> >    usually works on files in the working tree to *also*
> >    affect the index.  For example, `git stash apply` usually
> >    merges changes recorded in a stash to the working tree,
> >    but with the `--index` option, it also merges changes to
> >    the index as well.

Mnemonic: include _index_ (the name for concrete implementation of the
staging area) in operation.  We could use `--stage` here, but it would
be confusingly similar to `--staged`.  We could use `--include-staged`
or `--also-staged`, but it is long and unwieldy, and doesn't read as
nice.

> 
> Doesn't this just offer opportunity for two new options? E.g., --staged
> and --also-staged or --include-staged or something? In the current form,
> these two options provide a variation of the same concept, using
> completely different option names (which could lead people to think
> that they're really the same option, just inconsistently implemented).

That's why documentation is for.  That is why we have gitcli(7).

Sidenote: there were some proposal of including pseudo-ref name for
cache/index/staging area (and for workdir contents), i.e. to use for
example INDEX or STAGE instead of `--cached`... but they fell flat
because `--cached` / STAGE is not exactly like the ref, and it felt
like it would contribute to confusion rather than reducing it.

> 
> So, regardless of changing over to --staged, I guess these two options
> could be made more consistent (though sticking to the "index"
> terminology is tricky, since that would require --cached to be become
> --index and --index to become --include-index, which throws away
> backward compatibility...).

Breaking backward compatibility that badly is a big NO.

Unfortunately the need for backward compatibility prevents us from some
of improvements...

> 
> FWIW, I do rather like the "staging area" concept, since I feel it
> accurately describes its use (or at least the most common use of the
> staging area).

I also like "staging area" concept (and "to stage" as a verb), but there
are some difficulties in applying it thorough and through.

-- 
Jakub Narebski
Poland
