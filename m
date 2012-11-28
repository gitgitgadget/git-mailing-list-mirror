From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Millisecond precision in timestamps?
Date: Tue, 27 Nov 2012 17:07:34 -0800
Message-ID: <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
References: <20121127204828.577264065F@snark.thyrsus.com> <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org> <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com> <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Raymond <esr@thyrsus.com>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:08:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdW8I-0006fC-IB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 02:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab2K1BH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 20:07:56 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56062 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2K1BHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 20:07:55 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so4529629qat.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dD1XLlbAlBBF6vhmTx/TGkD6feZ4zmk5W5dm6UuV7iY=;
        b=SM3OG2dM3m8gzoVi++/c1mrPh1PGC/Uh4zJFQ43t3gAmjh5ErGnRVE2NJuqXo4/eI/
         zHrWOIRdloabUwNX3yM4tLJaEyMPISOMgLCGUdegVDBL2lqEOqVED3NbDNfS7dvv7Z6S
         vPlefusyNi2oOgSmAR99x/wTGS2ygJ3qzfVA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=dD1XLlbAlBBF6vhmTx/TGkD6feZ4zmk5W5dm6UuV7iY=;
        b=eupOeN+Hsiq0rWamz7PTTyEXyc/tmrQwZpAkxSZnd37lgVqixKa4h8QxYyfX/NgQcw
         U+yQPWrDxs8yH/b75GKPvm5JoYoDf52m57a6CbICOmZ7C4uO2Hg5sB57pj3ck1hRc56q
         TYOuizXhdqBRThexHqDYzM33/4rO1gVhZQso3nA/IOcD4hVpNDRz0rsTgT18EAEiyrWv
         aiGks4UESPs1aFy1CzJtTZ+lSi3HLv9Y5Wts1P+2qTZSlPxjaNKy8sDK+GWKexXv6ofE
         TXBMCWWMqgoME/kHF+JN3vq+n60ANW58sctDGk5tFtPT/97ZMHUJGwbJzaBMIS/esrAq
         +WeQ==
Received: by 10.224.220.146 with SMTP id hy18mr18188409qab.5.1354064874481;
 Tue, 27 Nov 2012 17:07:54 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Tue, 27 Nov 2012 17:07:34 -0800 (PST)
In-Reply-To: <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnWBtanH5AdeHfWXDRAOwaaipK21ty5qZ+LnEMN37CMFoxPghYpOKo4F1EKhrEz/lBRFTXl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210652>

On Tue, Nov 27, 2012 at 4:26 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Nov 28, 2012 at 1:12 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
>> Shawn Pearce <spearce@spearce.org>:
>>> Well... if we added a fractional seconds to a commit, older versions
>>> of Git will scream loudly and refuse to work with the new commit. That
>>> would create a fork of Git.
>>
>> So much for that idea, I guess.
>>
>> Unless..I don't know how git's database representations work.  Are they
>> version-stamped in any way?  If so, some slightly painful hackery would
>> get around that problem.
>
> % git cat-file -p HEAD
>
> You'll see exactly how git stores commits. Changing anything in there
> must be done carefully.

Apparently there is no room to change in these fields without breaking
compatibility with all current versions of Git. So its not just done
carefully... its deciding to make Git 2.0 that is not compatible with
any Git 1.x release.
